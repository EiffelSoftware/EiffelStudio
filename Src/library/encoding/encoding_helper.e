indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ENCODING_HELPER

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
		require
			a_multi_string_not_default: a_multi_string /= default_pointer
			a_count_non_negative: a_count >= 0
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
		ensure
			Result_not_void: Result /= Void
		end

	pointer_to_wide_string (a_w_string: POINTER; a_count: INTEGER): STRING_32 is
		require
			a_w_string_not_default: a_w_string /= default_pointer
			a_count_non_negative: a_count >= 0
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
		ensure
			Result_not_void: Result /= Void
		end

	pointer_to_string_32 (a_w_string: POINTER; a_count: INTEGER_32): STRING_32
		require
			a_w_string_not_default: a_w_string /= default_pointer
			a_count_non_negative: a_count >= 0
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
		ensure
			Result_not_void: Result /= Void
		end

	string_32_to_stream (a_string: STRING_32): STRING_8 is
		require
			a_string_not_void: a_string /= Void
		do
			Result := pointer_to_multi_byte (a_string.area.base_address, a_string.count * 4)
		ensure
			Result_not_void: Result /= Void
		end

	string_16_to_stream (a_string: STRING_32): STRING_8 is
			-- We use `a_string' as 2 bytes encoding string, the first two bytes are not used.
		require
			a_string_not_void: a_string /= Void
		local
			l_managed_pointer: MANAGED_POINTER
			i, l_count: INTEGER
		do
			l_managed_pointer := wide_string_to_pointer (a_string)
			create Result.make (l_managed_pointer.count)
			from
				i := 0
				l_count := l_managed_pointer.count - 1
			until
				i = l_count
			loop
				Result.put (l_managed_pointer.read_natural_8 (i).to_character_8, i + 1)
				i := i + 1
			end
		ensure
			Result_not_void: Result /= Void
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
