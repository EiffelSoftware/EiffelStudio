indexing

	description: 
		"Bulletin Board resources."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_BULLETIN_BOARD_RESOURCES

feature -- Implementation

	XmNallowOverlap: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNallowOverlap"
		end;

	XmNautoUnmanage: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNautoUnmanage"
		end;

	XmNbuttonFontList: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNbuttonFontList"
		end;

	XmNcancelButton: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNcancelButton"
		end;

	XmNdefaultButton: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNdefaultButton"
		end;

	XmNdefaultPosition: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNdefaultPosition"
		end;

	XmNdialogStyle: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNdialogStyle"
		end;

	XmNdialogTitle: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNdialogTitle"
		end;

	XmNlabelFontList: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNlabelFontList"
		end;

	XmNmarginHeight: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNmarginHeight"
		end;

	XmNmarginWidth: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNmarginWidth"
		end;

	XmNnoResize: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNnoResize"
		end;

	XmNresizePolicy: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNresizePolicy"
		end;

	XmNshadowType: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNshadowType"
		end;

	XmNtextFontList: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNtextFontList"
		end;

	XmNtextTranslations: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNtextTranslations"
		end;

	XmNfocusCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNfocusCallback"
		end;

	XmNmapCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNmapCallback"
		end;

	XmNunmapCallback: POINTER is
			-- Motif resource
		external
			"C [macro <Xm/BulletinB.h>]: EIF_POINTER"
		alias
			"XmNunmapCallback"
		end;

	XmDIALOG_WORK_AREA: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_WORK_AREA"
		end;

	XmDIALOG_MODELESS: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_MODELESS"
		end;

	XmDIALOG_FULL_APPLICATION_MODAL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_FULL_APPLICATION_MODAL"
		end;

	XmDIALOG_APPLICATION_MODAL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_APPLICATION_MODAL"
		end;

	XmDIALOG_PRIMARY_APPLICATION_MODAL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_PRIMARY_APPLICATION_MODAL"
		end;

	XmDIALOG_SYSTEM_MODAL: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmDIALOG_SYSTEM_MODAL"
		end;

	XmRESIZE_NONE: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmRESIZE_NONE"
		end;

	XmRESIZE_GROW: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmRESIZE_GROW"
		end;

	XmRESIZE_ANY: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmRESIZE_ANY"
		end;

	XmSHADOW_IN: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmSHADOW_IN"
		end;

	XmSHADOW_OUT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmSHADOW_OUT"
		end;

	XmSHADOW_ETCHED_IN: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmSHADOW_ETCHED_IN"
		end;

	XmSHADOW_ETCHED_OUT: INTEGER is
			-- Motif constant value
		external
			"C [macro <Xm/BulletinB.h>]: EIF_INTEGER"
		alias
			"XmSHADOW_ETCHED_OUT"
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_BULLETIN_BOARD_RESOURCES


