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

