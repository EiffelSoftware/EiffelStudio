indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_CODE_ENTITY

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	XMLDOC_WITH_TEXT

create
	make

feature {NONE} -- Initialization

	make (a_kind: STRING)
			-- Initialize `Current'.
		require
			a_kind_valid: a_kind /= Void and then not a_kind.is_empty and then a_kind.as_lower.is_equal (a_kind)
		do
			kind := a_kind
		end

feature -- Access

	kind: STRING
			-- Kind of code entity

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_code_entity (Current)
		end

end
