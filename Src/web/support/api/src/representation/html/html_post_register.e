note
	description: "Summary description for {ESA_HTML_POST_REGISTER_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_POST_REGISTER

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
			log.write_information (generator + ".make render template: post_register_page.tpl")
				-- Set folder to HTML
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, a_user, "post_register_page.tpl")
				-- Process current template
			process
		end

end
