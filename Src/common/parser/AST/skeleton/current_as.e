-- Abstract description to access to `Current'

class CURRENT_AS

inherit

	ACCESS_AS
		redefine
			type_check, byte_node, format, replicate
		end

feature -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

feature -- Type check and byte code

	type_check is
			-- Type check access to Current
		local
			current_access: CURRENT_B;
		do
				-- Creation of a byte code access to Current and insertion
			   -- of it in the access line.
			!!current_access;
			context.access_line.insert (current_access);
		end;

	byte_node: CURRENT_B is
			-- Associated byte code
		local
			access_line: ACCESS_LINE;
		do
			access_line := context.access_line;
			check
				access_line_is_ok: not access_line.after
			end;
			Result ?= access_line.access;
			access_line.forth;
		end;

	format (ctxt: FORMAT_CONTEXT) is
		do
			ctxt.begin;
			ctxt.prepare_for_current;
			ctxt.put_string (ctxt.new_types.final_name);
			ctxt.commit;
			--ctxt.set_types_back_to_global;
		end;

	access_name: STRING is
		once
			Result := "Current"
		end;

feature -- Replication

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			ctxt.adapt_current;
			Result := twin
		end;
end
