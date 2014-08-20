note
	description: "Template class to generate an CJ API with details"
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_REPORT_DETAIL

inherit

	TEMPLATE_REPORT_DETAIL
		rename
			make as make_template
		end

create
	make

feature {NONE} -- {Initialization}

	make (a_host: READABLE_STRING_GENERAL; a_report: detachable REPORT; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_reports_detail.tpl")
				-- Set template to CJ
			set_template_folder (cj_path)
				-- Build common template
			make_template (a_host, a_report, a_user, "cj_reports_detail.tpl")
				-- Process current template
			process
		end
end
