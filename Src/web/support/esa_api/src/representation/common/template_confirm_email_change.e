note
	description: "Confirm email change template page, with common propertes to CJ and HTML"
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_CONFIRM_EMAIL_CHANGE

inherit

	TEMPLATE_USER_HOST
		rename
			make as make_user_host
		end
create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY; a_view: ESA_EMAIL_VIEW; a_template: READABLE_STRING_32)
			-- Initialize `Current'.
		do
			make_user_host (a_host, a_user, a_template)
			if attached a_view.token as l_token then
				template.add_value (l_token, "token")
			end
			if attached a_view.email as l_email then
				template.add_value (l_email, "email")
			end
		end

end
