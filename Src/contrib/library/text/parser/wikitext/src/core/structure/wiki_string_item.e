note
	description: "Summary description for {WIKI_STRING_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	WIKI_STRING_ITEM

inherit
	WIKI_ITEM

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		deferred
		end

	is_whitespace: BOOLEAN
			-- Is empty or blank text?
		do
				--| Redefined where a string item may be whitespace.
			Result := False
		end

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
