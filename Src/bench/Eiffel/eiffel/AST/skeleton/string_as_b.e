indexing

	description: "Node for string constants. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class STRING_AS_B

inherit

	STRING_AS;

	ATOMIC_AS_B
		redefine
			type_check, byte_node, value_i
		end;

feature -- Type check and byte code

	value_i: STRING_VALUE_I is
			-- Interface value
		do
			!!Result;
			Result.set_str_val (value);
		end;

	type_check is
			-- Type check a string constant
		do
				-- Update the type stack
			context.put (String_type);
		end;

	String_type: CL_TYPE_A is
			-- Actual string type
		once
			Result := System.string_class.compiled_class.actual_type;
		end;

	byte_node: STRING_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_value (value);
		end;

end -- class STRING_AS_B
