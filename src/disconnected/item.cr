module Disconnected
  class Item < Interactable
    getter :name, :id, :sprite

    def initialize(@name : String, @id : Int64, texture : String, x : Int32, y : Int32)
      texture = SF::Texture.from_file(texture)
      @sprite = SF::Sprite.new(texture)
      @sprite.position = SF.vector2(x, y)
    end
  end
end
