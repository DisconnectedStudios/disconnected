require "crsfml"
require "./disconnected/**"

# TODO: Write documentation for `Disconnected`
module Disconnected
  class Game
    def initialize(resolution_x : Int32, resolution_y : Int32, full_screen : Bool, vsync : Bool = true)
      mode = SF::VideoMode.new(resolution_x, resolution_y)
      @window = SF::RenderWindow.new(mode, "Disconnected", full_screen ? SF::Style::Fullscreen : SF::Style::Default)
      @window.vertical_sync_enabled = vsync

      @levels = Array(Level).new
      load_levels
      @player = Player.new(["resources/player/player.png"], @levels.first.player.starting_position.x, @levels.first.player.starting_position.x)
      @chars = Array(BasicChar).new
      @event_loop = EventLoop.new(@window, @player, @levels.first, @chars)
    end

    def load_levels
      glob = Dir.glob("data/levels/*")
      raise "No Level data !" if glob.empty?
      glob.sort.each do |lvl_path|
        puts "loading level: #{lvl_path}"
        @levels << Level.from_json(lvl_path)
      end
    end

    def run
      @event_loop.run
    end
  end
end

g = Disconnected::Game.new(1920, 1080, false, true)
g.run
