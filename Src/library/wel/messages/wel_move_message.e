indexing
	description: "Information about message Wm_move which is sent after a %
		%window has been moved."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MOVE_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

create
	make

feature -- Access

	x: INTEGER is
			-- x-coordinate of the upper-left corner of the client
			-- area of the window
		do
			Result := c_mouse_message_x (l_param)
		end

	y: INTEGER is
			-- y-coordinate of the upper-left corner of the client
			-- area of the window
		do
			Result := c_mouse_message_y (l_param)
		end

feature {NONE} -- Externals

	c_mouse_message_x (lparam: INTEGER): INTEGER is
		external
			"C [macro <wel.h>]"
		end

	c_mouse_message_y (lparam: INTEGER): INTEGER is
		external
			"C [macro <wel.h>]"
		end

end -- class WEL_MOVE_MESSAGE

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

