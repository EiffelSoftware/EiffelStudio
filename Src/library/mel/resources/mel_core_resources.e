indexing

	description: 	
		"Core widget resources..";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CORE_RESOURCES

feature -- Implementation

	XmNaccelerators: POINTER is
			-- Core resource
		  external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNaccelerators"
		end;

	XmNbackground: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNbackground"
		end;

	XmNbackgroundPixmap: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNbackgroundPixmap"
		end;
	
	XmNborderColor: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNborderColor"
		end;

	XmNborderPixmap: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNborderPixmap"
		end;
	
	XmNcolormap: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNcolormap"
		end;

	XmNdepth: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNdepth"
		end;

	XmNinitialResourcesPersistent: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNinitialResourcesPersistent"
		end;

	XmNmappedWhenManaged: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNmappedWhenManaged"
		end;

	XmNscreen: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNscreen"
		end;

	XmNtranslations: POINTER is
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNtranslations"
		end;

end -- class MEL_CORE_RESOURCES


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

