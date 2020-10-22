note
	description: "Summary description for {EWF_WIZARD_GENERATOR}."
	date: "$Date$"
	revision: "$Revision$"

class
	WRAPC_WIZARD_GENERATOR

inherit
	WIZARD_GENERATOR
		redefine
			copy_template
		end

	SHARED_TEMPLATE_CONTEXT

create
	make

feature -- Query

	collection: detachable WIZARD_DATA

	functions: detachable TUPLE [value: ANY; key: READABLE_STRING_GENERAL]
			-- temporary tuple to add a list of values to the templates.

feature -- Execution

	execute (a_collection: WIZARD_DATA)
		local
			d, cd: DIRECTORY
			pdn, dn, cdir: PATH
			c_name: STRING
			l_path_library: STRING
			l_str: STRING
			i: INTEGER
			env: EXECUTION_ENVIRONMENT
			l_command: STRING
			index: INTEGER
		do
			l_command := "wrap_c --verbose $COMPILE_OPTIONS--script_pre_process=$PATH$SEPARATORpre_script.bat --script_post_process=$PATH$SEPARATORpost_script.bat --output-dir=generated_wrapper  --full-header=$FULL_PATH --config=$PATH$SEPARATORconfig.xml"

			collection := a_collection
			if
				attached a_collection.item ("library:name") as pn and then
				attached a_collection.item ("library:location") as l_loc and then
				attached a_collection.item ("c_library:c_header") as l_c_header
			then
				create pdn.make_from_string (l_loc)

				create c_name.make_from_string (l_c_header.to_string_8)
				c_name.remove_tail (2) -- remove .h

				variables.force (pn.as_lower, "LIB_NAME")
				variables.force (new_uuid, "UUID")
				variables.force ("none", "CONCURRENCY")
				variables.force ("${cwd}", "CWD")
				variables.force ("${system_dir}", "SYSTEM_DIR")
				variables.force ("${path_separator}", "PATH_SEPARATOR")
				variables.force ("${ISE_C_COMPILER}", "ISE_C_COMPILER")
				variables.force ("${ISE_PLATFORM}", "ISE_PLATFORM")
				variables.force ("${is_windows}", "IS_WINDOWS")
				variables.force (c_name, "PREPROCESS_HEADER")

					-- Workaround
				if attached collection as l_collection and then attached {WIZARD_PAGE_DATA} l_collection.page_data ("c_functions") as c_functions_data then
					functions := [c_functions_data.elements, "LIST_C_FUNCTIONS"]
				end

				if attached a_collection.item ("c_library:c_compile_options") as l_options and then
					not l_options.is_empty
				then
					variables.force (l_options, "C_COMPILE_OPTIONS")
					l_command.replace_substring_all ("$COMPILE_OPTIONS", l_options.to_string_8)
				else
					l_command.replace_substring_all ("$COMPILE_OPTIONS", "")
				end

				l_command.replace_substring_all ("$PATH", pdn.extended ("library").absolute_path.name.to_string_32)
				l_command.replace_substring_all ("$SEPARATOR", pdn.directory_separator.out)

				dn := pdn
				create d.make_with_path (dn)
				if not d.exists then
					d.recursive_create_dir
				end

				recursive_copy_templates (application.layout.resources_location, dn)

					-- Copy C headers
				if {PLATFORM}.is_windows and then
					attached a_collection.item ("c_header_location") as l_header_location
				then
					l_path_library := l_header_location
						-- Remove trailing '\' if exist.
					index := l_path_library.last_index_of ({PATH}.windows_separator, l_path_library.count)
					l_path_library := l_path_library.substring (1, index - 1)


						-- We assume the C library will be in a path like %PATH%\include{\dir}
					i := l_path_library.last_index_of ('\', l_path_library.count)
					l_str := l_path_library.substring (i + 1, l_path_library.count)
					if l_path_library.has_substring ("include") and then not l_str.is_case_insensitive_equal_general ("include") then
						cdir := dn
						cdir := cdir.extended ("library").extended ("C").extended ("include").extended (l_str)
					else
						cdir := dn
						cdir := cdir.extended ("library").extended ("C").extended ("include")

					end
					l_command.replace_substring_all ("$FULL_PATH", cdir.absolute_path.extended (l_c_header).name.as_string_32)
					create cd.make_with_path (cdir)
					if not cd.exists then
						cd.recursive_create_dir
					end
					recursive_copy_templates (create {PATH}.make_from_string (l_path_library), cdir)

					create env
					env.change_working_path (pdn.extended ("library"))
					env.launch (l_command)

				end

				send_response (create {WIZARD_SUCCEED_RESPONSE}.make (dn.extended ("library").extended (pn).appended_with_extension ("ecf"), d.path))
			else
				send_response (create {WIZARD_FAILED_RESPONSE})
			end
		end

feature -- Templates

	smarty_template_extensions: ARRAY [READABLE_STRING_32]
		once
			Result := <<"eant", "ecf", "xml", "sh", "bat", "md">>
		end

	is_smarty_template_file (f: PATH): BOOLEAN
		do
			if attached f.extension as ext then
				Result := across smarty_template_extensions as ext_ic some ext_ic.item.is_case_insensitive_equal_general (ext) end
			end
		end

	is_template_file (f: PATH): BOOLEAN
		do
			Result := is_smarty_template_file (f)
		end

	copy_template (a_src: PATH; a_target: PATH)
		do
			if is_smarty_template_file (a_src) then
				copy_smarty_template (a_src, a_target)
			else
				Precursor (a_src, a_target)
			end
		end

	copy_smarty_template (a_res: PATH; a_target: PATH)
		local
			tpl: TEMPLATE_FILE
			f, t: PLAIN_TEXT_FILE
			inspectors: ARRAYED_LIST [TEMPLATE_INSPECTOR]
		do
			create f.make_with_path (a_res)
			if f.exists and f.is_readable then
				create tpl.make_from_file (f.path.name)
				if attached collection as l_collection then
					tpl.add_value (l_collection, "WIZ")
				end
				across
					variables as ic
				loop
					tpl.add_value (ic.item, ic.key)
				end
				if attached functions as l_functions then
					tpl.add_value (l_functions.value, l_functions.key)
				end
				template_context.set_template_folder (application.layout.templates_location)
				create inspectors.make (2)
				inspectors.force (create {WIZARD_DATA_TEMPLATE_INSPECTOR}.register (({detachable WIZARD_DATA}).name))
				inspectors.force (create {WIZARD_PAGE_DATA_TEMPLATE_INSPECTOR}.register (({detachable WIZARD_PAGE_DATA}).name))
				tpl.analyze
				tpl.get_output
				across
					inspectors as ic
				loop
					ic.item.unregister
				end
				if attached tpl.output as l_output then
					create t.make_with_path (a_target)
					if not t.exists or else t.is_writable then
						t.create_read_write
						t.put_string (l_output)
						t.close
					end
				else
					copy_file (a_res, a_target)
				end
			end
		end

end
