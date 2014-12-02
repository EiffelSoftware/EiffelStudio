note
	description: "Wiki text from string content."
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_CONTENT_TEXT

inherit
	WIKI_TEXT

create
	make_from_string

feature -- Initialization	

	make_from_string (a_content: READABLE_STRING_8)
		do
			content := a_content
			internal_structure := Void
		end

feature -- Access

	content: READABLE_STRING_8

	structure: WIKI_STRUCTURE
			-- Associated wiki structure.
		local
			l_internal_structure: detachable WIKI_STRUCTURE
		do
			l_internal_structure := internal_structure
			if l_internal_structure = Void then
				create l_internal_structure.make (content)
				internal_structure := l_internal_structure
			end
			Result := l_internal_structure
		end

feature {NONE} -- Implementation

	internal_structure: detachable like structure
			-- Internal structure value.

invariant

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
