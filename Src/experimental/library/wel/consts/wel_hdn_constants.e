note
	description: "Possible notification messages of class WEL_HEADER_CONTROL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HDN_CONSTANTS

feature -- Access
 
	Hdn_begin_track: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_BEGINTRACK"
		end 

	Hdn_divider_dbl_click: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_DIVIDERDBLCLICK"
		end 
 
	Hdn_end_track: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_ENDTRACK"
		end 
  
	Hdn_item_changed: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_ITEMCHANGED"
		end 
  
	Hdn_item_changing: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_ITEMCHANGING"
		end 
 
	Hdn_item_click: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_ITEMCLICK"
		end 
  
	Hdn_item_dbl_click: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_ITEMDBLCLICK"
		end 

	Hdn_track: INTEGER
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_TRACK"
		end 
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




end -- class WEL_HDN_CONSTANTS

