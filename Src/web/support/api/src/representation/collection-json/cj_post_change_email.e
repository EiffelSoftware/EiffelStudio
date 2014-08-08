note
	description: "Summary description for {ESA_CJ_POST_CHANGE_EMAIL_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_POST_CHANGE_EMAIL

inherit

	TEMPLATE_USER_HOST
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_post_change_email.tpl")
				-- Set template to CJ
			set_template_folder (CJ_path)
				-- Build common template
			make_template (a_host, a_user, "cj_post_change_email.tpl")
				-- Process current template
			process
		end

end
