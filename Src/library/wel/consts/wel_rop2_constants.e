note
	description: "Raster operation 2 (R2) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_ROP2_CONSTANTS

feature -- Access

	R2_black: INTEGER = 1

	R2_notmergepen: INTEGER = 2

	R2_masknotpen: INTEGER = 3

	R2_notcopypen: INTEGER = 4

	R2_maskpennot: INTEGER = 5

	R2_not: INTEGER = 6

	R2_xorpen: INTEGER = 7

	R2_notmaskpen: INTEGER = 8

	R2_maskpen: INTEGER = 9

	R2_notxorpen: INTEGER = 10

	R2_nop: INTEGER = 11

	R2_mergenotpen: INTEGER = 12

	R2_copypen: INTEGER = 13

	R2_mergepennot: INTEGER = 14

	R2_mergepen: INTEGER = 15

	R2_white: INTEGER = 16

feature -- Status report

	valid_rop2_constant (c: INTEGER): BOOLEAN
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




end -- class WEL_ROP2_CONSTANTS

