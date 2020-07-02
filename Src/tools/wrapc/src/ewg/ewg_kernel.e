note
	title: "Kernal EWG Ops"
	description: "Shared features between command line and UI version"
	purpose: "[
		To capture common ancestor features useful to both the command
		line WrapC application and the Vision2 UI application.
		]"
	WARNINGS: "[
		Some common routines found here will have implementations, which are
		completely over-ridden in the descendant. Others will utilize the
		implementations found here, but add code before or after by way of
		the placement of the Precursor call. Finally, some routines (like make)
		will include mid-way routine calls, where needed. Examine to the code
		to discern why.
		]"
	to_dos: "[
		1. Dying or Stopping: In the GUI, we do not yet know if we need
			a mechanism for dying or stopping processing for whatever
			reason. At this point, we don't see a need, but that could
			change!
		]"


deferred class
	EWG_KERNEL

inherit
	ANY

	KL_SHARED_EXCEPTIONS
		export {NONE} all end

	EWG_SHARED_C_SYSTEM
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

	KL_SHARED_OPERATING_SYSTEM
		export {NONE} all end

	SHARED_PROCESS_MISC

feature {NONE} -- Initialization

	make
			-- Create new EWG tool.
		note
			design_modification: "[
				The call to `mid_make_process' is for the sake
				of the {WUI_EWG} descendant version. In the {EWG}
				version, this routine is a `do_nothing'.
				]"
		do
			create error_handler.make
			process_arguments
			parse_config_file
			run
		end


feature -- Basic Ops: Primary

	parse_config_file
			-- Parse Configuration file (e.g. config.xml)
		local
			parser: EWG_CONFIG_PARSER
			file: KL_TEXT_INPUT_FILE
			rule: EWG_CONFIG_RULE
			matching_clause: EWG_CONFIG_MATCHING_CLAUSE
		do
			if attached config_file_name as l_config_file_name then
				create parser.make (error_handler)
				create file.make (l_config_file_name)
				file.open_read
				if file.is_open_read then
					parser.parse_file (file, config_system)
					file.close
				else
					report_cannot_read_error (l_config_file_name)
					exceptions_die
				end
			else
				create matching_clause.make
				create rule.make (matching_clause, create {EWG_CONFIG_DEFAULT_WRAPPER_CLAUSE}.make)
				config_system.append_rule (rule)
			end
			if error_handler.has_error and then
				attached config_file_name as l_config_file_name
			then
				report_quitting_because_of_config_file_errors_error (l_config_file_name)
				exceptions_die
			end
		ensure
			has_directory_structure: attached config_system.directory_structure as al_dir_structure
		end

	run
			-- Run WrapC core logic.
		note
			design_note: "[
				This routine will most likely remain unchanged in the
				descendants because all of the nuance differences between
				the CLI and GUI have to do with how the "options" are set up.
				Once we arrive here, the options have either been parsed from 
				the CLI options or set in the GUI objects.
				]"
		local
			l_c_parser: like c_parser
			l_c_macro_parser: like c_macro_parser
		do
			create l_c_parser.make (error_handler)
			if is_msc_extension_enabled then
				l_c_parser.enable_msc_extensions
			end
			create post_parser_processor.make (error_handler)
			create eiffel_wrapper_builder.make (error_handler,
															config_system.directory_structure,
															config_system.header_file_name,
															config_system.eiffel_wrapper_set,
															config_system)
			create ewg_generator.make (config_system.header_file_name,
												error_handler,
												config_system.directory_structure,
												config_system.eiffel_wrapper_set)

			debug ("EWG_EXPENSIVE_PHASE_2_ASSERTIONS")
				report_info_message ("expensive phase 2 assertions enabled")
			end

			if attached cpp_header_file_name as l_cpp_header_file_name then
				preprocess_file
					-- parsing (creates C AST)
				l_c_parser.parse_file (l_cpp_header_file_name)
				l_c_parser.print_summary
				l_c_parser := Void

					-- parsing C macro header
				create l_c_macro_parser.make (create {PATH}.make_from_string (l_cpp_header_file_name))
				l_c_macro_parser.parse_macro

					-- post process C AST
				post_parser_processor.post_process

					-- build Eiffel AST from post processed C AST
				eiffel_wrapper_builder.build
				print_eiffel_wrapper_summary


				eiffel_wrapper_builder.build_macros (l_c_macro_parser.constants)


					-- generating
				ewg_generator.generate

					-- Post processing
				execute_post_process
			end
		end

