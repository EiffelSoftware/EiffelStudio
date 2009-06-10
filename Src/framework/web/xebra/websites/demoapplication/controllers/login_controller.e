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

	logout (a_bean: ANY)
			-- Removes the user from the session
		do
			if attached current_session as session  then
					session.remove ("auth")
					--Result := "/demoapplication/logout.xeb"
			end
		end

	login: STRING
			-- Adds the user to the session
		local
			l_user: detachable USER
		do
			Result := ""
			if attached current_request.arguments["name"] as name and then attached current_request.arguments["password"] as password then
				l_user := global_state.db.valid_login (name, password)
				if attached l_user as user then
--				if attached {USER} global_state.db.valid_login (name, password) as user then
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
		ensure
			Result_attached: Result /= Void
		end

	login_with_bean (a_login: LOGIN_BEAN)
			-- Tries to log in with the information provided by `a_login'
		do
			print ("%NTRY TO LOGIN WITH: " + a_login.out)
			if attached {USER} global_state.db.valid_login (a_login.name, a_login.password) as user then
				if attached current_session as session then
					session.put (user, "auth")
				end
			--Result := "/demoapplication/home.xeb"
			--else
			--	Result := "/demoapplication/login.xeb"
			end

		end

end
