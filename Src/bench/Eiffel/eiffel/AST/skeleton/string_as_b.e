indexing

	description: "Node for string constants. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class STRING_AS_B

inherit

	STRING_AS
		undefine
			string_value
		redefine
			infix "<"
		end;

	ATOMIC_AS_B
		undefine
			simple_format
		redefine
			type_check, byte_node, value_i, format
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

feature -- formatter

	format (ctxt: FORMAT_CONTEXT_B) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Double_quote);
			ctxt.put_string (eiffel_string (value));
			ctxt.put_text_item (ti_Double_quote);
			ctxt.always_succeed;
		end;

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := value_i.str_val < other.value_i.str_val 
		end;

end -- class STRING_AS_B
