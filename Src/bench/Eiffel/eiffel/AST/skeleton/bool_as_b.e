indexing

	description: "Node for boolean constant. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class BOOL_AS_B

inherit

	BOOL_AS;

	ATOMIC_AS_B
		redefine
			type_check, byte_node, value_i
		end

feature -- Type check

	value_i: BOOL_VALUE_I is
		do
			!!Result;
			Result.set_bool_val (value);
		end;

	type_check is
			-- Type chek a boolean type
		do
			context.put (Boolean_type);
		end;

	byte_node: BOOL_CONST_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_value (value);
		end;

end -- class BOOL_AS_B
