note
	description: "Summary description for {ESA_HTML_REGISTER_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_HTML_REGISTER_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_REGISTER_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: register.tpl")
			set_template_folder (html_path)
			set_template_file_name ("register.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_form.questions, "questions")

			if attached a_form.errors then
				template.add_value (True, "has_error")
				template.add_value (a_form, "form")
			end

			if attached a_user then
				template.add_value (a_user, "user")
			end

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				debug
					log.write_debug (generator + ".make " + l_output)
				end
			end
		end

end


