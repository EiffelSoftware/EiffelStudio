indexing
	description: "Track Mouse Event (TME) constants for use by %
		% WEL_TRACK_MOUSE_EVENT."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TME_CONSTANTS

feature -- Access

	tme_cancel: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TME_CANCEL"
		end
	
	tme_hover: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TME_HOVER"
		end	

	tme_leave: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TME_LEAVE"
		end	

	tme_query: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TME_QUERY"
		end	

end -- class WEL_TME_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

