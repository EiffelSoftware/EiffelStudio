note
	description: "Summary description for {WIKI_PAGE_TITLE_NORMALIZER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIKI_PAGE_TITLE_NORMALIZER

feature -- Update

	normalized_title (a_title: READABLE_STRING_GENERAL): STRING_32
			-- Normalize `a_title` into `Result`.
			-- i.e: remove space, and any character that may cause trouble in url or path.
		deferred
		end

note
	copyright: "2011-2018, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
