indexing
	description: "Abstract representation of an interval in an inspect clause."
	date: "$Date$"
	revision: "$Revision$"

deferred class INTERVAL_B 

inherit
	BYTE_NODE

	COMPARABLE
		undefine
			is_equal
		end

	IL_CONST
		undefine
			is_equal
		end
	
feature 

	lower: INTERVAL_VAL_B
			-- Lower bound

	upper: INTERVAL_VAL_B
			-- Upper bound

	intersection (other: like Current): like Current is
			-- Instersection of `other' and Current.
		require
			good_argument: other /= Void
			not_disjunction: not disjunction (other)
		deferred
		end

	is_good_range: BOOLEAN is
			-- Is Current lower <= upper?
		do
			Result := (lower <= upper)
		end

	make (i: like lower; j: like upper) is
			-- Create a new interval with lower `i' and upper `j'.
			-- If `i' >= `j', then we reverse the order.
		require
			i_not_void: i /= Void
			j_not_void: j /= Void
		do
			lower := i
			upper := j
		end

	disjunction (other: like Current): BOOLEAN is
			-- Is the intersection of Current and `other' null ?
		require
			good_argument: other /= Void
		do
			Result := 	lower > other.upper
						or else
						upper < other.lower 
		end

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := lower < other.lower
		end

	display (st: STRUCTURED_TEXT) is
		do
			lower.display (st)
			st.add_string ("..")
			upper.display (st)
		end

feature -- IL code generation

	generate_il_interval (next_case_label: IL_LABEL) is
			-- Generate IL code for interval range
		require
			next_case_label_not_void: next_case_label /= Void
		deferred
		end

feature -- Byte code generation

	make_range (ba: BYTE_ARRAY) is
			-- Generate byte code for interval range.
		require
			not (lower = Void or else upper = Void)
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
