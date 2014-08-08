note
	description: "Summary description for {ESA_CJ_CONFIRMATION_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_CONFIRMATION

inherit

	TEMPLATE_CONFIRMATION
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_confirmation.tpl")
				-- Set folder to CJ
			set_template_folder (cj_path)
				-- Build common template
			make_template (a_host, a_user, "cj_confirmation.tpl")
				-- Process current template
			process
		end
end
