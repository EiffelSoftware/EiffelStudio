indexing

	description: "Abstract class for expression nodes. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

deferred class EXPR_AS_B

inherit

	EXPR_AS;

	AST_EIFFEL_B
		undefine
			byte_node
		end

feature

	byte_node: EXPR_B is
			-- Byte code type
		deferred
		end;

end -- class EXPR_AS_B
