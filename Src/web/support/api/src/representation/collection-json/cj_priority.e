note
	description: "Summary description for {ESA_CJ_PRIORITY_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_PRIORITY

inherit

	TEMPLATE_USER_HOST
		rename
			make as make_template
		end

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_list: LIST [REPORT_PRIORITY]; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_priority.tpl")
				-- Set tempalate to CJ
			set_template_folder (cj_path)
				-- Build commmon template
			make_template (a_host, a_user, "cj_priority.tpl")
				-- Custom property
			template.add_value (a_list, "priorities")
				-- Process current template
			process

		end
end
