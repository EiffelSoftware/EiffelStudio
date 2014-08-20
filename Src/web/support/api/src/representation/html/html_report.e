note
	description: "Template class to generate an HTML report page."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_REPORT
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
		local
			tpl_inspector: TEMPLATE_INSPECTOR
		do
			log.write_information (generator + ".make render template: template_guest_reports.tpl")
			create {ESA_REPORT_CATEGORY_TEMPLATE_INSPECTOR} tpl_inspector.register (({detachable REPORT_CATEGORY}).out)
			set_selected_category (a_view.categories,a_view.selected_category)

			create {ESA_REPORT_STATUS_TEMPLATE_INSPECTOR} tpl_inspector.register (({detachable REPORT_STATUS}).out)
				-- Set folder to HTML
			set_template_folder (html_path)

			    -- Build common template
			make_template (a_host, a_view, "template_guest_reports.tpl")

				-- Process the current tempate.
			process

		end

end
