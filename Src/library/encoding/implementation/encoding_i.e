indexing
	description: "Interfaces of encoding conversion."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ENCODING_I

inherit
	ANY

	CODE_PAGE_CONSTANTS
		export
			{NONT} all
		end

feature {ENCODING} -- String encoding convertion

	convert_to (a_from_code_page: STRING; a_from_string: STRING_GENERAL; a_to_code_page: STRING): STRING_GENERAL is
			-- Convert `a_from_string' of `a_from_code_page' to a string of `a_to_code_page'.
		require
			a_from_code_page_valid: is_code_page_valid (a_from_code_page)
			a_to_code_page_valid: is_code_page_valid (a_to_code_page)
			code_page_convertable: is_code_page_convertable (a_from_code_page, a_to_code_page)
			a_from_string_not_void: a_from_string /= Void
		deferred
		ensure
			success_implies_not_void: last_conversion_successful implies Result /= Void
		end

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

feature {NONE} -- Status report

	is_valid_as_string_16 (a_string: STRING_GENERAL): BOOLEAN is
			-- Check high 16 bit of any char in `a_string' is not zero.
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
				if l_code > 0xffff then
					Result.append_code (l_code |>> 10 + 0xD7C0)
					Result.append_code (l_code & 0x03FF + 0xDC00)
				else
					Result.append_code (l_code)
				end
				i := i + 1
			end
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
				if l_temp >= 0xD800 and then l_temp <= 0xDBFF and then i < l_count and then
					(a_str.code (i) & 0xFFFF) >= 0xDC00 and then
					(a_str.code (i) & 0xFFFF) <= 0xDFFF
				then
					Result.append_code ((l_temp - 0xD7C0) |<< 10 + a_str.code (i) & 0x03FF)
					i := i + 1
				else
					Result.append_code (l_temp)
				end
			end
		end

feature {NONE} -- Implementation

	multi_byte_to_pointer (a_string: STRING_8): MANAGED_POINTER is
		require
			a_string_not_void: a_string /= Void
		local
			i, nb: INTEGER
			new_size: INTEGER
			l_end_pos, l_start_pos: INTEGER
			l_managed_data: MANAGED_POINTER
		do
			l_start_pos := 1
			l_end_pos := a_string.count
			create l_managed_data.make ((l_end_pos + 1) )
			nb := l_end_pos - l_start_pos + 1

			new_size := (nb + 1)

			if l_managed_data.count < new_size  then
				l_managed_data.resize (new_size)
			end

			from
				i := 0
			until
				i = nb
			loop
				l_managed_data.put_natural_8 (a_string.code (i + l_start_pos).to_natural_8, i)
				i := i +  1
			end
			l_managed_data.put_natural_8 (0, new_size - 1)
			Result := l_managed_data
		ensure
			result_not_void: Result /= Void
		end

	wide_string_to_pointer (a_string: STRING_32): MANAGED_POINTER is
		require
			a_string_not_void: a_string /= Void
		local
			i, nb: INTEGER
			new_size: INTEGER
			l_end_pos, l_start_pos: INTEGER
			l_managed_data: MANAGED_POINTER
		do
			l_start_pos := 1
			l_end_pos := a_string.count
			create l_managed_data.make ((l_end_pos + 1) * 2)
			nb := l_end_pos - l_start_pos + 1

			new_size := (nb + 1) * 2

			if l_managed_data.count < new_size  then
				l_managed_data.resize (new_size)
			end

			from
				i := 0
			until
				i = nb
			loop
				l_managed_data.put_natural_16 (a_string.code (i + l_start_pos).to_natural_16, i * 2)
				i := i +  1
			end
			l_managed_data.put_natural_16 (0, i * 2)
			Result := l_managed_data
		end

	pointer_to_multi_byte (a_multi_string: POINTER; a_count: INTEGER): STRING_8 is
		local
			i: INTEGER
			l_managed_pointer: MANAGED_POINTER
		do
			create l_managed_pointer.share_from_pointer (a_multi_string, a_count)
			create Result.make (a_count)
			from
				i := 0
			until
				i >= a_count
			loop
				Result.append_code (l_managed_pointer.read_natural_8 (i))
				i := i + 1
			end
		end

	pointer_to_wide_string (a_w_string: POINTER; a_count: INTEGER): STRING_32 is
		local
			i: INTEGER
			l_managed_pointer: MANAGED_POINTER
			l_size: INTEGER
		do
			create l_managed_pointer.share_from_pointer (a_w_string, a_count)
			l_size := (a_count + 1) // 2
			create Result.make (l_size)
			from
				i := 0
			until
				i >= l_size
			loop
				if i * 2 <= a_count then
					Result.append_code (l_managed_pointer.read_natural_16 (i * 2))
				end
				i := i + 1
			end
		end

	pointer_to_string_32 (a_w_string: POINTER; a_count: INTEGER_32): STRING_32
		local
			i: INTEGER_32
			l_managed_pointer: MANAGED_POINTER
			l_size: INTEGER_32
		do
			create l_managed_pointer.share_from_pointer (a_w_string, a_count)
			l_size := a_count // 4
			create Result.make (l_size)
			from
				i := 0
			until
				i >= l_size
			loop
				if i * 4 <= a_count then
					Result.append_code (l_managed_pointer.read_natural_32 (i * 4))
				end
				i := i + 1
			end
		end

feature {NONE} -- Endian

	string_32_switch_endian (a_str: STRING_32): STRING_32 is
			-- Switch endian of `a_str' for both high and low bits.
		require
			a_str /= Void
		local
			l_code: NATURAL_32
			i, l_count: INTEGER
		do
			l_count := a_str.count
			create Result.make (l_count)
			from
				i := 1
			until
				i > l_count
			loop
				l_code := a_str.code (i)
				Result.append_code (l_code & 0xFF |<< 24 & 0xFF000000 +
									l_code & 0xFF00 |<< 8 +
									l_code & 0xFF0000 |>> 8 +
									l_code & 0xFF000000 |>> 24 & 0xFF)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

	string_16_switch_endian (a_str: STRING_32): STRING_32 is
			-- Switch endian of `a_str' for low bits.
			-- High bits are cleaned.
		require
			a_str /= Void
		local
			l_code: NATURAL_32
			i, l_count: INTEGER
		do
			l_count := a_str.count
			create Result.make (l_count)
			from
				i := 1
			until
				i > l_count
			loop
				l_code := a_str.code (i)
				Result.append_code (l_code & 0xFF |<< 8 & 0xFF00 +
									l_code & 0xFF00 |>> 8 & 0xFF)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
		end

	is_little_endian: BOOLEAN is
			-- Is this system little endian?
		local
			l_p: PLATFORM
		once
			Result := (create {PLATFORM}).is_little_endian
		end

indexing
	library:   "EiffelBase: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
