note
	description: "Summary description for {SVN_ENGINE_OPTIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SVN_ENGINE_OPTIONS

feature -- Access

	username: detachable STRING

	password: detachable STRING

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


end
