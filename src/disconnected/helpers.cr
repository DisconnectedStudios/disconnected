module Disconnected
  module Move
    extend self

    def up(speed = 0)
      SF.vector2(0, -1 + -speed)
    end

    def down(speed = 0)
      SF.vector2(0, 1 + speed)
    end

    def right(speed = 0)
      SF.vector2(1 + speed, 0)
    end

    def left(speed = 0)
      SF.vector2(-1 + -speed, 0)
    end
  end

  module Intersection
    extend self

    def lines(p1_x : Int32, p1_y : Int32, p2_x : Int32, p2_y : Int32, p3_x : Int32, p3_y : Int32, p4_x : Int32, p4_y : Int32)
      intrsc_x1 = p2_x - p1_x
      intrsc_y1 = p2_y - p1_y
      intrsc_x2 = p4_x - p3_x
      intrsc_y2 = p4_y - p3_y

      v1 = (-intrsc_y1 * (p1_x - p3_x) + intrsc_x1 * (p1_y - p3_y)) / (-intrsc_x2 * intrsc_y1 + intrsc_x1 * intrsc_y2)
      v2 = (intrsc_x2 * (p1_y - p3_y) - intrsc_y2 * (p1_x - p3_x)) / (-intrsc_x2 * intrsc_y1 + intrsc_x1 * intrsc_y2)

      if (v1 >= 0 && v1 <= 1 && v2 >= 0 && v2 <= 1)
        return v1, v2
      end
      false
    end
  end
end
