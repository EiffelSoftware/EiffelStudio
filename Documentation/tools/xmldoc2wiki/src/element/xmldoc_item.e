indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_ITEM

feature -- Access

	is_block: BOOLEAN
		do
			Result := {a: XMLDOC_BLOCK_I} Current
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		require
			v_attached: v /= Void
		do
			v.process_item (Current)
		end

end
