indexing

	description: 
		"AST representation of an `all' structure.";
	date: "$Date$";
	revision: "$Revision $"

class ALL_AS

inherit

	FEATURE_SET_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (ti_All_keyword);
		end;

end -- class ALL_AS
