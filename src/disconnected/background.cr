module Disconnected
  class Background
    getter :sprite
    setter :texture

    @sprite : SF::Sprite

    def initialize(texture_path : String)
      texture = SF::Texture.from_file(texture_path)
      texture.repeated = true
      @sprite = SF::Sprite.new(texture)
    end

    def position
      @sprite.position
    end

    def position=(pos : SF::Vector2)
      @sprite.position = pos
    end
  end
end
