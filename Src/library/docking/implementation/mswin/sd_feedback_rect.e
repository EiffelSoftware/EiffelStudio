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
			destroy_extra_area
		end

	set_area (a_rect: EV_RECTANGLE) is
			-- Set feedback area.
		do
			set_area_internal (a_rect)
			destroy_extra_area
		end

	set_tab_area (a_top_rect, a_bottom_rect: EV_RECTANGLE) is
			-- Set size for tab feedback.
		require
			a_top_rect_not_void: a_top_rect /= Void
			a_bottom_rect_not_void: a_bottom_rect /= Void
		do
			set_area_internal (a_top_rect)

			if internal_extra_rect = Void then
				create internal_extra_rect.make
			end

			internal_extra_rect.set_area (a_bottom_rect)
			internal_extra_rect.show
		end

feature {NONE} -- Implementation

	set_area_internal (a_rect: EV_RECTANGLE) is
			-- Set feedback area, not destroy `internal_extra_area'.
		do
			set_position (a_rect.left, a_rect.top)
			set_size (a_rect.width, a_rect.height)
		end

	destroy_extra_area is
			-- Destroy extra area.
		do
			if internal_extra_rect /= Void and then internal_extra_rect.is_displayed then
				internal_extra_rect.clear
			end
		end

	set_transparent (a_alpha: INTEGER)is
			-- Set transparent. a_alpha is a value from 0-255.
		local
			l_imp: EV_POPUP_WINDOW_IMP
			l_result: INTEGER
			l_error: WEL_ERROR
		do
			l_imp ?= implementation
			l_imp.set_ex_style ({WEL_WS_CONSTANTS}.ws_ex_layered)
			check l_imp /= Void end
			set_transparency (l_imp.wel_item, a_alpha, $l_result)
			if l_result = 0 then
				create l_error
				l_error.display_last_error
			end
		end

	set_transparency (a_wnd: POINTER; a_alpha: INTEGER; a_result: TYPED_POINTER [INTEGER]) is
			-- Set layered window properties on Windows 2000 and later.
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

	internal_extra_rect: SD_FEEDBACK_RECT
			-- Extra rect feedback which used by draw tab feedback.

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
