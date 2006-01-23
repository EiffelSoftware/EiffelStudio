indexing
	description: "Special icon used for creating a WEL_WND_CLASS%
		% structure when an application must explicitly draw an icon%
		% whenever the user minimizes the window."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_NULL_ICON

inherit
	WEL_ICON
		redefine
			exists,
			destroy_item
		end

feature -- Status report

	exists: BOOLEAN is True
			-- A null icon always exists.

feature {NONE} -- Removal

	destroy_item is
			-- Nothing to destroy.
		do
		end

invariant
	exists: exists
	no_item: item = default_pointer

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




end -- class WEL_NULL_ICON

