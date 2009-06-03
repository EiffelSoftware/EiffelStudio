note

	description: 	
		"Core widget resources.."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_CORE_RESOURCES

feature -- Implementation

	XmNaccelerators: POINTER
			-- Core resource
		  external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNaccelerators"
		end;

	XmNbackground: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNbackground"
		end;

	XmNbackgroundPixmap: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNbackgroundPixmap"
		end;
	
	XmNborderColor: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNborderColor"
		end;

	XmNborderPixmap: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNborderPixmap"
		end;
	
	XmNcolormap: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNcolormap"
		end;

	XmNdepth: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNdepth"
		end;

	XmNinitialResourcesPersistent: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNinitialResourcesPersistent"
		end;

	XmNmappedWhenManaged: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNmappedWhenManaged"
		end;

	XmNscreen: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNscreen"
		end;

	XmNtranslations: POINTER
			-- Core resource
		external
			"C [macro <Xm/Xm.h>] : EIF_POINTER"
		alias
			"XmNtranslations"
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




end -- class MEL_CORE_RESOURCES


