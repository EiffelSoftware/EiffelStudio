indexing

	description: 
		"AST representation to access to `Result'.";
	date: "$Date$";
	revision: "$Revision$"

class RESULT_AS

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
			Result := "Result"
		end;

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_result;
			ctxt.put_text_item (ti_Result);
		end;

end -- class RESULT_AS
