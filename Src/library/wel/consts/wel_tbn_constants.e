indexing
	description: "Toolbar notification (RBN) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TBN_CONSTANTS

feature -- Access

	Tbn_getbuttoninfo: INTEGER is -680
			-- Declared in Windows as TBN_GETBUTTONINFO

	Tbn_begindrag: INTEGER is -701
			-- Declared in Windows as TBN_BEGINDRAG

	Tbn_enddrag: INTEGER is -702
			-- Declared in Windows as TBN_ENDDRAG

	Tbn_beginadjust: INTEGER is -703
			-- Declared in Windows as TBN_BEGINADJUST

	Tbn_endadjust: INTEGER is -704
			-- Declared in Windows as TBN_ENDADJUST

	Tbn_reset: INTEGER is -705
			-- Declared in Windows as TBN_RESET

	Tbn_queryinsert: INTEGER is -706
			-- Declared in Windows as TBN_QUERYINSERT

	Tbn_querydelete: INTEGER is -707
			-- Declared in Windows as TBN_QUERYDELETE

	Tbn_toolbarchange: INTEGER is -708
			-- Declared in Windows as TBN_TOOLBARCHANGE

	Tbn_custhelp: INTEGER is -709
			-- Declared in Windows as TBN_CUSTHELP

	Tbn_dropdown: INTEGER is -710;
			-- Declared in Windows as TBN_DROPDOWN

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




end -- class WEL_TBN_CONSTANTS

