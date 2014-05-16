note
	description: "Abstract template class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_TEMPLATE_PAGE

inherit

	SHARED_TEMPLATE_CONTEXT

	ESA_SHARED_LOGGER

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

	layout: ESA_LAYOUT
		local
			l_env: EXECUTION_ENVIRONMENT
		once
			create l_env
			if attached l_env.item ({ESA_CONSTANTS}.Esa_directory_variable_name) as s then
				create Result.make_with_path (create {PATH}.make_from_string (s))
			else
				create Result.make_default
			end
		end

	html_path: PATH
			-- Html template paths
		do
			Result := layout.html_template_path
		end

	cj_path:  PATH
			-- Collection json template paths
		do
			Result := layout.cj_template_path
		end

end
