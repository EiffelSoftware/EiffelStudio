indexing
	description: "EiffelVision polyline."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POLYLINE

inherit
	EV_OPEN_FIGURE
		redefine
			translate,
			set_origin,
			set_no_origin,
			self_scale,
			self_rotate,
			scale,
			rotate,
			clip_draw,
			recompute,
			attach_drawing
		end

	EV_ENDED_FIGURE

	EV_PATH
		redefine
			make
		end

	LINKED_LIST [EV_PIXEL]
		rename
			extend as add
		redefine
			make,
			put_right,
			put_left,
			put_i_th,
			put,
			merge_right,
			merge_left,
			duplicate,
			add,
			wipe_out
		end

create
	make 

feature {NONE} -- Initialization

	make is
			-- Create a world as a figure with f as a figure 
			-- for visual modification notification
		do
			init_fig (Void)
			{EV_PATH} Precursor
			create changes_box.make
			create surround_box.make
			{LINKED_LIST} Precursor
			create origin.make
		end

feature -- Access

	origin: EV_POINT
			-- Origin of the world

feature -- Duplication

	duplicate (n: INTEGER): like Current is
			-- Copy of the sub-list beginning at cursor position
			-- and comprising min (`n', count-position+1) items
		require else
			not_off: not off
			valid_sublist: n >= 0
		do
			Result ?= {LINKED_LIST} Precursor (n)
			Result.attach_drawing (drawing)
			Result.set_origin (origin)
		end

feature  -- Element change

	add (v: like first) is
			-- Append `v' to list.
		do
			v.attach_drawing (drawing)
			{LINKED_LIST} Precursor (v)
			set_modified
		end

	put_left (v: like first) is
			-- Put item `v' to the left of cursor position.
			-- Do not move cursor.
		do
			v.attach_drawing (drawing)
			{LINKED_LIST} Precursor (v)
			set_modified
		end

	put_right (v: like first) is
			-- Put item `v' to the right of cursor position.
			-- Do not move cursor.
		do
			v.attach_drawing (drawing)
			{LINKED_LIST} Precursor (v)
			set_modified
		end

	attach_drawing (a_drawing: EV_DRAWABLE) is
			-- Attach a drawing to the figure.
		local
			keep_cursor: CURSOR
		do
			drawing := a_drawing
			keep_cursor := cursor
			from
				start
			until
				off
			loop
				item.attach_drawing (drawing)
				forth
			end
			go_to (keep_cursor)
			set_modified_with (surround_box)
		end

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
				other.attach_drawing (drawing)
				other.forth
			end
			{LINKED_LIST} Precursor (other)
			set_modified
		end

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
				other.attach_drawing (drawing)
				other.forth
			end
			{LINKED_LIST} Precursor (other)
			set_modified
		end

	put (v: like first) is
			-- Put item `v' at cursor position.
		require else
			not_off: not off
		do
			v.attach_drawing (drawing)
			{LINKED_LIST} Precursor (v)
			set_modified
		end

	put_i_th (v: like first; i: INTEGER) is
			-- Put item `v' at `i'-th position.
		do
			v.attach_drawing (drawing)
			{LINKED_LIST} Precursor (v, i)
			set_modified
		end

	rotate (a: EV_ANGLE; p: like origin) is
			-- Rotate figure by `a' relative to `p'.
			-- Angle `a' is measured in radians.
		require else
			point_exists: p /= Void
		local
			keep_cursor: CURSOR
		do
			keep_cursor := cursor
			from
				start
			until
				off
			loop
				item.rotate (a, p)
				forth
			end
			go_to (keep_cursor)
			set_modified
		end

	scale (f: REAL; p: like origin) is
			-- Scale figure by `f' relative to `p'.
		require else
			scale_factor_positive: f > 0.0
			point_exists: p /= Void
		local
			keep_cursor: CURSOR
		do
			keep_cursor := cursor
			from
				start
			until
				off
			loop
				item.scale (f, p)
				forth
			end
			go_to (keep_cursor)
			set_modified
		end

	self_rotate (a: EV_ANGLE) is
			-- Rotate figure by `a' relative to `origin'.
			-- Angle is measured in degrees.
		require else
			origin_exists: origin /= Void
		local
			keep_cursor: CURSOR
		do
			keep_cursor := cursor
			from
				start
			until
				off
			loop
				item.rotate (a, origin)
				forth
			end
			go_to (keep_cursor)
			set_modified
		end

	self_scale (f: REAL) is
			-- Scale figure by `f' relative to `origin'.
		require else
			scale_factor_positive: f > 0.0
			origin_exists: origin /= Void
		local
			keep_cursor: CURSOR
		do
			keep_cursor := cursor
			from
				start
			until
				off
			loop
				item.scale (f, origin)
				forth
			end
			go_to (keep_cursor)
			set_modified
		end


	set_origin (p: like origin) is
			-- Set `origin' to `p'.
		require else
			p_exists: p /= Void
		do
			origin := p
		ensure then
			origin_set: origin = p
		end

	translate (v: EV_VECTOR) is
			-- Translate current figure by `v'.
		require else
			vector_exists: v /= Void
		local
			keep_cursor: CURSOR
		do
			keep_cursor := cursor
			from
				start
			until
				off
			loop
				item.translate (v)
				forth
			end
			go_to (keep_cursor)
			set_modified
		end

	xyrotate (a: EV_ANGLE; px, py: INTEGER) is
			-- Rotate figure by `a' relative to (`px', `py').
			-- Angle `a' is measured in radians.
		local
			keep_cursor: CURSOR
		do
			keep_cursor := cursor
			from
				start
			until
				off
			loop
				item.xyrotate (a, px, py)
				forth
			end
			go_to (keep_cursor)
			set_modified
		end

	xyscale (f: REAL; px,py: INTEGER) is
			-- Scale figure by `f' relative to (`px', `py').
		require else
			scale_factor_positive: f > 0.0
		local
			keep_cursor: CURSOR
		do
			keep_cursor := cursor
			from
				start
			until
				off
			loop
				item.xyscale (f, px, py)
				forth
			end
			go_to (keep_cursor)
			set_modified	
		end

	xytranslate (vx, vy: INTEGER) is
			-- Translate by `vx' horizontally and `vy' vertically.
		local
			keep_cursor: CURSOR
		do
			keep_cursor := cursor
			from
				start
			until
				off
			loop
				item.xytranslate (vx, vy)
				forth
			end
			go_to (keep_cursor)
			set_modified
		end

