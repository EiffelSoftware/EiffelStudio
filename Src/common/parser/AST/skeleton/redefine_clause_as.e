indexing
	description: "Object that represents a redefine inherit clause"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REDEFINE_CLAUSE_AS

inherit
	INHERIT_CLAUSE_AS [EIFFEL_LIST [FEATURE_NAME]]
		rename
			clause_keyword as redefine_keyword
		end

create
	make

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_redefine_clause_as (Current)
		end

end
