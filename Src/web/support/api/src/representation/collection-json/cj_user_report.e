note
	description: "Summary description for {CJ_USER_REPORT}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_USER_REPORT

inherit

	TEMPLATE_REPORT
		rename
			make as make_template
		end
create
	make

feature {NONE} -- Initializarion

	make (a_host: READABLE_STRING_GENERAL; a_view: ESA_REPORT_VIEW; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_loggedin_reports.tpl")

			   -- Set path to CJ.
			set_template_folder (cj_path)

               -- Build common template.
			make_template (a_host, a_view, "cj_loggedin_reports.tpl")

				-- Custom properties
			add_user (a_user)
			template.add_value ((create {ESA_REPORT_INPUT_VALIDATOR}).accetpable_order_by, "columns" )
			template.add_value (checked_status_query(a_view.status), "checked_status" )

				-- Process the template
			process
		end
end