feature -- Basic Ops: Supporting

	preprocess_file
			--<Precursor>
		note
			design_note: "[
				Again--there are no anticipated changes to this routine
				in either the CLI or GUI descendants because this routine
				has to do with file processing based on CLI options or
				GUI control settings already set.
				]"
		local
			file: PLAIN_TEXT_FILE
			l_data: STRING
			regex: RX_PCRE_REGULAR_EXPRESSION
			regex2: RX_PCRE_REGULAR_EXPRESSION
			count: INTEGER
		do
			if attached cpp_header_file_name as l_cpp_header_file_name then
				create file.make_open_read_write (l_cpp_header_file_name)
				if file.exists then
					file.read_stream (file.count)
					l_data := file.last_string
					create regex.make
					regex.compile ("\t*__pragma.*")
					regex.match (l_data)
					count := regex.match_count
					l_data := regex.replace_all ("")
					create regex2.make
					regex2.compile (";\n\s*;")
					regex2.match (l_data)
					count := regex2.match_count
					l_data := regex2.replace_all (";")
					file.close
					file.wipe_out
					file.open_write
					file.put_string (l_data)
					file.flush
					file.close
				end
			end
		end

	process_arguments
			-- `process_arguments'.
		note
			design_note: "[
				The GUI descendant version has no need of version
				or verbose at this time. The GUI has an output section,
				which reveals what the software is doing as it processes.
				Only the {EWG} version will have code added for
				version and verbose.
				]"
		do
			show_intellectual_property

			process_msc_extension_options

			process_c_compiler_options

			process_extension_scripts_options

			process_other_arguments

			execute_pre_process

			preprocess_c_header
		end

feature -- Basic Ops: Sub-supporting

	process_msc_extension_options
			--<Precursor>
		note
			design_note: "[
				Both CLI and GUI need this as-is.
				]"
		do
			if operating_system.is_windows
				and then attached {EXECUTION_ENVIRONMENT}.item ("ISE_C_COMPILER") as l_compiler
				and then l_compiler.has_substring ("msc")
			then
				is_msc_extension_enabled := True
			end
		end

	process_c_compiler_options
			-- `process_c_compiler_options'.
		note
			design_note: "Full-implementation needed in both CLI and GUI"
		deferred
		end

	process_extension_scripts_options
			-- `process_extension_scripts_options'.
		note
			design_note: "Full-implementation needed in both CLI and GUI"
		deferred
		end

	process_other_arguments
			-- `process_other_arguments'.
		note
			design_note: "Full-implementation needed in both CLI and GUI"
		deferred
		end

	preprocess_c_header
			--<Precursor>
		note
			design_note: "[
				Another instance of full-implementation held here in
				this class, with nothing added or removed in the
				CLI or GUI descendants.
				]"
	    local
	    	l_cmd: STRING
	    	l_path: PATH
	    	l_name,
	    	l_error_message: STRING
	    	l_index: INTEGER
	    	l_file: RAW_FILE
	    	l_directory_name: STRING
	    	l_directory: DIRECTORY
	    	l_env: EXECUTION_ENVIRONMENT
		do
			if attached full_header_file_name as l_full_header_file_name  then
				-- gcc -E ${wrap_c.c_compile.options.default} ${wrap_c.c_compile.options} ${wrap_c.full_header_name} &gt; ${wrap_c.cpp_header_name}
				-- cl /nologo /E ${wrap_c.c_compile.options.default} ${wrap_c.c_compile.options} ${wrap_c.full_header_name} &gt; ${wrap_c.cpp_header_name}
				if attached output_directory_name as l_output_directory_name then
					l_directory_name := l_output_directory_name
					config_system.set_output_directory_name (l_output_directory_name)
				else
					l_directory_name := config_system.directory_structure.default_output_directory
					config_system.set_output_directory_name (config_system.directory_structure.default_output_directory)
				end

				create l_directory.make_with_name (config_system.output_directory_name)
				if not l_directory.exists then
					l_directory.create_dir
				end

				create l_path.make_from_string (l_directory_name)
				if {PLATFORM}.is_windows and then attached {EXECUTION_ENVIRONMENT}.item ("ISE_C_COMPILER") as l_platform and then
					l_platform.has_substring ("msc")
				then
					create l_cmd.make_from_string ("cl /nologo /E ")
				else
					create l_cmd.make_from_string ("gcc -E ")
				end
				l_cmd.append (" ")
				if attached compiler_options as l_compiler_options then
					l_cmd.append_string (l_compiler_options)
				end
				l_cmd.append (" ")
				l_cmd.append_string (l_full_header_file_name)

				if {PLATFORM}.is_windows then
					if attached process_misc.output_of_command (l_cmd, l_path) as l_result then
						if l_result.exit_code = 0 then
							error_handler.report_info_message ("[Preprocess C header]")
							error_handler.report_info_message (l_cmd)
								-- To be updated.
							l_index := l_result.error_output.index_of ('.', 1) - 1

							-- TODO check if to_string_8 is the right way to replace
							-- obsolete feature call `as_string_8`
							l_name := l_result.error_output.substring (1, l_index).to_string_8

							l_name.append_string ("_cpp.h")
							cpp_header_file_name := l_name.twin
							create l_file.make_create_read_write (l_name)
							l_file.put_string (l_result.output)
							l_file.flush
							l_file.close
						else
								-- Error
							l_error_message := l_result.error_output.out
							l_error_message.replace_substring_all ("%N", "")
							l_error_message.replace_substring_all ("%B", "")
							report_info_message (l_error_message)
						end
					else
						error_handler.report_info_message ("Command not found " + l_cmd )
					end
				else
						-- Linux workaround Base Process doesn't work as expected
					create l_env
					l_env.change_working_path (l_path.parent)
					l_index := config_system.header_file_name.index_of ('.', 1) - 1
					l_name := config_system.header_file_name.substring (1, l_index)
					l_name.append_string ("_cpp.h")
					cpp_header_file_name := l_name.twin
					l_env.system (l_cmd + " > " + l_name.twin)
				end
			end
		end

	print_eiffel_wrapper_summary
			--<Precursor>
			-- Print summary about Eiffel wrappers.
		note
			design_note: "[
				Note the use of `report_info_message', which is deferred
				in this class, but implemented in the CLI or GUI versions.
				See the last feature group for more of these deferred
				features. They represent two very different ways of telling
				the user what is happening--either in the CLI window or in
				the GUI output {EV_RICH_TEXT} control.
				]"
		local
			eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET
		do
			eiffel_wrapper_set := config_system.eiffel_wrapper_set
			report_info_message ("  found:")
			report_info_message ("    . " + eiffel_wrapper_set.enum_wrapper_count.out + " enum wrappers")
			report_info_message ("    . " + eiffel_wrapper_set.struct_wrapper_count.out + " struct wrappers")
			report_info_message ("    . " + eiffel_wrapper_set.union_wrapper_count.out + " union wrappers")
			report_info_message ("    . " + eiffel_wrapper_set.function_wrapper_count.out + " function wrappers")
			report_info_message ("    . " + eiffel_wrapper_set.callback_wrapper_count.out + " callback wrappers")
		end

feature -- Execute Plugin scripts

	execute_pre_process
			--<Precursor>
			-- Execute pre process script, if any.
		do
			if attached script_pre_process as l_script then
				if attached process_misc.output_of_command (l_script, Void) as l_result then
					if l_result.exit_code = 0 then
						report_info_message ("[Execute pre process script]")
					else
						-- Error
						-- TODO check if to_string_8 is the right way to replace
						-- obsolete feature call `as_string_8`
						report_info_message (l_result.error_output.to_string_8)
					end
				else
					report_info_message ("Script not found " + l_script )
				end
			end
		end

	execute_post_process
			--<Precursor>
			-- Execute post process script, if any.
		do
			if attached script_post_process as l_script then
				if attached process_misc.output_of_command (l_script, Void) as l_result then
					if l_result.exit_code = 0 then
						report_info_message ("[Execute post process script]")
					else
						-- Error
						-- TODO check if to_string_8 is the right way to replace
						-- obsolete feature call `as_string_8`
						report_info_message (l_result.error_output.to_string_8)
					end
				else
					report_info_message ("Script not found " + l_script )
				end
			end
		end

feature -- Access

	error_handler: EWG_ERROR_HANDLER
			-- Error handler

	c_parser: detachable EWG_C_PARSER
			-- C header parser
			--| Check if it really need as a feature of the class.


	eiffel_wrapper_builder: EWG_EIFFEL_WRAPPER_BUILDER
			-- Builds Eiffel wrappers from C AST

	post_parser_processor: EWG_POST_PARSER_PROCESSOR
			-- Post Parser Processor

	ewg_generator: EWG_GENERATOR
			-- Generator for Eiffel wrappers

	config_system: EWG_CONFIG_SYSTEM

	config_file_name: detachable STRING
			-- EWG configuration file name

	is_msc_extension_enabled: BOOLEAN

	cpp_header_file_name: detachable STRING
			-- Already C preprocessed header file (with full path name);
			-- This is the file ewg will open and parse.  It is a good
			-- idea to preprocess the header with the same (preprocessor)
			-- options you use to compile an application that uses this
			-- header.  Note: "cpp" does not stand for C++, it stands for
			-- "C-Pre-Processed".

	full_header_file_name: STRING
			-- C header file (with full path name)
			-- This is the file that will be preprocessed and
			-- saved as `cpp_header_file_name`.


	compiler_options: detachable STRING
			-- Optional compiler options to apply during C headerp
			-- preprocessing.


	output_directory_name: detachable STRING
			-- Optional dir path for output of `run'.

	c_macro_parser: detachable WRAPC_MACRO_PARSER
			-- C header macro parser
			--| Check if it really need as a feature of the class.

