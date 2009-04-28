note
	description: "Summary description for {LOGIN_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_CONTROLLER

inherit
	DEMOAPPLICATION_CONTROLLER

create
	make

feature -- Status Change

	logout
			-- Removes the user from the session
		do
			if attached current_session as session  then
					session.remove ("auth")
				end
		end

	login: STRING
			-- Adds the user to the session
		do
			Result := ""

			if attached current_request.arguments["name"] as name and then attached current_request.arguments["password"] as password then
				if attached {USER} global_state.db.valid_login (name, password) as user then
					if attached current_session as session  then
						session.put (user, "auth")
						Result := "Successfully logged in."
					end

				else
					Result := "Invalid username/password"
				end
			else
				Result := ""
			end
		end

end
