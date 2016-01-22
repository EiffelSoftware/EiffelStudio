note
	description: "Template class to generate an HTML report details page."
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_REPORT_DETAIL

inherit

	TEMPLATE_REPORT_DETAIL
		rename
			make as make_template
		end

create
	make

feature {NONE} -- {Initialization}

	make (a_host: READABLE_STRING_GENERAL; a_report: detachable REPORT; a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: reports_detail.tpl")
			-- Set folder to HTML
			set_template_folder (html_path)
			-- Build common template
			make_template (a_host, a_report, a_user, "reports_detail.tpl" )
				-- Process current template
			process
		end

end
