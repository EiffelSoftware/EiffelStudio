indexing
	description: "DOCHOSTUIFLAG enumeration. From <mshtmhst.h>"
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
	
	Dochostuiflag_disable_cookie 			: INTEGER is 1024

end -- DOC_HOST_UI_FLAG_ENUM
