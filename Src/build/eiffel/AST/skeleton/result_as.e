-- Abstract description to access to `Result'

class RESULT_AS

inherit

	ACCESS_AS
		redefine
			simple_format
		end

feature

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

	simple_format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.begin;
			ctxt.prepare_for_result;
			ctxt.put_string (ctxt.new_types.final_name);
			ctxt.commit;
		end;

	access_name: STRING is
		once
			Result := "Result"
		end;

end
