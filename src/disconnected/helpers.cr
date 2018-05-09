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
      s1_x = p2_x - p1_x
      s1_y = p2_y - p1_y

      s2_x = p4_x - p3_x
      s2_y = p4_y - p3_y

      s = (-s1_y * (p1_x - p3_x) + s1_x * (p1_y - p3_y)) / (-s2_x * s1_y + s1_x * s2_y)
      t = (s2_x * (p1_y - p3_y) - s2_y * (p1_x - p3_x)) / (-s2_x * s1_y + s1_x * s2_y)

      if (s >= 0 && s <= 1 && t >= 0 && t <= 1)
        # collision!
        return true
      end
      false
      #       // Returns 1 if the lines intersect, otherwise 0. In addition, if the lines
      # // intersect the intersection point may be stored in the floats i_x and i_y.
      # char get_line_intersection(float p0_x, float p0_y, float p1_x, float p1_y,
      #     float p2_x, float p2_y, float p3_x, float p3_y, float *i_x, float *i_y)
      # {
      #     float s1_x, s1_y, s2_x, s2_y;
      #     s1_x = p1_x - p0_x;     s1_y = p1_y - p0_y;
      #     s2_x = p3_x - p2_x;     s2_y = p3_y - p2_y;

      #     float s, t;
      #     s = (-s1_y * (p0_x - p2_x) + s1_x * (p0_y - p2_y)) / (-s2_x * s1_y + s1_x * s2_y);
      #     t = ( s2_x * (p0_y - p2_y) - s2_y * (p0_x - p2_x)) / (-s2_x * s1_y + s1_x * s2_y);

      #     if (s >= 0 && s <= 1 && t >= 0 && t <= 1)
      #     {
      #         // Collision detected
      #         if (i_x != NULL)
      #             *i_x = p0_x + (t * s1_x);
      #         if (i_y != NULL)
      #             *i_y = p0_y + (t * s1_y);
      #         return 1;
      #     }

      #     return 0; // No collision
      # }
    end
  end
end
