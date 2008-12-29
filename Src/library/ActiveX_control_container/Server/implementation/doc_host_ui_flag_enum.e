note
	description: "DOCHOSTUIFLAG enumeration. From <mshtmhst.h>"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOC_HOST_UI_FLAG_ENUM
	
feature -- Accsss

	Dochostuiflag_dialog            		: INTEGER = 1
	
	Dochostuiflag_disable_help_menu 		: INTEGER = 2
	
	Dochostuiflag_no3dborder        		: INTEGER = 4
	
	Dochostuiflag_scroll_no         		: INTEGER = 8
	
	Dochostuiflag_disable_script_inactive 	: INTEGER = 16
	
	Dochostuiflag_opennewwin        		: INTEGER = 32
	
	Dochostuiflag_disable_offscreen 		: INTEGER = 64
	
	Dochostuiflag_flat_scrollbar 			: INTEGER = 128
	
	Dochostuiflag_div_blockdefault 			: INTEGER = 256
	
	Dochostuiflag_activate_clienthit_only 	: INTEGER = 512
	
	Dochostuiflag_disable_cookie 			: INTEGER = 1024;

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




end -- DOC_HOST_UI_FLAG_ENUM
