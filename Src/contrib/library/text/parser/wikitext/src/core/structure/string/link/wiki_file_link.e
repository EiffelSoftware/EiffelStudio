note
	description: "[
		Summary description for {WIKI_FILE_LINK}.
		
		could be ..
		[[File:doc.pdf|This is a pdf file]]
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_FILE_LINK

inherit
	WIKI_LINK
		redefine
			make,
			process
		end

create
	make,
	make_inlined

feature {NONE} -- Initialization

	make_inlined (s: READABLE_STRING_8)
			-- [[File:title|string]]
		do
			make (s)
			set_inlined (True)
		end

	make (s: READABLE_STRING_8)
			-- [[File:title|string]]
		local
			t: STRING
		do
			Precursor (s)
			t := name
			if t.as_lower.starts_with ("file:") then
				name := t.substring (("file:").count + 1, t.count)
			end
			set_inlined (False)
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_file_link (Current)
		end

note
	copyright: "2011-2015, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
