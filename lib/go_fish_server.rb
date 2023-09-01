require 'socket'

require_relative 'go_fish_game'

class GoFishSocketServer
  # attr_reader :pending_clients, :server

  def initialize; end

  def port_number
    3336
  end

  def games
    @games ||= []
  end

  def read_input
    client.read_nonblock(1000)
  rescue StandardError
    nil
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def accept_new_client(_player_name = 'Random Player')
    client = @server.accept_nonblock
    pending_clients.push(client)
    client.puts(pending_clients.count % 3 == 0 ? 'Welcome. You are about to go fishing.' : 'Welcome. Waiting for another player to join.')
    # associate player and client
  rescue IO::WaitReadable, Errno::EINTR
    puts 'No client to accept'
  end

  def client_creates_player
    pending_clients.each do |client|
      next if clients_to_players.value?(client)

      client.puts('What is your name: ')
      name = read_input

      if name
        clients_to_players[client] = name
        puts 'added'
      end
    end
  end

  def create_game_if_possible
    client_creates_player
    return unless pending_clients.count > 2

    game = GoFishGame.new(pending_clients)

    games.push(game)
    games_to_humans[game] = pending_clients.shift(3)
    game.start
    inform_players_of_hand(game)
  end

  def stop
    return unless server

    server.close
    @clients = []
  end

  def clients_to_players
    @clients_to_players ||= {}
  end

  private

  def inform_players_of_hand(game)
    humans = games_to_humans[game]
    humans.each_with_index do |human, index|
      human.puts(game.players[index].hand)
    end
  end

  def pending_clients
    @pending_clients ||= []
  end

  def games_to_humans
    @games_to_humans ||= {}
  end
end
