class PlayerHand
  attr_accessor :hand

  def initialize(hand = [])
    @hand = hand
  end

  def size
    hand.length
  end

  def pick_up_card(card)
    hand << card
  end

  def cards_to_string
    cards_string = ''
    hand.each do |card|
      cards_string << " #{card}"
    end
    cards_string
  end

  def to_s
    "Your Hand:#{cards_to_string}"
  end
end
