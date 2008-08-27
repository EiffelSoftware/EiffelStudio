indexing
	description: "Interfaces of encoding conversion."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENCODING_I

inherit

	CODE_PAGE_CONSTANTS
		export
			{NONT} all
		end

	ENCODING_HELPER
		export
			{NONT} all
		end

feature {ENCODING} -- String encoding convertion

	convert_to (a_from_code_page: STRING; a_from_string: STRING_GENERAL; a_to_code_page: STRING) is
			-- Convert `a_from_string' of `a_from_code_page' to a string of `a_to_code_page'.
		require
			a_from_code_page_valid: is_code_page_valid (a_from_code_page)
			a_to_code_page_valid: is_code_page_valid (a_to_code_page)
			code_page_convertable: is_code_page_convertable (a_from_code_page, a_to_code_page)
			a_from_string_not_void: a_from_string /= Void
		deferred
		ensure
			success_implies_not_void: last_conversion_successful implies last_converted_stream /= Void
			success_implies_not_void: last_conversion_successful implies last_converted_string /= Void
		end

feature {ENCODING} -- Reset

	reset is
			-- Reset
		do
			last_converted_string := Void
			last_conversion_successful := False
			last_was_wide_string := False
		ensure
			last_converted_string_reset: last_converted_string = Void
			last_conversion_successful_reset: last_conversion_successful = False
		end

feature {ENCODING} -- Access

	last_converted_stream: STRING_8 is
			-- Stream prepresentation of last converted string.
		do
			if last_converted_string /= Void then
				if last_was_wide_string then
					Result := string_16_to_stream (last_converted_string.as_string_32)
				else
					Result := string_general_to_stream (last_converted_string)
				end
			end
		ensure
			last_converted_string_syn_with_last_converted_stream:
					(last_converted_string /= Void) = (Result /= Void)
		end

	last_converted_string: STRING_GENERAL
			-- Last converted string.

feature {ENCODING} -- Status report

	is_code_page_valid (a_code_page: STRING): BOOLEAN is
			-- Is `a_code_page' valid?
		deferred
		end

	is_code_page_convertable (a_from_code_page, a_to_code_page: STRING): BOOLEAN is
			-- Is `a_from_code_page' convertable to `a_to_code_page'.
		require
			a_from_code_page_valid: is_code_page_valid (a_from_code_page)
			a_to_code_page_valid: is_code_page_valid (a_to_code_page)
		deferred
		end

	last_conversion_successful: BOOLEAN
			-- Was last conversion successful?

	last_was_wide_string: BOOLEAN
			-- Last conversion result was wide string?

feature {NONE} -- Status report

	is_valid_as_string_16 (a_string: STRING_GENERAL): BOOLEAN is
			-- Check high 16 bit of any char in `a_string' is zero.
		local
			i, nb: INTEGER_32
			l_area: SPECIAL [CHARACTER_32]
		do
			if a_string /= Void then
				if a_string.is_string_32 then
					from
						nb := a_string.count
						Result := True
						l_area := a_string.as_string_32.area
					until
						i = nb or not Result
					loop
						Result := l_area.item (i).code <= 0xFFFF
						i := i + 1
					end
				else
					Result := True
				end
			end
		end

feature {NONE} -- Implementation

	utf32_to_utf16 (a_str: STRING_32): STRING_32 is
			-- Convert utf32 to utf16 without data lose.
		require
			a_str_not_void: a_str /= Void
		local
			l_code: NATURAL_32
			i, l_count: INTEGER
		do
			create Result.make (a_str.count * 2)
			from
				i := 1
				l_count := a_str.count
			until
				i > l_count
			loop
				l_code := a_str.code (i)
				l_code := l_code & 0xFFFFF
				if l_code > 0xFFFF then
					l_code := l_code - 0x10000
					Result.append_code (l_code |>> 10 | 0xD800)
					Result.append_code (l_code & 0x03FF | 0xDC00)
				else
					Result.append_code (l_code)
				end
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

	utf16_to_utf32 (a_str: STRING_32): STRING_32 is
			-- Convert utf16 to utf32.
		require
			a_str_not_void: a_str /= Void
		local
			i, -- Old string pointer
			l_count: INTEGER
			l_code: NATURAL_32
			l_temp: NATURAL_32
			l_lower: NATURAL_32
		do
			l_count := a_str.count
			create Result.make (l_count)
			from
				i := 1
			until
				i > l_count
			loop
				l_code := a_str.code (i)
				i := i + 1
				l_temp := l_code & 0xFFFF
				if i <= l_count then
					l_lower := a_str.code (i) & 0xFFFF
				end
				if l_temp >= 0xD800 and then l_temp <= 0xDBFF and then i <= l_count and then
					l_lower >= 0xDC00 and then
					l_lower <= 0xDFFF
				then
					Result.append_code ((l_temp & 0x03FF) |<< 10 + l_lower & 0x03FF + 0x10000)
					i := i + 1
				else
					Result.append_code (l_temp)
				end
			end
		ensure
			Result_not_void: Result /= Void
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

end
