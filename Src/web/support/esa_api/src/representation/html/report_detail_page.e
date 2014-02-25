note
	description: "Template class to generate an HTML report details page."
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_DETAIL_PAGE

inherit

	ESA_TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make

feature -- {Initialization}
	make (a_host: READABLE_STRING_GENERAL; a_report: detachable REPORT;)
			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("reports_detail.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_report, "report")
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				representation := l_output
				print (representation)
			end
		end

end
