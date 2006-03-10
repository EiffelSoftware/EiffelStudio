indexing
	description: "Representation of a 64-bit manifest natural constant"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	NAT64_VAL_B

inherit
	TYPED_INTERVAL_VAL_B [NATURAL_64]
		redefine
			is_allowed_unique_value
		end

create
	make

feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_nat64_val_b (Current)
		end

feature -- Comparison

	infix "<" (other: NAT64_VAL_B): BOOLEAN is
			-- Is `other' greater than Current?
		do
			Result := value < other.value
		end

	is_allowed_unique_value: BOOLEAN is
			-- Does `Current' represent an allowed unique value?
		do
			Result := value > 0
		end

feature -- Measurement

	distance (other: like Current): DOUBLE is
			-- Distance between `other' and Current
		do
			Result := other.value - value
		end

feature -- Error reporting

	display (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.process_number_text (value.out)
		end

feature -- Iteration

	do_all (is_included: BOOLEAN; other: like Current; is_other_included: BOOLEAN; action: PROCEDURE [ANY, TUPLE]) is
			-- Apply `action' to all values in range `Current'..`other' where
			-- inclusion of bounds in the range is specified by `is_included' and `is_other_included'.
		local
			i: like value
			j: like value
		do
			i := value
			j := other.value
			if i <= j and then (is_included or else i < i + 1) and then (is_other_included or else j - 1 < j) then
				if not is_included then
					i := i + 1
				end
				if not is_other_included then
					j := j - 1
				end
				if i <= j then
					from
						i := j - i
					until
						i = 0
					loop
						action.call (Void)
						i := i - 1
					end
					action.call (Void)
				end
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
				i := i + 1
			end
			if i /= 0 then
				il_generator.put_natural_64_constant (i)
				il_generator.generate_binary_operator ({IL_CONST}.il_minus, True)
			end
			il_generator.convert_to_natural_32
		end

feature {TYPED_INTERVAL_B} -- IL code generation

	il_load_value is
			-- Load value to IL stack.
		do
			il_generator.put_natural_64_constant (value)
		end

	il_load_difference (other: like Current) is
			-- Load a difference between current and `other' to IL stack.
		do
			il_generator.put_natural_64_constant (value - other.value)
		end

feature {NONE} -- Implementation: C generation

	generate_value (v: like value) is
			-- Generate single value `v'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_string ("RTU64C(")
			buf.put_string (v.out)
			buf.put_character (')')
		end

	next_value (v: like value): like value is
			-- Value after given value `v'
		do
			Result := v + 1
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
