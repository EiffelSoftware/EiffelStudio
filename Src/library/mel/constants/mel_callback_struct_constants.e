indexing
	description: 
		"Constants used to determine the class of a callback structure %
		%by comparing to the `reason' field in MEL_CALLBACK_STRUCTURE.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CALLBACK_STRUCT_CONSTANTS

feature -- Access

	XmCR_OBSCURED_TRAVERSAL: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_OBSCURED_TRAVERSAL"
		end;

	XmCR_PROTOCOLS: INTEGER is
		once
				-- Some machines (hp) do not define this
			Result := XmCR_OBSCURED_TRAVERSAL + 1
		end;

	XmCR_NONE: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_NONE"
		end;

	XmCR_HELP: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_HELP"
		end;

	XmCR_VALUE_CHANGED: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_VALUE_CHANGED"
		end;

	XmCR_INCREMENT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_INCREMENT"
		end;

	XmCR_DECREMENT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_DECREMENT"
		end;

	XmCR_PAGE_INCREMENT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_PAGE_INCREMENT"
		end;

	XmCR_PAGE_DECREMENT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_PAGE_DECREMENT"
		end;

	XmCR_TO_TOP: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_TO_TOP"
		end;

	XmCR_TO_BOTTOM: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_TO_BOTTOM"
		end;

	XmCR_DRAG: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_DRAG"
		end;

	XmCR_ACTIVATE: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_ACTIVATE"
		end;

	XmCR_ARM: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_ARM"
		end;

	XmCR_DISARM: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_DISARM"
		end;

	XmCR_MAP: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_MAP"
		end;

	XmCR_UNMAP: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_UNMAP"
		end;

	XmCR_TEAR_OFF_ACTIVATE: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_TEAR_OFF_ACTIVATE"
		end;

	XmCR_TEAR_OFF_DEACTIVATE: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_TEAR_OFF_DEACTIVATE"
		end;

	XmCR_FOCUS: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_FOCUS"
		end;

	XmCR_LOSING_FOCUS: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_LOSING_FOCUS"
		end;

	XmCR_MODIFYING_TEXT_VALUE: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_MODIFYING_TEXT_VALUE"
		end;

	XmCR_MOVING_INSERT_CURSOR: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_MOVING_INSERT_CURSOR"
		end;

	XmCR_EXECUTE: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_EXECUTE"
		end;

	XmCR_SINGLE_SELECT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_SINGLE_SELECT"
		end;

	XmCR_MULTIPLE_SELECT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_MULTIPLE_SELECT"
		end;

	XmCR_EXTENDED_SELECT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_EXTENDED_SELECT"
		end;

	XmCR_BROWSE_SELECT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_BROWSE_SELECT"
		end;

	XmCR_DEFAULT_ACTION: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_DEFAULT_ACTION"
		end;

	XmCR_CLIPBOARD_DATA_REQUEST: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_CLIPBOARD_DATA_REQUEST"
		end;

	XmCR_CLIPBOARD_DATA_DELETE: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_CLIPBOARD_DATA_DELETE"
		end;

	XmCR_CASCADING: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_CASCADING"
		end;

	XmCR_OK: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_OK"
		end;

	XmCR_CANCEL: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_CANCEL"
		end;

	XmCR_APPLY: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_APPLY"
		end;

	XmCR_NO_MATCH: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_NO_MATCH"
		end;

	XmCR_COMMAND_ENTERED: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_COMMAND_ENTERED"
		end;

	XmCR_COMMAND_CHANGED: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_COMMAND_CHANGED"
		end;

	XmCR_EXPOSE: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_EXPOSE"
		end;

	XmCR_RESIZE: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_RESIZE"
		end;

	XmCR_INPUT: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_INPUT"
		end;

	XmCR_GAIN_PRIMARY: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_GAIN_PRIMARY"
		end;

	XmCR_LOSE_PRIMARY: INTEGER is
		external
			"C [macro <Xm/Xm.h>]: EIF_INTEGER"
		alias
			"XmCR_LOSE_PRIMARY"
		end;

end -- class MEL_CALLBACK_STRUCT_CONSTANTS


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

