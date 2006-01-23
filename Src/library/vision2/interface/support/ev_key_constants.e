indexing
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

	Key_0: INTEGER is 1
	Key_1: INTEGER is 2
	Key_2: INTEGER is 3
	Key_3: INTEGER is 4
	Key_4: INTEGER is 5
	Key_5: INTEGER is 6
	Key_6: INTEGER is 7
	Key_7: INTEGER is 8
	Key_8: INTEGER is 9
	Key_9: INTEGER is 10
	Key_numpad_0: INTEGER is 11
	Key_numpad_1: INTEGER is 12
	Key_numpad_2: INTEGER is 13
	Key_numpad_3: INTEGER is 14
	Key_numpad_4: INTEGER is 15
	Key_numpad_5: INTEGER is 16
	Key_numpad_6: INTEGER is 17
	Key_numpad_7: INTEGER is 18
	Key_numpad_8: INTEGER is 19
	Key_numpad_9: INTEGER is 20
	Key_numpad_add: INTEGER is 21
	Key_numpad_divide: INTEGER is 22
	Key_numpad_multiply: INTEGER is 23
	key_num_lock: INTEGER is 24
	Key_numpad_subtract: INTEGER is 25
	Key_numpad_decimal: INTEGER is 26
	Key_f1: INTEGER is 27
	Key_f2: INTEGER is 28
	Key_f3: INTEGER is 29
	Key_f4: INTEGER is 30
	Key_f5: INTEGER is 31
	Key_f6: INTEGER is 32
	Key_f7: INTEGER is 33
	Key_f8: INTEGER is 34
	Key_f9: INTEGER is 35
	Key_f10: INTEGER is 36
	Key_f11: INTEGER is 37
	Key_f12: INTEGER is 38
	Key_space: INTEGER is 39
	Key_back_space: INTEGER is 40
	Key_enter: INTEGER is 41
	Key_escape: INTEGER is 42
	Key_tab: INTEGER is 43
	Key_pause: INTEGER is 44
	Key_caps_lock: INTEGER is 45
	Key_scroll_lock: INTEGER is 46
	Key_comma: INTEGER is 47
	Key_equal: INTEGER is 48
	Key_period: INTEGER is 49
	Key_semicolon: INTEGER is 50
	Key_open_bracket: INTEGER is 51
	Key_close_bracket: INTEGER is 52
	Key_slash: INTEGER is 53
	Key_backslash: INTEGER is 54
	Key_quote: INTEGER is 55
	Key_backquote: INTEGER is 56
	Key_dash: INTEGER is 57
	Key_up: INTEGER is 58
	Key_down: INTEGER is 59
	Key_left: INTEGER is 60
	Key_right: INTEGER is 61
	Key_page_up: INTEGER is 62
	Key_page_down: INTEGER is 63
	Key_home: INTEGER is 64
	Key_end: INTEGER is 65
	Key_insert: INTEGER is 66
	Key_delete: INTEGER is 67
	Key_a: INTEGER is 68
	Key_b: INTEGER is 69
	Key_c: INTEGER is 70
	Key_d: INTEGER is 71
	Key_e: INTEGER is 72
	Key_f: INTEGER is 73
	Key_g: INTEGER is 74
	Key_h: INTEGER is 75
	Key_i: INTEGER is 76
	Key_j: INTEGER is 77
	Key_k: INTEGER is 78
	Key_l: INTEGER is 79
	Key_m: INTEGER is 80
	Key_n: INTEGER is 81
	Key_o: INTEGER is 82
	Key_p: INTEGER is 83
	Key_q: INTEGER is 84
	Key_r: INTEGER is 85
	Key_s: INTEGER is 86
	Key_t: INTEGER is 87
	Key_u: INTEGER is 88
	Key_v: INTEGER is 89
	Key_w: INTEGER is 90
	Key_x: INTEGER is 91
	Key_y: INTEGER is 92
	Key_z: INTEGER is 93
	Key_shift: INTEGER is 94
	Key_ctrl: INTEGER is 95
	Key_left_meta: INTEGER is 96
	Key_right_meta: INTEGER is 97

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

	key_code_from_key_string (key_string: STRING): INTEGER is
			-- Key code value from `key_string'
		require
			key_string_not_void: key_string /= Void
		local
			l_key_strings: ARRAY [STRING]
			l_cnt: INTEGER
			found: BOOLEAN
		do
			l_key_strings := key_strings
			from
				l_cnt := l_key_strings.lower
			until
				l_cnt > l_key_strings.upper or found
			loop
				found := l_key_strings.item (l_cnt).as_lower.is_equal (key_string.as_lower)
				if found then
					Result := l_cnt
				else
					l_cnt := l_cnt + 1
				end
			end
		end

feature -- Contract support

	valid_key_code (a_code: INTEGER): BOOLEAN is
			-- Is ``a_code'' a valid key code?
		do
			Result := a_code >= Key_0 and then a_code <= Key_right_meta
		end

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




end -- class EV_KEY_CONSTANTS

