note
	description: "Summary description for {WIKI_STRING_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_STRING_LIST

inherit
	WIKI_COMPOSITE [WIKI_STRING_ITEM]

create
	make

feature {NONE} -- Initialization

	make
		do
			initialize
		end

feature -- Element change

	add_raw_string (s: STRING)
		do
			add_element (create {WIKI_RAW_STRING}.make (s))
		end

note
	copyright: "2011-2013, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
