indexing

	description: 
		"AST representation of expanded class type.";
	date: "$Date$";
	revision: "$Revision$"

class EXP_TYPE_AS

inherit

	CLASS_TYPE_AS
		rename
			dump as basic_dump,
			set as basic_set,
			simple_format as basic_simple_format
		redefine
			initialize
		end;

	CLASS_TYPE_AS
		redefine
			initialize,
			dump, set, simple_format
		select
			dump, set, simple_format
		end;

feature {AST_FACTORY} -- Initialization

	initialize (n: like class_name; g: like generics) is
			-- Create a new EXPANDED_CLASS_TYPE AST node.
		do
			Precursor (n, g)
			record_expanded
		end

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			basic_set;
			record_expanded
		end;

	record_expanded is
			-- This must be done before pass2
			-- `solved_type' and `actual type' are called in pass3 for
			-- local variables
		do
		end;

feature -- Output

	dump: STRING is
			-- Dumped trace
		do
			!!Result.make (class_name.count + 9);
			Result.append ("expanded ");
			Result.append (basic_dump);
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_Expanded_keyword);
			ctxt.put_space;
			basic_simple_format (ctxt);
		end;

end -- class EXP_TYPE_AS
