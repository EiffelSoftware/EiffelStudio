note
	description: "[
		The Cell is similar to EV_GRID_LABEL_ITEM, except it has extra pixmaps on the right
		See description of EV_GRID_LABEL_ITEM for more details
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			implementation, create_implementation
		end

create
	default_create,
	make_with_text

feature -- Access

	pixmaps_on_right: ARRAY [EV_PIXMAP]
		do
			Result := implementation.pixmaps_on_right
		end

feature -- Change

	set_pixmaps_on_right_count (c: INTEGER)
		do
			implementation.set_pixmaps_on_right_count (c)
		end

	put_pixmap_on_right (p: EV_PIXMAP; i: INTEGER)
		do
			implementation.put_pixmap_on_right (p, i)
		end

feature {EV_ANY, EV_ANY_I, EV_GRID_DRAWER_I} -- Implementation

	implementation: EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM_I} implementation.make (Current)
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
