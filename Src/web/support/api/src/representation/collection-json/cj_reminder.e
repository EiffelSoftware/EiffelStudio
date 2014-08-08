note
	description: "Summary description for {ESA_CJ_REMINDER_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_REMINDER

inherit

	TEMPLATE_REMINDER
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_error: detachable STRING)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_reminder.tpl")
				-- Set template CJ
			set_template_folder (cj_path)
				-- Build common template
			make_template (a_host, a_error, "cj_reminder.tpl")
				-- Process current template
			process
		end
end
