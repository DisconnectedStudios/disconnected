module Disconnected
  class Render
    @window : SF::RenderWindow
    @player : Player
    @level : Level

    def initialize(@window, @level : Level, @player, @chars : Array(BasicChar))
      @main_view = @window.default_view.as(SF::View)
      @main_view.zoom(0.5)
      @main_view.viewport = SF.float_rect(0, 0, 1, 1)
      @main_view.center = @player.position
    end

    def run
      loop do
        @window.clear SF::Color.new(0, 0, 0)
        @main_view.center = @player.position
        @window.view = @main_view
        @window.draw @level.bg.sprite
        @window.draw @player.sprite
        @chars.each { |n| @window.draw n.sprite }
        @window.display
        Fiber.yield
        break unless @window.open?
      end
    end
  end
end
