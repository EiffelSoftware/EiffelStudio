indexing

	description: "Abstract description to access to `Current'.";
	date: "$Date$";
	revision: "$Revision$"

class CURRENT_AS

inherit

	ACCESS_AS
		redefine
			simple_format
		end;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

	access_name: STRING is
		once
			Result := "Current"
		end;

feature -- Simple formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.begin;
			ctxt.prepare_for_current;
			ctxt.put_current;
			ctxt.commit;
		end;

end -- class CURRENT_AS
