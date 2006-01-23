indexing
	description: "Memory device context compatible with a given %
		%device context."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COMPATIBLE_DC

obsolete
	"use WEL_MEMORY_DC"

inherit
	WEL_DC
		redefine
			get,
			release,
			destroy_item
		end

create
	make

feature {NONE} -- Initialization

	make (a_dc: WEL_DC) is
			-- Make a compatible dc with `a_dc'
		require
			a_dc_not: a_dc /= Void
			a_dc_exists: a_dc.exists
		do
			item := cwin_create_compatible_dc (a_dc.item)
		ensure
			exists: exists
		end

feature -- Basic operations

	get is
			-- Get the device context
		do
		end

	release is
			-- Release the device context
		do
		end

feature {NONE} -- Removal

	destroy_item is
		do
			unselect_all
			delete
		end

feature {NONE} -- Externals

	cwin_create_compatible_dc (hdc: POINTER): POINTER is
			-- SDK CreateCompatibleDC
		external
			"C [macro <wel.h>] (HDC): EIF_POINTER"
		alias
			"CreateCompatibleDC"
		end

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




end -- class WEL_COMPATIBLE_DC

