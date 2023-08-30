# frozen_string_literal: true

# creates all the cards that will be used by Player Game and Deck
class PlayingCard
  attr_reader :suit, :rank, :rank_ratings

  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[D H S C].freeze

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def ==(other)
    other.respond_to?(:rank) && other.respond_to?(:suit) &&
      rank == other.rank && suit == other.suit
  end

  def rank_rating
    RANKS.find_index(rank)
  end
end
