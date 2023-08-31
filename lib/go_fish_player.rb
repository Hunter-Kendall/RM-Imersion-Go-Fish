# frozen_string_literal: true

require_relative 'card_deck'

# Player for the WarGame class
class GoFishPlayer
  attr_accessor :hand
  attr_reader :name, :books

  def initialize(name, hand = [], books = [])
    @name = name
    @hand = hand
    @books = books
  end

  def hand_size
    hand.length
  end

  def draw(deck)
    hand << deck.deal
  end

  def number_of_books
    books.length
  end
end
