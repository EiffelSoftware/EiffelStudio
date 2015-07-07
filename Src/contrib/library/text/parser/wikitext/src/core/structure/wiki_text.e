note
	description: "Interface representing the wikitext source code."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIKI_TEXT

inherit
	ITERABLE [WIKI_ITEM] -- related to wiki structure

feature -- Access

	new_cursor: ITERATION_CURSOR [WIKI_ITEM]
			-- Fresh cursor associated with current structure
		do
			Result := structure.new_cursor
		end

feature -- Access

	content: detachable READABLE_STRING_8
			-- Content of the wiki text
			-- if exists and convertible to string.
		deferred
		end

	structure: WIKI_STRUCTURE
		deferred
		end

note
	copyright: "2011-2015, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
