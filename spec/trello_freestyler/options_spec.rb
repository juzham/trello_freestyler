# frozen_string_literal: true

require 'spec_helper'
require 'trello_freestyler/cli'
require 'trello_freestyler/options'

RSpec.describe TrelloFreestyler::Options do
  describe '.new' do
    it 'has default settings' do
      expected = TrelloFreestyler::Options.new(
        nil,
        nil,
        'https://api.trello.com/1',
        nil,
        'addMemberToCard,removeMemberFromCard,createCard,moveCardFromBoard,moveCardToBoard,updateCard',
        '.output',
        'Australia/Melbourne'
      )
      expect(described_class.new(nil, nil, nil, nil, nil, nil, nil)).to eq(expected)
    end
  end
end
