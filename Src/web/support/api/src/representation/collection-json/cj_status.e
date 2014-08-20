note
	description: "Summary description for {ESA_CJ_STATUS_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_STATUS

inherit

	TEMPLATE_USER_HOST
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_list: LIST[REPORT_STATUS]; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_status.tpl")
			set_template_folder (cj_path)
				-- Custom property
				-- Build common template
			make_template (a_host, a_user, "cj_status.tpl")
				-- Set template to CJ
			template.add_value (a_list, "status")
				-- Process current template
			process
		end
end
