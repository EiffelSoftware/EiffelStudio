-- Abstract description to access to `Current'

class CURRENT_AS

inherit

	ACCESS_AS
		redefine
			simple_format
		end

feature -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

feature -- Formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.begin;
			ctxt.prepare_for_current;
			ctxt.put_string (ctxt.new_types.final_name);
			ctxt.commit;
			ctxt.set_types_back_to_global;
		end;

	access_name: STRING is
		once
			Result := "Current"
		end;

end
