note
	description: "Summary description for {LOGIN_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_CONTROLLER

inherit
	XWA_CONTROLLER

create
	default_create

feature {NONE} -- Access

feature -- Access

	is_logged_in: BOOLEAN
			-- Is a user logged in?
		do
			Result := attached session as l_current and then attached l_current.get (authentication_key)
		end

	is_not_logged_in: BOOLEAN
			-- Is a user not logged in?
		do
			Result := not is_logged_in
		end

	login
		do
			if attached session as l_current then
				l_current.put ("user", authentication_key)
			end
		end

	logout
		do
			if attached session as l_current then
				l_current.remove (authentication_key)
			end
		end

	user_name: STRING
		do
			Result := "UserTodo"
		end

feature -- Constants

	authentication_key: STRING = "auth"

end
