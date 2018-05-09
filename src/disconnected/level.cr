module Disconnected
  class Level
    getter :bg, :obstacles, :items, :player

    def initialize(@bg : Background, @obstacles : Array(SF::ConvexShape), @items : Array(Item), @player : PlayerJSON)
    end

    def self.from_json(path : String)
      level_json = LevelJSON.from_json(File.read(path))
      bg = Background.new(level_json.background)
      obstacles = Array(SF::ConvexShape).new
      items = Array(Item).new
      if (array = level_json.obstacles)
        array.each do |obs|
          shape = SF::ConvexShape.new
          shape.point_count = obs.points.size
          obs.points.each_with_index do |point, i|
            shape[i] = SF.vector2f(point.x, point.y)
          end
          # # DEBUG
          shape.fill_color = SF::Color::Transparent
          shape.outline_color = SF::Color::Red
          shape.outline_thickness = 2
          # # END DEBUG
          obstacles << shape
        end
      end
      if (array = level_json.items)
        array.each do |itm|
          item = Item.new(itm.name, itm.id, itm.texture, itm.x, itm.y)
          items << item
        end
      end
      self.new(bg, obstacles, items, level_json.player)
    end
  end
end
