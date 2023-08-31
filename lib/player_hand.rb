class PlayerHand
  attr_reader :hand

  def initialize(hand = [])
    @hand = hand
  end

  def get_cards_to_string
    cards_string = ''
    hand.each do |card|
      cards_string << " #{card}"
    end
    cards_string
  end

  def to_s
    "Your Hand:#{get_cards_to_string}"
  end
end
