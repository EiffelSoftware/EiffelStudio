indexing
	description: "Transparent rectangle which only avail on Microsoft Windows 2000 and later."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FEEDBACK_RECT

inherit
	EV_UNTITLED_DIALOG
		rename
			set_background_color as set_color,
			hide as clear
		end
create
	make

feature {NONE} -- Initlization

	make  is
			-- Creation method
		do
			default_create
			set_transparent (255 // 5 * 3)
		end

feature

	set_transparent (a_alpha: INTEGER)is
			-- Set transparent. a_alpha is a value from 0-255.
		local
			l_imp: EV_TITLED_WINDOW_IMP
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

feature {NONE}  -- Implementation

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

end
