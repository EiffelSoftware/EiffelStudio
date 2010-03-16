note
	description:
		"Eiffel Vision key constants. Each constant defined here %N%
		%corresponds to a possible value of {EV_KEY}.code"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "key, code, constant"
	date: "generated"
	revision: "generated"

class
	EV_KEY_CONSTANTS

feature -- Constants

	Key_0: INTEGER = 1
	Key_1: INTEGER = 2
	Key_2: INTEGER = 3
	Key_3: INTEGER = 4
	Key_4: INTEGER = 5
	Key_5: INTEGER = 6
	Key_6: INTEGER = 7
	Key_7: INTEGER = 8
	Key_8: INTEGER = 9
	Key_9: INTEGER = 10
	Key_numpad_0: INTEGER = 11
	Key_numpad_1: INTEGER = 12
	Key_numpad_2: INTEGER = 13
	Key_numpad_3: INTEGER = 14
	Key_numpad_4: INTEGER = 15
	Key_numpad_5: INTEGER = 16
	Key_numpad_6: INTEGER = 17
	Key_numpad_7: INTEGER = 18
	Key_numpad_8: INTEGER = 19
	Key_numpad_9: INTEGER = 20
	Key_numpad_add: INTEGER = 21
	Key_numpad_divide: INTEGER = 22
	Key_numpad_multiply: INTEGER = 23
	key_num_lock: INTEGER = 24
	Key_numpad_subtract: INTEGER = 25
	Key_numpad_decimal: INTEGER = 26
	Key_f1: INTEGER = 27
	Key_f2: INTEGER = 28
	Key_f3: INTEGER = 29
	Key_f4: INTEGER = 30
	Key_f5: INTEGER = 31
	Key_f6: INTEGER = 32
	Key_f7: INTEGER = 33
	Key_f8: INTEGER = 34
	Key_f9: INTEGER = 35
	Key_f10: INTEGER = 36
	Key_f11: INTEGER = 37
	Key_f12: INTEGER = 38
	Key_space: INTEGER = 39
	Key_back_space: INTEGER = 40
	Key_enter: INTEGER = 41
	Key_escape: INTEGER = 42
	Key_tab: INTEGER = 43
	Key_pause: INTEGER = 44
	Key_caps_lock: INTEGER = 45
	Key_scroll_lock: INTEGER = 46
	Key_comma: INTEGER = 47
	Key_equal: INTEGER = 48
	Key_period: INTEGER = 49
	Key_semicolon: INTEGER = 50
	Key_open_bracket: INTEGER = 51
	Key_close_bracket: INTEGER = 52
	Key_slash: INTEGER = 53
	Key_backslash: INTEGER = 54
	Key_quote: INTEGER = 55
	Key_backquote: INTEGER = 56
	Key_dash: INTEGER = 57
	Key_up: INTEGER = 58
	Key_down: INTEGER = 59
	Key_left: INTEGER = 60
	Key_right: INTEGER = 61
	Key_page_up: INTEGER = 62
	Key_page_down: INTEGER = 63
	Key_home: INTEGER = 64
	Key_end: INTEGER = 65
	Key_insert: INTEGER = 66
	Key_delete: INTEGER = 67
	Key_a: INTEGER = 68
	Key_b: INTEGER = 69
	Key_c: INTEGER = 70
	Key_d: INTEGER = 71
	Key_e: INTEGER = 72
	Key_f: INTEGER = 73
	Key_g: INTEGER = 74
	Key_h: INTEGER = 75
	Key_i: INTEGER = 76
	Key_j: INTEGER = 77
	Key_k: INTEGER = 78
	Key_l: INTEGER = 79
	Key_m: INTEGER = 80
	Key_n: INTEGER = 81
	Key_o: INTEGER = 82
	Key_p: INTEGER = 83
	Key_q: INTEGER = 84
	Key_r: INTEGER = 85
	Key_s: INTEGER = 86
	Key_t: INTEGER = 87
	Key_u: INTEGER = 88
	Key_v: INTEGER = 89
	Key_w: INTEGER = 90
	Key_x: INTEGER = 91
	Key_y: INTEGER = 92
	Key_z: INTEGER = 93
	Key_shift: INTEGER = 94
	Key_ctrl: INTEGER = 95
	Key_alt: INTEGER = 96
	Key_left_meta: INTEGER = 97
	Key_right_meta: INTEGER = 98
	Key_menu: INTEGER = 99

feature -- Access

	Key_strings: ARRAY [STRING_32]
			-- String representations of all key codes.
		once
			create Result.make (Key_0, Key_menu)
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
			Result.put ("Alt", Key_alt)
			Result.put ("Left Meta", Key_left_meta)
			Result.put ("Right Meta", Key_right_meta)
			Result.put ("Menu", Key_menu)
		end

	key_code_from_key_string (key_string: STRING_GENERAL): INTEGER
			-- Key code value from `key_string'
		require
			key_string_not_void: key_string /= Void
		local
			l_key_strings: like key_strings
			l_cnt: INTEGER
			found: BOOLEAN
			l_key: STRING_32
		do
			l_key := key_string
			l_key := l_key.as_lower
			l_key_strings := key_strings
			from
				l_cnt := l_key_strings.lower
			until
				l_cnt > l_key_strings.upper or found
			loop
				found := l_key_strings.item (l_cnt).as_lower.is_equal (l_key)
				if found then
					Result := l_cnt
				else
					l_cnt := l_cnt + 1
				end
			end
		end

feature -- Contract support

	valid_key_code (a_code: INTEGER): BOOLEAN
			-- Is ``a_code'' a valid key code?
		do
			Result := a_code >= Key_0 and then a_code <= Key_menu
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_KEY_CONSTANTS

