module Disconnected
  class BasicChar
    getter :name, :sprite
    property :health, :speed

    def initialize(texture_path : Array(String), starting_position_x : Int32, starting_position_y : Int32, @name : String = "", @health : Int32 = 10)
      @speed = 1
      @images = Array(SF::Image).new
      texture_path.each do |p|
        @images << SF::Image.from_file(p)
      end
      @texture = SF::Texture.from_file(texture_path.first)
      @sprite = SF::Sprite.new(@texture)
      @sprite.position = SF.vector2(starting_position_x, starting_position_y)
      reset_sprite_position
      loop_texture
    end

    def loop_texture
      if @images.size > 1
        spawn do
          loop do
            @images.each do |i|
              @texture.update(i)
              Fiber.yield
              sleep 0.10
            end
            Fiber.yield
          end
        end
      end
    end

    def reset_sprite_position
      @sprite.origin = @texture.size / 2.0
      @sprite.scale = SF.vector2(0.9, 0.9)
    end

    def position
      @sprite.position
    end

    def position(pos : SF::Vector2)
      @sprite.position = pos
    end

    def move(direction : Symbol)
      case direction
      when :up
        @sprite.move Move.up(@speed)
      when :down
        @sprite.move Move.down(@speed)
      when :right
        @sprite.move Move.right(@speed)
      when :left
        @sprite.move Move.left(@speed)
      end
    end
  end
end
