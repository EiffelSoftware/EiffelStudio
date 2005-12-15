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
	make

feature -- Initialization

	make (a: like assertions; k_as: KEYWORD_AS) is
			-- Create new REQUIRE AST node.
		do
			initialize (a)
			require_keyword := k_as
		ensure
			require_keyword_set: require_keyword = k_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_require_as (Current)
		end

feature -- Roundtrip

	require_keyword: KEYWORD_AS
		-- Keyword "require" accosiated with this structure.

feature -- Properties

	is_else: BOOLEAN is
			-- Is the assertion list a require else ?
		do
			-- Do nothing
		end

end -- class REQUIRE_AS
