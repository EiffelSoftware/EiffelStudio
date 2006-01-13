indexing
	description	: "Shortcut resource."
	date		: "$Date:"
	revision	: "$Revision$"

class
	SHORTCUT_PREFERENCE

inherit
	TYPED_PREFERENCE [ARRAYED_LIST [STRING]]

	PREFERENCE_CONSTANTS

	EV_KEY_CONSTANTS

create {PREFERENCE_FACTORY}
	make, make_from_string_value

feature -- Access

	string_value: STRING is
			-- String representation of `value'.
		do
			create Result.make_empty
			Result.append (is_alt.out + shortcut_delimiter)
			Result.append (is_ctrl.out + shortcut_delimiter)
			Result.append (is_shift.out + shortcut_delimiter)
			Result.append (key.out)
		end

	string_type: STRING is
			-- String description of this resource type.
		once
			Result := "SHORTCUT"
		end

	key: EV_KEY is
			-- Actual Key
		local
			l_key_code: INTEGER
		do
			l_key_code := key_code_from_key_string (value.last)
			if l_key_code > 0 then
				create Result.make_with_code (l_key_code)
			else
				create Result
			end
		end

	display_string: STRING is
			-- Value of Current in nice diplay format:
			-- `True+True+True+Key' becomes `Alt+Ctrl+Shift+Key'
		require
			has_value_string: valid_value_string (string_value)
		local
			values: LIST [STRING]
			l_cnt: INTEGER
			l_string: STRING
		do
			l_string := string_value
			values := l_string.split ('+')
			create Result.make_empty
			from
				l_cnt := 1
			until
				l_cnt > values.count
			loop
				inspect l_cnt
				when 1 then
					if values.i_th (l_cnt).as_lower.is_equal ("true") then
						Result.append (Alt_text + shortcut_delimiter)
					end
				when 2 then
					if values.i_th (l_cnt).as_lower.is_equal ("true") then
						Result.append (Ctrl_text + shortcut_delimiter)
					end
				when 3 then
					if values.i_th (l_cnt).as_lower.is_equal ("true") then
						Result.append (Shift_text + shortcut_delimiter)
					end
				when 4 then
					Result.append (values.i_th (l_cnt).twin)
				else
				end
				l_cnt := l_cnt + 1
			end
		end

	Shortcut_keys: ARRAY [INTEGER] is
			-- All key codes that are acceptable for use in shortcut preferences.
		once
			create Result.make (1, 87)
			Result.compare_objects
			Result.put (Key_0, 1)
			Result.put (Key_1, 2)
			Result.put (Key_2, 3)
			Result.put (Key_3, 4)
			Result.put (Key_4, 5)
			Result.put (Key_5, 6)
			Result.put (Key_6, 7)
			Result.put (Key_7, 8)
			Result.put (Key_8, 9)
			Result.put (Key_9, 10)
			Result.put (Key_numpad_0, 11)
			Result.put (Key_numpad_1, 12)
			Result.put (Key_numpad_2, 13)
			Result.put (Key_numpad_3, 14)
			Result.put (Key_numpad_4, 15)
			Result.put (Key_numpad_5, 16)
			Result.put (Key_numpad_6, 17)
			Result.put (Key_numpad_7, 18)
			Result.put (Key_numpad_8, 19)
			Result.put (Key_numpad_9, 20)
			Result.put (Key_numpad_add, 21)
			Result.put (Key_numpad_divide, 22)
			Result.put (Key_numpad_multiply, 23)
			Result.put (Key_numpad_subtract, 24)
			Result.put (Key_numpad_decimal, 25)
			Result.put (Key_f1, 26)
			Result.put (Key_f2, 27)
			Result.put (Key_f3, 28)
			Result.put (Key_f4, 29)
			Result.put (Key_f5, 30)
			Result.put (Key_f6, 31)
			Result.put (Key_f7, 32)
			Result.put (Key_f8, 33)
			Result.put (Key_f9, 34)
			Result.put (Key_f10, 35)
			Result.put (Key_f11, 36)
			Result.put (Key_f12, 37)
			Result.put (Key_space, 38)
			Result.put (Key_back_space, 39)
			Result.put (Key_enter, 40)
			Result.put (Key_comma, 41)
			Result.put (Key_equal, 42)
			Result.put (Key_period, 43)
			Result.put (Key_semicolon, 44)
			Result.put (Key_open_bracket, 45)
			Result.put (Key_close_bracket, 46)
			Result.put (Key_slash, 47)
			Result.put (Key_backslash, 48)
			Result.put (Key_quote, 49)
			Result.put (Key_backquote, 50)
			Result.put (Key_dash, 51)
			Result.put (Key_up, 52)
			Result.put (Key_down, 53)
			Result.put (Key_left, 54)
			Result.put (Key_right, 55)
			Result.put (Key_page_up, 56)
			Result.put (Key_page_down, 57)
			Result.put (Key_home, 58)
			Result.put (Key_end, 59)
			Result.put (Key_insert, 60)
			Result.put (Key_delete, 61)
			Result.put (Key_a, 62)
			Result.put (Key_b, 63)
			Result.put (Key_c, 64)
			Result.put (Key_d, 65)
			Result.put (Key_e, 66)
			Result.put (Key_f, 67)
			Result.put (Key_g, 68)
			Result.put (Key_h, 69)
			Result.put (Key_i, 70)
			Result.put (Key_j, 71)
			Result.put (Key_k, 72)
			Result.put (Key_l, 73)
			Result.put (Key_m, 74)
			Result.put (Key_n, 75)
			Result.put (Key_o, 76)
			Result.put (Key_p, 77)
			Result.put (Key_q, 78)
			Result.put (Key_r, 79)
			Result.put (Key_s, 80)
			Result.put (Key_t, 81)
			Result.put (Key_u, 82)
			Result.put (Key_v, 83)
			Result.put (Key_w, 84)
			Result.put (Key_x, 85)
			Result.put (Key_y, 86)
			Result.put (Key_z, 87)
		end

