-- Loop test expression os not boolean expression

class VWBE4 

inherit

	VWBE
	
feature 

	loop_expression: EXPR_AS;
			-- Clause involved

	set_loop_expression (c: EXPR_AS) is
			-- Assign `c' to `loop_expression'.
		do
			loop_expression := c;
		end;

end
