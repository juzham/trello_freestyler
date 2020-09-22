# frozen_string_literal: true

require 'optparse'
require 'tzinfo'

module TrelloFreestyler
  class Cli
    Options = Struct.new(:key, :token, :url, :board_id, :action_types, :output, :timezone)
    # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Layout/LineLength
    def self.parse(options)
      # DEFAULTS
      args = Options.new(nil,
                         nil,
                         'https://api.trello.com/1',
                         nil,
                         'addMemberToCard,removeMemberFromCard,createCard,moveCardFromBoard,moveCardToBoard,updateCard',
                         '.output',
                         TZInfo::Timezone.get('Australia/Melbourne'))

      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: trello_freestyler -k <KEY> -t <TOKEN> -b <BOARD_ID>'

        opts.on('-k', '--key KEY', String, 'REQUIRED - Developer Trello Key') do |i|
          args.key = i
        end

        opts.on('-t', '--token TOKEN', String, 'REQUIRED - Developer Trello Token') do |i|
          args.token = i
        end

        opts.on('-b', '--board_id BOARD_ID', String, 'REQUIRED - The Trello Board Id to export') do |i|
          args.board_id = i
        end

        opts.on('-a', '--actions ACTIONS', Array, "Override the list of Trello action types to dump: example 'createCard,updateCard'") do |i|
          args.action_types = i.join(',')
        end

        opts.on('-u', '--url TRELLO_URL', String, 'Override the default Trello API Url [https://api.trello.com/1]') do |i|
          args.url = i
        end

        opts.on('-o', '--output OUTPUT_FOLDER', String, 'Override the default output folder [.output]') do |i|
          args.output = i
        end

        opts.on('-z', '--timezone TIME_ZONE', String, 'Override the default timezone for folder naming [Australia/Melbourne]') do |i|
          args.timezone = TZInfo::Timezone.get(i)
        end

        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          exit
        end
      end

      opt_parser.parse!(options)
      validate(args)
    end
    # rubocop:enable Metrics/MethodLength, Metrics/AbcSize, Layout/LineLength

    def self.validate(options)
      if options.key && options.token && options.board_id
        options
      else
        puts 'ERROR: One of the mandory arguments is missing. [--key, --token, --board_id]'
        exit 1
      end
    end
  end
end
