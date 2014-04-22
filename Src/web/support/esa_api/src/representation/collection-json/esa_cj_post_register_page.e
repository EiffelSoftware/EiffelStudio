note
	description: "Summary description for {ESA_CJ_POST_REGISTER_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_POST_REGISTER_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY)
			-- Initialize `Current'.
		local
			l_item: STRING
			l_report: ESA_REPORT
		do
			set_template_folder (cj_path)
			set_template_file_name ("cj_post_register.tpl")
			template.add_value (a_host, "host")
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
					print ("%N===========%N" + l_output)
				end
			end
		end
end
