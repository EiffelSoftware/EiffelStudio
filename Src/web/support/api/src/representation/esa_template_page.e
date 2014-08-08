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
			-- String representation, if any.

	set_template_folder (v: PATH)
			-- Set template folder to `v'.
		do
			template_context.set_template_folder (v)
		end

	set_template_file_name (v: STRING)
			-- Set  `template' to `v'.
		do
			create template.make_from_file (v)
		end

	set_template (v: like template)
			-- Set `template' to `v'.
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
			-- Html template paths.
		do
			Result := layout.html_template_path
		end

	cj_path:  PATH
			-- Collection json template paths.
		do
			Result := layout.cj_template_path
		end


feature -- Process

	process
			-- Process the current template.
		do
			template_context.enable_verbose
			template.analyze
			template.get_output

			if attached template.output as l_output then
				if
					attached template_context.template_folder as l_folder and then
					l_folder.is_case_insensitive_equal (cj_path)
				then
						-- CJ workaround
					l_output.replace_substring_all ("<", "{")
					l_output.replace_substring_all (">", "}")
					l_output.replace_substring_all (",]", "]")
					l_output.replace_substring_all ("},]", "}]")
				end

				representation := l_output
				debug
					log.write_debug (generator + ".make " +  l_output)
				end
			end
		end
end
