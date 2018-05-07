require "json"

module Disconnected
  class LevelJSON
    JSON.mapping(
      {
        title:      String,
        background: String,
        obstacles:  Array(ObstaclesJSON)?,
        items:      Array(ItemsJSON)?,
      }
    )
  end

  class ObstaclesJSON
    JSON.mapping(
      {
        x:      Int32,
        y:      Int32,
        size_x: Int32,
        size_y: Int32,
        name:   String?,
      }
    )
  end

  class ItemsJSON
    JSON.mapping(
      {
        id:   Int64,
        name: String?,
        x:    Int32,
        y:    Int32,
      }
    )
  end
end
