note
	description: "Summary description for {ESA_CONFIRM_EMAIL_CHANGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_CONFIRM_EMAIL_CHANGE

inherit

	TEMPLATE_CONFIRM_EMAIL_CHANGE
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY; a_view: ESA_EMAIL_VIEW)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: confirm_change_email.tpl")
				-- Set folder to HTML
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, a_user, a_view, "confirm_change_email.tpl")
				-- Custom fields
			if attached a_view.errors then
				template.add_value ("True", "has_error")
				template.add_value (a_view, "form")
			end
				-- Process current template
			process
		end

end
