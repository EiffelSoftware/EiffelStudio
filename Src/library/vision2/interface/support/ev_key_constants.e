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

	Key_0: INTEGER is unique
			-- Code representing "0".

	Key_1: INTEGER is unique
			-- Code representing "1".

	Key_2: INTEGER is unique
			-- Code representing "2".

	Key_3: INTEGER is unique
			-- Code representing "3".

	Key_4: INTEGER is unique
			-- Code representing "4".

	Key_5: INTEGER is unique
			-- Code representing "5".

	Key_6: INTEGER is unique
			-- Code representing "6".

	Key_7: INTEGER is unique
			-- Code representing "7".

	Key_8: INTEGER is unique
			-- Code representing "8".

	Key_9: INTEGER is unique
			-- Code representing "9".

	Key_numpad_0: INTEGER is unique
			-- Code representing numerical keypad "0".

	Key_numpad_1: INTEGER is unique
			-- Code representing numerical keypad "1".

	Key_numpad_2: INTEGER is unique
			-- Code representing numerical keypad "2".

	Key_numpad_3: INTEGER is unique
			-- Code representing numerical keypad "3".

	Key_numpad_4: INTEGER is unique
			-- Code representing numerical keypad "4".

	Key_numpad_5: INTEGER is unique
			-- Code representing numerical keypad "5".

	Key_numpad_6: INTEGER is unique
			-- Code representing numerical keypad "6".

	Key_numpad_7: INTEGER is unique
			-- Code representing numerical keypad "7".

	Key_numpad_8: INTEGER is unique
			-- Code representing numerical keypad "8".

	Key_numpad_9: INTEGER is unique
			-- Code representing numerical keypad "9".

	Key_numpad_add: INTEGER is unique
			-- Code representing numerical keypad "+".

	Key_numpad_divide: INTEGER is unique
			-- Code representing numerical keypad "/".

	Key_numpad_multiply: INTEGER is unique
			-- Code representing numerical keypad "*".

	Key_num_lock: INTEGER is unique
			-- Code representing num lock.

	Key_numpad_subtract: INTEGER is unique
			-- Code representing numerical keypad "-".

	Key_numpad_decimal: INTEGER is unique
			-- Code representing numerical keypad ".".

	Key_f1: INTEGER is unique
			-- Code representing F1.

	Key_f2: INTEGER is unique
			-- Code representing F2.

	Key_f3: INTEGER is unique
			-- Code representing F3.

	Key_f4: INTEGER is unique
			-- Code representing F4.

	Key_f5: INTEGER is unique
			-- Code representing F5.

	Key_f6: INTEGER is unique
			-- Code representing F6.

	Key_f7: INTEGER is unique
			-- Code representing F7.

	Key_f8: INTEGER is unique
			-- Code representing F8.

	Key_f9: INTEGER is unique
			-- Code representing F9.

	Key_f10: INTEGER is unique
			-- Code representing F10.

	Key_f11: INTEGER is unique
			-- Code representing F11.

	Key_f12: INTEGER is unique
			-- Code representing F12.

	Key_space: INTEGER is unique
			-- Code representing the spacebar.

	Key_back_space: INTEGER is unique
			-- Code representing back space.

	Key_enter: INTEGER is unique
			-- Code representing enter.

	Key_escape: INTEGER is unique
			-- Code representing escape.

	Key_tab: INTEGER is unique
			-- Code representing tab.

	Key_pause: INTEGER is unique
			-- Code representing pause (break).

	Key_caps_lock: INTEGER is unique
			-- Code representing caps lock.

	Key_scroll_lock: INTEGER is unique
			-- Code representing scroll lock.

	Key_comma: INTEGER is unique
			-- Code representing "," (or "<").

	Key_equal: INTEGER is unique
			-- Code representing "=" (or "+").

	Key_period: INTEGER is unique
			-- Code representing "." (or ">").

	Key_semicolon: INTEGER is unique
			-- Code representing ";" (or ":").

	Key_open_bracket: INTEGER is unique
			-- Code representing "[" (or "{").

	Key_close_bracket: INTEGER is unique
			-- Code representing "]" (or "}").

	Key_slash: INTEGER is unique
			-- Code representing "/" (or "?").

	Key_backslash: INTEGER is unique
			-- Code representing "\" (or "|").

	Key_quote: INTEGER is unique
			-- Code representing "'" (or """).

	Key_backquote: INTEGER is unique
			-- Code representing "`" (or "~").

	Key_dash: INTEGER is unique
			-- Code representing "-" (or "_").

	Key_up: INTEGER is unique
			-- Code representing the up-arrow.

	Key_down: INTEGER is unique
			-- Code representing the down-arrow.

	Key_left: INTEGER is unique
			-- Code representing the left-arrow.

	Key_right: INTEGER is unique
			-- Code representing the right-arrow.

	Key_page_up: INTEGER is unique
			-- Code representing page up.

	Key_page_down: INTEGER is unique
			-- Code representing page down.

	Key_home: INTEGER is unique
			-- Code representing home.

	Key_end: INTEGER is unique
			-- Code representing end.

	Key_insert: INTEGER is unique
			-- Code representing insert.

	Key_delete: INTEGER is unique
			-- Code representing delete.

	Key_a: INTEGER is unique
			-- Code representing "a".

	Key_b: INTEGER is unique
			-- Code representing "b".

	Key_c: INTEGER is unique
			-- Code representing "c".

	Key_d: INTEGER is unique
			-- Code representing "d".

	Key_e: INTEGER is unique
			-- Code representing "e".

	Key_f: INTEGER is unique
			-- Code representing "f".

	Key_g: INTEGER is unique
			-- Code representing "g".

	Key_h: INTEGER is unique
			-- Code representing "h".

	Key_i: INTEGER is unique
			-- Code representing "i".

	Key_j: INTEGER is unique
			-- Code representing "j".

	Key_k: INTEGER is unique
			-- Code representing "k".

	Key_l: INTEGER is unique
			-- Code representing "l".

	Key_m: INTEGER is unique
			-- Code representing "m".

	Key_n: INTEGER is unique
			-- Code representing "n".

	Key_o: INTEGER is unique
			-- Code representing "o".

	Key_p: INTEGER is unique
			-- Code representing "p".

	Key_q: INTEGER is unique
			-- Code representing "q".

	Key_r: INTEGER is unique
			-- Code representing "r".

	Key_s: INTEGER is unique
			-- Code representing "s".

	Key_t: INTEGER is unique
			-- Code representing "t".

	Key_u: INTEGER is unique
			-- Code representing "u".

	Key_v: INTEGER is unique
			-- Code representing "v".

	Key_w: INTEGER is unique
			-- Code representing "w".

	Key_x: INTEGER is unique
			-- Code representing "x".

	Key_y: INTEGER is unique
			-- Code representing "y".

	Key_z: INTEGER is unique
			-- Code representing "z".

	Key_shift: INTEGER is unique
			-- Code representing shift.

	Key_ctrl: INTEGER is unique
			-- Code representing control.

	Key_left_meta: INTEGER is unique
			-- Code representing left application-key.

	Key_right_meta: INTEGER is unique
			-- Code representing right application-key.

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
