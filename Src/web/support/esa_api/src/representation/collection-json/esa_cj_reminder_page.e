note
	description: "Summary description for {ESA_CJ_REMINDER_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_REMINDER_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_error: detachable STRING)
			-- Initialize `Current'.
		do
			set_template_folder (cj_path)
			set_template_file_name ("cj_reminder.tpl")
			template.add_value (a_host, "host")
			if attached a_error then
				template.add_value (a_error, "error")
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
