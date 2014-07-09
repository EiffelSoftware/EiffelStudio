note
	description: "Summary description for {ESA_HTML_POST_REGISTER_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_HTML_POST_REGISTER_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: post_register_page.tpl")
			set_template_folder (html_path)
			set_template_file_name ("post_register_page.tpl")
			template.add_value (a_host, "host")
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
