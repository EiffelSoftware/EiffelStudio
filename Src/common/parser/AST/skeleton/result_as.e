indexing

	description: "Abstract description to access to `Result'.";
	date: "$Date$";
	revision: "$Revision$"

class RESULT_AS

inherit

	ACCESS_AS

feature

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

	access_name: STRING is
		once
			Result := "Result"
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.prepare_for_result;
			ctxt.put_text_item (ti_Result);
		end;

end -- class RESULT_AS
