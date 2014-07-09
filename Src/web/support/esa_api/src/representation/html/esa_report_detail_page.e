note
	description: "Template class to generate an HTML report details page."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_DETAIL_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature {NONE} -- {Initialization}
	make (a_host: READABLE_STRING_GENERAL; a_report: detachable ESA_REPORT;a_user: detachable ANY)
			-- Initialize `Current'.
		do
			log.write_information (generator + ".make render template: reports_detail.tpl")
			set_template_folder (html_path)
			set_template_file_name ("reports_detail.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_report, "report")
			if attached a_user then
				 template.add_value (a_user,"user")
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

end
