note
	description: "Summary description for {ESA_CJ_ACCOUNT_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_ACCOUNT

inherit

	TEMPLATE_ACCOUNT
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_account: ESA_ACCOUNT_VIEW)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_account.tpl")
				-- Set path to CJ.
			set_template_folder (cj_path)
				-- Build common template
			make_template (a_host, a_account, "cj_account.tpl")
				-- Process current template.
			process
		end

end
