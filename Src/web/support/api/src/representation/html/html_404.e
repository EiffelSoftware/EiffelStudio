note
	description: "Summary description for {HTML_404_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_404

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
			log.write_information (generator + ".make render template: 404.tpl")
				-- Set path to HTML.
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, a_user, "404.tpl" )
				-- Process current template
			process
		end

end
