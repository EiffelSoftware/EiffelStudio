note
	description: "Summary description for {LOGOUT_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_LOGOUT

inherit

	TEMPLATE_USER_HOST
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: logoff.tpl")
				-- Set folder to HTML
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, Void, "logoff.tpl")
				-- Process current template
			process
		end

end


