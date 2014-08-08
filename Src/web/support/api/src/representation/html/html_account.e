note
	description: "Summary description for {ESA_ACCOUNT_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_ACCOUNT
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
			log.write_information (generator  +"make render template: account.tpl" )
				-- Set path to HTML.
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, a_account, "account.tpl")
				-- Process current template
			process
		end

end
