note

	description: 
		"Scrolled Text resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCROLLED_TEXT_RESOURCES

feature -- Implementation

	XmNscrollHorizontal: POINTER
		external
			"C [macro <Xm/Text.h>]: EIF_POINTER"
		alias
			"XmNscrollHorizontal"
		end;

	XmNscrollVertical: POINTER
		external
			"C [macro <Xm/Text.h>]: EIF_POINTER"
		alias
			"XmNscrollVertical"
		end;

	XmNscrollLeftSide: POINTER
		external
			"C [macro <Xm/Text.h>]: EIF_POINTER"
		alias
			"XmNscrollLeftSide"
		end;

	XmNscrollTopSide: POINTER
		external
			"C [macro <Xm/Text.h>]: EIF_POINTER"
		alias
			"XmNscrollTopSide"
		end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_SCROLLED_TEXT_RESOURCES


