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
		end

feature -- Access

	palette_index (i: INTEGER): WEL_COLOR_REF is
			-- Color number `i' of the palette
		require
			exists: exists
		do
			!! Result.make_by_pointer (cwin_palette_index (i))
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwin_create_palette (a_palette: POINTER): POINTER is
			-- SDK CreatePalette
		external
			"C [macro <wel.h>] (LOGPALETTE *): EIF_POINTER"
		alias
			"CreatePalette"
		end

	cwin_palette_index (i: INTEGER): POINTER is
			-- SDK PALETTEINDEX
		external
			"C [macro <wel.h>] (WORD): EIF_POINTER"
		alias
			"PALETTEINDEX"
		end

end -- class WEL_PALETTE

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
