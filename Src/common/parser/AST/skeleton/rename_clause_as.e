indexing
	description: "Object that represents a rename inherit clause"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RENAME_CLAUSE_AS

inherit
	INHERIT_CLAUSE_AS
		rename
			clause_keyword as rename_keyword
		redefine
			content
		end

create
	make

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_rename_clause_as (Current)
		end

feature -- Clause content

	content: EIFFEL_LIST [RENAME_AS]
			-- Content of Current rename clause

end
