note
	description: "Summary description for {WIKI_BOX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIKI_BOX [G -> WIKI_ITEM]

inherit
	WIKI_COMPOSITE [G]

	WIKI_ITEM_WITH_PARENT [G]


--feature -- Visitor

--	process (a_visitor: WIKI_VISITOR)
--		do
--			a_visitor.process_box (Current)
--		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
