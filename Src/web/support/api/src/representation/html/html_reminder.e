note
	description: "Summary description for {ESA_REMINDER_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_REMINDER

inherit

	TEMPLATE_REMINDER
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_error: detachable READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			debug
				log.write_information (generator + ".make render template: reminder.tpl")
			end
				-- Set folder to HTML
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, a_error, "reminder.tpl")
				-- Process current template
			process
		end

end
