--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class INTEGER_REF

inherit

	NUMERIC
		redefine
			out
		end;

	COMPARABLE
		redefine
			out
		end;

	HASHABLE
		undefine
			out
		end

feature

	item: INTEGER;
			-- Numeric double value

	set_item (i: INTEGER) is
			-- Assign `i' to `item'.
		do
			item := i
		end;

	out: STRING is
			-- Return a printable representation of `Current'.
		do
			Result := c_outi ($item)
		end;

feature -- Hashcode

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := item;
		end;

feature -- Comparison

	infix "<" (other: INTEGER_REF): BOOLEAN is
			-- Is `Current' less than `other'?
		require else
			other_exists: other /= Void
		do
			Result := item < other.item
		end;

feature	-- Numeric

	infix "+" (other: INTEGER_REF): INTEGER_REF is
			-- Sum of `Current' and `other'
		do
			!!Result;
			Result.set_item (item + other.item)
		end;

	infix "-" (other: INTEGER_REF): INTEGER_REF is
			-- Difference between `Current' and `other'
		do
			!!Result;
			Result.set_item (item - other.item)
		end;

	infix "*" (other: INTEGER_REF): INTEGER_REF is
			-- Product of `Current' by `other'
		do
			!!Result;
			Result.set_item (item * other.item)
		end;

	infix "/" (other: INTEGER_REF): INTEGER_REF is
			-- Division of `Current' by `other'
		require else
			good_divisor: other.item /= 0.0
		do
			!!Result;
			Result.set_item (item / other.item)
		end;

	prefix "+": INTEGER_REF is
			-- Unary addition applied to `Current'
		do
			!!Result;
			Result.set_item (+ item)
		end;

	prefix "-": INTEGER_REF is
			-- Unary subtraction applied to `Current'
		do
			!!Result;
			Result.set_item (- item)
		end;

feature	-- div, mod

	infix "//" (other: INTEGER_REF): INTEGER_REF is
			-- Integer division of Current by `other'
		require
			other_exists: other /= Void
		do
			!!Result;
			Result.set_item (item // other.item)
		end;

	infix "\\" (other: INTEGER_REF): INTEGER_REF is
			-- Remainder of the integer division of Current by `other'
		require
			other_exists: other /= Void
		do
			!!Result;
			Result.set_item (item \\ other.item)
		end;

feature {NONE}
			-- External

	c_outi (i: INTEGER): STRING is
			-- Return a printable representation of `Current'.
		external
			"C"
		end;

end -- class INTEGER_REF
