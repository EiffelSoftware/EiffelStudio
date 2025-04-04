note
	description: "[
		Representation of a DOUBLE constant in source code. Name of class is
		not the best one since it is confusion that it is called REAL where it handles DOUBLE.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$date: $"

class
	REAL_VALUE_I

inherit
	VALUE_I
		redefine
			is_real_64, is_real_32, unary_minus, set_real_type, is_real
		end

create
	make

feature {NONE} -- Initialization

	make (d: like real_64_value; a_is_real_64: like is_real_64)
			-- Create instance of current with `real_64_value' set to `d'.
		do
			real_64_value := d
			is_real_64 := a_is_real_64
		ensure
			real_64_value_set: real_64_value = d
			is_real_64: is_real_64 = a_is_real_64
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := (is_real_64 = other.is_real_64) and
				(real_64_value = other.real_64_value)
		end

feature -- Access

	real_64_value: REAL_64
			-- Double value.

	real_32_value: REAL_32
			-- Real value.
		do
			Result := real_64_value.truncated_to_real
		end

feature -- Status report

	is_real: BOOLEAN = True
			-- Is current constant a real constant (regardless of its implementation size)?

	is_real_64: BOOLEAN
			-- Is the current constant a double one?

	is_real_32: BOOLEAN
			-- Is current constant a real one?
		do
			Result := not is_real_64
		end

	valid_type (t: TYPE_A): BOOLEAN
			-- Is the current value compatible with `t' ?
		do
			Result := t.is_real_32 or t.is_real_64
		end

feature -- Settings

	set_real_type (t: TYPE_A)
			-- Update current value accordingly to context `t'.
		local
			l_is_real_64: BOOLEAN
		do
			l_is_real_64 := is_real_64
			if t.is_real_64 /= l_is_real_64 then
				is_real_64 := not l_is_real_64
			end
		end

feature -- Unary operators

	unary_minus: VALUE_I
			-- Apply `-' operator to Current.
		do
			create {REAL_VALUE_I} Result.make (-real_64_value, is_real_64)
		end

feature -- Code generation

	generate (buffer: GENERATION_BUFFER)
			-- Generate value in `buffer'.
		local
			l_val: STRING
			l_nb, l_pos: INTEGER
		do
			l_val := real_64_value.out
			l_nb := l_val.count
				-- Special trick when current locale decimal separator
				-- is the coma (See bug#5659)
			l_pos := l_val.last_index_of (',', l_nb)
			if l_pos > 0 then
					-- Replace the `,' with a `.'.
				l_val.put ('.', l_pos)
				buffer.put_string (l_val)
			elseif l_val.last_index_of ('.', l_nb) = 0 and l_val.last_index_of ('e', l_nb) = 0 then
					-- It is an integer value, we need to add the '.'
					-- as otherwise it is not a valid C identifier.
				buffer.put_string (l_val)
				buffer.put_character ('.')
			else
				buffer.put_string (l_val)
			end
			if is_real_32 then
				buffer.put_character ('f')
			end
		end

	generate_il
			-- Generate IL code for real constant value.
		do
			if is_real_64 then
				il_generator.put_real_64_constant (real_64_value)
			else
				il_generator.put_real_32_constant (real_32_value)
			end
		end

	make_byte_code (ba: BYTE_ARRAY)
			-- Generate byte code for a real constant value
		do
			if is_real_64 then
				ba.append (Bc_real64)
				ba.append_double (real_64_value)
			else
				ba.append (Bc_real32)
				ba.append_double (real_32_value)
			end
		end

feature -- Output

	dump: STRING
			-- Textual representation of `real_64_value'.
		do
			Result := real_64_value.out
		end

invariant
	is_real_64_or_real_32: is_real_64 = not is_real_32

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
