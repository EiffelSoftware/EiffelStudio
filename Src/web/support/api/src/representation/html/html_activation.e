note
	description: "Summary description for {ESA_ACTIVATION_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_ACTIVATION

inherit

	TEMPLATE_ACTIVATION
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_form: detachable ESA_ACTIVATION_VIEW; a_user: detachable ANY;)
			-- Initialize `Current'.
		do
			log.write_information (generator  +"make render template: activation.tpl" )
				-- Set folder to HTML
			set_template_folder (html_path)
				-- Build common template
			make_template (a_host, a_form, a_user, "activation.tpl")
				-- Process current template
			process
		end

end
