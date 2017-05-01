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
			create Result.make_filled ({STRING_32} "", Key_0, Key_menu)
			Result.put ({STRING_32} "0", Key_0)
			Result.put ({STRING_32} "1", Key_1)
			Result.put ({STRING_32} "2", Key_2)
			Result.put ({STRING_32} "3", Key_3)
			Result.put ({STRING_32} "4", Key_4)
			Result.put ({STRING_32} "5", Key_5)
			Result.put ({STRING_32} "6", Key_6)
			Result.put ({STRING_32} "7", Key_7)
			Result.put ({STRING_32} "8", Key_8)
			Result.put ({STRING_32} "9", Key_9)
			Result.put ({STRING_32} "NumPad 0", Key_numpad_0)
			Result.put ({STRING_32} "NumPad 1", Key_numpad_1)
			Result.put ({STRING_32} "NumPad 2", Key_numpad_2)
			Result.put ({STRING_32} "NumPad 3", Key_numpad_3)
			Result.put ({STRING_32} "NumPad 4", Key_numpad_4)
			Result.put ({STRING_32} "NumPad 5", Key_numpad_5)
			Result.put ({STRING_32} "NumPad 6", Key_numpad_6)
			Result.put ({STRING_32} "NumPad 7", Key_numpad_7)
			Result.put ({STRING_32} "NumPad 8", Key_numpad_8)
			Result.put ({STRING_32} "NumPad 9", Key_numpad_9)
			Result.put ({STRING_32} "NumPad +", Key_numpad_add)
			Result.put ({STRING_32} "NumPad /", Key_numpad_divide)
			Result.put ({STRING_32} "NumPad *", Key_numpad_multiply)
			Result.put ({STRING_32} "NumLock", Key_num_lock)
			Result.put ({STRING_32} "NumPad -", Key_numpad_subtract)
			Result.put ({STRING_32} "NumPad .", Key_numpad_decimal)
			Result.put ({STRING_32} "F1", Key_f1)
			Result.put ({STRING_32} "F2", Key_f2)
			Result.put ({STRING_32} "F3", Key_f3)
			Result.put ({STRING_32} "F4", Key_f4)
			Result.put ({STRING_32} "F5", Key_f5)
			Result.put ({STRING_32} "F6", Key_f6)
			Result.put ({STRING_32} "F7", Key_f7)
			Result.put ({STRING_32} "F8", Key_f8)
			Result.put ({STRING_32} "F9", Key_f9)
			Result.put ({STRING_32} "F10", Key_f10)
			Result.put ({STRING_32} "F11", Key_f11)
			Result.put ({STRING_32} "F12", Key_f12)
			Result.put ({STRING_32} "Space", Key_space)
			Result.put ({STRING_32} "BackSpace", Key_back_space)
			Result.put ({STRING_32} "Enter", Key_enter)
			Result.put ({STRING_32} "Esc", Key_escape)
			Result.put ({STRING_32} "Tab", Key_tab)
			Result.put ({STRING_32} "Pause", Key_pause)
			Result.put ({STRING_32} "CapsLock", Key_caps_lock)
			Result.put ({STRING_32} "ScrollLock", Key_scroll_lock)
			Result.put ({STRING_32} ",", Key_comma)
			Result.put ({STRING_32} "=", Key_equal)
			Result.put ({STRING_32} ".", Key_period)
			Result.put ({STRING_32} ";", Key_semicolon)
			Result.put ({STRING_32} "[", Key_open_bracket)
			Result.put ({STRING_32} "]", Key_close_bracket)
			Result.put ({STRING_32} "/", Key_slash)
			Result.put ({STRING_32} "\", Key_backslash)
			Result.put ({STRING_32} "'", Key_quote)
			Result.put ({STRING_32} "`", Key_backquote)
			Result.put ({STRING_32} "-", Key_dash)
			Result.put ({STRING_32} "Up", Key_up)
			Result.put ({STRING_32} "Down", Key_down)
			Result.put ({STRING_32} "Left", Key_left)
			Result.put ({STRING_32} "Right", Key_right)
			Result.put ({STRING_32} "PageUp", Key_page_up)
			Result.put ({STRING_32} "PageDown", Key_page_down)
			Result.put ({STRING_32} "Home", Key_home)
			Result.put ({STRING_32} "End", Key_end)
			Result.put ({STRING_32} "Insert", Key_insert)
			Result.put ({STRING_32} "Del", Key_delete)
			Result.put ({STRING_32} "a", Key_a)
			Result.put ({STRING_32} "b", Key_b)
			Result.put ({STRING_32} "c", Key_c)
			Result.put ({STRING_32} "d", Key_d)
			Result.put ({STRING_32} "e", Key_e)
			Result.put ({STRING_32} "f", Key_f)
			Result.put ({STRING_32} "g", Key_g)
			Result.put ({STRING_32} "h", Key_h)
			Result.put ({STRING_32} "i", Key_i)
			Result.put ({STRING_32} "j", Key_j)
			Result.put ({STRING_32} "k", Key_k)
			Result.put ({STRING_32} "l", Key_l)
			Result.put ({STRING_32} "m", Key_m)
			Result.put ({STRING_32} "n", Key_n)
			Result.put ({STRING_32} "o", Key_o)
			Result.put ({STRING_32} "p", Key_p)
			Result.put ({STRING_32} "q", Key_q)
			Result.put ({STRING_32} "r", Key_r)
			Result.put ({STRING_32} "s", Key_s)
			Result.put ({STRING_32} "t", Key_t)
			Result.put ({STRING_32} "u", Key_u)
			Result.put ({STRING_32} "v", Key_v)
			Result.put ({STRING_32} "w", Key_w)
			Result.put ({STRING_32} "x", Key_x)
			Result.put ({STRING_32} "y", Key_y)
			Result.put ({STRING_32} "z", Key_z)
			Result.put ({STRING_32} "Shift", Key_shift)
			Result.put ({STRING_32} "Ctrl", Key_ctrl)
			Result.put ({STRING_32} "Alt", Key_alt)
			Result.put ({STRING_32} "Left Meta", Key_left_meta)
			Result.put ({STRING_32} "Right Meta", Key_right_meta)
			Result.put ({STRING_32} "Menu", Key_menu)
		end

	key_code_from_key_string (key_string: READABLE_STRING_GENERAL): INTEGER
			-- Key code value from `key_string'
		require
			key_string_not_void: key_string /= Void
		local
			l_key_strings: like key_strings
			l_cnt: INTEGER
			found: BOOLEAN
			l_key: STRING_32
		do
			l_key := key_string.as_string_32.as_lower
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
			-- Is `a_code' a valid key code?
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

