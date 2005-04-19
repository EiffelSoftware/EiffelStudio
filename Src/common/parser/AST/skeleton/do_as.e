indexing
	description: "AST representation of a non-deferred routine.";
	date: "$Date$";
	revision: "$Revision$"

class DO_AS

inherit
	INTERNAL_AS
		redefine
			process
		end

create
	initialize

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_do_as (Current)
		end

end -- class DO_AS
