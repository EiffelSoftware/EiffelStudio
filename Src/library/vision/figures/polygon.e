indexing

	description: "Description of a polygon";
	status: "See notice at end of class"
	date: "$Date$";
	revision: "$Revision$"

class

	POLYGON 

inherit
	CLOSED_FIG
		undefine
			copy, is_equal
		redefine
			conf_recompute
		end;

	TWO_WAY_LIST [COORD_XY_FIG]
		rename 
			make as twl_make,
			extend as add
		end

	JOINABLE
		undefine
			copy, is_equal
		end

creation

	make

feature -- Initialization 

	make  is
		do
			init_fig (Void);
			twl_make;
			!! path.make ;
			!! interior.make ;
			interior.set_no_op_mode;
		end;

feature -- Access

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

	center: COORD_XY_FIG is
			-- Center of the polygon.
		require else
			polygon_not_empty: not is_empty;
		local
			x, y: INTEGER;
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				x := x+item.x;
				y := y+item.y;
				forth
			end;
			go_to (keep_cursor);
			!!Result;
			Result.set (x, y)
		end;

feature -- Element change

	set_origin_to_center is
			-- Set origin to `center'.
		do
			origin_user_type := 4;
		ensure then
			origin.is_superimposable (center)
		end; 

	set_origin_to_first_point is
			-- Set origin to first point of polygon.
		do
			origin_user_type := 2;
		ensure
			origin.is_superimposable (first)
		end;

	set_origin_to_last_point is
			-- Set origin to last point of polygon.
		do
			origin_user_type := 3;
		ensure
			origin.is_superimposable (last)
		end;

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require else
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0;
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				item.xyrotate (a, px, py);
				forth
			end;
			go_to (keep_cursor);
			set_conf_modified
		end;

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0;
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				item.xyscale (f, px, py);
				forth
			end;
			go_to (keep_cursor);
			set_conf_modified
		end;

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		local
			keep_cursor: CURSOR;
		do
			keep_cursor := cursor;
			from
				start
			until
				off
			loop
				item.xytranslate (vx, vy);
				forth
			end;
			go_to (keep_cursor);	
			set_conf_modified
		end 

feature -- Output 

	draw is
			-- Draw the polygon.
		
		do
			if (count > 2) and then drawing.is_drawable then
				drawing.set_join_style (join_style);
				if interior /= Void then
					interior.set_drawing_attributes (drawing);
					drawing.fill_polygon (Current)
				end;
				if path /= Void then
					path.set_drawing_attributes (drawing);
					drawing.draw_polyline (Current, True)
				end
			end
		end;

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the current set of line superimposable to `other' ?
		require else
			other_exists: other = Void;
		local
			keep_cursor: CURSOR;
			other_keep_cursor: CURSOR;
		do
			if is_empty and other.is_empty then
				Result := True
				elseif (not is_empty) and (not other.is_empty) then
				keep_cursor := cursor;
				other_keep_cursor := cursor;
				start;
				other.start;
				Result := compare (other, False);
				if not Result then
					start;
					other.finish;
					Result := compare (other, True)
				end;
				other.go_to (other_keep_cursor);
				go_to (keep_cursor);
			end
		end;

feature {CONFIGURE_NOTIFY} -- Updating

	conf_recompute is
		local
			keep_cursor: CURSOR;
		do
			from
				!!surround_box.make;
				keep_cursor := cursor;
				start;
			until
				off
			loop
				surround_box.enlarge (item);
				forth;
			end;
			go_to (keep_cursor);
			unset_conf_modified
		end;

feature {NONE} -- Status report

	compare (other: like Current; direction: BOOLEAN): BOOLEAN is
			-- Is the sublist of Current beginning at cursor position
			-- to the end superimposable to the sublist of other beginning
			-- at cursor position to the beginning if direction and to the
			-- end else ?
		require
			other_exists: other /= Void;
			not_off: not off;
			not_other_off: not other.off
		do
			if item.is_superimposable (other.item) then
				from
				until
					islast or else (not item.is_superimposable (i_th (index+1)))
				loop
					forth
				end;
				from
				until
					other.islast or else (not other.item.is_superimposable (other.i_th (index+1)))
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
					Result := True
					elseif (not off) and (not other.off) then
					Result := compare (other, direction)
				end
			end
		end;

invariant

	origin_user_type_constarint: origin_user_type <= 4;
	drawable: (drawing /= Void) implies (count <= drawing.max_count_for_draw_polyline)

end -- class POLYGON


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

