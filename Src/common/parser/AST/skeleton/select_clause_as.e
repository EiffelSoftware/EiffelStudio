indexing
	description: "Object that represents a select inherit clause"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SELECT_CLAUSE_AS

inherit
	INHERIT_CLAUSE_AS [EIFFEL_LIST [FEATURE_NAME]]
		rename
			clause_keyword as select_keyword
		end

create
	make

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_select_clause_as (Current)
		end

end
