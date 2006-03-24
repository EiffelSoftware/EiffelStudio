indexing
	description: "Transparent rectangle which only avail on Microsoft Windows 2000 and later."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FEEDBACK_RECT

inherit
	EV_POPUP_WINDOW
		rename
			set_background_color as set_color,
			hide as clear
		redefine
			clear
		end
create
	make

feature {NONE} -- Initlization

	make  is
			-- Creation method
		do
			default_create
			create internal_shared
			set_transparent (255 // 5 * 3)
			disable_user_resize
			set_color (internal_shared.focused_color)
		end

feature -- Command

	clear is
			-- Clear
		do
			Precursor {EV_POPUP_WINDOW}
		end

	set_area (a_rect: EV_RECTANGLE) is
			-- Set feedback area.
		local
			l_region: WEL_REGION
			l_imp: WEL_WINDOW
			l_result: INTEGER
		do
			set_size (a_rect.width, a_rect.height)
			set_position (a_rect.left, a_rect.top)

			create l_region.make_rect (0, 0, a_rect.width, a_rect.height)
			l_imp ?= implementation
			check not_void: l_imp /= Void end
			set_window_rgn (l_imp.item, l_region.item, $l_result)
			check successed: l_result /= 0 end
		end

	set_tab_area (a_top_rect, a_bottom_rect: EV_RECTANGLE) is
			-- Set size for tab feedback.
		require
			a_top_rect_not_void: a_top_rect /= Void
			a_bottom_rect_not_void: a_bottom_rect /= Void
		local
			l_region: WEL_REGION
			l_temp_region, l_temp_region_2: WEL_REGION
			l_constants: WEL_RGN_CONSTANTS
			l_result: INTEGER
			l_imp: WEL_WINDOW
			l_left: INTEGER
		do
			set_size (a_top_rect.width.max (a_bottom_rect.width), a_top_rect.height + a_bottom_rect.height)
			set_position (a_top_rect.left, a_top_rect.top)

			create l_constants
			l_left := (a_top_rect.left - a_bottom_rect.left).abs
			if a_top_rect.left - a_bottom_rect.left >= 0 then
				create l_temp_region.make_rect (l_left, 0, l_left + a_top_rect.width, a_top_rect.height)
				create l_temp_region_2.make_rect (0, a_top_rect.height, a_bottom_rect.width, a_top_rect.height + a_bottom_rect.height)
			else
				create l_temp_region.make_rect (0, 0, a_top_rect.width, a_top_rect.height)
				create l_temp_region_2.make_rect (l_left, a_top_rect.height, l_left + a_bottom_rect.width, a_top_rect.height + a_bottom_rect.height)
			end

			l_region := l_temp_region.combine (l_temp_region_2, l_constants.rgn_or)

			l_temp_region.delete
			l_temp_region_2.delete

			l_imp ?= implementation
			check not_void: l_imp /= Void end
			set_window_rgn (l_imp.item, l_region.item, $l_result)
			check success: l_result /= 0 end
		end

feature {NONE} -- Implementation

	set_area_internal (a_rect: EV_RECTANGLE) is
			-- Set feedback area, not destroy `internal_extra_area'.
		do
			set_position (a_rect.left, a_rect.top)
			set_size (a_rect.width, a_rect.height)
		end

	set_transparent (a_alpha: INTEGER)is
			-- Set transparent. a_alpha is a value from 0-255.
		local
			l_imp: EV_POPUP_WINDOW_IMP
			l_result: INTEGER
		do
			l_imp ?= implementation
			l_imp.set_ex_style ({WEL_WS_CONSTANTS}.ws_ex_layered)
			check l_imp /= Void end
			cwin_setlayeredwindowattributes (l_imp.wel_item, a_alpha, $l_result)
		end

	cwin_setlayeredwindowattributes (a_wnd: POINTER; a_alpha: INTEGER; a_result: TYPED_POINTER [INTEGER]) is
				-- Set layered window properties on Windows 2000 and later.
		require
			exists: a_wnd /= a_wnd.default_pointer
			valid: 0 <= a_alpha and a_alpha <= 255
		external
			"C inline use <windows.h>"
		alias
			"[
			{
				FARPROC set_layer_window_attribute = NULL;
				HMODULE user32_module = LoadLibrary ("user32.dll");
				if (user32_module) {
					set_layer_window_attribute = GetProcAddress (user32_module, "SetLayeredWindowAttributes");
					if (set_layer_window_attribute) {
						*(EIF_INTEGER *) $a_result = (FUNCTION_CAST_TYPE(BOOL, WINAPI, (HWND, COLORREF, BYTE, DWORD)) set_layer_window_attribute) ($a_wnd,RGB(0,0,0),$a_alpha,0x00000002);
					}else
					{
						// Handle windows 98 and windows Nt here.
					}
				}
			}
			]"
		end

	set_window_rgn (a_hwnd: POINTER; a_rgn: POINTER; a_result: TYPED_POINTER [INTEGER]) is
			-- Set Windows reigon.
		external
			"C inline use <Winuser.h>"
		alias
			"[
				*(EIF_INTEGER *) $a_result = SetWindowRgn ($a_hwnd, $a_rgn, TRUE)
			]"
		end

	internal_shared: SD_SHARED;
			-- All singletons.
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
