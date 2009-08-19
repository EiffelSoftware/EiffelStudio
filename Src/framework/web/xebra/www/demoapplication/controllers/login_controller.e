note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_CONTROLLER

inherit
	DEMOAPPLICATION_CONTROLLER

create
	default_create

feature -- Status Change

	logout (a_bean: detachable ANY)
			-- Removes the user from the session
		do
			session.remove ("auth")
		end

	login_with_bean (a_login: LOGIN_BEAN)
			-- Tries to log in with the information provided by `a_login'
		do
			if attached {USER} global_state.db.valid_login (a_login.name, a_login.password) as user then
				session.put (user, "auth")
			end
		end
end
