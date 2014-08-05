note
	description: "Template class to generate an CJ API with reports."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_CJ_REPORT_PAGE

inherit

	ESA_TEMPLATE_PAGE

	ESA_TEMPLATE_REPORT_PAGE
		rename
			make as make_template
		end

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_view: ESA_REPORT_VIEW)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: cj_guest_reports.tpl")

               -- Build common template.
			make_template (a_host, a_view, "cj_guest_reports.tpl")

			   -- Set path to CJ.
			set_template_folder (cj_path)

			template.add_value ((create {ESA_REPORT_INPUT_VALIDATOR}).accetpable_order_by, "columns" )
			template.add_value (checked_status_query(a_view.status), "checked_status" )

				-- Process the template
			process

				-- Workaround
			if attached template.output as l_output then
				l_output.replace_substring_all ("<", "{")
				l_output.replace_substring_all (">", "}")
				l_output.replace_substring_all (",]", "]")
				l_output.replace_substring_all ("},]", "}]")

				representation := l_output
				debug
					log.write_information (generator + ".make " + l_output)
				end
			end
		end

		checked_status_query (a_status: LIST[ESA_REPORT_STATUS]): LIST[ESA_REPORT_STATUS]
			do
				create {ARRAYED_LIST[ESA_REPORT_STATUS]} Result.make (0)
				across a_status as c loop
					if c.item.is_selected then
						Result.force (c.item)
					end
				end
			end

end
