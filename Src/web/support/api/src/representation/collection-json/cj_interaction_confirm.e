note
	description: "Summary description for {ESA_CJ_INTERACTION_CONFIRM_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_INTERACTION_CONFIRM

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
			log.write_information (generator + ".make render template: cj_interaction_confirm.tpl")
			set_template_folder (cj_path)
				-- Build common template
			make_template (a_host, a_form, a_user, "cj_interaction_confirm.tpl")
			template.add_value (a_form.report, "report")
				-- Process current template
			process
		end
end
