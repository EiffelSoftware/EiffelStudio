indexing
	description: "Information about message Wm_char, Wm_syschar, %
		%Wm_keydown, Wm_keyup, Wm_syskeydown, Wm_syskeyup. These %
		%messages are sent when a key is pressed."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_KEY_MESSAGE

inherit
	WEL_MESSAGE_INFORMATION

creation
	make

feature -- Access

	code: INTEGER is
			-- Character code of the key
			-- See class WEL_VK_CONSTANTS for different values.
		do
			Result := w_param
		end

	data: INTEGER is
			-- Key data
		do
			Result := l_param
		end

end -- class WEL_KEY_MESSAGE


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

