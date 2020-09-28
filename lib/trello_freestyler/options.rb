# frozen_string_literal: true

require 'tzinfo'
module TrelloFreestyler
  class Options
    attr_accessor :key, :token, :url, :board_id, :action_types, :output, :timezone

    # rubocop:disable Metrics/ParameterLists
    def initialize(key, token, url, board_id, action_types, output, timezone)
      @key = key
      @token = token
      @url = url || 'https://api.trello.com/1'
      @board_id = board_id
      @action_types = action_types ||
                      'addMemberToCard,removeMemberFromCard,createCard,moveCardFromBoard,moveCardToBoard,updateCard'
      @output = output || '.output'
      @timezone = TZInfo::Timezone.get((timezone || 'Australia/Melbourne'))
    end
    # rubocop:enable Metrics/ParameterLists

    def ==(other)
      key == other.key &&
        token == other.token &&
        url == other.url &&
        board_id == other.board_id &&
        action_types == other.action_types &&
        output == other.output &&
        timezone == other.timezone
    end
  end
end
