-- Conditional expression is not a boolean expression

class VWBE1 

inherit

	VWBE
	
feature 

	conditional: IF_AS;
			-- Conditional instruction involved

	set_conditional (c: IF_AS) is
			-- Assign `c' to `conditional'.
		do
			conditional := c;
		end;

end
