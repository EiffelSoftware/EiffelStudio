note
	description: "Summary description for {ESA_CJ_CHANGE_EMAIL_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_CHANGE_EMAIL
inherit

	TEMPLATE_CHANGE_EMAIL
		rename
			make as make_template
		end
create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY; a_view: ESA_EMAIL_VIEW)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_change_email.tpl")
				-- Set path to CJ
			set_template_folder (cj_path)
				-- Build common template
			make_template (a_host, a_user, a_view, "cj_change_email.tpl")
				-- Process current template
			process
		end
end

