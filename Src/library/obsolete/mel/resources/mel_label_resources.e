note

	description: 
		"Label resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_LABEL_RESOURCES

feature -- Implementation

	XmNaccelerator: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNaccelerator"
		end;

	XmNacceleratorText: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNacceleratorText"
		end;

	XmNalignment: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNalignment"
		end;

	XmNlabelInsensitivePixmap: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNlabelInsensitivePixmap"
		end;

	XmNlabelPixmap: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNlabelPixmap"
		end;

	XmNlabelString: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNlabelString"
		end;

	XmNlabelType: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNlabelType"
		end;

	XmNmarginBottom: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmarginBottom"
		end;

	XmNmarginHeight: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmarginHeight"
		end;

	XmNmarginLeft: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmarginLeft"
		end;

	XmNmarginRight: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmarginRight"
		end;

	XmNmarginTop: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmarginTop"
		end;

	XmNmarginWidth: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmarginWidth"
		end;

	XmNmnemonic: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmnemonic"
		end;

	XmNmnemonicCharSet: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNmnemonicCharSet"
		end;

	XmNrecomputeSize: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNrecomputeSize"
		end;

	XmNstringDirection: POINTER
			-- Motif resource
		external
			"C [macro <Xm/Label.h>] : EIF_POINTER"
		alias
			"XmNstringDirection"
		end;

	XmALIGNMENT_BEGINNING: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmALIGNMENT_BEGINNING"
		end;

	XmALIGNMENT_CENTER: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmALIGNMENT_CENTER"
		end;

	XmALIGNMENT_END: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmALIGNMENT_END"
		end;

	XmPIXMAP: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmPIXMAP"
		end;

	XmSTRING: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmSTRING"
		end;

	XmSTRING_DIRECTION_L_TO_R: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmSTRING_DIRECTION_L_TO_R"
		end;

	XmSTRING_DIRECTION_R_TO_L: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmSTRING_DIRECTION_R_TO_L"
		end;

	XmSTRING_DIRECTION_DEFAULT: INTEGER
			-- Motif constant value
		external
			"C [macro <Xm/Label.h>] : EIF_INTEGER"
		alias
			"XmSTRING_DIRECTION_DEFAULT"
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




end -- class MEL_LABEL_RESOURCES


