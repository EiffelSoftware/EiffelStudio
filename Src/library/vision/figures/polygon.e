--|---------------------------------------------------------------
--| Copyright (C) Interactive Software Engineering, Inc.        --
--|  270 Storke Road, Suite 7 Goleta, California 93117          --
--|                      (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- POLYGON: Description of a polygon.

class POLYGON 

inherit

	CLOSED_FIG;

	TWO_WAY_LIST [COORD_XY_FIG];

	JOINABLE

creation

	make

feature 

	center: COORD_XY_FIG is
			-- Center of the polygon.
		require else
			polygon_not_empty: not empty
		local
			x, y: INTEGER
		do
			mark;
			from
				start
			until
				off
			loop
				x := x+item.x;
				y := y+item.y;
				forth
			end;
			return;
			!!Result;
			Result.set (x, y)
		end;

feature {NONE}

	compare (other: like Current; direction: BOOLEAN): BOOLEAN is
			-- Is the sublist of Current beginning at cursor position
			-- to the end surimposable to the sublist of other beginning
			-- at cursor position to the beginning if direction and to the
			-- end else ?
		require
			not (other = Void);
			not off;
			not other.off
		do
			if item.is_surimposable (other.item) then
				from
				until
					islast or else (not item.is_surimposable (i_th (position+1)))
				loop
					forth
				end;
				from
				until
					other.islast or else (not other.item.is_surimposable (other.i_th (position+1)))
				loop
					if direction then
						back
					else
						forth
					end
				end;
				forth;
				if direction then
					back
				else
					forth
				end;
				if off and other.off then
					Result := true
					elseif (not off) and (not other.off) then
					Result := compare (other, direction)
				end
			end
		end;

feature 

	draw is
			-- Draw the polygon.
		require else
			drawing_attached: not (drawing = Void)
		do
			if (count > 2) and then drawing.is_drawable then
				drawing.set_join_style (join_style);
				if not (interior = Void) then
					interior.set_drawing_attributes (drawing);
					drawing.fill_polygon (Current)
				end;
				if not (path = Void) then
					path.set_drawing_attributes (drawing);
					drawing.draw_polyline (Current, true)
				end
			end
		end;

	is_surimposable (other: like Current): BOOLEAN is
			-- Is the current set of line surimposable to `other' ?
		require else
			other_exists: not (other = Void)
		do
			if empty and other.empty then
				Result := true
				elseif (not empty) and (not other.empty) then
				mark;
				other.mark;
				start;
				other.start;
				Result := compare (other, false);
				if not Result then
					start;
					other.finish;
					Result := compare (other, true)
				end;
				other.return;
				return
			end
		end;

	origin: COORD_XY_FIG is
			-- Origin of line
		do
			inspect
				origin_user_type
			when 0 then
			when 1 then
				Result := origin_user
			when 2 then
				Result := first
			when 3 then
				Result := last
			when 4 then
				Result := center
			end
		end;

	set_origin_to_center is
			-- Set origin to `center'.
		do
			origin_user_type := 4
		ensure then
			origin.is_surimposable (center)
		end; 

	set_origin_to_first_point is
			-- Set origin to first point of polygon.
		do
			origin_user_type := 2
		ensure
			origin.is_surimposable (first)
		end;

	set_origin_to_last_point is
			-- Set origin to last point of polygon.
		do
			origin_user_type := 3
		ensure
			origin.is_surimposable (last)
		end;

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0
		do
			mark;
			from
				start
			until
				off
			loop
				item.xyrotate (a, px, py);
				forth
			end;
			return
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		do
			mark;
			from
				start
			until
				off
			loop
				item.xyscale (f, px, py);
				forth
			end;
			return
		end;

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		do
			mark;
			from
				start
			until
				off
			loop
				item.xytranslate (vx, vy);
				forth
			end;
			return
		end 

invariant

	origin_user_type <= 4;
	(not (drawing = Void)) implies (count <= drawing.max_count_for_draw_polyline)

end