feature -- Removal

	wipe_out is
		do
			{LINKED_LIST} Precursor
			set_modified
		end

feature -- Output
			
	draw is
			-- Draw the figure in `drawing'.
		require else
			a_drawing_attached: drawing /= Void
			one_segment_at_least: count > 1
		local
			p1, p2: EV_PIXEL
			keep_cursor: CURSOR
			lpath: EV_PATH
		do
			if drawing.is_drawable then
				create lpath.make
				lpath.get_drawing_attributes (drawing)
--				drawing.set_cap_style (cap_style)
				set_drawing_attributes (drawing)
				keep_cursor := cursor
				from
					start
					p1 := item
					forth
					p2 := item
				until
					off
				loop
					drawing.draw_segment (p1, p2)
					p1 := p2
					forth
					if not off then
						p2 := item
					end
				end
				go_to (keep_cursor)
				lpath.set_drawing_attributes (drawing)
			end
		end

	clip_draw (clip: EV_CLIP) is
		do
			if receive then
				if modified then
					recompute
				end
			else
				recompute
			end
			if drawing.is_drawable then
				draw
			end
		end

feature -- Status report

	is_superimposable (other: like Current): BOOLEAN is
			-- Is the figure superimposable to `other' ?
		local
			keep_cursor: CURSOR
			other_keep_cursor: CURSOR
		do
			keep_cursor := cursor
			keep_cursor := other.cursor
			from
				start
				other.start
				Result := true
			until
				not Result or off or other.off
			loop
				Result := Result and item.is_superimposable (other.item)
				forth
				other.forth
			end
			Result := Result and off and other.off
			go_to (keep_cursor)
			other.go_to (other_keep_cursor)
		end

feature {NONE} -- Element change

	set_no_origin is
			-- Erase definition of `origin'.
		do
			origin := Void
		ensure then
			no_origin: origin = Void
		end

feature {NONE} -- Updating

	recompute is
		local
			keep_cursor: CURSOR
		do
			from
				keep_cursor := cursor
				start
				surround_box.wipe_out
			until
				off
			loop
				item.recompute
				surround_box.merge (item.surround_box)
				forth
			end
			go_to (keep_cursor)
			unset_modified
		end
		
end -- class EV_POLYLINE

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

