note
	description: "Summary description for {ESA_HTML_REGISTER_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_REGISTER

inherit

	TEMPLATE_REGISTER
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_REGISTER_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: register.tpl")
				-- Set folder to HTML
			set_template_folder (html_path)

				-- Build template
			make_template (a_host, a_form, a_user, "register.tpl")

			if attached a_form.errors then
				template.add_value (True, "has_error")

			end

				-- Process the current template
			process
		end

end


