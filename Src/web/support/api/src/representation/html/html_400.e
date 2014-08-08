note
	description: "Summary description for {ESA_HTML_400_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_400

inherit

	TEMPLATE_BAD_REQUEST
		rename
			make as make_template
		end

create
	make, make_with_errors

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: 400.tpl")
				-- Set template to HTML
			set_template_folder (html_path)

				-- Build Common Template
			make_template (a_host, a_user, "400.tpl")


				-- Process the current tempate.
			process
		end

	make_with_errors (a_host: READABLE_STRING_GENERAL; a_errors: STRING_TABLE [READABLE_STRING_32]; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make_with_errors render template: 400.tpl")
				-- Set path to HTML.
			set_template_folder (html_path)

				-- Build Common Template
			make_template (a_host, a_user, "400.tpl")

			template.add_value (a_errors, "errors")

				-- Process the current tempate.
			process
		end

end
