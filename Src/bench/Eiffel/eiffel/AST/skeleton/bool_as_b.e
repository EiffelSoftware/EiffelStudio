indexing

	description: "Node for boolean constant. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class BOOL_AS_B

inherit

	BOOL_AS;

	ATOMIC_AS_B
		undefine
			simple_format, string_value
		redefine
			type_check, byte_node, value_i, format
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

feature -- formatter

	format (ctxt: FORMAT_CONTEXT_B) is
		do
			ctxt.always_succeed;
			if value then
				ctxt.put_text_item (ti_True_keyword)
			else
				ctxt.put_text_item (ti_False_keyword)
			end
		end;

end -- class BOOL_AS_B
