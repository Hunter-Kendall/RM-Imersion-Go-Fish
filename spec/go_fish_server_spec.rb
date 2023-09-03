# frozen_string_literal: true

require 'socket'
require_relative '../lib/go_fish_server'

class MockGoFishSocketClient
  attr_reader :socket, :output

  def initialize(port)
    @socket = TCPSocket.new('localhost', port)
    @port = port
  end

  def provide_input(text)
    @socket.puts(text)
  end

  def capture_output(delay = 1.0)
    sleep(delay)
    @output = @socket.read_nonblock(1000) # not gets which blocks
  rescue IO::WaitReadable
    @output = ''
  end

  def close
    @socket&.close
  end
end

describe GoFishSocketServer do
  let(:server) { GoFishSocketServer.new }
  let(:clients) { [] }
  def connect_client(name, welcome_message)
    client = MockGoFishSocketClient.new(server.port_number)
    sleep 1
    clients.push client
    server.accept_new_client

    expect(client.capture_output).to match welcome_message

    client
  end

  def create_client
    client = MockGoFishSocketClient.new(server.port_number)
    sleep 1
    clients.push client
    client
  end
  before(:each) do
    server.start
  end

  after(:each) do
    clients.each(&:close)
    server.stop
  end

  around(:each) do |example|
    example.run
  rescue GoFishGame::NotEnoughPlayers
  end
  context 'game started' do
    xit 'Tells each player how many cards they have left' do
      server.start

      client1 = connect_client('Player 1', "Welcome. Waiting for another player to join.\n")
      client2 = connect_client('Player 2', "Welcome. Waiting for another player to join.\n")
      client3 = connect_client('Player 3', "Welcome. You are about to go fishing.\n")

      expect(client1.capture_output).to eq "Player 1 has 7 cards and 0 books\n"
      expect(client2.capture_output).to eq "Player 2 has 7 cards and 0 books\n"
      expect(client3.capture_output).to eq "Player 3 has 7 cards and 0 books\n"
    end
  end
  context '#client_creates_player' do
    it 'asks the client for its name' do
      name = 'Hunter'

      client = connect_client('Player 1', "Welcome. Waiting for another player to join.\n")
      client.provide_input(name)
      server.client_creates_player # asks for name
      # expect(client.capture_output).to eq "What is your name: \n"

      expect(server.clients_to_players.length).to eq(1)
    end
  end
  context 'Accept_new_client' do
    it 'accepts one client and asks for their name' do
      client1 = create_client
      server.accept_new_client
      output = client1.capture_output
      expect(output).to match 'Name?'
    end
    it 'client provides name' do
      client1 = create_client
      server.accept_new_client
      expect(client1.capture_output).to match 'Name?' # Name question
      client1.provide_input('Jacob')
      server.create_game_if_possible
      expect(client1.capture_output).to match 'Waiting for 1 more player'
    end
  end

  # context '#accept_new_client' do
  #   after(:each) do
  #     server.stop
  #     server.clients.each(&:close)
  #   end

  #   it 'accepts one client' do
  #     server.start
  #     client1 = MockGoFishSocketClient.new(server.port_number)
  #     server.accept_new_client
  #     client1.provide_input('Jacob')

  #     binding.irb

  #     expect(server.clients.first.last).to eql client1.socket
  #   end

  #   # it 'asks for name' do
  #   #   server.start
  #   #   client1 = MockGoFishSocketClient.new(server.port_number)
  #   #   server.accept_new_client
  #   #   expect(server.clients.first.socket).to_not eql client1
  #   # end

  #   # it 'accepts two clients' do
  #   #   server.start
  #   #   MockGoFishSocketClient.new(server.port_number)
  #   #   MockGoFishSocketClient.new(server.port_number)
  #   #   server.accept_new_client
  #   #   server.accept_new_client
  #   #   expect(server.clients).to have_length 2
  #   # end
  # end

  # Add more tests to make sure the game is being played
  # For example:
  #   make sure the mock client gets appropriate output
  #   make sure the next round isn't played until both clients say they are ready to play
  #   ...
end
