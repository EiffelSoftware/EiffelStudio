indexing
	description: "Abstract representation of an interval in an inspect clause."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class INTERVAL_B

inherit
	BYTE_NODE
		redefine
			generate,
			is_equal
		end

	COMPARABLE
		redefine
			is_equal
		end

	IL_CONST
		redefine
			is_equal
		end

	INTERVAL_SPAN
		redefine
			is_equal
		end

feature {INTERVAL_B} -- Creation

	make (i: like lower; j: like upper) is
			-- Create a new interval with lower `i' and upper `j'.
		require
			i_not_void: i /= Void
			j_not_void: j /= Void
			same_type: i.same_type (j)
			not_empty: i <= j
		do
			lower := i
			upper := j
		end

feature  -- Access

	lower: INTERVAL_VAL_B
			-- Lower bound

	upper: like lower
			-- Upper bound

	case_index: INTEGER
			-- Position of corresponding When_part in inspect instruction

	intersection (other: like Current): like Current is
			-- Instersection of `other' and Current
		require
			good_argument: other /= Void
			same_type: same_type (other)
			not_disjunction: not disjunction (other)
		local
			new_lower, new_upper: like lower
		do
			if lower < other.lower then
				new_lower := other.lower
			else
				new_lower := lower
			end
			if upper < other.upper then
				new_upper := upper
			else
				new_upper := other.upper
			end
			Result := twin
			Result.make (new_lower, new_upper)
		end

	disjunction (other: like Current): BOOLEAN is
			-- Is the intersection of Current and `other' null?
		require
			good_argument: other /= Void
			same_type: same_type (other)
		do
			Result := 	lower > other.upper
						or else
						upper < other.lower
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater than Current?
		do
			Result :=
				lower < other.lower or else
				lower.is_equal (other.lower) and then upper < other.upper
		end

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to Current?
		do
			Result := lower.is_equal (other.lower) and then upper.is_equal (other.upper)
		end

feature -- Status report

	is_lower_included: BOOLEAN is true
			-- Is `lower' included in an interval?

	is_upper_included: BOOLEAN is true
			-- Is `upper' included in an interval?

feature -- Measurement

	count: DOUBLE is 1.0
			-- Number of intervals and gaps in current span

feature -- Modification

	set_upper (new_upper: like upper) is
			-- Set `upper' to `new_upper'.
		require
			new_upper_not_void: new_upper /= Void
			new_upper_greater_than_upper: new_upper > upper
			same_type: lower.same_type (new_upper)
		do
			upper := new_upper
		ensure
			upper_set: upper = new_upper
		end

	set_case_index (i: INTEGER) is
			-- Set `case_index' to `i'.
		require
			valid_index: i > 0
		do
			case_index := i
		ensure
			case_index_set: case_index = i
		end

feature -- Output

	display (st: STRUCTURED_TEXT) is
		do
			lower.display (st)
			st.add_string ("..")
			upper.display (st)
		end

feature -- C code generation

	generate is
			-- Generate the interval.
		do
			lower.generate_interval (upper)
		end

feature -- IL code generation

	generate_il (a_generator: IL_NODE_GENERATOR; min_value, max_value: like lower; is_min_included, is_max_included: BOOLEAN; labels: ARRAY [IL_LABEL]; instruction: INSPECT_B) is
			-- Generate code for single interval of `instruction' assuming that inspect value is in range `min_value'..`max_value'
			-- where bounds are included in interval according to values of `is_min_included' and `is_max_included'.
			-- Use `labels' to branch to the corresponding code.
		local
			is_min_equal_lower: BOOLEAN
			is_max_equal_upper: BOOLEAN
			label: IL_LABEL
			else_label: IL_LABEL
		do
			is_min_equal_lower := min_value = lower or else not is_min_included and then min_value.is_next (lower)
			is_max_equal_upper := upper = max_value or else not is_max_included and then upper.is_next (max_value)
			label := labels.item (case_index)
			else_label := labels.item (0)
			if is_min_equal_lower then
					-- No need to test lower bound
				if is_max_equal_upper then
						-- No need to test either bound: just branch to the code
					else_label := label
				else
						-- Test upper bound
					a_generator.generate_il_load_value (instruction)
					upper.il_load_value
					if label = Void then
						il_generator.branch_on_condition ({MD_OPCODES}.bgt, else_label)
					else
						il_generator.branch_on_condition ({MD_OPCODES}.ble, label)
					end
				end
			elseif is_max_equal_upper then
					-- No need to test upper bound
					-- Test lower bound
				a_generator.generate_il_load_value (instruction)
				lower.il_load_value
				if label = Void then
					il_generator.branch_on_condition ({MD_OPCODES}.blt, else_label)
				else
					il_generator.branch_on_condition ({MD_OPCODES}.bge, label)
				end
			elseif lower.is_equal (upper) then
					-- This is a single value
					-- Test for equality
				a_generator.generate_il_load_value (instruction)
				lower.il_load_value
				if label = Void then
					il_generator.branch_on_condition ({MD_OPCODES}.bne_un, else_label)
				else
					il_generator.branch_on_condition ({MD_OPCODES}.beq, label)
				end
			else
					-- General case
					-- Generate unsigned test `val - lower <= upper - lower' which is equivalent to
					-- signed test `lower <= val and val <= upper'.
				a_generator.generate_il_load_value (instruction)
				lower.il_load_value
				il_generator.generate_binary_operator (il_minus, True)
				upper.il_load_difference (lower)
				if label = Void then
					il_generator.branch_on_condition ({MD_OPCODES}.bgt_un, else_label)
				else
					il_generator.branch_on_condition ({MD_OPCODES}.ble_un, label)
				end
			end
			if label = Void then
				a_generator.generate_il_when_part (instruction, case_index, labels)
			else
				il_generator.branch_to (else_label)
			end
		end

invariant
	lower_not_void: lower /= Void
	upper_not_void: upper /= Void
	bounds_of_same_type: lower.same_type (upper)
	valid_range: lower <= upper

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
