indexing
	description: "Status window text constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SBT_CONSTANTS

feature -- Access

	Sbt_borders: INTEGER is 0
			-- The text is drawn with a border to appear
			-- lower than the plane of the window.

	Sbt_noborders: INTEGER is
			-- The text is drawn without borders.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SBT_NOBORDERS"
		end

	Sbt_ownerdraw: INTEGER is
			-- The text is drawn by the parent window.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SBT_OWNERDRAW"
		end

	Sbt_popout: INTEGER is
			-- The text is drawn with a border to appear
			-- higher than the plane of the window.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"SBT_POPOUT"
		end

end -- class WEL_SBT_CONSTANTS

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

