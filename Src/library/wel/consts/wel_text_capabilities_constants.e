indexing
	description: "Text capabilities (TC) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_TEXT_CAPABILITIES_CONSTANTS

feature -- Access

	Tc_op_character: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_OP_CHARACTER"
		end

	Tc_op_stroke: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_OP_STROKE"
		end

	Tc_cp_stroke: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_CP_STROKE"
		end

	Tc_cr_90: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_CR_90"
		end

	Tc_cr_any: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_CR_ANY"
		end

	Tc_sf_x_yindep: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_SF_X_YINDEP"
		end

	Tc_sa_double: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_SA_DOUBLE"
		end

	Tc_sa_integer: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_SA_INTEGER"
		end

	Tc_sa_contin: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_SA_CONTIN"
		end

	Tc_ea_double: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_EA_DOUBLE"
		end

	Tc_ia_able: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_IA_ABLE"
		end

	Tc_ua_able: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_UA_ABLE"
		end

	Tc_so_able: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_SO_ABLE"
		end

	Tc_ra_able: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_RA_ABLE"
		end

	Tc_va_able: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_VA_ABLE"
		end

	Tc_reserved: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"TC_RESERVED"
		end

end -- class WEL_TEXT_CAPABILITIES_CONSTANTS

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

