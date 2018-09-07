note
	description: "Summary description for {GITHUB_REPOSITORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GITHUB_REPOSITORY

inherit
	DEBUG_OUTPUT
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
			if attached {JSON_STRING} j.item ("name") as js then
				name := js.item
			end
			if attached {JSON_STRING} j.item ("full_name") as js then
				full_name := js.item
			end
			if attached {JSON_STRING} j.item ("description") as js then
				description := js.item
			end
			if attached {JSON_BOOLEAN} j.item ("private") as jb then
				is_private := jb.item
			end
			if attached {JSON_BOOLEAN} j.item ("fork") as jb then
				is_fork := jb.item
			end
			if attached {JSON_STRING} j.item ("url") as js then
				url := js.item
			end
			if attached {JSON_STRING} j.item ("html_url") as js then
				html_url := js.item
			end
			if attached {JSON_OBJECT} j.item ("owner") as jo then
				create owner.make_from_json_object (jo)
			end
		end

feature -- Access

	id: detachable READABLE_STRING_8
	owner: detachable GITHUB_USER
	name: detachable READABLE_STRING_8
	full_name: detachable READABLE_STRING_8
	description: detachable READABLE_STRING_8
	is_private: BOOLEAN
	is_fork: BOOLEAN
	url: detachable READABLE_STRING_8
	html_url: detachable READABLE_STRING_8

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_empty
			if attached full_name as fn then
				Result.append (fn)
			end
			if attached description as d then
				Result.append (" : ")
				Result.append (d)
			end
		end

note
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
