-- Elsif alternaltive has not a boolean expression as condition

class VWBE2 

inherit

	VWBE
	
feature 

	clause: ELSIF_AS;
			-- Clause involved

	set_clause (c: ELSIF_AS) is
			-- Assign `c' to `clause'.
		do
			clause := c;
		end;

end
