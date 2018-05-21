require "./basic_char.cr"

module Disconnected
  class Player < BasicChar
    property :interactions
    getter :inventory, :sprite

    def initialize(texture_path : Array(String),
                   starting_position_x : Int32,
                   starting_position_y : Int32,
                   @name : String = "",
                   @health : Int32 = 10)
      @speed = 1
      @images = Array(SF::Image).new
      texture_path.each do |p|
        @images << SF::Image.from_file(p)
      end
      @texture = SF::Texture.from_file(texture_path.first)
      @sprite = SF::Sprite.new(@texture)
      @sprite.position = SF.vector2(starting_position_x, starting_position_y)
      @interactions = Array(Item | BasicChar).new
      @inventory = Array(Item).new
      reset_sprite_position
      loop_texture
    end

    def stats : SF::Text
      a = @attributes.map do |attr|
        "\n~~~~~~~~\n" + attr.inspect
      end

      headline = get_text
      headline.string = <<-EOF
      ~~STATS~~
      Health: #{@health}
      Mutation Cycles: #{@mutation_counter}
      ~~Attributes~~
      #{a.join("\n")}
      EOF

      headline
    end
  end
end
