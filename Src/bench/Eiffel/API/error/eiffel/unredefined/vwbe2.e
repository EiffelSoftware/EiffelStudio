-- Elsif alternaltive has not a boolean expression as condition

class VWBE2 

inherit

	VWBE
		redefine
			subcode
		end
feature 

	subcode: INTEGER is 2;

	clause: ELSIF_AS;
			-- Clause involved

	set_clause (c: ELSIF_AS) is
			-- Assign `c' to `clause'.
		do
			clause := c;
		end;

end
