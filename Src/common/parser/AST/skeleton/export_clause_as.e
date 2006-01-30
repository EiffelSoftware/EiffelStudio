indexing
	description: "Object that represents an export inherit clause"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EXPORT_CLAUSE_AS

inherit
	INHERIT_CLAUSE_AS
		rename
			clause_keyword as export_keyword
		redefine
			content
		end

create
	make

feature -- Visitor

	process (v: AST_VISITOR) is
			-- Visitor feature.
		do
			v.process_export_clause_as (Current)
		end

feature -- Clause content

	content: EIFFEL_LIST [EXPORT_ITEM_AS]
			-- Content of Current export clause

end
