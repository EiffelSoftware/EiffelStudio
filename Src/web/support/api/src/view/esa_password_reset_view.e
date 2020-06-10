note
	description: "Summary description for {ESA_PASSWORD_RESET_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_PASSWORD_RESET_VIEW

inherit

	ESA_PASSWORD_VIEW

feature -- Access

	token: detachable STRING_32

feature -- Change Element

	set_token (a_token: like token)
			-- Set 'token' with 'a_token'.
		do
			token := a_token
		end

end
