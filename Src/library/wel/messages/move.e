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

creation
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

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
