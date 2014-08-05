note
	description: "Template class to generate an HTML report page."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_PAGE
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
		local
			tpl_inspector: TEMPLATE_INSPECTOR
		do
			log.write_information (generator + ".make render template: template_guest_reports.tpl")
			create {ESA_REPORT_CATEGORY_TEMPLATE_INSPECTOR} tpl_inspector.register (({detachable ESA_REPORT_CATEGORY}).out)
			set_selected_category (a_view.categories,a_view.selected_category)

			create {ESA_REPORT_STATUS_TEMPLATE_INSPECTOR} tpl_inspector.register (({detachable ESA_REPORT_STATUS}).out)

			    -- Build common template
			make_template (a_host, a_view, "template_guest_reports.tpl")

				-- Set path to HTML.
			set_template_folder (html_path)

				-- Process the current tempate.
			process

			if attached template.output as l_output then
				representation := l_output
				debug
					log.write_debug (generator + ".make " + l_output)
				end
			end
		end

end
