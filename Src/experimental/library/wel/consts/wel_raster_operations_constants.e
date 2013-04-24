note
	description	: "Raster operations constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	WEL_RASTER_OPERATIONS_CONSTANTS

feature -- Access

	Srccopy: INTEGER = 13369376
			-- Declared in Windows as SRCCOPY

	Srcpaint: INTEGER = 15597702
			-- Declared in Windows as SRCPAINT

	Srcand: INTEGER = 8913094
			-- Declared in Windows as SRCAND

	Srcinvert: INTEGER = 6684742
			-- Declared in Windows as SRCINVERT

	Srcerase: INTEGER = 4457256
			-- Declared in Windows as SRCERASE

	Notsrccopy: INTEGER = 3342344
			-- Declared in Windows as NOTSRCCOPY

	Notsrcerase: INTEGER = 1114278
			-- Declared in Windows as NOTSRCERASE

	Mergecopy: INTEGER = 12583114
			-- Declared in Windows as MERGECOPY

	Mergepaint: INTEGER = 12255782
			-- Declared in Windows as MERGEPAINT

	Patcopy: INTEGER = 15728673
			-- Declared in Windows as PATCOPY

	Patpaint: INTEGER = 16452105
			-- Declared in Windows as PATPAINT

	Patinvert: INTEGER = 5898313
			-- Declared in Windows as PATINVERT

	Dstinvert: INTEGER = 5570569
			-- Declared in Windows as DSTINVERT

	Blackness: INTEGER = 66
			-- Declared in Windows as BLACKNESS

	Whiteness: INTEGER = 16711778
			-- Declared in Windows as WHITENESS

	Maskpaint: INTEGER = 2229030 -- 0x220326

	--| Constants for mask_blt only

	frozen Maskcopy: INTEGER
			-- Use SRCCOPY for foreground and R2_NOOP for background
		external
			"C [macro %"wel.h%"]"
		alias
			"MAKEROP4(SRCCOPY, 0xAA0029)"
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




end -- class WEL_RASTER_OPERATIONS_CONSTANTS

