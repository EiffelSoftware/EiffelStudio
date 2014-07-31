note
	description: "Summary description for {USER_REPORT_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_USER_REPORT_PAGE

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
			log.write_information (generator + ".make render template: user_reports.tpl")
			create {ESA_REPORT_CATEGORY_TEMPLATE_INSPECTOR} tpl_inspector.register (({detachable ESA_REPORT_CATEGORY}).out)
			set_selected_category (a_view.categories, a_view.selected_category)
			create {ESA_REPORT_STATUS_TEMPLATE_INSPECTOR} tpl_inspector.register (({detachable ESA_REPORT_STATUS}).out)
			set_template_folder (html_path)
			set_template_file_name ("user_reports.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_view, "view")
			template.add_value (a_view.reports, "reports")
			template.add_value (a_view.categories, "categories")
			template.add_value (a_view.status, "status")
			template.add_value (a_view.selected_category, "selected_category")
			template.add_value (a_view.index, "index")
			template.add_value (a_view.order_by, "orderBy")
			template.add_value (a_view.direction, "dir")
			template.add_value (a_view.size, "size")
			template.add_value (retrieve_status_query (a_view.status), "status_query")
			if a_view.index > 1 then
				template.add_value (a_view.index - 1, "prev")
			end
			if a_view.index < a_view.pages then
				template.add_value (a_view.index + 1, "next")
			end
			template.add_value (a_view.pages + 1, "last")
			template.add_value (a_view.user, "user")
			template.add_value (a_view.pages + 1, "pages")
			if attached a_view.filter as l_filter then
				template.add_value (l_filter, "filter")
			end
			if a_view.filter_content = 1 then
				template.add_value (a_view.filter_content, "filter_content")
			end
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				debug
					log.write_debug (generator + ".make " + l_output)
				end
			end
		end

	set_selected_category (a_categories: LIST [ESA_REPORT_CATEGORY]; a_selected_category: INTEGER)
			-- Set the current selected category
		do
			across
				a_categories as c
			loop
				c.item.set_selected_id (a_selected_category)
			end
		end

	retrieve_status_query (a_status: LIST [ESA_REPORT_STATUS]): STRING
		do
			Result := "0&"
			across
				a_status as c
			loop
				if c.item.is_selected then
					Result.append_string ("status=")
					Result.append_string (c.item.id.out)
					Result.append_string ("&")
				end
			end
			Result.remove_tail (1)
		end

end
