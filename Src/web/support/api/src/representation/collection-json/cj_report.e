note
	description: "Template class to generate an CJ API with reports."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_REPORT

inherit

	TEMPLATE_REPORT
		rename
			make as make_template
		end
create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_view: ESA_REPORT_VIEW)
			-- Initialize `Current'.
		do
			debug
				log.write_information (generator + ".make render template: cj_guest_reports.tpl")
			end

			   -- Set path to CJ.
			set_template_folder (cj_path)

               -- Build common template.
			make_template (a_host, a_view, "cj_guest_reports.tpl")

				-- Custom properties
			template.add_value ((create {ESA_REPORT_INPUT_VALIDATOR}).accetpable_order_by, "columns" )
			template.add_value (checked_status_query(a_view.status), "checked_status" )

				-- Process the template
			process
		end
end
