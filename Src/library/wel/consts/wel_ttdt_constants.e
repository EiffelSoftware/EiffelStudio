indexing
	description: "Tooltip Delay Time (TTDT) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TTDT_CONSTANTS

feature -- Access

	Ttdt_automatic: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_AUTOMATIC"
		end

	Ttdt_autopop: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_AUTOPOP"
		end

	Ttdt_initial: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_INITIAL"
		end

	Ttdt_reshow: INTEGER is
		external
			"C [macro %"cctrl.h%"]"
		alias
			"TTDT_RESHOW"
		end

end -- class WEL_TTDT_CONSTANTS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

