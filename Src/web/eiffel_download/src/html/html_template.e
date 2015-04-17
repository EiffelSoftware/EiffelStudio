note
	description: "Summary description for {TEMPLATE_PAGE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HTML_TEMPLATE

inherit

	SHARED_TEMPLATE_CONTEXT


feature -- Status

	representation: detachable STRING

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


feature -- Process template

	process
			-- Process the current template.
		do
			template_context.enable_verbose
			template.analyze
			template.get_output

			if attached template.output as l_output then
				representation := l_output
			end
		end
end


