indexing

	description: "Node for integer constant. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class INTEGER_AS_B

inherit

	INTEGER_AS;

	ATOMIC_AS_B
		undefine
			is_integer, good_integer,
			simple_format, string_value
		redefine
			type_check, byte_node, value_i,
			make_integer, format
		end

feature -- Conveniences

	value_i: INT_VALUE_I is
			-- Interface value
		do
			!!Result;
			Result.set_int_val (value);
		end;

	type_check is
			-- Type check an integer type
		do
				-- Put onto the type stack an integer actual type
			context.put (Integer_type);
		end;

	byte_node: INT_CONST_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_value (value);
		end;

	make_integer: INT_VAL_B is
			-- Integer value
		do
			!!Result.make (value);
		end;

feature -- Formatter 

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.always_succeed;
			ctxt.put_string(value.out);
		end;

end -- class INTEGER_AS_B
