deferred class INTERVAL_B 

inherit

	BYTE_NODE;
	COMPARABLE;
	BASIC_ROUTINES;
	
feature 

	lower: INTERVAL_VAL_B;
			-- Lower bound

	upper: INTERVAL_VAL_B;
			-- Upper bound

	intersection (other: like Current): like Current is
			-- Instersection of `other' and Current.
		require
			good_argument: other /= Void;
			not_disjunction: not disjunction (other);
		deferred
		end;

	is_good_range: BOOLEAN is
			-- Is Current lower <= upper?
		do
			Result := (lower <= upper)
		end;

	make (i: like lower; j: like upper) is
		do
			lower := i;
			upper := j;
		end;

	disjunction (other: like Current): BOOLEAN is
			-- Is the intersection of Current and `other' null ?
		require
			good_argument: other /= Void
		do
			Result := 	lower > other.upper
						or else
						upper < other.lower 
		end;

	infix "<" (other: like Current): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			Result := lower < other.lower;
		end;

	display (a_clickable: CLICK_WINDOW) is
		do
			lower.display (a_clickable);
			a_clickable.put_string ("..");
			upper.display (a_clickable);
		end;

feature -- Byte code generation

	make_range (ba: BYTE_ARRAY) is
			-- Generate byte code for interval range.
		require
			not (lower = Void or else upper = Void);
			is_good_range: is_good_range
		do
			lower.make_byte_code (ba);
			upper.make_byte_code (ba);
			ba.append (Bc_range);
		end;

end
