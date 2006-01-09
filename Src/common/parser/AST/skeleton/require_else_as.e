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
			is_else, complete_end_location
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

feature -- Roundtrip/Location

	complete_end_location (a_list: LEAF_AS_LIST): LOCATION_AS is
		do
			if a_list = Void then
				if assertions /= Void then
					Result := assertions.complete_end_location (a_list)
				else
					Result := null_location
				end
			else
				if full_assertion_list /= Void then
					Result := full_assertion_list.complete_end_location (a_list)
				else
					Result := else_keyword.complete_end_location (a_list)
				end
			end
		end

end -- class REQUIRE_ELSE_AS
