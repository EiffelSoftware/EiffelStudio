note
	description: "Summary description for {ESA_CJ_POST_REMINDER_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_POST_REMINDER_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_email: detachable STRING)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_post_reminder.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("cj_post_reminder.tpl")
			template.add_value (a_host, "host")
			if attached a_email then
				template.add_value (a_email, "email")
			end

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				l_output.replace_substring_all ("<", "{")
				l_output.replace_substring_all (">", "}")
				representation := l_output
				debug
					log.write_information (generator + ".make " + l_output)
				end
			end
		end
end
