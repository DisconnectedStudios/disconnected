module Disconnected
  class EventLoop
    @window : SF::RenderWindow
    @player : Player
    @bg : Background

    def initialize(@window, @player, @bg)
    end

    def run
      while @window.open?
        while event = @window.poll_event
          case event
          when SF::Event::Closed
            @window.close
          when SF::Event::KeyPressed
            case event.code
            when .w?
              movment
            when .a?
              movment
            when .s?
              movment
            when .d?
              movment
            when .escape?
              @window.close
            end
          end
          Fiber.yield
        end
        Fiber.yield
      end
    end

    def movment
      while SF::Keyboard.key_pressed?(SF::Keyboard::W)
        @player.move(:up)
        if SF::Keyboard.key_pressed?(SF::Keyboard::A)
          @player.move(:left)
        elsif SF::Keyboard.key_pressed?(SF::Keyboard::D)
          @player.move(:right)
        end
        Fiber.yield
      end
      while SF::Keyboard.key_pressed?(SF::Keyboard::A)
        @player.move(:left)
        if SF::Keyboard.key_pressed?(SF::Keyboard::S)
          @player.move(:down)
        elsif SF::Keyboard.key_pressed?(SF::Keyboard::W)
          @player.move(:up)
        end
        Fiber.yield
      end
      while SF::Keyboard.key_pressed?(SF::Keyboard::S)
        @player.move(:down)
        if SF::Keyboard.key_pressed?(SF::Keyboard::A)
          @player.move(:left)
        elsif SF::Keyboard.key_pressed?(SF::Keyboard::D)
          @player.move(:right)
        end
        Fiber.yield
      end
      while SF::Keyboard.key_pressed?(SF::Keyboard::D)
        @player.move(:right)
        if SF::Keyboard.key_pressed?(SF::Keyboard::S)
          @player.move(:down)
        elsif SF::Keyboard.key_pressed?(SF::Keyboard::W)
          @player.move(:up)
        end
        Fiber.yield
      end
    end
  end
end
