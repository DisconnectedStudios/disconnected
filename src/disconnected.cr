require "crsfml"
require "./disconnected/**"

# TODO: Write documentation for `Disconnected`
module Disconnected
  class Game
    def initialize(resolution_x : Int32, resolution_y : Int32, full_screen : Bool, vsync : Bool = true)
      mode = SF::VideoMode.new(resolution_x, resolution_y)
      @window = SF::RenderWindow.new(mode, "Disconnected", full_screen ? SF::Style::Fullscreen : SF::Style::Default)
      @window.vertical_sync_enabled = vsync
      @player = Player.new(["resources/player/player.png"])
      @bg = Background.new("resources/Backgrounds/Chapter 01 - Forest clearing .png")
      @event_loop = EventLoop.new(@window, @player)
      @chars = Array(BasicChar).new
      @renderer = Render.new(@window, @bg, @player, @chars)
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
