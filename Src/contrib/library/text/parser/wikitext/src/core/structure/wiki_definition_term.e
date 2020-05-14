note
	description: "Summary description for {WIKI_DEFINITION_TERM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_DEFINITION_TERM

inherit
	WIKI_LIST_ITEM
		redefine
			make_item
		end

create
	make_item

feature {NONE} -- Initialization

	make_item (a_description: READABLE_STRING_8; s: READABLE_STRING_8)
		local
			p: INTEGER
		do
			Precursor (a_description, s)
			p := s.index_of (':', 1)
			if p > 0 then
				create text.make (s.substring (1, p - 1))
				create definition_description.make_item (expected_parent_description + ":", s.substring (p + 1, s.count))
			end
		end

feature -- Access

	definition_description: detachable WIKI_DEFINITION_DESCRIPTION

feature {NONE} -- Implementation

	factory: WIKI_LIST_FACTORY
		once
			create Result
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
