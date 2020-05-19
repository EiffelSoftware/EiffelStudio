note
	description: "Facility routines to check the validity of DATEs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DATE_VALIDITY_CHECKER

inherit
	DATE_CONSTANTS
		export
			{NONE} all
		end

	DATE_VALUE
		export
			{NONE} all
		end

	ANY

feature -- Preconditions

	date_valid (s: READABLE_STRING; code_string: READABLE_STRING): BOOLEAN
			-- Is the code_string enough precise
			-- To create an instance of type DATE
			-- And does the string `s' correspond to `code_string'?
		require
			s_exists: s /= Void
			code_exists: code_string /= Void
		local
			code: DATE_TIME_CODE_STRING
		do
			create code.make (code_string)
			Result := code.precise_date and code.correspond (s) and then
				code.is_date (s)
		ensure
			class
		end

	date_valid_with_base (s: READABLE_STRING; code_string: READABLE_STRING;
							base: INTEGER): BOOLEAN
			-- Is the code_string enough precise
			-- To create an instance of type DATE
			-- And does the string `s' correspond to `code_string'?
			-- Use base century `base'.
		require
			s_exists: s /= Void
			code_exists: code_string /= Void
			base_valid: base > 0 and (base \\ 100 = 0)
		local
			code: DATE_TIME_CODE_STRING
		do
			create code.make (code_string)
			code.set_base_century (base)
			Result := code.precise_date and code.correspond (s) and then
				code.is_date (s)
		end

	date_valid_default (s: READABLE_STRING): BOOLEAN
			-- Is the code_string enough precise
			-- To create an instance of type DATE
			-- And does the string `s' correspond to
			-- `date_default_format_string'?
		require
			s_exists: s /= Void
		do
			Result := date_valid (s, date_default_format_string)
		end

	date_valid_default_with_base (s: READABLE_STRING; base: INTEGER): BOOLEAN
			-- Is the code_string enough precise
			-- To create an instance of type DATE
			-- And does the string `s' correspond to
			-- `date_default_format_string'?
			-- Use base century `base'.
		require
			s_exists: s /= Void
			base_valid: base > 0 and (base \\ 100 = 0)
		do
			Result := date_valid_with_base (s, date_default_format_string, base)
		end

	compact_date_valid (c_d: INTEGER): BOOLEAN
			-- Is compact date `c_d' valid?
		obsolete "Use `ordered_compact_date_valid` taking into account that it uses a different encoding. [2020-05-31]"
		local
			l_cd: INTEGER
			y, m, d: INTEGER
		do
			l_cd := ordered_compact_date
			set_private_internal_compact_date (c_d)
			d := day
			m := month
			y := year
			ordered_compact_date := l_cd
			Result := is_correct_date (y, m, d)
		end

	ordered_compact_date_valid (c_d: INTEGER): BOOLEAN
			-- Is compact date `c_d' valid?
		local
			l_cd: INTEGER
			y, m, d: INTEGER
		do
			l_cd := ordered_compact_date
			ordered_compact_date := c_d
			d := day
			m := month
			y := year
			ordered_compact_date := l_cd
			Result := is_correct_date (y, m, d)
		end

	is_correct_date (y, m, d: INTEGER): BOOLEAN
			-- Is date specified by `y', `m', and `d' a correct date?
		do
			Result := m >= 1 and m <= Months_in_year and then d >= 1 and
				d <= days_in_i_th_month (m, y) and then y >= 0 and then y <= 65535
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
