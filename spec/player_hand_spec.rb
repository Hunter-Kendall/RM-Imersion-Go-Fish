require_relative '../lib/player_hand'
require_relative '../lib/playing_card'

describe 'PlayerHand' do
  let(:hand) { PlayerHand.new([PlayingCard.new('A', 'S'), PlayingCard.new('4', 'S'), PlayingCard.new('2', 'S')]) }
  context '#to_s' do
    it 'returns a string of all the cards in the hand' do
      expect(hand.to_s).to eq("Your Hand: A'S 4'S 2'S")
    end
  end
end
