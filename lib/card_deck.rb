# frozen_string_literal: true

require_relative 'playing_card'

# This is the deck of cards that will be used for WarGame.
class CardDeck
  attr_accessor :cards

  def initialize
    @cards = generate_cards
  end

  def cards_left
    cards.length
  end

  def deal
    cards.pop
  end

  def shuffle_cards(seed = rand(9999))
    self.cards = cards.shuffle(random: Random.new(seed))
  end

  private

  def generate_cards
    PlayingCard::SUITS.flat_map do |suit|
      PlayingCard::RANKS.map do |rank|
        PlayingCard.new(rank, suit)
      end
    end
  end
end
