indexing
	description: "Raster operation 2 (R2) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ROP2_CONSTANTS

feature -- Access

	R2_black: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_BLACK"
		end

	R2_notmergepen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_NOTMERGEPEN"
		end

	R2_masknotpen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_MASKNOTPEN"
		end

	R2_notcopypen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_NOTCOPYPEN"
		end

	R2_maskpennot: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_MASKPENNOT"
		end

	R2_not: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_NOT"
		end

	R2_xorpen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_XORPEN"
		end

	R2_notmaskpen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_NOTMASKPEN"
		end

	R2_maskpen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_MASKPEN"
		end

	R2_notxorpen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_NOTXORPEN"
		end

	R2_nop: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_NOP"
		end

	R2_mergenotpen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_MERGENOTPEN"
		end

	R2_copypen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_COPYPEN"
		end

	R2_mergepennot: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_MERGEPENNOT"
		end

	R2_mergepen: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_MERGEPEN"
		end

	R2_white: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"R2_WHITE"
		end

feature -- Status report

	valid_rop2_constant (c: INTEGER): BOOLEAN is
			-- Is `c' a valid rop2 constant?
		do
			Result := c = R2_black or else
				c = R2_copypen or else
				c = R2_masknotpen or else
				c = R2_maskpen or else
				c = R2_maskpennot or else
				c = R2_mergenotpen or else
				c = R2_mergepen or else
				c = R2_mergepennot or else
				c = R2_nop or else
				c = R2_not or else
				c = R2_notcopypen or else
				c = R2_notmaskpen or else
				c = R2_notmergepen or else
				c = R2_notxorpen or else
				c = R2_white or else
				c = R2_xorpen
		end

end -- class WEL_ROP2_CONSTANTS

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

