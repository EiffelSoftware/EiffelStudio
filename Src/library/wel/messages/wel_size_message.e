indexing
	description: "Information about message Wm_size which is sent to a %
		%window after its size has changed."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SIZE_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

	WEL_SIZE_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature -- Access

	size_type: INTEGER is
			-- Type of resizing requested.
			-- See class WEL_SIZE_CONSTANTS for different values.
		do
			Result := w_param
		end

	width: INTEGER is
			-- New width of the client area
		do
			Result := cwin_lo_word (l_param)
		end

	height: INTEGER is
			-- New height of the client area
		do
			Result := cwin_hi_word (l_param)
		end

feature -- Status report

	maximized: BOOLEAN is
			-- Has the window been maximized?
		do
			Result := size_type = Size_maximized
		end

	minimized: BOOLEAN is
			-- Has the window been minimized?
		do
			Result := size_type = Size_minimized
		end

	restored: BOOLEAN is
			-- Has the window been restored?
		do
			Result := size_type = Size_restored
		end

end -- class WEL_SIZE_MESSAGE


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

