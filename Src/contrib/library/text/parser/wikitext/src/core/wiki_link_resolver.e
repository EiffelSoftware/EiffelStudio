note
	description: "Summary description for {WIKI_LINK_RESOLVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIKI_LINK_RESOLVER

inherit
	WIKI_ITEM_RESOLVER

feature -- Access

	wiki_url (a_link: WIKI_LINK; a_page: detachable WIKI_PAGE): detachable STRING
			-- URL accessing the wiki link `a_link' in the context of `a_page'.
		deferred
		end

	missing_wiki_url (a_link: WIKI_LINK; a_page: detachable WIKI_PAGE): detachable STRING
			-- URL accessing the missing wiki link `a_link' in the context of `a_page'.
		do
			create Result.make_from_string (a_link.name)
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
