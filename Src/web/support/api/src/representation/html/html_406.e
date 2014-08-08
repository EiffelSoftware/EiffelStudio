note
	description: "Summary description for {HTML_406_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_406

inherit

	TEMPLATE_USER_HOST
		rename
			make as make_template
		end
create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_resource: READABLE_STRING_GENERAL; a_accept: detachable READABLE_STRING_GENERAL)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: 406.tpl")
				-- Set path to HTML.
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, Void, "406.tpl")
				-- Custom fields
			template.add_value (a_resource, "resource")
			template.add_value (a_accept, "accept")
				-- Process current template
			process
		end
end

