note
	description: "Summary description for {WIKI_ITEM_WITH_PARENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_ITEM_WITH_PARENT [G -> WIKI_ITEM]

feature -- Access

	parent: detachable WIKI_COMPOSITE [WIKI_ITEM]

feature -- Element change

	set_parent (p: like parent)
		do
			parent := p
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
