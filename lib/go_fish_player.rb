# frozen_string_literal: true

require_relative 'card_deck'
require_relative 'player_hand'

# Player for the WarGame class
class GoFishPlayer
  attr_accessor :hand
  attr_reader :name, :books

  def initialize(name, hand = PlayerHand.new, books = [])
    @name = name
    @hand = hand
    @books = books
  end

  def hand_size
    hand.size
  end

  def draw(deck)
    hand.pick_up_card(deck.deal)
  end

  def number_of_books
    books.length
  end
end
