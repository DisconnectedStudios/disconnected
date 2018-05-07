module Disconnected
  class Render
    @window : SF::RenderWindow
    @player : Player

    def initialize(@window, @player, @npcs : Array(NPC))
    end

    def run
      loop do
        @window.clear SF::Color.new(0, 0, 0)
        @main_view.center = @player.position
        @window.view = @main_view
        @window.draw @level.bg.sprite
        @window.draw @player.sprite
        npc_random_move
        @npcs.each { |n| @window.draw n.sprite }
        @window.view = @stats_view
        @window.draw @side_bar.sprite
        @window.draw @player.stats
        @window.display
        Fiber.yield
        break unless @window.open?
      end
    end
  end
end
