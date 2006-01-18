indexing
	description: "System color on Windows."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SYSTEM_COLOR

feature

	mdi_back_ground_color: EV_COLOR is
			-- Background color of multiple document interface (MDI) applications.
		local
			l_color_integer: INTEGER
			l_hex: SD_HEXER
			l_r, l_g, l_b: INTEGER
		do
			sys_color (12, $l_color_integer)
			create l_hex
			l_r := l_hex.hex_to_integer_32 (l_color_integer.to_hex_string.substring (3, 4))
			l_g := l_hex.hex_to_integer_32 (l_color_integer.to_hex_string.substring (5, 6))
			l_b := l_hex.hex_to_integer_32 (l_color_integer.to_hex_string.substring (7, 8))
			create Result.make_with_8_bit_rgb (l_r, l_g, l_b)
		end

	focused_selection_color: EV_COLOR is
			-- Focused selection color for title bar.
		local
			l_grid: EV_GRID
		do
			create l_grid
			Result := l_grid.focused_selection_color
		end

	non_focused_selection_color: EV_COLOR is
			-- Non focused selection color for title bar.
		local
			l_grid: EV_GRID
		do
			create l_grid
			Result := l_grid.non_focused_selection_color
		end

	non_focused_selection_title_color: EV_COLOR is
			-- Non focused selectetion color for title.
		local
			l_color_integer: INTEGER
		do
			-- COLOR_INACTIVECAPTION
			sys_color (3, $l_color_integer)
			Result := int_to_color (l_color_integer)
		end

	title_bar_non_focus_color: EV_COLOR is
			--  Non focused color of title bar.
		local
			l_color_integer: INTEGER
		do
			-- COLOR_APPWORKSPACE
			sys_color (12, $l_color_integer)
			Result := int_to_color (l_color_integer)
		end

feature {NONE}  -- Implementation

	int_to_color (a_integer: INTEGER): EV_COLOR is
			-- Change a_integer to EV_COLOR.
		require
			valid:
		local
			l_hex: SD_HEXER
			l_r, l_g, l_b: INTEGER
		do
			create l_hex
			l_r := l_hex.hex_to_integer_32 (a_integer.to_hex_string.substring (3, 4))
			l_g := l_hex.hex_to_integer_32 (a_integer.to_hex_string.substring (5, 6))
			l_b := l_hex.hex_to_integer_32 (a_integer.to_hex_string.substring (7, 8))
			create Result.make_with_8_bit_rgb (l_r, l_g, l_b)
		ensure
			not_void: Result /= Void
		end

	sys_color (a_color_index: INTEGER; a_result: TYPED_POINTER [INTEGER]) is
			-- Get a system color of Windows.
		external
			"C inline use <windows.h>"
		alias
			"[
			{
				FARPROC get_sys_color = NULL;
				HMODULE user32_module = LoadLibrary ("user32.dll");
				if (user32_module) {
					get_sys_color = GetProcAddress (user32_module, "GetSysColor");
					if (get_sys_color) {
						*(EIF_INTEGER *) $a_result = (FUNCTION_CAST_TYPE(DWORD, WINAPI, (int)) get_sys_color) ($a_color_index);
					}
				}
			}
			]"
		end

end
