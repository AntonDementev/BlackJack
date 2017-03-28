#!/usr/bin/env ruby

require_relative 'card'
require_relative 'card_stock'
require_relative 'player'
require_relative 'player_ai'
require_relative 'player_human'
require_relative 'black_jack'

game = BlackJack.new
game.begin_game
