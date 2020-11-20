note
	description: "Representation of a manifest integer constant"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INT_VAL_B

inherit
	TYPED_INTERVAL_VAL_B [INTEGER]
		redefine
			is_allowed_unique_value,
			is_signed,
			position
		end

create
	make

feature -- Visitor

	process (v: BYTE_NODE_VISITOR)
			-- Process current element.
		do
			v.process_int_val_b (Current)
		end

feature -- Comparison

	is_allowed_unique_value: BOOLEAN
			-- Does `Current' represent an allowed unique value?
		do
			Result := value > 0
		end

	is_signed: BOOLEAN = True
			-- Current requires signed comparison.

feature -- Measurement

	distance (other: like Current): DOUBLE
			-- Distance between `other' and Current
		do
				-- Convert to result type first to avoid overflow if difference is higher than maximum integer
			Result := other.value
			Result := Result - value
		end

feature -- Error reporting

	display (a_text_formatter: TEXT_FORMATTER)
		do
			a_text_formatter.add_int (value)
		end

feature -- Iteration

	do_all (is_included: BOOLEAN; other: like Current; is_other_included: BOOLEAN; action: PROCEDURE)
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

	generate_il_subtract (is_included: BOOLEAN)
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
				il_generator.put_integer_32_constant (i)
				il_generator.generate_binary_operator ({IL_CONST}.il_minus, False)
			end
		end

feature {TYPED_INTERVAL_B} -- IL code generation

	il_load_value
			-- Load value to IL stack.
		do
			il_generator.put_integer_32_constant (value)
		end

	il_load_difference (other: like Current)
			-- Load a difference between current and `other' to IL stack.
		do
			il_generator.put_integer_32_constant (value - other.value)
		end

feature {NONE} -- Implementation: C generation

	generate_value (v: like value)
			-- Generate single value `v'.
		local
			buf: GENERATION_BUFFER
		do
			buf := buffer
			buf.put_integer (v)
			buf.put_character ('L')
		end

	next_value (v: like value): like value
			-- Value after given value `v'
		do
			Result := v + 1
		end

feature {NONE} -- Code generation

	position (v: like value): like {FEATURE_I}.creator_position
			-- <Precursor>
		do
			Result := v
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
