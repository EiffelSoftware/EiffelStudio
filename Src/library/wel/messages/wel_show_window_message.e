indexing
	description: "Information about message Wm_showwindow which is when a %
		%window is about to be hidden or shown."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SHOW_WINDOW_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

	WEL_SW_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature -- Status report

	shown: BOOLEAN is
			-- Is the window being shown?
		do
			Result := w_param.to_integer_32 = 1
		end

	parent_opening: BOOLEAN is
			-- Is window's owner window being restored?
		do
			Result := status = Sw_parentopening
		end

	parent_closing: BOOLEAN is
			-- Is window's owner window being minimized?
		do
			Result := status = Sw_parentclosing
		end

feature -- Access

	status: INTEGER is
			-- Status of the window being shown.
			-- See class WEL_SW_CONSTANTS for differents values.
		do
			Result := l_param.to_integer_32
		end

end -- class WEL_SHOW_WINDOW_MESSAGE

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

