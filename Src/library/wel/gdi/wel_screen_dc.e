indexing
	description: "Screen device context."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SCREEN_DC

inherit
	WEL_DISPLAY_DC

feature -- Basic operations

	get is
			-- Get the device context
		local
			p: POINTER
		do
			if item = p then
				item := cwin_get_dc (default_pointer)
			end
		end

	release is
			-- Release the device context
		local
			p: POINTER
		do
			if item /= p then
				unselect_all
				cwin_release_dc (default_pointer, item)
				item := p
			end
		end

	quick_release is
			-- Release the device context
		local
			p: POINTER
		do
			if item /= p then
				cwin_release_dc (default_pointer, item)
				item := p
			end
		end

feature {NONE} -- Implementation

	destroy_item is
		local
			p: POINTER
		do
			if item /= p then
				unselect_all
				cwin_release_dc (default_pointer, item)
				item := p
			end
		end

end -- class WEL_SCREEN_DC

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

