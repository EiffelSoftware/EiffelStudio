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
	make
	
feature {NONE} -- Access

feature -- Access

	is_logged_in: BOOLEAN
			-- Is a user logged in?
		do
			Result := attached current_session and then attached current_session.get (authentication_key)
		end
		
	is_not_logged_in: BOOLEAN
			-- Is a user not logged in?
		do
			Result := not is_logged_in
		end

	login
		do
			--if attached {USER} global_state.db.valid_login (a_login.name, a_login.password) as user then
				--if attached current_session as session then
					--session.put (user, "auth")
				--end
			--end
			current_session.put ("user", authentication_key)
		end

	logout
		do
			current_session.remove (authentication_key)
		end

	user_name: STRING
		do
			Result := "UserTodo"
		end

feature -- Constants

	authentication_key: STRING = "auth"

end
