indexing

	description: "Abstract description to access to `Result'.";
	date: "$Date$";
	revision: "$Revision$"

class RESULT_AS

inherit

	ACCESS_AS
		redefine
			simple_format
		end;

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
			ctxt.begin;
			ctxt.prepare_for_result;
			ctxt.put_result;
			ctxt.commit;
		end;

end -- class RESULT_AS
