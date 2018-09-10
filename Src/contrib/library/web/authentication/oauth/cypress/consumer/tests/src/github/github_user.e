note
	description: "Summary description for {GITHUB_USER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GITHUB_USER
inherit
	JSON_PARSER_ACCESS

create
	make_from_json_object,
	make_from_json

feature {NONE} -- Initialization

	make_from_json (s: READABLE_STRING_8)
		local
			p: JSON_PARSER
		do
			create p.make_with_string (s)
			if attached {JSON_OBJECT} p.next_parsed_json_value as j and then p.is_valid then
				make_from_json_object (j)
			end
		end

	make_from_json_object (j: JSON_OBJECT)
		do
			if attached {JSON_NUMBER} j.item ("id") as js then
				id := js.item
			end
			if attached {JSON_STRING} j.item ("login") as js then
				login := js.item
			end
			if attached {JSON_STRING} j.item ("url") as js then
				url := js.item
			end
		end

feature -- Access

	id: detachable READABLE_STRING_8
	login: detachable READABLE_STRING_8
	url: detachable READABLE_STRING_8

;note
	copyright: "2013-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
