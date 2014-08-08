note
	description: "Summary description for {ESA_HTML_500_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_500

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
			log.write_information (generator + ".make render template: 500.tpl")
				-- Build common template
			make_template (a_host, Void, "500.tpl")
				-- Set template to HTML
			set_template_folder (html_path)
				-- Process current tempalte
			process
		end
end
