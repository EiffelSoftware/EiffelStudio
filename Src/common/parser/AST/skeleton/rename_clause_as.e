indexing
	description: "Object that represents a rename inherit clause"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RENAME_CLAUSE_AS

inherit
	INHERIT_CLAUSE_AS [EIFFEL_LIST [RENAME_AS]]
		rename
			clause_keyword as rename_keyword
		end

create
	make

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_rename_clause_as (Current)
		end

end
