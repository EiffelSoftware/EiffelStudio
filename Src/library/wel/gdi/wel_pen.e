indexing
	description: "Drawing object used to draw lines and borders."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PEN

inherit
	WEL_GDI_ANY

	WEL_PS_CONSTANTS
		export
			{NONE} all
			{ANY} valid_pen_style_constant
		end

creation
	make,
	make_solid,
	make_indirect,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_style, a_width: INTEGER; a_color: WEL_COLOR_REF) is
			-- Make a pen using `a_style', `a_width' and `a_color'.
			-- See class WEL_PS_CONSTANTS for `a_style' values.
		require
			valid_pen_style_constant: valid_pen_style_constant (a_style)
			positive_width: a_width >= 0
			color_not_void: a_color /= Void
		local
			error_code: INTEGER
		do
			item := cwin_create_pen (a_style, a_width, a_color.item)
			if item = default_pointer then
				error_code := cwin_get_last_error
				debug("WEL")
					io.putstring("Error while creating a pen in class WEL_PEN. error_code = "+error_code.out+"%N")
				end
			end
			gdi_make
		ensure
			pen_created: item /= default_pointer
		end

	make_solid (a_width: INTEGER; a_color: WEL_COLOR_REF) is
			-- Make a solid pen using `a_width' and `a_color'.
		require
			positive_width: a_width >= 0
			a_color_not_void: a_color /= Void
		do
			item := cwin_create_pen (Ps_solid, a_width, a_color.item)
			gdi_make
		ensure
			style_set: exists implies style = Ps_solid
			width_set: exists implies width = a_width
			color_set: exists implies color.item = a_color.item
		end

	make_indirect (a_log_pen: WEL_LOG_PEN) is
			-- Make a pen using `a_log_pen'.
		require
			a_log_pen_not_void: a_log_pen /= Void
		do
			item := cwin_create_pen_indirect (a_log_pen.item)
			gdi_make
		end

feature -- Access

	style: INTEGER is
			-- Pen style
		require
			exists: exists
		do
			Result := log_pen.style
		ensure
			valid_result: valid_pen_style_constant (Result)
		end

	width: INTEGER is
			-- Pen width
		require
			exists: exists
		do
			Result := log_pen.width
		ensure
			positive_result: Result >= 0
		end

	color: WEL_COLOR_REF is
			-- Pen color
		require
			exists: exists
		do
			Result := log_pen.color
		ensure
			result_not_void: Result /= Void
		end

	log_pen: WEL_LOG_PEN is
			-- Log pen structure associated to `Current'
		require
			exists: exists
		do
			create Result.make_by_pen (Current)
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwin_create_pen (a_style, a_width: INTEGER; a_color: INTEGER): POINTER is
			-- SDK CreatePen
		external
			"C [macro <windows.h>] (int, int, COLORREF): EIF_POINTER"
		alias
			"CreatePen"
		end

	cwin_create_pen_indirect (a_log_pen: POINTER): POINTER is
			-- SDK CreatePenIndirect
		external
			"C [macro <windows.h>] (LOGPEN *): EIF_POINTER"
		alias
			"CreatePenIndirect"
		end
	
	cwin_get_last_error: INTEGER is
		external
			"C [macro <windows.h>]: DWORD"
		alias
			"GetLastError"
		end

end -- class WEL_PEN

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

