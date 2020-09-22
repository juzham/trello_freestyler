# frozen_string_literal: true

require 'spec_helper'
require 'trello_freestyler/cli'

RSpec.describe TrelloFreestyler::Cli do
  describe '.parse' do
    it 'uses default and mandatory arguments to construct options' do
      input = ['-k', 'key111',
               '-t', 'token111',
               '-b', 'board_id111']
      expected = TrelloFreestyler::Cli::Options.new(
        'key111',
        'token111',
        'https://api.trello.com/1',
        'board_id111',
        'addMemberToCard,removeMemberFromCard,createCard,moveCardFromBoard,moveCardToBoard,updateCard',
        '.output',
        TZInfo::Timezone.get('Australia/Melbourne')
      )
      expect(described_class.parse(input)).to eq(expected)
    end

    it 'is able to override all the defaults' do
      input = ['-k', 'key111',
               '-t', 'token111',
               '-b', 'board_id111',
               '-u', 'https://api.trello.com/2',
               '-a', 'addMemberToCard,removeMemberFromCard',
               '-o', '.dump',
               '-z', 'Australia/Sydney']
      expected = TrelloFreestyler::Cli::Options.new(
        'key111',
        'token111',
        'https://api.trello.com/2',
        'board_id111',
        'addMemberToCard,removeMemberFromCard',
        '.dump',
        TZInfo::Timezone.get('Australia/Sydney')
      )
      expect(described_class.parse(input)).to eq(expected)
    end
  end
end
