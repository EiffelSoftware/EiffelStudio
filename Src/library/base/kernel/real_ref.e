--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------


-- Representation of real number in single floating-point
-- uses at most 'Real_bits' bits defined in class 'PLATFORM' 


indexing

	date: "$Date$";
	revision: "$Revision$"

class REAL_REF

inherit

	NUMERIC
		redefine
			out
		end;

	COMPARABLE
        redefine
            out
        end

feature -- Access

	item: REAL;
			-- Numeric real value

feature -- Comparison

	infix "<" (other: REAL_REF): BOOLEAN is
			-- Is `Current' less than `other'?
		require else
			other_exists: other /= Void
		do
			Result := item < other.item
		end; -- "<"

feature -- Basic operation

	infix "+" (other: REAL_REF): REAL_REF is
			-- Sum of `Current' and `other'
		do
			!!Result;
			Result.set_item (item + other.item)
		end; -- infix "+"

	infix "-" (other: REAL_REF): REAL_REF is
			-- Difference between `Current' and `other'
		do
			!!Result;
			Result.set_item (item - other.item)
		end; -- infix "-"

	infix "*" (other: REAL_REF): REAL_REF is
			-- Product of `Current' by `other'
		do
			!!Result;
			Result.set_item (item * other.item)
		end; -- infix "*"

	infix "/" (other: REAL_REF): REAL_REF is
			-- Division of `Current' by `other'
		require else
			good_divisor: other.item /= 0.0
		do
			!!Result;
			Result.set_item (item / other.item)
		end; -- infix "/"

	infix "^" (other: REAL_REF): REAL_REF is
			-- Power of `Current' by `other'
		do
			!!Result;
			Result.set_item (item ^ other.item)
		end; -- infix "^"

	prefix "+": REAL_REF is
			-- Unary addition applied to `Current'
		do
			!!Result;
			Result.set_item (+ item)
		end; -- prefix "+"

	prefix "-": REAL_REF is
			-- Unary subtraction applied to `Current'
		do
			!!Result;
			Result.set_item (- item)
		end; -- prefix "-"


feature -- Modification & Insertion

	set_item (r: REAL) is
			-- Assign `r' to item'.
		do
			item := r
		end;

feature -- Ouput


	out: STRING is
			-- Return a printable representation of `Current'.
		do
			Result := c_outr ($item)
		end; -- out

feature  {NONE} -- External, Ouput

	c_outr (r: REAL): STRING is
			-- Return a prinatble representation of `Current'.
		external
			"C"
		end; -- c_outr

end -- class REAL_REF
