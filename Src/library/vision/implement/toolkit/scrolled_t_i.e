indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class SCROLLED_T_I 

inherit

	TEXT_I

feature 

	show_vertical_scrollbar is
			-- Make vertical scrollbar visible.
		deferred
		end; -- show_vertical_scrollbar

	hide_vertical_scrollbar is
			-- Make vertical scrollbar invisible.
		deferred
		end; -- hide_vertical_scrollbar

	show_horizontal_scrollbar is
			-- Make horizontal scrollbar visible.
		deferred
		end; -- show_horizontal_scrollbar

	hide_horizontal_scrollbar is
			-- Make horizontal scrollbar invisible.
		deferred
		end; -- hide_horizontal_scrollbar

	is_vertical_scrollbar: BOOLEAN is
			-- Is vertical scrollbar visible?
		deferred
		end; -- is_vertical_scrollbar

	is_horizontal_scrollbar: BOOLEAN is
			-- Is horizontal scrollbar visible?
		deferred
		end -- is_horizontal_scrollbar

	action_target: POINTER is
			-- Widget ID on which action must be applied
		deferred
		end

end -- class SCROLLED_T_I


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
