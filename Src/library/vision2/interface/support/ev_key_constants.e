indexing
	description:
		"Eiffel Vision key constants. Each constant defined here %N%
		%corresponds to a possible value of {EV_KEY}.code"
	status: "See notice at end of class"
	keywords: "key, code, constant"
	date: "generated"
	revision: "generated"

class
	EV_KEY_CONSTANTS
	
feature -- Constants

	Key_0, Key_1, Key_2, Key_3, Key_4, Key_5, Key_6, Key_7, Key_8, Key_9, Key_numpad_0, 
	Key_numpad_1, Key_numpad_2, Key_numpad_3, Key_numpad_4, Key_numpad_5, Key_numpad_6,
	Key_numpad_7, Key_numpad_8, Key_numpad_9, Key_numpad_add, Key_numpad_divide, Key_numpad_multiply,
	key_num_lock, Key_numpad_subtract, Key_numpad_decimal, Key_f1, Key_f2, Key_f3, Key_f4, Key_f5,
	Key_f6, Key_f7, Key_f8, Key_f9, Key_f10, Key_f11, Key_f12, Key_space, Key_back_space, Key_enter, 
	Key_escape, Key_tab, Key_pause, Key_caps_lock, Key_scroll_lock, Key_comma, Key_equal, Key_period,
	Key_semicolon, Key_open_bracket, Key_close_bracket, Key_slash, Key_backslash, Key_quote, Key_backquote,
	Key_dash, Key_up, Key_down, Key_left, Key_right, Key_page_up, Key_page_down, Key_home, Key_end,	Key_insert, 
	Key_delete, Key_a, Key_b, Key_c, Key_d, Key_e, Key_f, Key_g, Key_h, Key_i, Key_j, Key_k, Key_l, Key_m,
	Key_n, Key_o, Key_p, Key_q, Key_r, Key_s, Key_t, Key_u, Key_v, Key_w, Key_x, Key_y, Key_z, Key_shift,
	Key_ctrl, Key_left_meta, Key_right_meta: INTEGER is unique
		-- Codes representing keys supported in vision2.
	
feature -- Access

	Key_strings: ARRAY [STRING] is
			-- String representations of all key codes.
		once
			create Result.make (Key_0, Key_right_meta)
			Result.put ("0", Key_0)
			Result.put ("1", Key_1)
			Result.put ("2", Key_2)
			Result.put ("3", Key_3)
			Result.put ("4", Key_4)
			Result.put ("5", Key_5)
			Result.put ("6", Key_6)
			Result.put ("7", Key_7)
			Result.put ("8", Key_8)
			Result.put ("9", Key_9)
			Result.put ("NumPad 0", Key_numpad_0)
			Result.put ("NumPad 1", Key_numpad_1)
			Result.put ("NumPad 2", Key_numpad_2)
			Result.put ("NumPad 3", Key_numpad_3)
			Result.put ("NumPad 4", Key_numpad_4)
			Result.put ("NumPad 5", Key_numpad_5)
			Result.put ("NumPad 6", Key_numpad_6)
			Result.put ("NumPad 7", Key_numpad_7)
			Result.put ("NumPad 8", Key_numpad_8)
			Result.put ("NumPad 9", Key_numpad_9)
			Result.put ("NumPad +", Key_numpad_add)
			Result.put ("NumPad /", Key_numpad_divide)
			Result.put ("NumPad *", Key_numpad_multiply)
			Result.put ("NumLock", Key_num_lock)
			Result.put ("NumPad -", Key_numpad_subtract)
			Result.put ("NumPad .", Key_numpad_decimal)
			Result.put ("F1", Key_f1)
			Result.put ("F2", Key_f2)
			Result.put ("F3", Key_f3)
			Result.put ("F4", Key_f4)
			Result.put ("F5", Key_f5)
			Result.put ("F6", Key_f6)
			Result.put ("F7", Key_f7)
			Result.put ("F8", Key_f8)
			Result.put ("F9", Key_f9)
			Result.put ("F10", Key_f10)
			Result.put ("F11", Key_f11)
			Result.put ("F12", Key_f12)
			Result.put ("Space", Key_space)
			Result.put ("BackSpace", Key_back_space)
			Result.put ("Enter", Key_enter)
			Result.put ("Esc", Key_escape)
			Result.put ("Tab", Key_tab)
			Result.put ("Pause", Key_pause)
			Result.put ("CapsLock", Key_caps_lock)
			Result.put ("ScrollLock", Key_scroll_lock)
			Result.put (",", Key_comma)
			Result.put ("=", Key_equal)
			Result.put (".", Key_period)
			Result.put (";", Key_semicolon)
			Result.put ("[", Key_open_bracket)
			Result.put ("]", Key_close_bracket)
			Result.put ("/", Key_slash)
			Result.put ("\", Key_backslash)
			Result.put ("'", Key_quote)
			Result.put ("`", Key_backquote)
			Result.put ("-", Key_dash)
			Result.put ("Up", Key_up)
			Result.put ("Down", Key_down)
			Result.put ("Left", Key_left)
			Result.put ("Right", Key_right)
			Result.put ("PageUp", Key_page_up)
			Result.put ("PageDown", Key_page_down)
			Result.put ("Home", Key_home)
			Result.put ("End", Key_end)
			Result.put ("Insert", Key_insert)
			Result.put ("Del", Key_delete)
			Result.put ("a", Key_a)
			Result.put ("b", Key_b)
			Result.put ("c", Key_c)
			Result.put ("d", Key_d)
			Result.put ("e", Key_e)
			Result.put ("f", Key_f)
			Result.put ("g", Key_g)
			Result.put ("h", Key_h)
			Result.put ("i", Key_i)
			Result.put ("j", Key_j)
			Result.put ("k", Key_k)
			Result.put ("l", Key_l)
			Result.put ("m", Key_m)
			Result.put ("n", Key_n)
			Result.put ("o", Key_o)
			Result.put ("p", Key_p)
			Result.put ("q", Key_q)
			Result.put ("r", Key_r)
			Result.put ("s", Key_s)
			Result.put ("t", Key_t)
			Result.put ("u", Key_u)
			Result.put ("v", Key_v)
			Result.put ("w", Key_w)
			Result.put ("x", Key_x)
			Result.put ("y", Key_y)
			Result.put ("z", Key_z)
			Result.put ("Shift", Key_shift)
			Result.put ("Ctrl", Key_ctrl)
			Result.put ("Left Meta", Key_left_meta)
			Result.put ("Right Meta", Key_right_meta)
		end
		
feature -- Contract support

	valid_key_code (a_code: INTEGER): BOOLEAN is
			-- Is ``a_code'' a valid key code?
		do
			Result := a_code >= Key_0 and then a_code <= Key_right_meta
		end

end -- class EV_KEY_CONSTANTS

--!-----------------------------------------------------------------------------
--! EiffelVision Library: library of reusable components for ISE Eiffel.
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
