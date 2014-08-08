note
	description: "Summary description for {ESA_CJ_POST_REMINDER_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_POST_REMINDER

inherit

	TEMPLATE_POST_REMINDER
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_email: detachable STRING)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_post_reminder.tpl")
				-- Set folder to CJ	
			set_template_folder (cj_path)
				-- Build common template
			make_template (a_host, a_email, "cj_post_reminder.tpl" )
				-- Process current template
			process
		end
end
