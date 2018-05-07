module Disconnected
  class Render
    @window : SF::RenderWindow
    @player : Player
    @bg : Background

    def initialize(@window, @bg, @player, @chars : Array(BasicChar))
      @main_view = @window.default_view.as(SF::View)
      @main_view.viewport = SF.float_rect(0, 0, 1, 1)
      @main_view.center = @player.position
    end

    def run
      loop do
        @window.clear SF::Color.new(0, 0, 0)
        @main_view.center = @player.position
        @window.view = @main_view
        # @window.draw @level.bg.sprite
        @window.draw @bg.sprite
        @window.draw @player.sprite
        @chars.each { |n| @window.draw n.sprite }
        # @window.view = @stats_view
        # @window.draw @side_bar.sprite
        # @window.draw @player.stats
        @window.display
        Fiber.yield
        break unless @window.open?
      end
    end
  end
end