feature -- Status Setting

	set_value_from_string (a_value: STRING) is
			-- Parse the string value `a_value' and set `value'.
			-- String format: "Alt+Ctrl+Shift+KeyString"		
		local
			values: LIST [STRING]
			l_string: STRING
			l_value: like value
			l_cnt: INTEGER
		do
			create internal_value.make (4)
			values := a_value.split ('+')
			l_value := value
			from
				l_cnt := 1
			until
				l_cnt > values.count
			loop
				l_string ?= values.i_th (l_cnt)
				if l_string.as_lower.is_equal (once "true") then
					l_value.extend (once "True")
				else
					if l_cnt = values.count then
							-- Last one is assumed to be key
						l_value.extend (l_string.as_lower)
					else
						l_value.extend (once "False")
					end
				end
				l_cnt := l_cnt + 1
			end
			set_value (internal_value)
		end

feature -- Query

	is_alt: BOOLEAN is
			-- Requires Alt key?
		do
			Result := value.i_th (1).as_lower.is_equal (once "true")
		end

	is_ctrl: BOOLEAN is
			-- Requires Ctrl key?
		do
			Result := value.i_th (2).as_lower.is_equal (once "true")
		end

	is_shift: BOOLEAN is
			-- Requires Shift key?
		do
			Result := value.i_th (3).as_lower.is_equal (once "true")
		end

	valid_value_string (a_string: STRING): BOOLEAN is
			-- Is `a_string' valid for this resource type to convert into a value?		
		do
			Result := a_string /= Void and then a_string.split ('+').count = 4
		end

	matches (a_key: like key; alt, ctrl, shift: BOOLEAN): BOOLEAN is
			-- Do combinations of `a_key', `alt', `ctrl' an `shift' match Current?
		do
			Result := (is_alt = alt)
				and then (is_ctrl = ctrl)
				and then (is_shift = shift)
				and then (value.last.is_equal (key_strings.item (a_key.code)))
		end

feature {PREFERENCES} -- Access

	generating_resource_type: STRING is
			-- The generating type of the resource for graphical representation.
		do
			Result := "SHORTCUT"
		end

feature {NONE} -- Implementation

	auto_default_value: ARRAYED_LIST [STRING] is
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			create Result.make (4)
			Result.extend ((create {EV_KEY}).out)
			Result.extend (once "True")
			Result.extend (once "False")
			Result.extend (once "False")
		end

invariant
	has_control_key: value.i_th (1).as_lower.is_equal ("true") or
		value.i_th (2).as_lower.is_equal ("true") or
		value.i_th (3).as_lower.is_equal ("true")

end -- class SHORTCUT_PREFERENCE

