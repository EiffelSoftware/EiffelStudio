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

create
	make

feature -- Access

	position: WEL_WINDOW_POS is
		do
			create Result.make_by_pointer (l_param)
		end

end -- class WEL_WINDOW_POSITION_MESSAGE

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

