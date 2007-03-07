indexing
	description	: "Shortcut preference."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date:"
	revision	: "$Revision$"

class
	SHORTCUT_PREFERENCE

inherit
	TYPED_PREFERENCE [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING]]
		redefine
			is_default_value
		end

	PREFERENCE_CONSTANTS

	EV_KEY_CONSTANTS

	MANAGED_SHORTCUT

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
			if not is_wiped then
				Result.append (key.out)
			end
		end

	string_type: STRING is
			-- String description of this preference type.
		once
			Result := "SHORTCUT"
		end

	key: EV_KEY is
			-- Actual Key
		local
			l_key_code: INTEGER
			s: STRING
		do
			s ?= value.reference_item (4)
			l_key_code := key_code_from_key_string (s)
			if l_key_code > 0 then
				create Result.make_with_code (l_key_code)
			else
				create Result
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
			l_key_code: INTEGER
			l_key: EV_KEY
			l_alt, l_ctrl, l_shift: BOOLEAN
		do
			if internal_value = Void then
				internal_value := [False, False, False, ""]
			end
			values := a_value.split ('+')
			l_value := [False, False, False, ""]
			from
				l_cnt := 1
			until
				l_cnt > values.count
			loop
				l_string ?= values.i_th (l_cnt).as_lower
				if l_string.is_equal (str_lower_true) then
					l_value.put_boolean (True, l_cnt)
				elseif l_cnt = values.count then
						-- Last one is assumed to be key
					l_value.put_reference (l_string, 4)
				end
				l_cnt := l_cnt + 1
			end

			l_string ?= l_value.reference_item (4)
			l_key_code := key_code_from_key_string (l_string)
			if l_key_code > 0 then
				l_key := create {EV_KEY}.make_with_code (l_key_code)
			end
			l_alt := l_value.boolean_item (1)
			l_ctrl := l_value.boolean_item (2)
			l_shift := l_value.boolean_item (3)
			if modifiable_with (l_key, l_alt, l_ctrl, l_shift) then
					-- Managed shortcut value setting.
				set_values (l_key, l_alt, l_ctrl, l_shift)
					-- Preference value setting.
				set_value (l_value)
			else
				modification_deny_actions.call (Void)
			end
		end

feature -- Query

	is_alt: BOOLEAN is
			-- Requires Alt key?
		do
			Result := value.boolean_item (1)
		end

	is_ctrl: BOOLEAN is
			-- Requires Ctrl key?
		do
			Result := value.boolean_item (2)
		end

	is_shift: BOOLEAN is
			-- Requires Shift key?
		do
			Result := value.boolean_item (3)
		end

	valid_value_string (a_string: STRING): BOOLEAN is
			-- Is `a_string' valid for this preference type to convert into a value?		
		do
			Result := a_string /= Void and then a_string.split ('+').count = 4
		end

	is_default_value: BOOLEAN is
			-- Is this preference value the same as the default value?
		do
			if not is_wiped then
				Result := Precursor {TYPED_PREFERENCE}
			end
		end

feature {PREFERENCES} -- Access

	generating_preference_type: STRING is
			-- The generating type of the preference for graphical representation.
		do
			Result := "SHORTCUT"
		end

feature {NONE} -- Implementation

	auto_default_value: TUPLE [BOOLEAN, BOOLEAN, BOOLEAN, STRING] is
			-- Value to use when Current is using auto by default (until real auto is set)
		once
			Result := [True, False, False, (create {EV_KEY}).out]
		end

	str_true: STRING is "True"
	str_false: STRING is "False"
	str_lower_true: STRING is "true";

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




end -- class SHORTCUT_PREFERENCE

