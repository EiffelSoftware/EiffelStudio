indexing
	description: "AST represenation of a require else construct."
	date: "$Date$"
	revision: "$Revision$"

class REQUIRE_ELSE_AS

inherit
	REQUIRE_AS
		rename
			make as require_make
		redefine
			process,
			is_else
		end

create
	make

feature -- Initialization

	make (a: like assertions; k_as, l_as: KEYWORD_AS) is
			-- Create new REQUIRE AST node.
		do
			require_make (a, k_as)
			else_keyword := l_as
		ensure
			else_keyword_set: else_keyword = l_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_require_else_as (Current)
		end

feature -- Roundtrip

	else_keyword: KEYWORD_AS
			-- Keyword "else" associated with this structure

feature -- Properties

	is_else: BOOLEAN is True
			-- Is the assertion list a require else?

end -- class REQUIRE_ELSE_AS
