indexing
	description: "Representation of a manifest constant constant"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CHAR_VAL_B

inherit
	TYPED_INTERVAL_VAL_B [CHARACTER_32]

create
	make

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_char_val_b (Current)
		end

feature -- Measurement

	distance (other: like Current): DOUBLE is
			-- Distance between `other' and Current
		do
			Result := other.value.natural_32_code - value.natural_32_code
		end

feature -- Error reporting

	display (a_text_formatter: TEXT_FORMATTER) is
		do
			if value.natural_32_code <= {CHARACTER_8}.max_value.as_natural_32 then
				a_text_formatter.add_char ('%'')
				a_text_formatter.add_char (value.to_character_8)
				a_text_formatter.add_char ('%'')
			else
				a_text_formatter.add_char ('%'')
				a_text_formatter.add_char ('%%')
				a_text_formatter.add_char ('/')
				a_text_formatter.add_string (value.natural_32_code.out)
				a_text_formatter.add_char ('/')
				a_text_formatter.add_char ('%'')
			end
		end

feature -- Iteration

	do_all (is_included: BOOLEAN; other: like Current; is_other_included: BOOLEAN; action: PROCEDURE [ANY, TUPLE]) is
			-- Apply `action' to all values in range `Current'..`other' where
			-- inclusion of bounds in the range is specified by `is_included' and `is_other_included'.
		local
			i: NATURAL_32
		do
			from
				i := other.value.natural_32_code - value.natural_32_code + 1
				if not is_included then
					i := i - 1
				end
				if not is_other_included then
					i := i - 1
				end
			until
				i <= 0
			loop
				action.call (Void)
				i := i - 1
			end
		end

feature -- IL code generation

	generate_il_subtract (is_included: BOOLEAN) is
			-- Generate code to subtract this value if `is_included' is true or
			-- next value if `is_included' is false from top of IL stack.
			-- Ensure that resulting value on the stack is UInt32.
		local
			i: like value
		do
			i := value
			if not is_included then
				i := next_value (i)
			end
			if i /= '%U' then
				il_generator.put_natural_32_constant (i.natural_32_code)
				il_generator.generate_binary_operator ({IL_CONST}.il_minus, True)
			end
		end

feature {TYPED_INTERVAL_B} -- IL code generation

	il_load_value is
			-- Load value to IL stack.
		do
			il_generator.put_natural_32_constant (value.natural_32_code)
		end

	il_load_difference (other: like Current) is
			-- Load a difference between current and `other' to IL stack.
		do
			il_generator.put_natural_32_constant (value.natural_32_code - other.value.natural_32_code)
		end

feature {NONE} -- Implementation: C generation

	generate_value (v: like value) is
			-- Generate single value `v'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			if v.natural_32_code <= {CHARACTER_8}.max_value.as_natural_32 then
				char_c_type.generate_cast (buf)
				buffer.put_character_literal (v.to_character_8)
			else
				wide_char_c_type.generate_cast (buf)
				buf.put_natural_32 (v.natural_32_code)
				buf.put_character ('U')
			end
		end

	next_value (v: like value): like value is
			-- Value after given value `v'
		do
			Result := (v.natural_32_code + 1).to_character_32
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
