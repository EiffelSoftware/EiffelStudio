indexing
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

	send_rqst_0 (code: INTEGER) is
		external
			"C"
		end;

	send_rqst_1 (code: INTEGER; info1: INTEGER) is
		external
			"C"
		end;

	send_rqst_2 (code: INTEGER; info1: INTEGER; info2: INTEGER) is
		external
			"C"
		end;

	send_rqst_3 (code: INTEGER; info1: INTEGER; info2: INTEGER; info3: POINTER) is
		external
			"C"
		end;

	send_rqst_3_integer (code: INTEGER; info1: INTEGER; info2: INTEGER; info3: INTEGER) is
		do
			send_rqst_3 (code, info1, info2, integer_to_pointer (info3))
		end

	send_integer_value (value: INTEGER) is
		external
			"C"
		end

	send_integer_64_value (value: INTEGER_64) is
			--
		external
			"C"
		end

	send_real_value (value: REAL) is
		external
			"C"
		end

	send_double_value (value: DOUBLE) is
		external
			"C"
		end

	send_char_value (value: CHARACTER) is
		external
			"C"
		end

	send_wchar_value (value: WIDE_CHARACTER) is
		external
			"C"
		end

	send_bool_value (value: BOOLEAN) is
		external
			"C"
		end

	send_ptr_value (value: POINTER) is
			-- value is the value of the pointer
		external
			"C"
		end

	send_string_value (value: POINTER) is
			-- value is the address of a C string
		external
			"C"
		end

	send_ref_value (value: POINTER) is
			-- value is the address of the object
		external
			"C signature (EIF_REFERENCE)"
		end

	recv_ack: BOOLEAN is
		external
			"C"
		end;

	recv_dead: BOOLEAN is
		external
			"C"
		end;

	c_twrite (data: POINTER; size: INTEGER) is
		external
			"C"
		end;

	c_send_str (str: POINTER) is
		external
			"C"
		end;

	c_tread: STRING is
		external
			"C"
		end;

	integer_to_pointer (i: INTEGER): POINTER is
			-- Convert integer value `i' in a valid `POINTER' value.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"(EIF_POINTER) $i"
		end

feature {NONE} -- Implementation

	to_boolean (s: STRING): BOOLEAN is
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

	to_character (s: STRING): CHARACTER is
			-- Convert binary character enclosed in `s' into an CHARACTER.
		require
			s_not_void: s /= Void
			valid_string: s.count = Character_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Character_bytes);
		end

	to_wide_char (s: STRING): WIDE_CHARACTER is
			-- Convert binary wide_char enclosed in `s' into an WIDE_CHARACTER.
		require
			s_not_void: s /= Void
			valid_string: s.count = Wide_character_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Wide_character_bytes)
		end

	to_natural_8 (s: STRING): NATURAL_8 is
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

	to_natural_16 (s: STRING): NATURAL_16 is
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

	to_natural_32 (s: STRING): NATURAL_32 is
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

	to_natural_64 (s: STRING): NATURAL_64 is
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

	to_integer_8 (s: STRING): INTEGER_8 is
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

	to_integer_16 (s: STRING): INTEGER_16 is
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

	to_integer (s: STRING): INTEGER is
			-- Convert binary integer enclosed in `s' into an INTEGER.
		require
			s_not_void: s /= Void
			valid_string: s.count = Integer_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Integer_bytes)
		end

	to_integer_64 (s: STRING): INTEGER_64 is
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

	to_pointer (s: STRING): POINTER is
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

	to_real (s: STRING): REAL is
			-- Convert binary double enclosed in `s' into a DOUBLE.
		require
			s_not_void: s /= Void
			valid_string: s.count = Real_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Real_bytes)
		end

	to_double (s: STRING): DOUBLE is
			-- Convert binary double enclosed in `s' into a DOUBLE.
		require
			s_not_void: s /= Void
			valid_string: s.count = Double_bytes
		local
			a: ANY
		do
			a := s.area;
			($Result).memory_copy ($a, Double_bytes)
		end


indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
