indexing
	description: "Screen device context."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SCREEN_DC

inherit
	WEL_DISPLAY_DC
		redefine
			destroy_item
		end

feature -- Basic operations

	get is
			-- Get the device context
		local
			a_default_pointer: POINTER
		do
			if item = a_default_pointer then
				item := cwin_get_dc (a_default_pointer)
			end
		end

	release is
			-- Release the device context
		local
			a_default_pointer: POINTER
		do
			if item /= a_default_pointer then
				unselect_all
				cwin_release_dc (a_default_pointer, item)
				item := a_default_pointer
			end
		end

	quick_release is
			-- Release the device context
		local
			a_default_pointer: POINTER
		do
			if item /= a_default_pointer then
				cwin_release_dc (a_default_pointer, item)
				item := a_default_pointer
			end
		end

feature {NONE} -- Implementation

	destroy_item is
			-- Delete the current device context.
		local
			a_default_pointer: POINTER	-- Default_pointer
		do
				-- Protect the call to DeleteDC, because `destroy_item' can 
				-- be called by the GC so without assertions.
			if item /= a_default_pointer then
				unselect_all
				cwin_release_dc (a_default_pointer, item)
				item := a_default_pointer
			end
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




end -- class WEL_SCREEN_DC

