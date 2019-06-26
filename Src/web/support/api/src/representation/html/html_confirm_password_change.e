note
	description: "Summary description for {HTML_CONFIRM_PASSWORD_CHANGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_CONFIRM_PASSWORD_CHANGE

inherit

	TEMPLATE_CHANGE_PASSWORD
		rename
			make as make_template
		end

create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY; a_view: ESA_PASSWORD_RESET_VIEW;)
			-- Initialize `Current'.
		do
			debug
				log.write_information (generator + ".make render template: confirm_change_password.tpl")
			end
				-- Set folder to HTML
			set_template_folder (html_path)
				-- Build common template

			make_template (a_host, a_user, a_view, "confirm_change_password.tpl")
			if attached a_view.token as l_token then
				template.add_value (l_token, "token")
			end
				-- Custom fields
			if attached a_view.errors then
				template.add_value ("True", "has_error")
				template.add_value (a_view, "form")
			end
				-- Process current template
			process
		end

end
