note
	description: "Template class to generate an CJ API root"
	date: "$Date$"
	revision: "$Revision$"


class
	ESA_CJ_ROOT_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make, make_with_error

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: collection_json.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("collection_json.tpl")
			template.add_value (a_host, "host")
			if attached a_user  then
				template.add_value (a_user, "user")
			end
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				l_output.replace_substring_all ("<", "{")
				l_output.replace_substring_all (">", "}")
				representation := l_output
				debug
					log.write_debug (generator + ".make" + l_output)
				end
			end
		end

	make_with_error (a_host: READABLE_STRING_GENERAL; a_error: READABLE_STRING_GENERAL; a_code: INTEGER; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make_with_error render template: collection_json_error.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("collection_json_error.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_error, "error")
			template.add_value (a_code, "code")
			if attached a_user then
				template.add_value (a_user, "user")
			end
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				l_output.replace_substring_all ("<", "{")
				l_output.replace_substring_all (">", "}")
				representation := l_output
				debug
					log.write_debug (generator + ".make " + l_output)
				end
			end
		end
end
