# frozen_string_literal: true

require_relative 'card_deck'

# Player for the WarGame class
class GoFishPlayer
  attr_accessor :hand
  attr_reader :name

  def initialize(name, hand = [])
    @name = name
    @hand = hand
  end

  def hand_size
    hand.length
  end

  def draw(deck)
    hand << deck.deal
  end
end
