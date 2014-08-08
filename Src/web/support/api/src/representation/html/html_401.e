note
	description: "Summary description for {ESA_HTML_401_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_401

inherit

	TEMPLATE_USER_HOST
		rename
			make as make_template
		end

create
	make, make_with_redirect

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: 401.tpl")
				-- Set path to HTML.
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, Void, "401.tpl" )
				-- Process current tempalte
			process
		end


	make_with_redirect (a_host: READABLE_STRING_GENERAL; a_redirect: READABLE_STRING_GENERAL; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: 401.tpl")
				-- Set path to HTML.
			set_template_folder (html_path)
				-- Build common template	
			make_template (a_host, a_user, "401.tpl" )
				-- Custome field
			template.add_value (a_redirect, "redirect")
				-- Process current template
			process
		end

end
