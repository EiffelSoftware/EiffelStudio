indexing
	description: "Logical color palette."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PALETTE

inherit
	WEL_GDI_ANY

creation
	make,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_log_palette: WEL_LOG_PALETTE) is
			-- Create a palette associated to `a_log_palette'
		require
			a_log_palette_not_void: a_log_palette /= Void
		do
			item := cwin_create_palette (a_log_palette.item)
			gdi_make
		end

feature -- Access

	palette_index (i: INTEGER): WEL_COLOR_REF is
			-- Color number `i' of the palette
		require
			exists: exists
		do
			create Result.make_by_color (cwin_palette_index (i))
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwin_create_palette (a_palette: POINTER): POINTER is
			-- SDK CreatePalette
		external
			"C [macro <windows.h>] (LOGPALETTE *): EIF_POINTER"
		alias
			"CreatePalette"
		end

	cwin_palette_index (i: INTEGER): INTEGER is
			-- SDK PALETTEINDEX
		external
			"C [macro <windows.h>] (WORD): COLORREF"
		alias
			"PALETTEINDEX"
		end

end -- class WEL_PALETTE


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

