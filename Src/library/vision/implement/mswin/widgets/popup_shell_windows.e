indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 

class
	POPUP_SHELL_WINDOWS
 
inherit 
	SHELL_WINDOWS

feature -- Status report

	foreground: COLOR

feature -- Status setting

	set_foreground (a_color: COLOR) is
		do
		end

	update_foreground is
		do
		end

feature -- Output

	popup is
		do
		end
 
end -- class POPUP_SHELL_WINDOWS
 
--|---------------------------------------------------------------- 
--| EiffelVision: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software 
--|   Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|----------------------------------------------------------------
