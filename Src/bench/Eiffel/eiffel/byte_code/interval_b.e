indexing
	description: "Abstract representation of an interval in an inspect clause."
	date: "$Date$"
	revision: "$Revision$"

deferred class INTERVAL_B 

inherit
	BYTE_NODE
		rename
			generate_il as old_generate_il
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

feature -- Byte code generation

	make_range (ba: BYTE_ARRAY) is
			-- Generate byte code for interval range.
		require
			ba_not_void: ba /= Void
		do
			lower.make_byte_code (ba)
			upper.make_byte_code (ba)
			ba.append (Bc_range)
		end

feature -- C code generation

	generate is
			-- Generate the interval.
		do
			lower.generate_interval (upper)
		end

feature -- IL code generation

	generate_il (min_value, max_value: like lower; is_min_included, is_max_included: BOOLEAN; labels: ARRAY [IL_LABEL]; instruction: INSPECT_B) is
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
					instruction.generate_il_load_value
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
				instruction.generate_il_load_value
				lower.il_load_value
				if label = Void then
					il_generator.branch_on_condition ({MD_OPCODES}.blt, else_label)
				else
					il_generator.branch_on_condition ({MD_OPCODES}.bge, label)
				end
			elseif lower.is_equal (upper) then
					-- This is a single value
					-- Test for equality
				instruction.generate_il_load_value
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
				instruction.generate_il_load_value
				lower.il_load_value
				il_generator.generate_binary_operator (il_minus)
				lower.il_load_difference (upper)
				if label = Void then
					il_generator.branch_on_condition ({MD_OPCODES}.bgt_un, else_label)
				else
					il_generator.branch_on_condition ({MD_OPCODES}.ble_un, label)
				end
			end
			if label = Void then
				instruction.generate_il_when_part (case_index, labels)
			else
				il_generator.branch_to (else_label)
			end
		end

invariant
	lower_not_void: lower /= Void
	upper_not_void: upper /= Void
	bounds_of_same_type: lower.same_type (upper)
	valid_range: lower <= upper

end
