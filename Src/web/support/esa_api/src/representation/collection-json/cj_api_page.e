note
	description: "Template class to generate an CJ API root"
	date: "$Date$"
	revision: "$Revision$"


class
	CJ_API_PAGE

inherit

	TEMPLATE_PAGE

	SHARED_TEMPLATE_CONTEXT

create
	make, make_with_error

feature {NONE} --Initialization

	make (a_host: READABLE_STRING_GENERAL;)
			-- Initialize `Current'.
		local
			p: PATH
			l_item: STRING
			l_template: STRING
			l_report: REPORT
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("collection_json.tpl")
			template.add_value (a_host, "host")
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				l_output.replace_substring_all ("<", "{")
				l_output.replace_substring_all (">", "}")
				representation := l_output
				print ("%N===========%N" + l_output)
			end
		end

	make_with_error (a_host: READABLE_STRING_GENERAL; a_error: READABLE_STRING_GENERAL; a_code: INTEGER)
			-- Initialize `Current'.
		local
			p: PATH
			l_item: STRING
			l_template: STRING
		do
			create p.make_current
			p := p.appended ("/www")
			set_template_folder (p)
			set_template_file_name ("collection_json_error.tpl")
			template.add_value (a_host, "host")
			template.add_value (a_error, "error")
			template.add_value (a_code, "code")
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				l_output.replace_substring_all ("<", "{")
				l_output.replace_substring_all (">", "}")
				representation := l_output
				print ("%N===========%N" + l_output)
			end
		end



end
