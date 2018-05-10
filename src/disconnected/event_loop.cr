module Disconnected
  class EventLoop
    @window : SF::RenderWindow
    @player : Player
    @level : Level
    @chars : Array(BasicChar)

    def initialize(@window, @player, @level, @chars)
      @main_view = @window.default_view.as(SF::View)
      @main_view.zoom(0.5)
      @main_view.viewport = SF.float_rect(0, 0, 1, 1)
      @main_view.center = @player.position
      @block_render = false
    end

    def handle_interactions
      case (interaction = @player.interactions.first)
      when .is_a?(Item)
        @player.inventory << interaction
        @player.interactions.delete(interaction)
        @level.items.delete(interaction)
        txt = Text.get_text
        txt.string = "Got Item: #{interaction}"
        txt.position = @player.position
        @window.draw(txt)
        @block_render = true
      when .is_a?(BasicChar)
      end
    end

    def render
      loop do
        @window.clear SF::Color.new(0, 0, 0)
        @main_view.center = @player.position
        @window.view = @main_view
        @window.draw @level.bg.sprite
        @window.draw @player.sprite
        unless @player.interactions.empty?
          handle_interactions
        end
        # @level.obstacles.each { |obs| @window.draw obs }
        @level.items.each { |itm| @window.draw itm.sprite }
        @chars.each { |n| @window.draw n.sprite }
        @window.display
        Fiber.yield
        while @block_render
          Fiber.yield
        end
        break unless @window.open?
      end
    end

    def run
      spawn render
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
            when .space?
              check_interactions
            when .escape?
              @window.close
            when .enter?
              @block_render = false
            end
          end
          Fiber.yield
        end
        Fiber.yield
      end
    end

    def check_interactions
      @level.items.each do |itm|
        if itm.sprite.global_bounds.contains? @player.position
          @player.interactions << itm
        end
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
      @level.obstacles.each do |obs| # obs is a ConvexShape
        next unless obs.global_bounds.contains? p_position
        obs.point_count.times do |point|
          break if point + 1 > obs.point_count
          p1 = obs.get_point(point)
          p2 = obs.get_point(point + 1)
          if (Intersection.lines(
               p_position.x.to_i,
               p_position.y.to_i,
               @level.player.starting_position.x.to_i,
               @level.player.starting_position.y.to_i,
               p1.x.to_i,
               p1.y.to_i,
               p2.x.to_i,
               p2.y.to_i
             ) == {0, 0})
            return true
          end
        end
      end
      false
    rescue DivisionByZero
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
