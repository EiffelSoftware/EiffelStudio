indexing
	description: "Clipping capabilities (CP) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CLIPPING_CAPABILITIES_CONSTANTS

feature -- Access

	Cp_none: INTEGER is
			-- Output is not clipped
		external
			"C [macro %"wel.h%"]"
		alias
			"CP_NONE"
		end

	Cp_rectangle: INTEGER is
			-- Output is clipped to rectangles
		external
			"C [macro %"wel.h%"]"
		alias
			"CP_RECTANGLE"
		end

	Cp_region: INTEGER is
			-- Output is clipped to regions
		external
			"C [macro %"wel.h%"]"
		alias
			"CP_REGION"
		end

end -- class WEL_CLIPPING_CAPABILITIES_CONSTANTS

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

