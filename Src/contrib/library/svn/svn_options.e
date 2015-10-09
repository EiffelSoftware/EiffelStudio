note
	description: "Summary description for {SVN_OPTIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_OPTIONS

feature -- Access

	username: detachable STRING_32

	password: detachable STRING_32

	parameters: detachable READABLE_STRING_32

	auth_cached: BOOLEAN

feature -- Element change

	set_username (u: like username)
		do
			username := u
		end

	set_password (p: like password)
		do
			password := p
		end

	set_parameters (a_params: detachable READABLE_STRING_GENERAL)
		do
			if a_params = Void then
				parameters := Void
			else
				create {STRING_32} parameters.make_from_string_general (a_params)
			end
		end


note
	copyright: "Copyright (c) 2003-2015, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