feature {NONE} -- Implementation: Error Reporting

	report_cannot_read_error (a_message: STRING)
			-- Report cannot read config file.
		note
			design: "[
				Generally speaking, ALL of the routines in this feature
				group are deferred because the CLI and GUI versions have
				their own way of telling the user what is happening.
				]"
		deferred
		end

	report_missing_command_line_parameter_error (a_message: STRING)
			-- Report a missing command line paramter.
		deferred
		end

	report_missing_command_line_parameter_value_error (a_message: STRING)
			-- Report a missing command line parameter value (parm=?)
		deferred
		end

	report_usage_error
			-- Report a general usage error (user got options wrong)
		deferred
		end

	exceptions_die
			-- Let the application die, if needed.
		note
			design: "[
				Dying differs in both how and why between the CLI and
				the GUI versions. In the CLI, we die generally because
				we are missing a CLI parm option value. In the GUI,
				we don't "die", because we don't have a need--we either
				have the option values or we do not. If we do not, then
				we simply do not process them (e.g. C-compile option or
				scripts for pre- or post-processing).
				]"
		deferred
		end

	report_quitting_because_of_config_file_errors_error (a_message: STRING)
			-- Report quitting because of config file errors.
		deferred
		end

	report_info_message (a_message: STRING)
			-- Report a general information message.
		deferred
		end

	show_intellectual_property
		do
			report_info_message ({STRING_8}"Intellectual property status of WrapC-generated code")
			report_info_message ({STRING_8}"====================================================")
			report_info_message ({STRING_8}"Code generated by WrapC includes two kinds of element:")
			report_info_message ({STRING_8}" - Code generated by WrapC.")
			report_info_message ({STRING_8}" - Code resulting, directly or indirectly, from the library being wrapped.")
			report_info_message ({STRING_8}"For type-1 elements, [EFL] (the Eiffel Forum License) applies. For type-2 elements, the licensing terms of the original library apply.")
			report_info_message ({STRING_8}"By using WrapC you agree to acquaint yourself of those terms and to conform to them.")
			report_info_message (" ")
		end

feature {NONE} -- Implementation

	script_pre_process: detachable  STRING

	script_post_process: detachable STRING

end
