note
	description: "Summary description for {ESA_CJ_RESPONSIBLE_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	CJ_RESPONSIBLE

inherit

	TEMPLATE_SHARED

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_view: ESA_REPORT_VIEW)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: ch_responsible_reports.tpl")
			set_template_folder (cj_path)
			set_template_file_name ("cj_responsible_reports.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_view.reports, "reports")
			template.add_value (a_view.index, "index")
			template.add_value (a_view.categories, "categories")
			template.add_value (a_view.priorities, "priorities")
			template.add_value (a_view.responsibles, "responsibles")
			template.add_value (a_view.status, "status")
			template.add_value (a_view.severities, "severities")
			template.add_value (retrieve_status_query (a_view.status),"status_query")
			template.add_value (a_view, "view")
			template.add_value (a_view.index, "index")
			template.add_value (a_view.size, "size")
			template.add_value ((create {ESA_REPORT_INPUT_VALIDATOR}).accetpable_order_by, "columns" )
			template.add_value (checked_status_query(a_view.status), "checked_status" )


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

			if attached a_view.id as l_id then
				template.add_value (l_id, "id")
			end

			if a_view.index > 1 then
				template.add_value (a_view.index-1 , "prev")
			end
			if a_view.index < a_view.pages then
				template.add_value (a_view.index+1, "next")
			end
			template.add_value (a_view.pages, "last")

			if attached a_view.user as l_user then
				template.add_value (a_view.user, "user")
			end

				-- Process current template
			process
		end

	retrieve_status_query (a_status: LIST [REPORT_STATUS]): STRING
		do
			Result := "0&"
			across a_status as c loop
				if c.item.is_selected then
					Result.append_string ("status=")
					Result.append_string (c.item.id.out)
					Result.append_string ("&")
				end
			end
			Result.remove_tail (1)
		end


	checked_status_query (a_status: LIST [REPORT_STATUS]): LIST [REPORT_STATUS]
		do
			create {ARRAYED_LIST [REPORT_STATUS]} Result.make (0)
			across a_status as c loop
				if c.item.is_selected then
					Result.force (c.item)
				end
			end
		end

end
