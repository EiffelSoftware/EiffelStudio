indexing
	description: "Bit description"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BITS_DESC

inherit
	ATTR_DESC
		rename
			Bits_level as level
		redefine
			is_bits, same_as
		end

feature -- Access

	value: INTEGER
			-- Bits value

	type_i: TYPE_I is
			-- Correspdonding instance of BIT type.
		do
			create {BIT_I} Result.make (value)
		end

	sk_value: INTEGER is
			-- Sk value
		do
			Result := Sk_bit + value
		end

feature -- Status report

	is_bits: BOOLEAN is True
			-- Is the attribute a bits one ?

feature -- Comparisons

	same_as (other: ATTR_DESC): BOOLEAN is
			-- Is `other' equal to Current ?
		local
			other_bits: BITS_DESC
		do
			if Precursor {ATTR_DESC} (other) then
				other_bits ?= other
				Result := (other_bits /= Void) and then (other_bits.value = value)
			end
		end

feature -- Settings

	set_value (i: INTEGER) is
			-- Assign `i' to `value'.
		require
			i_positive: i >= 0
		do
			value := i
		ensure
			value_set: value = i
		end

feature -- Code generation

	generate_code (buffer: GENERATION_BUFFER) is
			-- Generate type code for current attribute description in
			-- `buffer'.
		do
			buffer.put_string ("SK_BIT + ")
			buffer.put_integer (value)
		end

feature -- Debug

	trace is
		do
			io.error.put_string (attribute_name)
			io.error.put_string ("[BITS ")
			io.error.put_integer (value)
			io.error.put_string ("]")
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
