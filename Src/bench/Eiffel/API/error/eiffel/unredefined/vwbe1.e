-- Conditional expression is not a boolean expression

class VWBE1 

inherit

	VWBE
		redefine
			subcode
		end
feature 

	subcode: INTEGER is 1;

	conditional: IF_AS;
			-- Conditional instruction involved

	set_conditional (c: IF_AS) is
			-- Assign `c' to `conditional'.
		do
			conditional := c;
		end;

end
