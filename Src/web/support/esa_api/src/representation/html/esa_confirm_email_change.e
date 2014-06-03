note
	description: "Summary description for {ESA_CONFIRM_EMAIL_CHANGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CONFIRM_EMAIL_CHANGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY; a_view: ESA_EMAIL_VIEW)
			-- Initialize `Current'.
		do
			set_template_folder (html_path)
			set_template_file_name ("confirm_change_email.tpl")
			template.add_value (a_host, "host")
			if attached a_user then
				template.add_value (a_user, "user")
			end
			if attached a_view.errors then
				template.add_value ("True", "has_error")
				template.add_value (a_view, "form")
			end
			if attached a_view.token as l_token then
				template.add_value (l_token, "token")
			end
			if attached a_view.email as l_email then
				template.add_value (l_email, "email")
			end

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				debug
					print (representation)
				end
			end
		end

end
