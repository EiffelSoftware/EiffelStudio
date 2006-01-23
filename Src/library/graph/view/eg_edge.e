indexing
	description: "Object that is an movable edge of an polyline link figure (the black dot)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EG_EDGE

inherit
	EV_MODEL_MOVE_HANDLE
		export
			{EG_POLYLINE_LINK_FIGURE} on_start_resizing
		end

create
	make

create {EG_EDGE}
	make_filled

feature {NONE} -- Initialization

	make (owner: like corresponding_line) is
			-- Create a move handle used to move the edges (the black circle).
			-- | If you change this you might also have to change the drawers in EG_FIGURE_DRAWER
		local
			dot: EV_MODEL_DOT
		do
			default_create
			create dot
			dot.set_line_width (10)
			extend (dot)
			set_pointer_style (default_pixmaps.sizeall_cursor)
			set_pebble (Current)
			disable_always_shown
			corresponding_line := owner
			set_center
		end

feature -- Access

	corresponding_point: EV_COORDINATE
			-- Point on line `Current' is an edge handler for.

	corresponding_line: EG_POLYLINE_LINK_FIGURE
			-- Line `Current' is part of.

feature {EG_POLYLINE_LINK_FIGURE} -- Element change

	set_corresponding_point (a_corresponding_point: like corresponding_point) is
			-- Set `corresponding_point' to `a_corresponding_point'.
		require
			a_corresponding_point_not_void: a_corresponding_point /= Void
		do
			corresponding_point := a_corresponding_point
		ensure
			corresponding_point_assigned: corresponding_point = a_corresponding_point
		end


invariant
	corresponding_point_not_void: corresponding_point /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EG_EDGE

