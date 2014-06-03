note
	description: "Summary description for {ESA_ACCOUNT_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_ACCOUNT_PAGE
inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_account: ESA_ACCOUNT_VIEW)
			-- Initialize `Current'.
		do
			set_template_folder (html_path)
			set_template_file_name ("account.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_account, "account")
			template.add_value (a_account.username, "user")

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				log.write_debug (generator  +"executor " + l_output)
			end
		end

end
