require "json"

module Disconnected
  class LevelJSON
    JSON.mapping(
      {
        title:      String,
        background: String,
        obstacles:  Array(ObstacleJSON)?,
        items:      Array(ItemJSON)?,
        player:     PlayerJSON,
      }
    )
  end

  class PlayerJSON
    JSON.mapping(
      {
        starting_position: StartingPositionJSON,
      }
    )
  end

  class StartingPositionJSON
    JSON.mapping(
      {
        x: Int32,
        y: Int32,
      }
    )
  end

  class ObstacleJSON
    JSON.mapping(
      {
        points: Array(PointJSON),
        name:   String,
      }
    )
  end

  class PointJSON
    JSON.mapping(
      {
        x: Int32,
        y: Int32,
      }
    )
  end

  class ItemJSON
    JSON.mapping(
      {
        id:      Int64,
        name:    String,
        x:       Int32,
        y:       Int32,
        texture: String,
      }
    )
  end
end
