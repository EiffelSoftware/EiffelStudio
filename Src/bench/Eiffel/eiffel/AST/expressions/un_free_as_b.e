indexing

	description: "Free unary expression description. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class UN_FREE_AS_B

inherit

	UN_FREE_AS
		redefine
			op_name, expr
		end;

	UNARY_AS_B
		undefine
			set, is_equivalent
		redefine
			byte_node, expr
		end

feature -- Properties

	op_name: ID_AS_B;
			-- Operator name

	expr: EXPR_AS_B

feature -- Type check

	byte_node: UN_FREE_B is
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

end -- class UN_FREE_AS_B
