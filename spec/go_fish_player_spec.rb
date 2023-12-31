# frozen_string_literal: true

require_relative '../lib/go_fish_player'
require_relative '../lib/playing_card'
require_relative '../lib/card_deck'

describe GoFishPlayer do
  name = 'Hunter'
  let(:deck) { CardDeck.new }
  let(:hand) do
    [PlayingCard.new('A', 'S'),
     PlayingCard.new('A', 'C'),
     PlayingCard.new('A', 'H'),
     PlayingCard.new('A', 'D'),
     PlayingCard.new('3', 'D')]
  end
  let(:books) { %w[A K J] }
  let(:player) { GoFishPlayer.new(name, hand, books) }
  let(:player_empty_hand) { GoFishPlayer.new(name) }

  context '#hand_size' do
    it 'returns the length of the hand' do
      expect(player.hand_size).to eq(5)
    end
  end
  context '#draw' do
    it 'takes one card from deck' do
      player_empty_hand.draw(deck)
      expect(player_empty_hand.hand_size).to eq(1)
    end
  end
  context '#number_of_books' do
    it 'returns the number of books a player has' do
      expect(player.number_of_books).to eq books.length
    end
  end
  context '#hand' do
    it 'shows the players hand'
  end
end
