indexing

	description: 
		"AST representation to access to `Current'.";
	date: "$Date$";
	revision: "$Revision$"

class CURRENT_AS

inherit

	ACCESS_AS

feature {NONE} -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

feature -- Properties

	access_name: STRING is
		once
			Result := "Current"
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_current;
			ctxt.put_text_item (ti_Current)
		end;

end -- class CURRENT_AS
