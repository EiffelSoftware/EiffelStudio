indexing

	description:
		"Abstract description to access to `Current'. %
		%Version for Bench.";
	date: "$Date$";
	revision: "$Revision$"

class CURRENT_AS_B

inherit

	CURRENT_AS;

	ACCESS_AS_B
		redefine
			type_check, byte_node, replicate
		end

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

feature -- Replication

	replicate (ctxt: REP_CONTEXT): like Current is
		do
			ctxt.adapt_current;
			Result := clone (Current)
		end;

end -- class CURRENT_AS_B
