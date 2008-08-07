indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XMLDOC_WITH_CONTENT

feature {NONE} -- Initialization

	make
		do
			create {ARRAYED_LIST [XMLDOC_ITEM]} items.make (10)
		end

feature -- Access

	items: LIST [XMLDOC_ITEM]
			-- Contained items

feature -- Status report

	is_empty: BOOLEAN
		do
			Result := items.is_empty
		end

	valid_item (i: XMLDOC_ITEM): BOOLEAN
			-- Is `i' a valid item for `items'?
		do
			if {unused: XMLDOC_UNUSED} i then
				Result := False
			else
				Result := i /= Void
			end
		end

feature -- Element change

	set_content (c: XMLDOC_COMPOSITE_TEXT)
		require
			c_attached: c /= Void
		do
			c.items.do_all (agent add_item)
		end

	add_item (i: XMLDOC_ITEM)
			-- Add item `i' to `items'
		require
			valid_item: valid_item (i)
		do
			if {t: XMLDOC_TEXT} i and then t.is_empty then
			else
				items.extend (i)
			end
		end

end
