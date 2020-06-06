note
	description: "Abstract template class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ESA_TEMPLATE_PAGE

inherit

	SHARED_TEMPLATE_CONTEXT

	SHARED_LOGGER

	ARGUMENTS
feature -- Status

	representation: detachable STRING
			-- String representation, if any.

	set_template_folder (v: PATH)
			-- Set template folder to `v'.
		do
			template_context.set_template_folder (v)
		end

	set_template_file_name (v: READABLE_STRING_GENERAL)
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

	layout: APPLICATION_LAYOUT
		once
			if attached separate_character_option_value ('d') as l_dir  then
				create Result.make_with_path (create {PATH}.make_from_string (l_dir))
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
