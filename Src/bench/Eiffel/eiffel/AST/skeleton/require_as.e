indexing
	description	: "AST representation of a require statement."
	date		: "$Date$"
	revision	: "$Revision$"

class REQUIRE_AS

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
			v.process_require_as (Current)
		end

feature -- Properties

	is_else: BOOLEAN is
			-- Is the assertion list a require else ?
		do
			-- Do nothing
		end

end -- class REQUIRE_AS
