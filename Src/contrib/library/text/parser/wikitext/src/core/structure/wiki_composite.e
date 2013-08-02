note
	description: "Summary description for {WIKI_COMPOSITE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIKI_COMPOSITE [G -> WIKI_ITEM]

inherit
	WIKI_ITEM

feature {NONE} -- Initialization

	initialize
		do
			create elements.make (5)
		end

feature -- Access

	elements: ARRAYED_LIST [G]

	count: INTEGER
		do
			Result := elements.count
		end

feature -- Status report

	valid_element (e: G): BOOLEAN
		do
			Result := True
		end

feature -- Element change

	add_element (e: G)
		require
			valid_element: valid_element (e)
		do
			elements.extend (e)
			if attached {WIKI_ITEM_WITH_PARENT [G]} e as l_parentable then
				l_parentable.set_parent (Current)
			end
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_composite (Current)
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
