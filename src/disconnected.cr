require "crsfml"
require "./disconnected/**"

# TODO: Write documentation for `Disconnected`
module Disconnected
  class Game
    def initialize(resolution_x : Int32, resolution_y : Int32, full_screen : Bool, vsync : Bool = true)
      mode = SF::VideoMode.new(resolution_x, resolution_y)
      @window = SF::RenderWindow.new(mode, "Disconnected", full_screen ? SF::Style::Fullscreen : SF::Style::None)
      @window.vertical_sync_enabled = vsync
      @player = Player.new(["resources/player/player.png"])
      @event_loop = EventLoop.new(@window, @player)
      @renderer = Render.new(@window, @player)
    end

    def run
      spawn @renderer.run
      @event_loop.run
    end
  end
end

g = Disconnected::Game.new(1920, 1080, false, true)
g.run
