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


note
	copyright: "Copyright (c) 2003-2015, Jocelyn Fiat"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Jocelyn Fiat
			 Contact: jocelyn@eiffelsolution.com
			 Website http://www.eiffelsolution.com/
		]"
end
