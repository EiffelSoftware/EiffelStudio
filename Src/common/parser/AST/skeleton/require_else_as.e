indexing
	description: "AST represenation of a require else construct."
	date: "$Date$"
	revision: "$Revision $"

class
	REQUIRE_ELSE_AS

inherit
	REQUIRE_AS
		redefine
			is_else,
			process
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_require_else_as (Current)
		end

feature -- Properties

	is_else: BOOLEAN is True
			-- Is the assertion list a require else ?

end -- class REQUIRE_ELSE_AS
