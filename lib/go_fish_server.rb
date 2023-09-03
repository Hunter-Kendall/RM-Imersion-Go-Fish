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

  def read_input(client)
    begin
      input = client.read_nonblock(1000)
    rescue IO::WaitReadable, Errno::EINTR
    end
    input
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def accept_new_client(_player_name = 'Random Player')
    client = @server.accept_nonblock
    pending_clients.push(client)
    client.puts(pending_clients.count % 3 == 0 ? 'Welcome. You are about to go fishing.' : 'Welcome. Waiting for another player to join.')
    client.puts 'Name?'
    # associate player and client
  rescue IO::WaitReadable, Errno::EINTR
    puts 'No client to accept'
  end

  def client_creates_player
    pending_clients.each do |client|
      next if clients_to_players[client]

      # begin
      #   name = client.read_nonblock(1000)
      #   puts "create #{name}"
      #   clients_to_players[client] = GoFishPlayer.new(name: name.chomp)
      #   client.puts 'Waiting for 1 more player' if pending_clients.size.odd?
      # rescue IO::WaitReadable, Errno::EINTR
      # end

      name = read_input(client)
      puts "name #{name}"
      clients_to_players[client] = name if name
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

  # def create_game_if_possible
  #   # capture input of the name
  #   pending_clients.each do |client|
  #     next if clients_to_players[client]

  #     begin
  #       name = client.read_nonblock(1000)
  #       puts "name #{name}"
  #       clients_to_players[client] = GoFishPlayer.new(name: name.chomp)
  #       client.puts 'Waiting for 1 more player' if pending_clients.size.odd?
  #     rescue IO::WaitReadable, Errno::EINTR
  #     end
  #   end

  #   return unless pending_clients.size.even?

  #   # start a game if possible
  #   pending_clients.each do |client|
  #     client.puts 'Game is starting...'
  #   end
  #   GoFishGame.new(players: clients_to_players.values.last(2))
  # end

  def stop
    return unless @server

    @server.close
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
