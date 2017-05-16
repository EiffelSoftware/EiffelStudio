note
	description: "Summary description for {TEMPLATE_CHANGE_PASSWORD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_CHANGE_PASSWORD

inherit

	TEMPLATE_USER_HOST
		rename
			make as make_user_host
		end

create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY; a_view: ESA_PASSWORD_RESET_VIEW; a_template: READABLE_STRING_32)
			-- Initialize `Current'.
		do
			make_user_host (a_host, a_user, a_template)
			if attached a_view.errors then
				template.add_value ("True", "has_error")
				template.add_value (a_view, "form")
			end
		end

end
