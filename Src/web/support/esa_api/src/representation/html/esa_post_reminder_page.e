note
	description: "Summary description for {ESA_POST_REMINDER_PAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_POST_REMINDER_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_email: detachable STRING)
			-- Initialize `Current'.
		do
			set_template_folder (html_path)
			set_template_file_name ("post_reminder.tpl")
			template.add_value (a_host, "host")

			if attached a_email then
				template.add_value (a_email, "email")
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



