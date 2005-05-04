indexing
	description: "Common type for several control which%
				% backgound and foreground colors can be%
				% changed"
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
			foreground_color_not_void: Result /= Void
		end

	background_color: WEL_COLOR_REF is
			-- Background color used for the background of the
			-- control
		require
			exists: exists
		deferred
		ensure
			background_color_not_void: Result /= Void
		end

feature -- Status report

	exists: BOOLEAN is
			-- Does the control exists ?
		deferred
		end

end -- class WEL_COLOR_CONTROL

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

