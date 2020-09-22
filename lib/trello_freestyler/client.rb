# frozen_string_literal: true

require 'rest-client'

module TrelloFreestyler
  class Client
    def initialize(key, token, trello_url)
      @key = key
      @token = token
      @trello_url = trello_url
    end

    def auth
      { key: @key, token: @token }
    end

    def cards(board_id)
      url = @trello_url + "/boards/#{board_id}/cards"
      params = { params: auth }
      RestClient.get url, params
    end

    def card_actions(card_id, action_types)
      url = @trello_url + "/cards/#{card_id}/actions"
      params = { params: auth.merge({ filter: action_types }) }
      RestClient.get url, params
    end
  end
end
