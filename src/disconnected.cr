require "crsfml"
require "./disconnected/**"

# TODO: Write documentation for `Disconnected`
module Disconnected
  class Game
    def initialize(resolution_x : Int32, resolution_y : Int32, full_screen : Bool, vsync : Bool = true)
      mode = SF::VideoMode.new(resolution_x, resolution_y)
      @window = SF::RenderWindow.new(mode, "Disconnected", full_screen ? SF::Style::Fullscreen : SF::Style::Default)
      @window.vertical_sync_enabled = vsync
      @player = Player.new(["resources/player/player.png"], 350, 300)
      @levels = Array(Level).new
      load_levels
      @event_loop = EventLoop.new(@window, @player, @levels.first)
      @chars = Array(BasicChar).new
      @renderer = Render.new(@window, @levels.first, @player, @chars)
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
      spawn do
        @renderer.run
      end
      @event_loop.run
    end
  end
end

g = Disconnected::Game.new(1920, 1080, false, true)
g.run
