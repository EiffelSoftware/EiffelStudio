note
	description: "Summary description for {ESA_HTML_400_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_HTML_400_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make,
	make_with_errors

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: 400.tpl")
			set_template_folder (html_path)
			set_template_file_name ("400.tpl")
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


	make_with_errors (a_host: READABLE_STRING_GENERAL; a_errors: STRING_TABLE[READABLE_STRING_32])
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make_with_errors render template: 400.tpl")
			set_template_folder (html_path)
			set_template_file_name ("400.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_errors, "errors")
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
