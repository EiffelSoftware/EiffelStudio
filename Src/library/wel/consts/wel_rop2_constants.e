indexing
	description: "Raster operation 2 (R2) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ROP2_CONSTANTS

feature -- Access

	R2_black: INTEGER is 1

	R2_notmergepen: INTEGER is 2

	R2_masknotpen: INTEGER is 3

	R2_notcopypen: INTEGER is 4

	R2_maskpennot: INTEGER is 5

	R2_not: INTEGER is 6

	R2_xorpen: INTEGER is 7

	R2_notmaskpen: INTEGER is 8

	R2_maskpen: INTEGER is 9

	R2_notxorpen: INTEGER is 10

	R2_nop: INTEGER is 11

	R2_mergenotpen: INTEGER is 12

	R2_copypen: INTEGER is 13

	R2_mergepennot: INTEGER is 14

	R2_mergepen: INTEGER is 15

	R2_white: INTEGER is 16

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

