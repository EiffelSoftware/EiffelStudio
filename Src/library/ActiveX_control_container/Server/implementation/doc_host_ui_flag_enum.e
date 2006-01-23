indexing
	description: "DOCHOSTUIFLAG enumeration. From <mshtmhst.h>"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOC_HOST_UI_FLAG_ENUM
	
feature -- Accsss

	Dochostuiflag_dialog            		: INTEGER is 1
	
	Dochostuiflag_disable_help_menu 		: INTEGER is 2
	
	Dochostuiflag_no3dborder        		: INTEGER is 4
	
	Dochostuiflag_scroll_no         		: INTEGER is 8
	
	Dochostuiflag_disable_script_inactive 	: INTEGER is 16
	
	Dochostuiflag_opennewwin        		: INTEGER is 32
	
	Dochostuiflag_disable_offscreen 		: INTEGER is 64
	
	Dochostuiflag_flat_scrollbar 			: INTEGER is 128
	
	Dochostuiflag_div_blockdefault 			: INTEGER is 256
	
	Dochostuiflag_activate_clienthit_only 	: INTEGER is 512
	
	Dochostuiflag_disable_cookie 			: INTEGER is 1024;

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




end -- DOC_HOST_UI_FLAG_ENUM
