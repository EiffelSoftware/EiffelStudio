note
	description: "Summary description for {ESA_INTERACTION_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_INTERACTION

inherit

	TEMPLATE_INTERACTION
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_INTERACTION_FORM_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: interaction_form.tpl")
				-- Set folder to HTML
			set_template_folder (html_path)
				-- Build Common Template
			make_template (a_host, a_form, a_user, "interaction_form.tpl")
				-- Process the current tempate.
			process
		end
end
