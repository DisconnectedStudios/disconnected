module Disconnected
  class InventoryMenu
    getter :name, :sprite

    def initialize(location : SF::Vector2,
                   @data : Array(Item),
                   @name : String,
                   texture_path : String,
                   @size : NamedTuple(w: Int32, h: Int32))
      #
      texture = SF::Texture.from_file(texture_path, SF.int_rect(0, 0, size[:w], size[:h]))
      texture.smooth = true
      @sprite = SF::Sprite.new(texture)
      @sprite.origin = SF.vector2(size[:w]/2, size[:h]/2)
      @sprite.position = location
    end

    def draw_menu(window)
      # Draw background
      window.draw(@sprite)

      # Add the menu header
      txt = Text.get_text
      txt.origin = SF.vector2(60, 0)
      txt.string = @name
      txt.color = SF::Color::Black
      txt.character_size = 24
      txt.style = SF::Text::Bold
      txt.position = @sprite.position.dup + SF.vector2(0, -(@size[:h] / 2))
      # txt.move(SF.vector2(0, -(@size[:h] / 2)))
      # txt.position.x = @player.position.x + 50.0_f32
      window.draw(txt)

      # Move drawing location to the table
      x_correction = (@size[:w] / 2) - 20
      y_correction = (@size[:h] / 2) - 50
      draw_location = @sprite.position.dup - SF.vector2(x_correction, y_correction)

      # Add table headers
      line_spacing = 30

      txt = Text.get_text
      txt.string = "Name\t\t\tID"
      txt.color = SF::Color::Black
      txt.character_size = 20
      txt.style = SF::Text::Underlined # Underline doesn't work, must be a bug
      txt.position = draw_location
      window.draw(txt)

      # Move to next line
      draw_location += SF.vector2(0, line_spacing*1.2)

      # Add table data
      @data.each do |i|
        data_text = Text.get_text
        data_text.string = "#{i.name}\t\t\t\t\t#{i.id.to_s}"
        data_text.color = SF::Color::Black
        data_text.character_size = 16
        data_text.position = draw_location
        window.draw(data_text)

        # Move to next line
        draw_location += SF.vector2(0, line_spacing)
      end
      @data.each do |i|
        data_text = Text.get_text
        data_text.string = "#{i.name}\t\t\t\t\t#{i.id.to_s}"
        data_text.character_size = 16
        data_text.position = draw_location
        window.draw(data_text)

        # Move sprite vertically
        draw_location += SF.vector2(0, line_spacing)
      end

      window.display
    end
  end
end
