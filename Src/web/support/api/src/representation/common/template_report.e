note
	description: "Report template page, setting common properties for CJ and HTML media types"
	date: "$Date$"
	revision: "$Revision$"

class
	TEMPLATE_REPORT

inherit

	TEMPLATE_SHARED

create
	make

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL; a_view: ESA_REPORT_VIEW; a_template_name: READABLE_STRING_32)
			-- Initialize `Current'.
		do
			set_template_file_name (a_template_name)
			add_host (a_host)
			template.add_value (a_view, "view")
			template.add_value (a_view.reports, "reports")
			template.add_value (a_view.categories, "categories")
			template.add_value (a_view.status, "status")
			template.add_value (a_view.selected_category, "selected_category")
			template.add_value (a_view.index, "index")
			template.add_value (a_view.order_by,"orderBy")
			template.add_value (a_view.direction,"dir")
			template.add_value (a_view.size, "size")
			template.add_value (retrieve_status_query (a_view.status),"status_query")


			if a_view.index > 1 then
				template.add_value (a_view.index - 1 , "prev")
			end
			if a_view.index <= a_view.pages then
				template.add_value (a_view.index + 1, "next")
			end
			template.add_value (a_view.pages + 1 , "last")

			template.add_value (a_view.pages + 1, "pages")


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

		 	if attached a_view.user as l_user then
		 		template.add_value (l_user,"user")
			end
		end

	set_selected_category (a_categories: LIST[REPORT_CATEGORY]; a_selected_category:  INTEGER)
			-- Set the current selected category
		do
			across a_categories as c  loop
				c.item.set_selected_id (a_selected_category)
			end
		end

	retrieve_status_query (a_status: LIST[REPORT_STATUS]): STRING
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


	checked_status_query (a_status: LIST[REPORT_STATUS]): LIST[REPORT_STATUS]
		do
			create {ARRAYED_LIST[REPORT_STATUS]} Result.make (0)
			across a_status as c loop
				if c.item.is_selected then
					Result.force (c.item)
				end
			end
		end


end
