indexing

	description:
		"Abstract description of a reverse assignment. %
		%Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class REVERSE_AS

inherit
	ASSIGN_AS
		redefine
			process
		end

create
	initialize

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_reverse_as (Current)
		end

end -- class REVERSE_AS

