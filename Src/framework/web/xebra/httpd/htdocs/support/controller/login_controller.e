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

	logged_in: BOOLEAN 
		-- Is the user logged in?

feature -- Access

	is_logged_in: BOOLEAN
			-- Is a user logged in?
		do
			-- TODO
			Result := logged_in
		end
		
	is_not_logged_in: BOOLEAN
			-- Is a user not logged in?
		do
			Result := not is_logged_in
		end

	login
		do
			logged_in := True
		end

	logout
		do
			logged_in := False
		end

	user_name: STRING
		do
			Result := "Sandro"
		end

end
