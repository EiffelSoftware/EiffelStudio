note
	description: "Summary description for {ESA_HTML_401_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_HTML_401_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make, make_with_redirect

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: 401.tpl")
			set_template_folder (html_path)
			set_template_file_name ("401.tpl")
			template.add_value (a_host, "host")
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


	make_with_redirect (a_host: READABLE_STRING_GENERAL; a_redirect: READABLE_STRING_GENERAL; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: 401.tpl")
			set_template_folder (html_path)
			set_template_file_name ("401.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_redirect, "redirect")
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
