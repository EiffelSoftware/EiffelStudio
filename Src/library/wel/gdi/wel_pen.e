note
	description: "Drawing object used to draw lines and borders."
	legal: "See notice at end of class."
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

create
	make,
	make_solid,
	make_indirect,
	make_from_brush,
	make_by_pointer

feature {NONE} -- Initialization

	make (a_style, a_width: INTEGER; a_color: WEL_COLOR_REF)
			-- Make a pen using `a_style', `a_width' and `a_color'.
			-- See class WEL_PS_CONSTANTS for `a_style' values.
		require
			valid_pen_style: valid_pen_style_constant (a_style)
			positive_width: a_width >= 0
			color_not_void: a_color /= Void
		local
			l_wel_error: WEL_ERROR
			a_default_pointer: POINTER
		do
			item := cwin_create_pen (a_style, a_width, a_color.item)
			if item = a_default_pointer then
				debug("WEL")
					create l_wel_error
					io.put_string_32 ({STRING} "Error while creating a pen in class WEL_PEN.error_code = " +
						l_wel_error.last_error_code.out+"%N")
				end
			end
			gdi_make
		ensure
			pen_created: item /= default_pointer
		end

	make_solid (a_width: INTEGER; a_color: WEL_COLOR_REF)
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

	make_indirect (a_log_pen: WEL_LOG_PEN)
			-- Make a pen using `a_log_pen'.
		require
			a_log_pen_not_void: a_log_pen /= Void
			a_log_pen_exists: a_log_pen.exists
		do
			item := cwin_create_pen_indirect (a_log_pen.item)
			gdi_make
		end

	make_from_brush (a_style, a_width: INTEGER; a_log_brush: WEL_LOG_BRUSH)
			-- Make a pen using `a_log_brush'.
		require
			a_log_brush_not_void: a_log_brush /= Void
			a_log_brush_exists: a_log_brush.exists
			valid_extended_pen_style: valid_extended_pen_style (a_style)
		do
			item := cwin_ext_create_pen (a_style, a_width, a_log_brush.item, 0 , default_pointer)
			gdi_make
		end

feature -- Access

	style: INTEGER
			-- Pen style
		require
			exists: exists
		do
			Result := log_pen.style
		ensure
			valid_result: valid_pen_style_constant (Result)
		end

	width: INTEGER
			-- Pen width
		require
			exists: exists
		do
			Result := log_pen.width
		ensure
			positive_result: Result >= 0
		end

	color: WEL_COLOR_REF
			-- Pen color
		require
			exists: exists
		do
			Result := log_pen.color
		ensure
			result_not_void: Result /= Void
		end

	log_pen: WEL_LOG_PEN
			-- Log pen structure associated to `Current'
		require
			exists: exists
		do
			create Result.make_by_pen (Current)
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwin_create_pen (a_style, a_width: INTEGER; a_color: INTEGER): POINTER
			-- SDK CreatePen
		external
			"C [macro <windows.h>] (int, int, COLORREF): EIF_POINTER"
		alias
			"CreatePen"
		end

	cwin_ext_create_pen (a_style, a_width: INTEGER; a_log_brush: POINTER; a_style_count: INTEGER; a_style_array: POINTER): POINTER
			-- SDK ExtCreatePen
		external
			"C [macro <windows.h>] (DWORD, DWORD, const LOGBRUSH*, DWORD, const DWORD*): EIF_POINTER"
		alias
			"ExtCreatePen"
		end

	cwin_create_pen_indirect (a_log_pen: POINTER): POINTER
			-- SDK CreatePenIndirect
		external
			"C [macro <windows.h>] (LOGPEN *): EIF_POINTER"
		alias
			"CreatePenIndirect"
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class WEL_PEN

