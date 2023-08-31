# frozen_string_literal: false

require_relative 'go_fish_player'

# The class the runs the go fish game.
class GoFishGame
  class NotEnoughPlayers < StandardError; end

  attr_accessor :deck, :players

  def initialize(players = [])
    @players = players
    @deck = CardDeck.new
  end

  def start
    raise NotEnoughPlayers if player_count < 2

    deck.shuffle_cards
    if player_count <= 3
      deal(7)
    else
      deal(5)
    end
  end

  def deal(num_of_cards)
    until num_of_cards == 0
      players.each do |player|
        player.draw(deck)
      end
      num_of_cards -= 1
    end
  end

  def player_count
    @players.length
  end

  def show_players
    players_string = ''
    players.each do |player|
      players_string << " #{player.name}"
    end
    players_string
  end

  def play_turn(player = players.pop)
    puts show_players
  end
end
