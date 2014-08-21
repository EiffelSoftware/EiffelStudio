note
	description: "Summary description for {ESA_INTERACTION_CONFIRM_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_INTERACTION_CONFIRM

inherit

	TEMPLATE_INTERACTION_CONFIRM
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: ESA_INTERACTION_FORM_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: interaction_form_confirm.tpl")
				-- Set template to HTML folder.
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, a_form, a_user, "interaction_form_confirm.tpl")
				-- Process current template
			process
		end
end
