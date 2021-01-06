note
	description: "Template class to generate an HTML recently closed. report page."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_CLOSED_REPORT

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
				log.write_information (generator + ".make render template: template_guest_closed_reports.tpl")
			end
				-- Set folder to HTML
			set_template_folder (html_path)

			    -- Build common template
			make_template (a_host, a_view, "template_guest_closed_reports.tpl")

				-- Process the current tempate.
			process

		end

end
