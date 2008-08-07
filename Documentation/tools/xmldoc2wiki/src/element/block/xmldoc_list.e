indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XMLDOC_LIST

inherit
	XMLDOC_ITEM
		redefine
			process_visitor
		end

	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			create {ARRAYED_LIST [XMLDOC_LIST_ITEM]} items.make (5)
		end

feature -- Access

	items: LIST [XMLDOC_LIST_ITEM]
			-- Contained items

	ordered: BOOLEAN
			-- Is ordered?

feature -- Element change

	add_item (i: XMLDOC_LIST_ITEM)
			-- Add item `i' to `items'
		require
			i_attached: i /= Void
		do
			items.extend (i)
		end

	set_ordered (v: BOOLEAN) is
			-- Set `ordered' to `v'
		do
			ordered := v
		end

feature {XMLDOC_VISITOR} -- Visitor

	process_visitor (v: XMLDOC_VISITOR)
		do
			v.process_list (Current)
		end

feature -- Status report

	debug_output: STRING is
		do
			Result := "List: " + items.count.out + " item(s)"
		end

end
