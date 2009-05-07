note
	description: "[
		External routines for debugging
		run-time counterpart: /C/ipc/ewb/eif_out.c
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class DEBUG_EXT

inherit
	PLATFORM

feature

	send_rqst_0 (code: INTEGER)
		external
			"C"
		end;

	send_rqst_1 (code: INTEGER; info1: INTEGER)
		external
			"C"
		end;

	send_rqst_1_ptr (code: INTEGER; info1: POINTER)
		do
			send_rqst_1 (code, info1.to_integer_32)
		end

	send_rqst_2 (code: INTEGER; info1: INTEGER; info2: INTEGER)
		external
			"C"
		end;

	send_rqst_3 (code: INTEGER; info1: INTEGER; info2: INTEGER; info3: POINTER)
		external
			"C"
		end

	send_rqst_4 (code: INTEGER; info1: INTEGER; info2: INTEGER; info3: POINTER; info4: INTEGER)
		external
			"C"
		end

	send_rqst_4_integer (code: INTEGER; info1: INTEGER; info2: INTEGER; info3: INTEGER; info4: INTEGER)
		do
			send_rqst_4 (code, info1, info2, integer_to_pointer (info3), info4)
		end;

	send_rqst_3_integer (code: INTEGER; info1: INTEGER; info2: INTEGER; info3: INTEGER)
		do
			send_rqst_3 (code, info1, info2, integer_to_pointer (info3))
		end

	send_integer_8_value (value: INTEGER_8)
		external
			"C"
		end

	send_integer_16_value (value: INTEGER_16)
		external
			"C"
		end

	send_integer_32_value (value: INTEGER_32)
		external
			"C"
		end

	send_integer_64_value (value: INTEGER_64)
		external
			"C"
		end

	send_natural_8_value (value: NATURAL_8)
		external
			"C"
		end

	send_natural_16_value (value: NATURAL_16)
		external
			"C"
		end

	send_natural_32_value (value: NATURAL_32)
		external
			"C"
		end

	send_natural_64_value (value: NATURAL_64)
			--
		external
			"C"
		end

	send_real_32_value (value: REAL_32)
		external
			"C"
		end

	send_real_64_value (value: REAL_64)
		external
			"C"
		end

	send_char_8_value (value: CHARACTER_8)
		external
			"C"
		end

	send_char_32_value (value: CHARACTER_32)
		external
			"C"
		end

	send_bool_value (value: BOOLEAN)
		external
			"C"
		end

	send_ptr_value (value: POINTER)
			-- value is the value of the pointer
		external
			"C"
		end

	send_string_value (value: POINTER)
			-- value is the address of a C string
		external
			"C"
		end

	send_ref_value (value: POINTER)
			-- value is the address of the object
		external
			"C signature (EIF_REFERENCE)"
		end

	send_ack_ok
		external
			"C"
		alias
			"ewb_send_ack_ok"
		end;

	send_string_content (s: STRING_GENERAL)
		local
			c_string: C_STRING
		do
			create c_string.make (s)
			c_send_str (c_string.item)
		end

	send_string_content_with_size (s: STRING_GENERAL; a_size: INTEGER)
		local
			c_string: C_STRING
		do
			create c_string.make (s)
			c_send_sized_str (c_string.item, a_size)
		end

	recv_ack: BOOLEAN
		external
			"C"
		end;

	recv_dead: BOOLEAN
		external
			"C"
		end;

	c_twrite (data: POINTER; size: INTEGER)
		external
			"C"
		end;

	c_send_sized_str (str: POINTER; size: INTEGER)
		external
			"C"
		end;

	c_send_str (str: POINTER)
		external
			"C"
		end;

	c_tread: STRING
		external
			"C"
		end;

	integer_to_pointer (i: INTEGER): POINTER
			-- Convert integer value `i' in a valid `POINTER' value.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"(EIF_POINTER) $i"
		end

feature {NONE} -- Status report

	is_valid_integer_32_string (s: STRING): BOOLEAN
		require
			s_attached: s /= Void
		do
			Result := s.count = Integer_32_bytes
		end

	is_valid_boolean_string (s: STRING): BOOLEAN
		require
			s_attached: s /= Void
		do
			Result := s.count = Boolean_bytes
		end

feature {NONE} -- Implementation

	to_boolean (s: STRING): BOOLEAN
			-- Convert binary boolean enclosed in `s' into an BOOLEAN.
		require
			s_not_void: s /= Void
			valid_string: s.count = Boolean_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Boolean_bytes)
		end

	to_character_8 (s: STRING): CHARACTER_8
			-- Convert binary character enclosed in `s' into an CHARACTER.
		require
			s_not_void: s /= Void
			valid_string: s.count = Character_8_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Character_8_bytes);
		end

	to_character_32 (s: STRING): CHARACTER_32
			-- Convert binary wide_char enclosed in `s' into an WIDE_CHARACTER.
		require
			s_not_void: s /= Void
			valid_string: s.count = character_32_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, character_32_bytes)
		end

	to_natural_8 (s: STRING): NATURAL_8
			-- Convert binary integer_8 enclosed in `s' into an NATURAL_8.
		require
			s_not_void: s /= Void
			valid_string: s.count = natural_8_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, natural_8_bytes)
		end

	to_natural_16 (s: STRING): NATURAL_16
			-- Convert binary integer_16 enclosed in `s' into an NATURAL_16.
		require
			s_not_void: s /= Void
			valid_string: s.count = natural_16_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, natural_16_bytes)
		end

	to_natural_32 (s: STRING): NATURAL_32
			-- Convert binary integer enclosed in `s' into an NATURAL.
		require
			s_not_void: s /= Void
			valid_string: s.count = natural_32_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, natural_32_bytes)
		end

	to_natural_64 (s: STRING): NATURAL_64
			-- Convert binary integer_64 enclosed in `s' into an NATURAL_64.
		require
			s_not_void: s /= Void
			valid_string: s.count = natural_64_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, natural_64_bytes)
		end

	to_integer_8 (s: STRING): INTEGER_8
			-- Convert binary integer_8 enclosed in `s' into an INTEGER_8.
		require
			s_not_void: s /= Void
			valid_string: s.count = Integer_8_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Integer_8_bytes)
		end

	to_integer_16 (s: STRING): INTEGER_16
			-- Convert binary integer_16 enclosed in `s' into an INTEGER_16.
		require
			s_not_void: s /= Void
			valid_string: s.count = Integer_16_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Integer_16_bytes)
		end

	to_integer_32 (s: STRING): INTEGER_32
			-- Convert binary integer enclosed in `s' into an INTEGER.
		require
			s_not_void: s /= Void
			valid_string: s.count = Integer_32_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Integer_32_bytes)
		end

	to_integer_64 (s: STRING): INTEGER_64
			-- Convert binary integer_64 enclosed in `s' into an INTEGER_64.
		require
			s_not_void: s /= Void
			valid_string: s.count = Integer_64_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Integer_64_bytes)
		end

	to_pointer (s: STRING): POINTER
			-- Convert binary pointer enclosed in `s' into a POINTER.
		require
			s_not_void: s /= Void
			valid_string: s.count = Pointer_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Pointer_bytes)
		end

	to_real_32 (s: STRING): REAL_32
			-- Convert binary double enclosed in `s' into a DOUBLE.
		require
			s_not_void: s /= Void
			valid_string: s.count = Real_32_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Real_32_bytes)
		end

	to_real_64 (s: STRING): REAL_64
			-- Convert binary double enclosed in `s' into a DOUBLE.
		require
			s_not_void: s /= Void
			valid_string: s.count = Real_64_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Real_64_bytes)
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
