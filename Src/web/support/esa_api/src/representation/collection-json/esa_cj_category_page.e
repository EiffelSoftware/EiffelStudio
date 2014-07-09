note
	description: "Summary description for {ESA_CJ_CATEGORY_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_CATEGORY_PAGE


inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_list: LIST[ESA_REPORT_CATEGORY]; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_category.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("cj_category.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_list, "categories")
			if attached a_user then
				template.add_value (a_user, "user")
			end
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				l_output.replace_substring_all ("<", "{")
				l_output.replace_substring_all (">", "}")
				l_output.replace_substring_all ("},]", "}]")

				representation := l_output
				debug
					log.write_debug (generator + ".make " + l_output )
				end
			end
		end
end
