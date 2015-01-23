note
	description: "Summary description for {ESA_RESPONSIBLE_REPORT_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_RESPONSIBLE_REPORT

inherit

	TEMPLATE_SHARED

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_view: ESA_REPORT_VIEW)
			-- Initialize `Current'.
		local
			tpl_inspector: TEMPLATE_INSPECTOR
		do

			log.write_information (generator + ".make render template: user_responsible_reports.tpl")
			create {ESA_REPORT_STATUS_TEMPLATE_INSPECTOR} tpl_inspector.register (({detachable REPORT_STATUS}).out)

			set_template_folder (html_path)
			set_template_file_name ("user_responsible_reports.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_view.reports, "reports")
			template.add_value (a_view.responsibles, "responsibles")
			template.add_value (a_view.categories, "categories")
			template.add_value (a_view.priorities, "priorities")
			template.add_value (a_view.status, "status")
			template.add_value (a_view.severities, "severities")
			template.add_value (a_view, "view")
			template.add_value (retrieve_status_query (a_view.status),"status_query")
			template.add_value (a_view.index, "index")
			template.add_value (a_view.size, "size")

			if attached a_view.filter as l_filter then
				template.add_value (l_filter, "filter")
			end

			if a_view.filter_content= 1 then
				template.add_value (a_view.filter_content, "filter_content")
			end

			if
				attached a_view.submitter as l_submitter and then
				not l_submitter.is_empty
			then
				template.add_value (a_view.submitter, "submitter")
			end

			if a_view.index > 1 then
				template.add_value (a_view.index - 1 , "prev")
			end
			if a_view.index <= a_view.pages then
				template.add_value (a_view.index + 1, "next")
			end
			template.add_value (a_view.pages + 1, "last")

			template.add_value (a_view.pages + 1, "pages")

		 	template.add_value (a_view.user,"user")

				-- Process current template
			process
		end

	retrieve_status_query (a_status: LIST[REPORT_STATUS]): STRING
		do
			Result := "0&amp;"
			across a_status as c loop
				if c.item.is_selected then
					Result.append_string ("status=")
					Result.append_string (c.item.id.out)
					Result.append_string ("&amp;")
				end
			end
			if Result.count > 5 then
				Result.remove_tail (5)
			end
		end
end



