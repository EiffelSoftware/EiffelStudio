note
	description: "Template class to generate an HTML Home page."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_HOME

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

			log.write_information (generator + ".make render template: home.tpl")
				-- Set template to HTML
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, a_user, "home.tpl")
				-- Process current template
			process
		end

end
