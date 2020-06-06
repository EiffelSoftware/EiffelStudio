note
	description: "Account template page, setting common properties for CJ and HTML media types"
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_ACCOUNT

inherit

	TEMPLATE_SHARED

create
	make

feature {NONE} -- Initialization

	make (a_host: READABLE_STRING_GENERAL; a_account: ESA_ACCOUNT_VIEW; a_template: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			set_template_file_name (a_template)
			add_host (a_host)
			template.add_value (a_account, "account")
			template.add_value (a_account.username, "user")
		end
end
