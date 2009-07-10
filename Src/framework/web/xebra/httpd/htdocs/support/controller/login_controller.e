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

feature -- Access

	logged_in: BOOLEAN
			-- Is a user logged in?
		do
			-- TODO
			Result := True
		end

	user_name: STRING
		do
			Result := "Sandro"
		end

end
