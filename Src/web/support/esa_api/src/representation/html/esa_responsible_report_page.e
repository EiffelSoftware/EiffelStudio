note
	description: "Summary description for {ESA_RESPONSIBLE_REPORT_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_RESPONSIBLE_REPORT_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_view: ESA_REPORT_VIEW)
			-- Initialize `Current'.
		local
			tpl_inspector: TEMPLATE_INSPECTOR
		do

			create {ESA_REPORT_STATUS_TEMPLATE_INSPECTOR} tpl_inspector.register (({detachable ESA_REPORT_STATUS}).out)

			set_template_folder (html_path)
			set_template_file_name ("user_responsible_reports.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_view.reports.at (1), "statistics")
			template.add_value (a_view.reports.at (2), "reports")
			template.add_value (a_view.responsibles, "responsibles")
			template.add_value (a_view.categories, "categories")
			template.add_value (a_view.priorities, "priorities")
			template.add_value (a_view.status, "status")
			template.add_value (a_view.severities, "severities")
			template.add_value (a_view, "view")
			template.add_value (retrieve_status_query (a_view.status),"status_query")
			template.add_value (a_view.index, "index")
			template.add_value (a_view.size, "size")


			if a_view.index > 1 then
				template.add_value (a_view.index-1 , "prev")
			end
			if a_view.index < a_view.pages then
				template.add_value (a_view.index+1, "next")
			end
			template.add_value (a_view.pages, "last")

		 	template.add_value (a_view.user,"user")

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				debug
					print (representation)
				end
			end
		end


	retrieve_status_query (a_status: LIST[ESA_REPORT_STATUS]): STRING
		do
			Result := "status=0&"
			across a_status as c loop
				if c.item.is_selected then
					Result.append_string ("status=")
					Result.append_string (c.item.id.out)
					Result.append_character ('&')
				end
			end
		end
end



