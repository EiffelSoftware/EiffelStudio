indexing
	description: "Information about message Wm_windowposchanged, %
		%Wm_windowposchanging. These messages are sent to a window %
		%whose size, position, or place in the Z order has changed."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_WINDOW_POSITION_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

creation
	make

feature -- Access

	position: WEL_WINDOW_POS is
		do
			!! Result.make_by_pointer (cwel_integer_to_pointer (l_param))
		end

feature {NONE} -- Externals

	cwel_integer_to_pointer (i: INTEGER): POINTER is
			-- Converts an integer `i' to a pointer
		external
			"C [macro <wel.h>]"
		end

end -- class WEL_WINDOW_POSITION_MESSAGE

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
