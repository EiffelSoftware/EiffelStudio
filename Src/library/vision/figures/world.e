--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                      (805) 685-1006                                --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- WORLD: Manager of figures.

indexing

	date: "$Date$";
	revision: "$Revision$"

class WORLD 

inherit

	LINKED_LIST [FIGURE]
		rename
			add as list_add,
			add_left as list_add_left,
			add_right as list_add_right,
			duplicate as list_duplicate,
			merge_left as list_merge_left,
			merge_right as list_merge_right,
			put as list_put,
			put_i_th as list_put_i_th,
			put_left as list_put_left,
			put_right as list_put_right,
            make as linked_list_make
		end;

	LINKED_LIST [FIGURE]
		rename
            make as linked_list_make
		redefine
			put_right, 
			put_left, 
			put_i_th, 
			put, 
			merge_right, 
			merge_left, 
			duplicate, 
			add_right, 
			add_left,
			add
		select
			put_right, 
			put_left, 
			put_i_th, 
			put, 
			merge_right, 
			merge_left, 
			duplicate, 
			add_right, 
			add_left,
			add
		end

creation

	make

feature 

	add (v: like first) is
			-- Append `v' to list.
		do
			v.attach_drawing_imp (drawing);
			list_add (v)
		end;

	add_left (v: like first) is
			-- Put item `v' to the left of cursor position.
			-- Do not move cursor.
			-- Synonym for `put_left'.
		do
			v.attach_drawing_imp (drawing);
			list_add_left (v)
		end;

	add_right (v: like first) is
			-- Put item `v' to the right of cursor position.
			-- Do not move cursor.
			-- Synonym for `put_right'.
		do
			v.attach_drawing_imp (drawing);
			list_add_right (v)
		end;

	attach_drawing (a_drawing: DRAWING) is
			-- Attach a drawing to the figure.
		do
			drawing := a_drawing.implementation;
			mark;
			from
				start
			until
				off
			loop
				item.attach_drawing_imp (drawing);
				forth
			end;
			return
		end;

feature {WORLD}

	attach_drawing_imp (a_drawing: DRAWING_I) is
			-- Attach a drawing to the figure.
			-- (use directly a DRAWING_I, private use only)
		do
			drawing := a_drawing
		end;

feature 

	make is
			-- Create a world
		do
			linked_list_make;
			!! origin
		ensure
			empty
		end;

	draw is
			-- Draw the figure in `drawing'.
		require
			a_drawing_attached: not (drawing = Void)
		do
			if drawing.is_drawable then
				mark;
				from
					start
				until
					off
				loop
					item.draw;
					forth
				end;
				return
			end
		end;

feature {NONE}

	drawing: DRAWING_I;
			-- Drawing in which the figure will be drawn

feature 

	duplicate (n: INTEGER): like Current is
			-- Copy of the sub-list beginning at cursor position
			-- and comprising min (`n', count-position+1) items
		require else
			not_off: not off;
			valid_sublist: n >= 0
		do
			Result := list_duplicate (n);
			Result.attach_drawing_imp (drawing);
			Result.set_origin (origin)
		end;

	merge_left (other: like Current) is
			-- Merge `other' into the current list before
			-- cursor position.
			-- Do not move cursor.
			-- Empty other.
		do
			from
				other.start
			until
				other.off
			loop
				other.attach_drawing_imp (drawing);
				other.forth
			end;
			list_merge_left (other)
		end;

	merge_right (other: like Current) is
			-- Merge `other' into the current list after
			-- cursor position.
			-- Do not move cursor.
			-- Empties other.
		do
			from
				other.start
			until
				other.off
			loop
				other.attach_drawing_imp (drawing);
				other.forth
			end;
			list_merge_right (other)
		end;

	origin: COORD_XY_FIG;
			-- Origin of the world

	put (v: like first) is
			-- Put item `v' at cursor position.
		require else
			not_off: not off
		do
			v.attach_drawing_imp (drawing);
			list_put (v)
		end;

	put_i_th (v: like first; i: INTEGER) is
			-- Put item `v' at `i'-th position.
		do
			v.attach_drawing_imp (drawing);
			list_put_i_th (v, i)
		end;

	put_left (v: like first) is
			-- Put item `v' to the left of cursor position.
			-- Do not move cursor.
		do
			v.attach_drawing_imp (drawing);
			list_put_left (v)
		end;

	put_right (v: like first) is
			-- Put item `v' to the right of cursor position.
			-- Do not move cursor.
		do
			v.attach_drawing_imp (drawing);
			list_put_right (v);
		end;

	rotate (a: REAL; p: like origin) is
			-- Rotate figure by `a' relative to `p'.
			-- Angle `a' is measured in degrees.
		require
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0;
			point_exists: not (p = Void)
		do
			mark;
			from
				start
			until
				off
			loop
				item.rotate (a, p);
				forth
			end;
			return
		end;

	scale (f: REAL; p: like origin) is
			-- Scale figure by `f' relative to `p'.
		require
			scale_factor_positive: f > 0.0;
			point_exists: not (p = Void)
		do
			mark;
			from
				start
			until
				off
			loop
				item.scale (f, p);
				forth
			end;
			return
		end;

	self_rotate (a: REAL) is
			-- Rotate figure by `a' relative to `origin'.
			-- Angle is measured in degrees.
		require
			a_smaller_than_360: a < 360;
			a_positive: a >= 0.0;
			origin_exists: not (origin = Void)
		do
			mark;
			from
				start
			until
				off
			loop
				item.rotate (a, origin);
				forth
			end;
			return
		end;

	self_scale (f: REAL) is
			-- Scale figure by `f' relative to `origin'.
		require
			scale_factor_positive: f > 0.0;
			origin_exists: not (origin = Void)
		do
			mark;
			from
				start
			until
				off
			loop
				item.scale (f, origin);
				forth
			end;
			return
		end;

feature {NONE}

	set_no_origin is
			-- Erase definition of `origin'.
		do
			origin := Void
		ensure
			(origin = Void)
		end;

feature 

	set_origin (p: like origin) is
			-- Set `origin' to `p'.
		require
			p_exists: not (p = Void)
		do
			origin := p
		ensure
			origin = p
		end;

	translate (v: VECTOR) is
			-- Translate current figure by `v'.
		require
			vector_exists: not (v = Void)
		do
			mark;
			from
				start
			until
				off
			loop
				item.translate (v);
				forth
			end;
			return
		end;

	xyrotate (a: REAL; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in degrees.
		require
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
		require
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
		end;

end
