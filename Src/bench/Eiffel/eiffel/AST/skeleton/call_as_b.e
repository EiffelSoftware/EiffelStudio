indexing

	description: "Abstract description of an EIffel call. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

deferred class CALL_AS_B

inherit

	CALL_AS;

	AST_EIFFEL_B	
		undefine
			byte_node
		end

feature

	byte_node: CALL_B is
		deferred
		end;

end -- class CALL_AS_B
