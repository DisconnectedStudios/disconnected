module Disconnected
  class EventLoop
    @window : SF::RenderWindow
    @player : Player
    @level : Level

    def initialize(@window, @player, @level)
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

    def direction_makes_collision?(direction : Symbol)
      return false if @level.obstacles.empty?

      p_position = @player.position.dup
      case direction
      when :up
        p_position.y -= 5
      when :down
        p_position.y += 5
      when :left
        p_position.x -= 5
      when :right
        p_position.x += 5
      end

      return true unless @level.bg.sprite.global_bounds.contains? p_position
      @level.obstacles.each do |obs|
        return true if obs.global_bounds.contains? p_position
      end
      false
    end

    def movment
      while SF::Keyboard.key_pressed?(SF::Keyboard::W)
        @player.move(:up) unless direction_makes_collision?(:up)
        if SF::Keyboard.key_pressed?(SF::Keyboard::A)
          @player.move(:left) unless direction_makes_collision?(:left)
        elsif SF::Keyboard.key_pressed?(SF::Keyboard::D)
          @player.move(:right) unless direction_makes_collision?(:right)
        end
        Fiber.yield
      end
      while SF::Keyboard.key_pressed?(SF::Keyboard::A)
        @player.move(:left) unless direction_makes_collision?(:left)
        if SF::Keyboard.key_pressed?(SF::Keyboard::S)
          @player.move(:down) unless direction_makes_collision?(:down)
        elsif SF::Keyboard.key_pressed?(SF::Keyboard::W)
          @player.move(:up) unless direction_makes_collision?(:up)
        end
        Fiber.yield
      end
      while SF::Keyboard.key_pressed?(SF::Keyboard::S)
        @player.move(:down) unless direction_makes_collision?(:down)
        if SF::Keyboard.key_pressed?(SF::Keyboard::A)
          @player.move(:left) unless direction_makes_collision?(:left)
        elsif SF::Keyboard.key_pressed?(SF::Keyboard::D)
          @player.move(:right) unless direction_makes_collision?(:right)
        end
        Fiber.yield
      end
      while SF::Keyboard.key_pressed?(SF::Keyboard::D)
        @player.move(:right) unless direction_makes_collision?(:right)
        if SF::Keyboard.key_pressed?(SF::Keyboard::S)
          @player.move(:down) unless direction_makes_collision?(:down)
        elsif SF::Keyboard.key_pressed?(SF::Keyboard::W)
          @player.move(:up) unless direction_makes_collision?(:up)
        end
        Fiber.yield
      end
    end
  end
end
