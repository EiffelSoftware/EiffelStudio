indexing

	description: "Description of a unique value. Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class UNIQUE_AS_B

inherit

	UNIQUE_AS
		undefine
			string_value
		end;

	ATOMIC_AS_B
		undefine
			is_unique, simple_format
		redefine
			type_check, format
		end

feature

	type_check is
			-- Type check a unique type
		do
			context.put (Integer_type);
		end;

	format (ctxt: FORMAT_CONTEXT_B) is
		do
			ctxt.put_text_item (ti_Unique_keyword);
		end;

end -- class UNIQUE_AS_B
