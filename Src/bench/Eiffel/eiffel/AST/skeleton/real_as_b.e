indexing

	description: "Node for real constant. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class REAL_AS_B

inherit

	REAL_AS;

	ATOMIC_AS_B
		undefine
			simple_format, string_value
		redefine
			type_check, byte_node, value_i, format
		end

feature -- Type check and byte code

	value_i: REAL_VALUE_I is
			-- Interface value
		do
			!!Result;
			Result.set_real_val (value);
		end;

	type_check is
			-- Type check a real type
		do
			context.put (Double_type);
		end;

	byte_node: REAL_CONST_B is
			-- Associated byte code
		do
			!!Result;
			Result.set_value (value);
		end;

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do	
			ctxt.always_succeed;
			ctxt.put_string(value);
		end;
		
end -- class REAL_AS_B
