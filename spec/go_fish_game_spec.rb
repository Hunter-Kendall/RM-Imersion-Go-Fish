# frozen_string_literal: true

require_relative '../lib/go_fish_game'
require_relative '../lib/go_fish_player'

describe GoFishGame do
  let(:player1) { GoFishPlayer.new('Hunter') }
  let(:player2) { GoFishPlayer.new('Benj') }
  let(:player3) { GoFishPlayer.new('Jacob') }
  let(:player4) { GoFishPlayer.new('Caleb') }
  let(:player5) { GoFishPlayer.new('Jeremy') }
  let(:player_count5) { [player1, player2, player3, player4, player5] }

  let(:player_count3) { [player1, player2, player3] }
  let(:game_3player) { GoFishGame.new(player_count3) }
  let(:game_5player) { GoFishGame.new(player_count5) }
  card_count3 = 7 # card count for 3 players
  card_count5 = 5 # card count for 5 players

  context '#start' do
    it 'can deal cards to 3 players' do
      game_3player.start
      expect(player1.hand_size).to eq(card_count3)
      expect(player2.hand_size).to eq(card_count3)
      expect(player3.hand_size).to eq(card_count3)
    end
    it 'can deal cards to 5 players' do
      game_5player.start
      expect(player1.hand_size).to eq(card_count5)
      expect(player2.hand_size).to eq(card_count5)
      expect(player3.hand_size).to eq(card_count5)
      expect(player4.hand_size).to eq(card_count5)
      expect(player5.hand_size).to eq(card_count5)
    end
    it 'raises exception when there are 1 or no players' do
      game1 = GoFishGame.new
      game2 = GoFishGame.new([player1])
      expect { game1.start }.to raise_error(GoFishGame::NotEnoughPlayers)
      expect { game2.start }.to raise_error(GoFishGame::NotEnoughPlayers)
    end
  end
  context '#show_players' do
    it 'returns a string of all the players in the game' do
      expect(game_3player.show_players).to eq(" #{player1.name} #{player2.name} #{player3.name}")
    end
  end
  context '#play_turn' do
    it 'shows all the other players to take from' do
      message = " #{player1.name} #{player2.name}"
      expect(game_3player).to receive(:puts).with(message)
      game_3player.play_turn
    end
  end
end
