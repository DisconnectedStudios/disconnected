module Disconnected
  class Level
    getter :bg, :obstacles

    def initialize(@bg : Background, @obstacles : Array(SF::RectangleShape))
    end

    def self.from_json(path : String)
      level_json = LevelJSON.from_json(File.read(path))
      bg = Background.new(level_json.background)
      obstacles = Array(SF::RectangleShape).new
      if (array = level_json.obstacles)
        array.each do |obs|
          rectangle = SF::RectangleShape.new(SF.vector2f(obs.size_x, obs.size_y))
          rectangle.position = {obs.x, obs.y}
          obstacles << rectangle
        end
      end
      self.new(bg, obstacles)
    end
  end
end
