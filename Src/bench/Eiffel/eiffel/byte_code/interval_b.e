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
			-- If `i' >= `j', then we reverse the order.
		require
			i_not_void: i /= Void
			j_not_void: j /= Void
			compatible_type: i.conforms_to (j) or j.conforms_to (i)
		do
			lower := i
			upper := j
		end

feature  -- Access

	lower: INTERVAL_VAL_B
			-- Lower bound

	upper: INTERVAL_VAL_B
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

	is_good_range: BOOLEAN is
			-- Is Current lower <= upper?
		do
			Result := lower <= upper
		end

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
			compatible_type: lower.conforms_to (new_upper) or new_upper.conforms_to (lower)
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
			is_good_range: is_good_range
		do
			lower.make_byte_code (ba)
			upper.make_byte_code (ba)
			ba.append (Bc_range)
		end

invariant
	lower_not_void: lower /= Void
	upper_not_void: upper /= Void

end
