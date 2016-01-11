note
	description: "Summary description for {ESA_CJ_SEVERITY_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_SEVERITY

inherit

	TEMPLATE_USER_HOST
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_list: LIST [REPORT_SEVERITY]; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_severity.tpl")
				-- Set template to CJ
			set_template_folder (cj_path)

				-- Build common template
			make_template (a_host, a_user, "cj_severity.tpl")
				-- Custom property
			template.add_value (a_list, "severity")
				-- Process current template
			process
		end
end
