note
	description: "Summary description for {USER_REPORT_PAGE}."
	author: ""
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
			p: PATH
			tpl_inspector: TEMPLATE_INSPECTOR
		do

			create {ESA_REPORT_CATEGORY_TEMPLATE_INSPECTOR} tpl_inspector.register (({detachable ESA_REPORT_CATEGORY}).out)
			set_selected_category (a_view.categories,a_view.selected_category)

			create {ESA_REPORT_STATUS_TEMPLATE_INSPECTOR} tpl_inspector.register (({detachable ESA_REPORT_STATUS}).out)
			set_selected_status (a_view.status,a_view.selected_status)

			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("user_reports.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_view.reports.at (1), "statistics")
			template.add_value (a_view.reports.at (2), "reports")
			template.add_value (a_view.categories, "categories")
			template.add_value (a_view.status, "status")
			template.add_value (a_view.selected_status, "selected_status")
			template.add_value (a_view.selected_category, "selected_category")
			if a_view.index > 1 then
				template.add_value (a_view.index-1 , "prev")
			else
				template.add_value (a_view.index , "prev")
			end
			if a_view.index < a_view.pages then
				template.add_value (a_view.index+1, "next")
			else
				template.add_value (a_view.index, "next")
			end
			template.add_value (a_view.pages, "last")

		 	template.add_value (a_view.user,"user")

			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				print (representation)
			end
		end

		set_selected_category (a_categories: LIST[ESA_REPORT_CATEGORY]; a_selected_category:  INTEGER)
				-- Set the current selected category
			do
				across a_categories as c  loop
					c.item.set_selected_id (a_selected_category)
				end
			end


		set_selected_status (a_status: LIST[ESA_REPORT_STATUS]; a_selected_status:  INTEGER)
				-- Set the current selected status
			do
				across a_status as c  loop
					c.item.set_selected_id (a_selected_status)
				end
			end

end
