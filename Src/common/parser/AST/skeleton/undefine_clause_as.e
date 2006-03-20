indexing
	description: "Object that represents a undefine inherit clause"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNDEFINE_CLAUSE_AS

inherit
	INHERIT_CLAUSE_AS [EIFFEL_LIST [FEATURE_NAME]]
		rename
			clause_keyword as undefine_keyword
		end

create
	make

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_undefine_clause_as (Current)
		end

end
