indexing
	description: "Eiffel Vision WEL key conversion. Provides a function%N%
		%for WEL to vision2 conversion and for vision2 to WEL conversion."
	status: "See notice at end of class"
	date: "generated"
	revision: "generated"

class
	EV_WEL_KEY_CONVERSION

inherit
	WEL_VK_CONSTANTS

	EV_KEY_CONSTANTS

feature -- Conversion

	key_code_to_wel (a_key_code: INTEGER): INTEGER is
			-- Corresponding WEL code for ``a_key_code''.
		require
			a_key_code_valid: valid_key_code (a_key_code)
		do
			Result := v2_to_wel_table @ a_key_code
		end

	key_code_from_wel (a_wel_code: INTEGER): INTEGER is
			-- Corresponding key code for ``a_wel_code''.
		require
			a_wel_code_valid: valid_wel_code (a_wel_code)
		do
			Result := wel_to_v2_table.item (a_wel_code)
		end

feature -- Contract support

	valid_wel_code (a_wel_code: INTEGER): BOOLEAN is
			-- Is ``a_wel_code'' valid?
		do
			Result := wel_to_v2_table.has (a_wel_code)
		end

feature {NONE} -- Implementation

	v2_to_wel_table: ARRAY [INTEGER] is
			-- WEL keycodes indexed by Vision2 key code.
		once
			create Result.make (Key_0, Key_right_meta)
			Result.put (48, Key_0)
			Result.put (49, Key_1)
			Result.put (50, Key_2)
			Result.put (51, Key_3)
			Result.put (52, Key_4)
			Result.put (53, Key_5)
			Result.put (54, Key_6)
			Result.put (55, Key_7)
			Result.put (56, Key_8)
			Result.put (57, Key_9)
			Result.put (Vk_numpad0, Key_numpad_0)
			Result.put (Vk_numpad1, Key_numpad_1)
			Result.put (Vk_numpad2, Key_numpad_2)
			Result.put (Vk_numpad3, Key_numpad_3)
			Result.put (Vk_numpad4, Key_numpad_4)
			Result.put (Vk_numpad5, Key_numpad_5)
			Result.put (Vk_numpad6, Key_numpad_6)
			Result.put (Vk_numpad7, Key_numpad_7)
			Result.put (Vk_numpad8, Key_numpad_8)
			Result.put (Vk_numpad9, Key_numpad_9)
			Result.put (Vk_add, Key_numpad_add)
			Result.put (Vk_divide, Key_numpad_divide)
			Result.put (Vk_multiply, Key_numpad_multiply)
			Result.put (Vk_numlock, Key_num_lock)
			Result.put (Vk_subtract, Key_numpad_subtract)
			Result.put (Vk_decimal, Key_numpad_decimal)
			Result.put (Vk_f1, Key_f1)
			Result.put (Vk_f2, Key_f2)
			Result.put (Vk_f3, Key_f3)
			Result.put (Vk_f4, Key_f4)
			Result.put (Vk_f5, Key_f5)
			Result.put (Vk_f6, Key_f6)
			Result.put (Vk_f7, Key_f7)
			Result.put (Vk_f8, Key_f8)
			Result.put (Vk_f9, Key_f9)
			Result.put (Vk_f10, Key_f10)
			Result.put (Vk_f11, Key_f11)
			Result.put (Vk_f12, Key_f12)
			Result.put (Vk_space, Key_space)
			Result.put (Vk_back, Key_back_space)
			Result.put (Vk_return, Key_enter)
			Result.put (Vk_escape, Key_escape)
			Result.put (Vk_tab, Key_tab)
			Result.put (Vk_pause, Key_pause)
			Result.put (Vk_capital, Key_caps_lock)
			Result.put (Vk_scroll, Key_scroll_lock)
			Result.put (188, Key_comma)
			Result.put (187, Key_equal)
			Result.put (190, Key_period)
			Result.put (186, Key_semicolon)
			Result.put (219, Key_open_bracket)
			Result.put (221, Key_close_bracket)
			Result.put (191, Key_slash)
			Result.put (220, Key_backslash)
			Result.put (222, Key_quote)
			Result.put (192, Key_backquote)
			Result.put (189, Key_dash)
			Result.put (Vk_up, Key_up)
			Result.put (Vk_down, Key_down)
			Result.put (Vk_left, Key_left)
			Result.put (Vk_right, Key_right)
			Result.put (Vk_prior, Key_page_up)
			Result.put (Vk_next, Key_page_down)
			Result.put (Vk_home, Key_home)
			Result.put (Vk_end, Key_end)
			Result.put (Vk_insert, Key_insert)
			Result.put (Vk_delete, Key_delete)
			Result.put (65, Key_a)
			Result.put (66, Key_b)
			Result.put (67, Key_c)
			Result.put (68, Key_d)
			Result.put (69, Key_e)
			Result.put (70, Key_f)
			Result.put (71, Key_g)
			Result.put (72, Key_h)
			Result.put (73, Key_i)
			Result.put (74, Key_j)
			Result.put (75, Key_k)
			Result.put (76, Key_l)
			Result.put (77, Key_m)
			Result.put (78, Key_n)
			Result.put (79, Key_o)
			Result.put (80, Key_p)
			Result.put (81, Key_q)
			Result.put (82, Key_r)
			Result.put (83, Key_s)
			Result.put (84, Key_t)
			Result.put (85, Key_u)
			Result.put (86, Key_v)
			Result.put (87, Key_w)
			Result.put (88, Key_x)
			Result.put (89, Key_y)
			Result.put (90, Key_z)
			Result.put (16, Key_shift)
			Result.put (17, Key_ctrl)
			Result.put (91, Key_left_meta)
			Result.put (92, Key_right_meta)
		end

	wel_to_v2_table: HASH_TABLE [INTEGER, INTEGER] is
			-- Vision2 keycodes indexed by WEL key code.
		once
			create Result.make (128)
			Result.put (Key_0, 48)
			Result.put (Key_1, 49)
			Result.put (Key_2, 50)
			Result.put (Key_3, 51)
			Result.put (Key_4, 52)
			Result.put (Key_5, 53)
			Result.put (Key_6, 54)
			Result.put (Key_7, 55)
			Result.put (Key_8, 56)
			Result.put (Key_9, 57)
			Result.put (Key_numpad_0, Vk_numpad0)
			Result.put (Key_numpad_1, Vk_numpad1)
			Result.put (Key_numpad_2, Vk_numpad2)
			Result.put (Key_numpad_3, Vk_numpad3)
			Result.put (Key_numpad_4, Vk_numpad4)
			Result.put (Key_numpad_5, Vk_numpad5)
			Result.put (Key_numpad_6, Vk_numpad6)
			Result.put (Key_numpad_7, Vk_numpad7)
			Result.put (Key_numpad_8, Vk_numpad8)
			Result.put (Key_numpad_9, Vk_numpad9)
			Result.put (Key_numpad_add, Vk_add)
			Result.put (Key_numpad_divide, Vk_divide)
			Result.put (Key_numpad_multiply, Vk_multiply)
			Result.put (Key_num_lock, Vk_numlock)
			Result.put (Key_numpad_subtract, Vk_subtract)
			Result.put (Key_numpad_decimal, Vk_decimal)
			Result.put (Key_f1, Vk_f1)
			Result.put (Key_f2, Vk_f2)
			Result.put (Key_f3, Vk_f3)
			Result.put (Key_f4, Vk_f4)
			Result.put (Key_f5, Vk_f5)
			Result.put (Key_f6, Vk_f6)
			Result.put (Key_f7, Vk_f7)
			Result.put (Key_f8, Vk_f8)
			Result.put (Key_f9, Vk_f9)
			Result.put (Key_f10, Vk_f10)
			Result.put (Key_f11, Vk_f11)
			Result.put (Key_f12, Vk_f12)
			Result.put (Key_space, Vk_space)
			Result.put (Key_back_space, Vk_back)
			Result.put (Key_enter, Vk_return)
			Result.put (Key_enter, Vk_return)
			Result.put (Key_escape, Vk_escape)
			Result.put (Key_tab, Vk_tab)
			Result.put (Key_tab, Vk_tab)
			Result.put (Key_pause, Vk_pause)
			Result.put (Key_caps_lock, Vk_capital)
			Result.put (Key_scroll_lock, Vk_scroll)
			Result.put (Key_comma, 188)
			Result.put (Key_equal, 187)
			Result.put (Key_period, 190)
			Result.put (Key_semicolon, 186)
			Result.put (Key_open_bracket, 219)
			Result.put (Key_close_bracket, 221)
			Result.put (Key_slash, 191)
			Result.put (Key_backslash, 220)
			Result.put (Key_quote, 222)
			Result.put (Key_backquote, 192)
			Result.put (Key_dash, 189)
			Result.put (Key_up, Vk_up)
			Result.put (Key_up, Vk_up)
			Result.put (Key_down, Vk_down)
			Result.put (Key_down, Vk_down)
			Result.put (Key_left, Vk_left)
			Result.put (Key_left, Vk_left)
			Result.put (Key_right, Vk_right)
			Result.put (Key_right, Vk_right)
			Result.put (Key_page_up, Vk_prior)
			Result.put (Key_page_up, Vk_prior)
			Result.put (Key_page_down, Vk_next)
			Result.put (Key_page_down, Vk_next)
			Result.put (Key_home, Vk_home)
			Result.put (Key_home, Vk_home)
			Result.put (Key_end, Vk_end)
			Result.put (Key_end, Vk_end)
			Result.put (Key_insert, Vk_insert)
			Result.put (Key_insert, Vk_insert)
			Result.put (Key_delete, Vk_delete)
			Result.put (Key_delete, Vk_delete)
			Result.put (Key_a, 65)
			Result.put (Key_b, 66)
			Result.put (Key_c, 67)
			Result.put (Key_d, 68)
			Result.put (Key_e, 69)
			Result.put (Key_f, 70)
			Result.put (Key_g, 71)
			Result.put (Key_h, 72)
			Result.put (Key_i, 73)
			Result.put (Key_j, 74)
			Result.put (Key_k, 75)
			Result.put (Key_l, 76)
			Result.put (Key_m, 77)
			Result.put (Key_n, 78)
			Result.put (Key_o, 79)
			Result.put (Key_p, 80)
			Result.put (Key_q, 81)
			Result.put (Key_r, 82)
			Result.put (Key_s, 83)
			Result.put (Key_t, 84)
			Result.put (Key_u, 85)
			Result.put (Key_v, 86)
			Result.put (Key_w, 87)
			Result.put (Key_x, 88)
			Result.put (Key_y, 89)
			Result.put (Key_z, 90)
			Result.put (Key_a, 65)
			Result.put (Key_b, 66)
			Result.put (Key_c, 67)
			Result.put (Key_d, 68)
			Result.put (Key_e, 69)
			Result.put (Key_f, 70)
			Result.put (Key_g, 71)
			Result.put (Key_h, 72)
			Result.put (Key_i, 73)
			Result.put (Key_j, 74)
			Result.put (Key_k, 75)
			Result.put (Key_l, 76)
			Result.put (Key_m, 77)
			Result.put (Key_n, 78)
			Result.put (Key_o, 79)
			Result.put (Key_p, 80)
			Result.put (Key_q, 81)
			Result.put (Key_r, 82)
			Result.put (Key_s, 83)
			Result.put (Key_t, 84)
			Result.put (Key_u, 85)
			Result.put (Key_v, 86)
			Result.put (Key_w, 87)
			Result.put (Key_x, 88)
			Result.put (Key_y, 89)
			Result.put (Key_z, 90)
			Result.put (Key_shift, 16)
			Result.put (Key_shift, 16)
			Result.put (Key_ctrl, 17)
			Result.put (Key_ctrl, 17)
			Result.put (Key_left_meta, 91)
			Result.put (Key_right_meta, 92)
		end

end -- class EV_WEL_KEY_CONVERSION

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
