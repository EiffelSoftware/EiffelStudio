indexing
	description	: "AST representation of an `ensure' structure."
	date		: "$Date$"
	revision	: "$Revision$"

class ENSURE_AS

inherit
	ASSERT_LIST_AS
		redefine 
			process
		end

create
	initialize

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_ensure_as (Current)
		end

feature -- Properties

	is_then: BOOLEAN is
			-- Is the assertion list an ensure then part ?
		do
			-- Do nothing
		end

end -- class ENSURE_AS
