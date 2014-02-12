note
	description: "Integer description"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INTEGER_DESC

inherit
	ATTR_DESC

create
	make

feature -- Initialization

	make (n: INTEGER)
			-- Create instance of INTEGER_DESC represented on `n' bits.
		require
			valid_n: n = 8 or n = 16 or n = 32 or n = 64
		do
			inspect n
			when 8 then internal_flags := {SHARED_LEVEL}.integer_8_level
			when 16 then internal_flags := {SHARED_LEVEL}.integer_16_level
			when 32 then internal_flags := {SHARED_LEVEL}.integer_32_level
			when 64 then internal_flags := {SHARED_LEVEL}.integer_64_level
			end
		end

feature -- Access

	sk_value: NATURAL_32
			-- Skeleton characteristic value
		do
			inspect level
			when {SHARED_LEVEL}.integer_8_level then Result := {SK_CONST}.Sk_int8
			when {SHARED_LEVEL}.integer_16_level then Result := {SK_CONST}.Sk_int16
			when {SHARED_LEVEL}.integer_32_level then Result := {SK_CONST}.Sk_int32
			when {SHARED_LEVEL}.integer_64_level then Result := {SK_CONST}.Sk_int64
			end
		end

	type_i: TYPE_A
			-- Corresponding TYPE_I instance
		do
			inspect level
			when {SHARED_LEVEL}.integer_8_level then Result := integer_8_type
			when {SHARED_LEVEL}.integer_16_level then Result := integer_16_type
			when {SHARED_LEVEL}.integer_32_level then Result := integer_32_type
			when {SHARED_LEVEL}.integer_64_level then Result := integer_64_type
			end
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER)
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			inspect level
			when {SHARED_LEVEL}.integer_8_level then buffer.put_string ({SK_CONST}.sk_int8_string)
			when {SHARED_LEVEL}.integer_16_level then buffer.put_string ({SK_CONST}.sk_int16_string)
			when {SHARED_LEVEL}.integer_32_level then buffer.put_string ({SK_CONST}.sk_int32_string)
			when {SHARED_LEVEL}.integer_64_level then buffer.put_string ({SK_CONST}.sk_int64_string)
			end
		end

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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
