class UN_PLUS_AS_B

inherit

	UN_PLUS_AS
		rename
			expr as old_plus_expr
		end;

	UNARY_AS_B
		redefine
			byte_node
		select	
			expr
		end

feature -- Byte node

	byte_node: UN_PLUS_B is
			-- Associated byte code
		local
			access_line: ACCESS_LINE;
			feature_b: FEATURE_B;
		do
			!!Result;
			Result.set_expr (expr.byte_node);

			access_line := context.access_line;
			feature_b ?= access_line.access;
			Result.init (feature_b);
			access_line.forth;
		end;
	
end -- class UN_PLUS_AS_B
