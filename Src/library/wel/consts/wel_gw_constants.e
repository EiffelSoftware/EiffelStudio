indexing
	description: "GetWindow (GW) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GW_CONSTANTS

feature -- Access

	Gw_hwndfirst: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_HWNDFIRST"
		end

	Gw_hwndlast: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_HWNDLAST"
		end

	Gw_hwndnext: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_HWNDNEXT"
		end

	Gw_hwndprev: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_HWNDPREV"
		end

	Gw_owner: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_OWNER"
		end

	Gw_child: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"GW_CHILD"
		end

end -- class WEL_GW_CONSTANTS

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

