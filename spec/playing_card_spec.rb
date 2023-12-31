# frozen_string_literal: true

require_relative '../lib/playing_card'
require_relative '../lib/card_deck'

describe 'PlayingCard' do
  let(:card) { PlayingCard.new('A', 'S') }
  it 'takes parameters rank and suit and returns them' do
    expect(card.rank).to eq('A')
    expect(card.suit).to eq('S')
  end
  context '#==' do
    it 'returns true for two cards that are the same and false if cards are not the same' do
      card1 = PlayingCard.new('A', 'S')
      card2 = PlayingCard.new('A', 'S')
      card3 = PlayingCard.new('K', 'S')
      card4 = PlayingCard.new('A', 'H')
      expect(card1).to eq(card2)
      expect(card1).to_not eq(card3)
      expect(card1).to_not eq(card4)
    end
    it 'returns false for non-PlayingCard classes' do
      something_else = CardDeck.new
      expect(card).to_not eq(something_else)
    end
  end
  context '#rank_rating' do
    it 'expects Ace to equal its rating of 13' do
      expect(card.rank_rating).to eq(12)
    end
  end
  context '#to_s' do
    it 'returns a string of the rank and suit' do
      expect(card.to_s).to eq("A'S")
    end
  end
end
