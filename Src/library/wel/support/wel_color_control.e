indexing
	description: "Common type for several control which%
				% backgound and foreground colors can be%
				% changed"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_COLOR_CONTROL

inherit
	WEL_COLOR_CONSTANTS

feature -- Access

	foreground_color: WEL_COLOR_REF is
			-- foreground color used for the text of the
			-- control
		require
			exists: exists
		deferred
		ensure
			color_not_void: foreground_color /= Void
		end

	background_color: WEL_COLOR_REF is
			-- Background color used for the background of the
			-- control
		require
			exists: exists
		deferred
		ensure
			color_not_void: background_color /= Void
		end

feature -- Status report

	exists: BOOLEAN is
			-- Does the control exists ?
		deferred
		end

end -- class WEL_COLOR_CONTROL


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

