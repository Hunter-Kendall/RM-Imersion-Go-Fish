# frozen_string_literal: true

require_relative '../lib/card_deck'

describe 'CardDeck' do
  seed = 1
  it 'Should have 52 cards when created' do
    deck = CardDeck.new
    expect(deck.cards_left).to eq 52
  end

  it 'should deal the top card' do
    deck = CardDeck.new
    card = deck.deal
    expect(card.rank).to eq('A')
    expect(card.suit).to eq('C')
    expect(deck.cards_left).to eq 51
  end

  it 'should deal twice and get two unique cards' do
    deck = CardDeck.new
    card1 = deck.deal
    card2 = deck.deal
    expect(card1).to_not eq(card2)
  end
  context '#generate_cards' do
    it 'should generate an array of PlayingCards' do
      deck = CardDeck.new
      cards = deck.cards
      expect(cards[0].suit).to eq('D')
      expect(cards[0].rank).to eq('2')
    end
  end
  context '#shuffle_cards' do
    it 'shuffles the array for deck2 and then compares the first value of it to the first value of deck 1' do
      deck1 = CardDeck.new
      deck2 = CardDeck.new
      expect(deck1.cards[0]).to eq(deck2.cards[0])
      deck2.shuffle_cards(seed)
      expect(deck1.cards[0]).to_not eq(deck2.cards[0])
    end
    it 'shuffles the array without parameter' do
      deck = CardDeck.new
      expect { deck.shuffle_cards }.to_not raise_error
    end
  end
end
