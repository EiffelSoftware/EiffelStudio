indexing

	description: 
		"Xt Application Shell resources.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_APPLICATION_SHELL_RESOURCES

feature -- Implementation

	XmNargc: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNargc"
		end;

	XmNargv: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>]: EIF_POINTER"
		alias
			"XmNargv"
		end

end -- class MEL_APPLICATION_SHELL_RESOURCES

--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
