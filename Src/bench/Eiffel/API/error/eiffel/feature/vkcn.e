-- Error when a call as an instruction is used as an expression

class VKCN 

inherit

	FEATURE_ERROR
	
feature

	node: AST_EIFFEL;
			-- Call involved

	set_node (c: AST_EIFFEL) is
			-- Assign `c' to `node'.
		do
			node := c;
		end;

	code: STRING is "VKCN";
			-- Error code

end

