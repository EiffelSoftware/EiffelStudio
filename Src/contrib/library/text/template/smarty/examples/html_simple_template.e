note
	description: "Summary description for {HTML_SIMPLE_TEMPLATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_SIMPLE_TEMPLATE


inherit

	SHARED_TEMPLATE_CONTEXT
		undefine
			default_create
		end

	ANY
		redefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create

			-- Initialize `Current'.
		local
			p: PATH
		do
			create p.make_current
			p:=p.appended ("/tpl")
			set_template_folder (p)
			set_template_file_name ("html_simple_table.tpl")
			template.add_value (<<"bob","jim","joe","jerry","fred">>, "names")
			template_context.enable_verbose
			template.analyze
			template.get_output
			if attached template.output as l_output then
				output := l_output
				print (output)
			end

		end

feature -- Status

	output: detachable STRING

	set_template_folder (v: PATH)
		do
			template_context.set_template_folder (v)
		end

	set_template_file_name (v: STRING)
		do
			create template.make_from_file (v)
		end

	set_template (v: like template)
		do
			template := v
		end

	template: TEMPLATE_FILE


end
