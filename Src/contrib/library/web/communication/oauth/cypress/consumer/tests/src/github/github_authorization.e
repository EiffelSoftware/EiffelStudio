note
	description: "Summary description for {GITHUB_AUTHORIZATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GITHUB_AUTHORIZATION

inherit
	DEBUG_OUTPUT

create
	make_from_json_object,
	make_from_json,
	make

feature {NONE} -- Initialization

	make (tok: READABLE_STRING_8)
		do
			token := tok
			create {ARRAYED_LIST [READABLE_STRING_8]} scopes.make (0)
		end

	make_from_json (s: READABLE_STRING_8)
		local
			p: JSON_PARSER
		do
			create {ARRAYED_LIST [READABLE_STRING_8]} scopes.make (0)
			create p.make_parser (s)
			if attached {JSON_OBJECT} p.parse as j then
				make_from_json_object (j)
			end
		end

	make_from_json_object (j: JSON_OBJECT)
		local
			p: JSON_PARSER
		do
			create {ARRAYED_LIST [READABLE_STRING_8]} scopes.make (0)
			if attached {JSON_STRING} j.item ("token") as js then
				token := js.item
			end
			if attached {JSON_NUMBER} j.item ("id") as js then
				id := js.item
			end
			if attached {JSON_STRING} j.item ("url") as js then
				url := js.item
			end
			if attached {JSON_ARRAY} j.item ("scopes") as jarr then
				across
					jarr.array_representation as c
				loop
					if attached {JSON_STRING} c.item as js then
						scopes.force (js.item)
					end
				end
			end
			if attached {JSON_OBJECT} j.item ("app") as japp then
				if attached {JSON_STRING} japp.item ("name") as js then
					app_name := js.item
				end
			end
		end

feature -- Access

	token: detachable READABLE_STRING_8
	id: detachable READABLE_STRING_8
	url: detachable READABLE_STRING_8
	scopes: LIST [READABLE_STRING_8]

	app_name: detachable READABLE_STRING_8

feature -- Status report

	debug_output: READABLE_STRING_GENERAL
			-- String that should be displayed in debugger to represent `Current'.
		local
			s: STRING
		do
			if attached app_name as n then
				create s.make_from_string (n)
			else
				create s.make_empty
			end
			if not scopes.is_empty then
				s.append_character (' ')
				s.append_character ('(')
				s.append_character (' ')
				across
					scopes as c
				loop
					s.append (c.item)
					s.append (" ")
				end
				s.append_character (')')
			end
			if attached token as t then
				s.append_character (' ')
				s.append (t)
			end
			Result := s
		end


note
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
