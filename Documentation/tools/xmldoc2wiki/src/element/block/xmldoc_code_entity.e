indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_CODE_ENTITY

inherit
	XMLDOC_CODE_ENTITY_KIND

	XMLDOC_ITEM
		redefine
			process_visitor
		end

	XMLDOC_WITH_CONTENT
		rename
			make as make_content
		redefine
			valid_item
		end

--	XMLDOC_WITH_TEXT

create
	make

feature {NONE} -- Initialization

	make (a_kind: STRING)
			-- Initialize `Current'.
		require
			a_kind_valid: a_kind /= Void and then not a_kind.is_empty and then a_kind.as_lower.is_equal (a_kind)
		do
			kind := a_kind
			make_content
		end

feature -- Access

	kind: STRING
			-- Kind of code entity

	valid_item (i: XMLDOC_ITEM): BOOLEAN
			-- is_text_or_container
		do
			Result := ({ot_t: XMLDOC_TEXT} i) or ({ot_e: XMLDOC_CODE_ENTITY_KIND} i) or ({ot_l: XMLDOC_LINK} i)
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_code_entity (Current)
		end

end
