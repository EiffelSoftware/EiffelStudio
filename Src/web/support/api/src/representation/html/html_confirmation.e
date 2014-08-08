note
	description: "Summary description for {ESA_CONFIRMATION_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_CONFIRMATION

inherit

	TEMPLATE_CONFIRMATION
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: confirmation.tpl")
				-- Set folder to HTML
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, a_user, "confirmation.tpl" )
				-- Process current template
			process
		end

end


