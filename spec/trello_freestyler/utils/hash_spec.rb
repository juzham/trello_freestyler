# frozen_string_literal: true

require 'spec_helper'
require 'trello_freestyler/utils/hash'

RSpec.describe TrelloFreestyler::Utils do
  describe '.deep_clean' do
    it 'doesnt touch a good hash' do
      input = { a: 100, b: 200, c: { c2: 300 } }
      expect(described_class.deep_clean(input)).to eq(input)
    end

    it 'cleans a single layer hash' do
      input = { a: 100, b: 200, c: {} }
      expected = { a: 100, b: 200 }
      expect(described_class.deep_clean(input)).to eq(expected)
    end

    it 'it can not clean a double layer empty hash' do
      input = { a: 100, b: 200, c: { c1: {} } }
      expected = { a: 100, b: 200, c: {} }
      expect(described_class.deep_clean(input)).to eq(expected)
    end
  end

  describe '.deep_deep_clean' do
    it 'can clean double layered empty hashs' do
      input = { a: 100, b: 200, c: { c1: {} } }
      expected = { a: 100, b: 200 }
      expect(described_class.deep_deep_clean(input)).to eq(expected)
    end

    it 'can clean triple layered empty hashs' do
      input = { a: 100, b: 200, c: { c1: { c2: {} } } }
      expected = { a: 100, b: 200 }
      expect(described_class.deep_deep_clean(input)).to eq(expected)
    end

    it 'can clean deep layered empty hashs' do
      input = { a: 100, b: 200, c: { c1: { c2: { c3: { c4: { c5: {} } } } } } }
      expected = { a: 100, b: 200 }
      expect(described_class.deep_deep_clean(input)).to eq(expected)
    end
  end
end
