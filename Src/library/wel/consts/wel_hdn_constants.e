indexing
	description: "Possible notification messages of class WEL_HEADER_CONTROL"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_HDN_CONSTANTS

feature -- Access
 
	Hdn_begin_track: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_BEGINTRACK"
		end 

	Hdn_divider_dbl_click: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_DIVIDERDBLCLICK"
		end 
 
	Hdn_end_track: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_ENDTRACK"
		end 
  
	Hdn_item_changed: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_ITEMCHANGED"
		end 
  
	Hdn_item_changing: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_ITEMCHANGING"
		end 
 
	Hdn_item_click: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_ITEMCLICK"
		end 
  
	Hdn_item_dbl_click: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_ITEMDBLCLICK"
		end 

	Hdn_track: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"HDN_TRACK"
		end 
end -- class WEL_HDN_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

