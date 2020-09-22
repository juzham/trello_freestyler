# frozen_string_literal: true

require_relative 'client'
require_relative 'utils/hash'
require 'json'
require 'pathname'

module TrelloFreestyler
  class Main
    Struct.new('CardDump', :card_ids, :raw)
    Struct.new('ActionsDump', :raw)

    # rubocop:disable Metrics/AbcSize
    def self.dump(options)
      client = TrelloFreestyler::Client.new(options.key, options.token, options.url)

      response_cards = client.cards(options.board_id)
      card_dump = parse_cards(response_cards.body)

      actions_dump = Struct::ActionsDump.new(
        card_dump
          .card_ids
          .map do |card_id|
          action_response = client.card_actions(card_id, options.action_types)
          parse_actions(action_response.body)
        end.flatten
      )

      basename = init_output_basename(options.output, options.timezone)
      export(card_dump.raw, basename.join('cards.jsonl').to_s)
      export(actions_dump.raw, basename.join('actions.jsonl').to_s)
    end
    # rubocop:enable Metrics/AbcSize

    def self.init_output_basename(base, timezone)
      time = Time.now.getlocal(timezone.current_period.offset.utc_total_offset)
      date = Date.parse(time.strftime('%Y/%m/%d')).to_s
      base = Pathname.new(base).join(date)
      Pathname.new(base).mkpath
      base
    end

    def self.full_filename(base, filename, timezone)
      time = Time.now.getlocal(timezone.current_period.offset.utc_total_offset)
      date = Date.parse(time.strftime('%Y/%m/%d')).to_s
      Pathname.new(base).join(date).join(filename).to_s
    end

    def self.parse_cards(raw_text)
      cards = JSON.parse(raw_text)
      cards.each_with_object(Struct::CardDump.new([], [])) do |card, all|
        Struct::CardDump.new(
          all.card_ids.push(card['id']),
          all.raw.push(Utils.deep_deep_clean(card))
        )
      end
    end

    def self.parse_actions(raw_text)
      actions = JSON.parse(raw_text)
      actions.map do |action|
        Utils.deep_deep_clean(action)
      end
    end

    def self.export(dump, to)
      File.open(to, 'w') do |f|
        dump.each { |row| f.puts row.to_json }
      end
    end
  end
end
