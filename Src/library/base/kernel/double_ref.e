--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class DOUBLE_REF

inherit

	NUMERIC
		redefine
			out
		end;

	COMPARABLE
		redefine
            out
        end

feature

	item: DOUBLE;
			-- Numeric double value

	set_item (d: DOUBLE) is
			-- Assign `d' to `item'.
		do
			item := d
		end;

	out: STRING is
			-- Return a printable representation of ~Current'.
		do
			Result := c_outd ($item)
		end;

feature -- Comparison

	infix "<" (other: DOUBLE_REF): BOOLEAN is
			-- Is `Current' less than `other'?
		require else
			other_exists: other /= Void
		do
			Result := item < other.item
		end;

feature	-- Numeric

	infix "+" (other: DOUBLE_REF): DOUBLE_REF is
			-- Sum of `Current' and `other'
		do
			!!Result;
			Result.set_item (item + other.item)
		end;

	infix "-" (other: DOUBLE_REF): DOUBLE_REF is
			-- Difference between `Current' and `other'
		do
			!!Result;
			Result.set_item (item - other.item)
		end;

	infix "*" (other: DOUBLE_REF): DOUBLE_REF is
			-- Product of `Current' by `other'
		do
			!!Result;
			Result.set_item (item * other.item)
		end;

	infix "/" (other: DOUBLE_REF): DOUBLE_REF is
			-- Division of `Current' by `other'
		require else
			good_divisor: other.item /= 0.0
		do
			!!Result;
			Result.set_item (item / other.item)
		end;

	prefix "+": DOUBLE_REF is
			-- Unary addition applied to `Current'
		do
			!!Result;
			Result.set_item (+ item)
		end;

	prefix "-": DOUBLE_REF is
			-- Unary subtraction applied to `Current'
		do
			!!Result;
			Result.set_item (- item)
		end;

feature {NONE}
			-- External


	c_outd (d: DOUBLE): STRING is
			-- Return a printable representation of `Current'.
		external
			"C"
		end;

end -- class DOUBLE_REF
