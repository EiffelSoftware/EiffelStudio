indexing

	description: "General scrolled window implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class SCROLLED_W_I 

inherit

	MANAGER_I
	
feature 

	working_area: WIDGET is
			-- Working area of window which will
			-- be moved using scrollbars
		deferred
		end; -- working_area

	set_working_area (a_widget: WIDGET) is
			-- Set work area of windon to `a_widget'.
		require
			not_a_widget_void: not (a_widget = Void)
		deferred
		ensure
			working_area = a_widget
		end -- set_working_area

end -- class SCROLLED_W_I


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
