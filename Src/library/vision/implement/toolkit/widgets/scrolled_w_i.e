indexing

	description: "General scrolled window implementation";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SCROLLED_W_I 

inherit

	MANAGER_I
	
feature 

	working_area: WIDGET is
			-- Working area of window which will
			-- be moved using scrollbars
		deferred
		end;

	set_working_area (a_widget: WIDGET) is
			-- Set work area of windon to `a_widget'.
		require
			not_a_widget_void: a_widget /= Void
		deferred
		ensure
			working_area = a_widget
		end

end -- class SCROLLED_W_I



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

