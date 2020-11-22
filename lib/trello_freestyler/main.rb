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
      execution_datetime = Time.now.getlocal(options.timezone.current_period.offset.utc_total_offset)
      execution_date = Date.parse(execution_datetime.strftime('%Y/%m/%d')).to_s

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

      basename = init_output_basename(options.output, execution_date)
      export_with_stamp(card_dump.raw, basename.join('cards.jsonl').to_s, execution_datetime, execution_date)
      export_with_stamp(actions_dump.raw, basename.join('actions.jsonl').to_s, execution_datetime, execution_date)
    end
    # rubocop:enable Metrics/AbcSize

    def self.init_output_basename(base, date)
      base = Pathname.new(base).join(date)
      Pathname.new(base).mkpath
      base
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

    def self.export_with_stamp(dump, to, execution_datetime, execution_date)
      File.open(to, 'w') do |f|
        dump.each do |row|
          row[:execution_datetime] = execution_datetime.strftime('%Y-%m-%d %H:%M:%S.%L %:z')
          row[:execution_local_date] = execution_date
          f.puts row.to_json
        end
      end
    end
  end
end
