note
	description: "Summary description for {ESA_CHANGE_PASSWORD_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_CHANGE_PASSWORD

inherit

	TEMPLATE_PASSWORD
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY; a_view: ESA_PASSWORD_VIEW)
			-- Initialize `Current'.
		do

			log.write_information (generator + ".make render template: change_password.tpl")
				-- Set folder to HTML
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, a_user, "change_password.tpl")

			if attached a_view.errors then
				template.add_value ("True", "has_error")
				template.add_value (a_view, "form")
			end

				-- Process the current template
			process
		end

end
