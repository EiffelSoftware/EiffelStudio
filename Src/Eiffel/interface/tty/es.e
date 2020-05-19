note
	description: "[
			Batch compiler without invoking the -loop.
			This is the root class for the personal version (which does allow c compilation).
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	ca_ignore:
		"CA032", "CA032 — very long feature",
		"CA033", "CA033 — very long class"

class
	ES

inherit
	ES_ARGUMENTS

	EB_SHARED_OUTPUT_TOOLS

	SHARED_CONFIGURE_RESOURCES

	SHARED_EIFFEL_PROJECT

	SHARED_EWB_HELP

	SHARED_EWB_CMD_NAMES

	EIFFEL_LAYOUT

	SHARED_OVERRIDDEN_METADATA_CACHE_PATH

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER

	SHARED_ERROR_BEHAVIOR

	REFACTORING_HELPER

	COMPILER_EXPORTER

	EXCEPTIONS
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS

	SHARED_BATCH_NAMES

	SHARED_COMPILER_PROFILE

	PREFERENCES_VERSIONS

	PROJECT_CONTEXT

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization
		local
			l_layout: ES_EIFFEL_LAYOUT
			l_eifgen_init: INIT_SERVERS
			l_preference_access: PREFERENCES
		do
				-- Code analysis command state is kept in a separate object
				-- that accumulates the corresponding requests.
			create code_analysis_command.make
				-- A parser to process configutation options specified in the command line.
			create configuration_option_parser.make
				(agent: ITERABLE [READABLE_STRING_32]
					do
							-- agent eiffel_layout.default_il_environment.installed_runtimes
							-- would work, but it would cause computation of CLR run-times
							-- immediately though it might never required.
							-- Therefore we are using the inline agent instead.
						Result := eiffel_layout.default_il_environment.installed_runtimes
					end)
				-- Check that environment variables
				-- are properly set.
			if not is_eiffel_layout_defined then
				create l_layout
				l_layout.check_environment_variable
				set_eiffel_layout (l_layout)
			end

				-- Set the default project path to the current working directory.
				-- This may be overriden via user settings.
			project_path :=(create {EXECUTION_ENVIRONMENT}).current_working_path

				--| Initialization of the run-time, so that at the end of a store/retrieve
				--| operation (like retrieving or storing the project, creating the CASEGEN
				--| directory, generating the profile information, ...) the run-time is initialized
				--| back to the values which permits the compiler to access correctly the EIFGEN
				--| directory
			create l_eifgen_init.make

				-- Initialization of compiler resources
			;(create {TTY_RESOURCES}.initialize).do_nothing

				-- Initialization of compiler resources.

			create l_preference_access.make_with_defaults_and_location_and_version (
				<<eiffel_layout.general_preferences.name, eiffel_layout.platform_preferences.name>>, eiffel_layout.eiffel_preferences, version_2_0)
			;(create {SETTABLE_COMPILER_OBJECTS}).set_preferences (create {EC_PREFERENCES}.make (l_preference_access))

				-- Remaining initialization			
			initialize

				-- Execution
			execute (l_preference_access)

			l_eifgen_init.dispose
		end

	initialize
			-- Initialize batch compiler
		do
				-- Initialize compiler encoding converter.
			(create {SHARED_ENCODING_CONVERTER}).set_encoding_converter (create {EC_ENCODING_CONVERTER}.make)
				-- Install code analyzer processor for obsolete calls.
			;(create {CA_CODE_ANALYZER}.make).install_obsolete_call_processor
		end

	execute (preferences: PREFERENCES)
			-- Analyze the command line options and
			-- execute the appropriate command.
		local
			temp: STRING
			new_resources: TTY_RESOURCES
			compilation: EWB_COMP
			l_loader: EC_PROJECT_LOADER
			l_generated_name: PATH
			u: FILE_UTILITIES
		do
			if not retried then
					-- Read the resource files
				create new_resources.initialize

				if not new_resources.error_occurred then
						-- Reset errors
					option_error_message := Void
					option_warning_messages := Void
					analyze_options (preferences)
					if has_error then
						print_option_error
						print_option_warnings
					elseif help_only then
						print_help
					elseif version_only then
						print_version
					elseif not file_error then
						print_option_warnings
						if output_window = Void then
							command.set_output_window (Error_window)
						else
							command.set_output_window (output_window)
						end

							--| Initialization of the display
						Eiffel_project.set_error_displayer (create {DEFAULT_ERROR_DISPLAYER}.make (Error_window))
						if output_file_option then
							Eiffel_project.set_degree_output (create {FILE_DEGREE_OUTPUT}.make (output_file_name))
						end
						degree_output.is_verbose := verbose_option

						if no_project_needed then
								-- No project needs to be loaded, we simply execute the command.
							command.execute
						else
								-- Load project
							create l_loader
							l_loader.set_should_stop_on_prompt (stop_on_error)
							l_loader.set_ignore_user_configuration_file (not is_user_settings_requested)
							l_loader.set_has_library_conversion (not has_no_library_conversion)
							if is_single_file_compilation then
								l_loader.open_single_file_compilation_project (single_file_compilation_filename, single_file_compilation_libraries, project_path, is_clean_requested, configuration_settings)
							elseif attached old_project_file as l_old_project_file then
								l_loader.open_project_file (l_old_project_file, Void, project_path, is_clean_requested, configuration_settings)
							elseif attached old_ace_file as l_old_ace_file then
								l_loader.open_project_file (l_old_ace_file, Void, project_path, is_clean_requested, configuration_settings)
							elseif config_file_name /= Void then
								l_loader.open_project_file (config_file_name.absolute_path.canonical_path, target_name, project_path, is_clean_requested, configuration_settings)
							else
								l_loader.open_project_file (Void, target_name, project_path, is_clean_requested, configuration_settings)
							end

							if not error_occurred and not l_loader.has_error then
								if attached {EWB_LOOP} command then
										-- Interactive mode is exclusive of others.
									command.execute
								else
									if attached {EWB_COMP} command as l_comp then
											-- A compilation flag was passed
										compilation := l_comp
									else
											-- No compilation flag was provided we default to a quick melt.
										create {EWB_QUICK_MELT} compilation
									end
										-- If C compilation was required, enable it.
									compilation.set_is_finish_freezing_called (is_finish_freezing_called)
									compilation.execute

									if command /= compilation and then workbench.system_defined and then system.successful then
											-- Case where we forced a quick melt. In the event we also have the `-tests'
											-- flag and no executable is present, we force a C compilation.
										if is_finish_freezing_for_test_needed then
											eiffel_project.call_finish_freezing_and_wait (True)
										end
											-- Execute other commands if one was specified
										command.execute
									end
								end

								if is_single_file_compilation and then l_loader.eiffel_project.successful then
										-- Copy generated executable in single file compilation to project location
									if is_finalizing then
										l_generated_name := l_loader.eiffel_project.project_directory.final_executable_file_name
									else
										l_generated_name := l_loader.eiffel_project.project_directory.workbench_executable_file_name
									end
										-- Check if generated file exists. If the C compilation fails, the file will not be generated.
									if u.file_path_exists (l_generated_name) then
											-- If generated file exists, copy it to the target location.
										u.copy_file_path (l_generated_name, l_loader.eiffel_project.project_directory.single_file_compilation_executable_file_name)
									end
								end
							end
						end
					end
				end
			end
			if output_window /= Void and then not output_window.is_closed then
				output_window.close
			end
			print_gc_statistics
		rescue
			if error_handler.is_developer_exception then
				Error_handler.trace
				if stop_on_error then
					print_gc_statistics
					die (-1)
				end
				if command_line_io.termination_requested then
					retried := True
					retry
				else
					command := Void
					retry
				end
			else
				localized_print_error (ewb_names.session_aborted)
				localized_print_error (ewb_names.exception_tag)
				temp := original_tag_name
				if output_window /= Void and then not output_window.is_closed then
					output_window.close
				end
				if temp /= Void then
					io.error.put_string (temp)
				end
			end
			io.error.put_new_line
			if not fail_on_rescue then
				retried := True
				retry
			end
		end

	is_finish_freezing_for_test_needed: BOOLEAN
			-- Check if test system is needed when -tests option is present.
		local
			u: FILE_UTILITIES
		do
			if attached {EWB_TEST_EXECUTION} command then
				Result :=
					not Eiffel_project.initialized or else
					not Eiffel_project.system_defined or else
					not u.file_path_exists (eiffel_system.application_name (True))
			end
		end

feature -- Properties

	error_occurred: BOOLEAN;
			-- Did an error occur during the initialization
			-- process?

	retried: BOOLEAN;
			-- For rescues

	no_project_needed: BOOLEAN
			-- Is a project needed to perform `command'?

	command: EWB_CMD
			-- Command to be executed corresponding to
			-- command line options

	command_option: detachable STRING_32
			-- Name of option associated to `command'.

	output_window: FILE_WINDOW
			-- Window where the output is displayed

	file_error: BOOLEAN
			-- Has an error been encountered in opening the
			-- file for redirection?

	has_error: BOOLEAN
			-- Has an error occurred in the procession of the command line?
		do
			Result := option_error_message /= Void
		end

	option_error_message: detachable STRING_32
			-- Error message when an error occurred.

	option_warning_messages: detachable ARRAYED_LIST [READABLE_STRING_32]
			-- Warning messages about using options (if any).

	current_option: INTEGER
			-- Current index in the option list

	help_only: BOOLEAN
			-- Print help information?

	version_only: BOOLEAN
			-- Print version information?

	output_file_option: BOOLEAN
			-- Redirect output to `output_file_name'?

	verbose_option: BOOLEAN
			-- Make compiler output verbose (default: quiet)?

	output_file_name: STRING_32
			-- File which Output is redirected into
			-- if `output_file_option' is set to True.

	option: STRING_32
			-- Current option being analyzed

	single_file_compilation_filename: PATH
			-- File name of Eiffel class file in single file compilation mode

	single_file_compilation_libraries: ARRAYED_LIST [PATH]
			-- List of specified libraries in single file compilation mode

	is_finish_freezing_called: BOOLEAN
			-- Should a freeze or a finalize call `finish_freezing' after generating
			-- C code

	is_project_path_requested: BOOLEAN
			-- Has the user explicitly set -project_path via command line.

	is_precompiling: BOOLEAN
			-- Should compilation actual precompile?

	is_finalizing: BOOLEAN
			-- Is finalized version compiled?

	is_clean_requested: BOOLEAN
			-- Should we recompile from scratch?

	is_user_settings_requested: BOOLEAN
			-- Should we compile without using the configuration file?

	is_single_file_compilation: BOOLEAN
			-- Is only a single file specified to compile?

	has_no_library_conversion: BOOLEAN
			-- Should we not convert clusters into libraries?

	is_gc_stats_enabled: BOOLEAN
			-- Will compiler display some GC timing at the end of a compilation?

	is_experimental_flag_set, is_compatible_flag_set: BOOLEAN
			-- Did use specify one of `-experiment' or `-compat' argument?

	help_messages: HASH_TABLE [READABLE_STRING_GENERAL, STRING]
			-- Help message table.
		once
			create Result.make (48)
			Result [ancestors_cmd_name] := ancestors_help
			Result [aversions_cmd_name] := aversions_help
			Result [batch_cmd_name] := batch_help
			Result [c_compile_cmd_name] := c_compile_help
			Result [ca_class_cmd_name] := ca_class_help
			Result [ca_default_cmd_name] := ca_default_help
			Result [ca_rule_cmd_name] := ca_rule_help
			Result [ca_setting_cmd_name] := ca_setting_help
			Result [callees_cmd_name] := callees_help
			Result [callers_cmd_name] := callers_help
			Result [clean_cmd_name] := clean_help
			Result [clients_cmd_name] := clients_help
			Result [compat_cmd_name] := compat_help
			Result [config_cmd_name] := config_help
			Result [config_option_cmd_name] := config_option_help
			Result [debug_cmd_name] := debug_help
			Result [descendants_cmd_name] := descendants_help
			Result [dversions_cmd_name] := dversions_help
			Result [experiment_cmd_name] := experiment_help
			Result [file_cmd_name] := file_help
			Result [filter_cmd_name] := filter_help
			Result [finalize_cmd_name] := finalize_help
			Result [flat_cmd_name] := flat_help
			Result [flatshort_cmd_name] := flatshort_help
			Result [freeze_cmd_name] := freeze_help
			Result [full_class_checking_cmd_name] := full_help
			Result [gc_stats_cmd_name] := gc_stats_help
			Result [gui_cmd_name] := gui_help
			Result [help_cmd_name] := help_help
			Result [implementers_cmd_name] := implementers_help
			Result [library_cmd_name] := library_help
			Result [loop_cmd_name] := loop_help
			Result [melt_cmd_name] := melt_help
			Result [no_library_cmd_name] := no_library_help
			Result [overwrite_old_project_cmd_name] := overwrite_old_project_help
			Result [precompile_cmd_name] := precompile_help
			Result [preference_cmd_name] := preference_help
			Result [pretty_cmd_name] := pretty_help
			Result [project_cmd_name] := project_help
			Result [project_path_cmd_name] := project_path_help
			Result [quick_melt_cmd_name] := quick_melt_help
			Result [reset_ide_layout_cmd_name] := reset_ide_layout_help
			Result [short_cmd_name] := short_help
			Result [single_file_compilation_cmd_name] := single_file_compilation_help
			Result [stop_cmd_name] := stop_help
			Result [suppliers_cmd_name] := suppliers_help
			Result [target_cmd_name] := target_help
			Result [use_settings_cmd_name] := use_settings_help
			Result [version_cmd_name] := version_help
		end

	loop_cmd: EWB_LOOP
			-- Loop command
		do
			create Result
		end

feature -- Setting

	set_file (filename: READABLE_STRING_GENERAL)
			-- Set the output_window file to `filename'.
		do
			create output_window.make_with_name (filename)
			if output_window.exists then
				localized_print_error (ewb_names.file_exists (filename))
				file_error := True
			else
				output_window.open_file
				if not output_window.exists then
					localized_print_error (ewb_names.cannot_create_file)
					localized_print_error (filename)
					io.error.put_new_line
					file_error := True
				end
			end
		end

feature {NONE} -- Output

	print_option_error
			-- Print the incorrect usage of ewb.
		do
			print_version
			localized_print ("%N")
			localized_print (argument (0))
			localized_print (ewb_names.incorrect_options);
			localized_print ("%N")
			localized_print (option_error_message)
			localized_print ("%N")
		end

	add_option_warning (m: READABLE_STRING_32)
			-- Add message `m' to the list of option warning messages.
		local
			ms: like option_warning_messages
		do
			ms := option_warning_messages
			if not attached ms then
				create ms.make (1)
				option_warning_messages := ms
			end
			ms.extend (m)
		ensure
			added: attached option_warning_messages as w and then w.last = m
		end

	print_option_warnings
			-- Print the incorrect usage of ewb.
		do
			if attached option_warning_messages as m then
				across m as mc loop
					localized_print (mc.item)
					localized_print ("%N")
				end
			end
		end

	print_usage
			-- Print the usage of command line options.
		do
			print_version
			io.put_new_line
			localized_print (ewb_names.usage)
			localized_print (argument (0))
				-- The leading space on the first line is required to delimit options from the command name.
			io.put_string ("[
				 -help | [-compat | -experiment] | -version | -full |
				-batch | -clean | -verbose | -use_settings |
				-freeze | -finalize [-keep] | -precompile [-finalize [-keep]] | -c_compile |
				-loop | -debug | -quick_melt | -melt |
				(-clients | -suppliers | -ancestors | -descendants) [-filter filtername] class |
				(-flatshort | -flat | -short) [-filter filtername] [-all | -all_and_parents | class] |
				(-aversions | -dversions | -implementers) [-filter filtername] class feature |
				-callers [-filter filtername] [-show_all] [-assigners | -creators] class feature |
				-callees [-filter filtername] [-show_all] [-assignees | -creators] class feature |
				-filter filtername [-all | class] |
				-pretty input_filename [output_filename] |
				-reset_ide_layout |
				[[-config config.ecf] [-target target] [-config_option option] |
				[class_file.e [-library library_name]] |
				-stop | -no_library |
				-project_path project_directory | -file file |
				-preference preference_name preference_value |
				-ca_class (-all | class) | -ca_default | -ca_rule rule | -ca_setting file |
				-gc_stats]

			]")
		end

	print_version
			-- Print Version Number
		do
			io.put_string_32 ({STRING_32} "ISE " + Workbench_name + " version " + Version_number + "%N")
		end

	print_help
			-- Print the help.
		local
			command_list: SORTED_TWO_WAY_LIST [STRING]
			cmd_name: STRING
		do
			print_usage
			localized_print (ewb_names.options)
			localized_print (ewb_names.default_quick_melt_the_system)

			create command_list.make
			across
				help_messages.current_keys as k
			loop
				command_list.extend (k.item)
			end
			across
				command_list as c
			loop
				cmd_name := c.item
				print_one_help (cmd_name, help_messages.item (cmd_name))
			end
		end

	print_one_help (opt: STRING; txt: READABLE_STRING_GENERAL)
		do
			io.put_string ("%T-")
			io.put_string (opt)
			io.put_string (": ")
			localized_print (txt)
			io.put_string (".%N")
		end

	print_gc_statistics
			-- Display some GC statistics if `is_gc_stats_enabled'.
		local
			l_mem: MEMORY
			l_mem_info: MEM_INFO
			l_full_gc_info, l_part_gc_info: GC_INFO
		do
			if is_gc_stats_enabled then
				create l_mem
					-- Get current GC stats
				l_full_gc_info := l_mem.gc_statistics ({MEM_CONST}.full_collector)
				l_part_gc_info := l_mem.gc_statistics ({MEM_CONST}.incremental_collector)

					-- Do a full collect and coalesc, then retrieve final memory statistics
				l_mem.full_collect
				l_mem.full_coalesce
				l_mem_info := l_mem.memory_statistics ({MEM_CONST}.eiffel_memory)

				io.put_new_line
				io.put_string ("                   Total |      Used |  Overhead |      Free")
				io.put_new_line
				io.put_string ("Eiffel memory: ")
				print_memory_value (l_mem_info.total64)
				io.put_string (" | ")
				print_memory_value (l_mem_info.used64)
				io.put_string (" | ")
				print_memory_value (l_mem_info.overhead64)
				io.put_string (" | ")
				print_memory_value (l_mem_info.free64)
				io.put_new_line

				l_mem_info := l_mem.memory_statistics ({MEM_CONST}.c_memory)
				io.put_string ("C memory:      ")
				print_memory_value (l_mem_info.total64)
				io.put_string (" | ")
				print_memory_value (l_mem_info.used64)
				io.put_string (" | ")
				print_memory_value (l_mem_info.overhead64)
				io.put_string (" | ")
				print_memory_value (l_mem_info.free64)
				io.put_new_line

				l_mem_info := l_mem.memory_statistics ({MEM_CONST}.total_memory)
				io.put_string ("Total memory:  ")
				print_memory_value (l_mem_info.total64)
				io.put_string (" | ")
				print_memory_value (l_mem_info.used64)
				io.put_string (" | ")
				print_memory_value (l_mem_info.overhead64)
				io.put_string (" | ")
				print_memory_value (l_mem_info.free64)
				io.put_new_line

				io.put_new_line

				io.put_string ("GC full cycle iterations   = " + l_full_gc_info.cycle_count.out + "%N")
				io.put_string ("GC full cycle average time = " + l_full_gc_info.cpu_time_average.out + "%N")
				io.put_new_line


				io.put_string ("GC incremental cycle iterations   = " + l_part_gc_info.cycle_count.out + "%N")
				io.put_string ("GC incremental cycle average time = " + l_part_gc_info.cpu_time_average.out + "%N")
				io.put_string ("CPU time " + l_part_gc_info.cpu_total_time.out + "%N")
				io.put_string ("Kernel time " + l_part_gc_info.sys_total_time.out + "%N")
				io.put_string ("Full Collection period " + l_mem.collection_period.out + "%N")
				io.put_string ("GC percentage time " +
					(100 * (((l_full_gc_info.cycle_count * l_full_gc_info.cpu_time_average) +
					 (l_part_gc_info.cycle_count * l_part_gc_info.cpu_time_average)) /
					 l_part_gc_info.cpu_total_time)).out + "%N%N")
			end
		end

feature {NONE} -- Update

	analyze_options (preferences: PREFERENCES)
			-- Analyze the options entered by the user.
		do
				-- Reset compiler_profile
			compiler_profile.reset

				-- Default Project Options
			from
				current_option := 1
			until
				(current_option > argument_count) or else has_error
			loop
				analyze_one_option (preferences)
			end
				-- Default command
			if (not has_error) and then (command = Void) then
				if is_precompiling then
					create {EWB_PRECOMP} command
					command_option := "-precompile"
				else
					create {EWB_QUICK_MELT} command
					command_option := "-quick_melt"
				end
			end
		end

	code_analysis_command: EWB_CODE_ANALYSIS
			-- Code analysis command.

	configuration_settings: detachable CONF_TARGET_SETTINGS
			-- Configuration settings (if any) specified in the command-line.

	configuration_option_parser: CONF_STRING_PARSER
			-- A parser of configuration options.

	analyze_one_option (preferences: PREFERENCES)
			-- Analyze current option.
		local
			cn, fn: STRING_32
			filter_name: STRING_32
			show_all: BOOLEAN
			show_assigners: BOOLEAN
			show_creators: BOOLEAN
			ewb_senders: EWB_SENDERS
			ewb_callees: EWB_CALLEES
			l_arg: READABLE_STRING_32
			in_filename, out_filename: STRING_32
			l_configuration_settings: like configuration_settings
		do
			filter_name := ""
			option := argument (current_option);

			if option.same_string_general ("-help") then
				help_only := True
			elseif option.same_string_general ("-loop") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				else
					command := loop_cmd
					command_option := option
				end
			elseif option.same_string_general ("-verbose") then
				verbose_option := True
			elseif option.same_string_general ("-version") then
				version_only := True
			elseif option.same_string_general ("-quick_melt") then
				if command = Void then
					create {EWB_QUICK_MELT} command
					command_option := option
				else
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				end
			elseif option.same_string_general ("-melt") then
				if command = Void then
					create {EWB_COMP} command
					command_option := option
				else
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				end
			elseif option.same_string_general ("-" + debug_cmd_name) then
				if command = Void then
					create {EWB_DEBUG} command
					command_option := "-" + debug_cmd_name
				else
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				end

			elseif
				option.same_string_general ("-dversions") or
				option.same_string_general ("-aversions") or
				option.same_string_general ("-implementers")
			then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				elseif current_option < argument_count then
					current_option := current_option + 1
					if argument (current_option).same_string_general ("-filter") then
						if current_option < argument_count then
							current_option := current_option + 1
							filter_name := argument (current_option)
							if current_option < argument_count then
									-- Fetch next option
								current_option := current_option + 1
							else
								option_error_message := locale.formatted_string ("Missing class and feature name for option $1.", option)
							end
						else
							option_error_message := locale.translation ("Missing filter name for option -filter.")
						end
					end
					if not has_error then
						cn := argument (current_option)
						if current_option < argument_count then
							current_option := current_option + 1
							fn := argument (current_option)
							if option.same_string_general ("-dversions") then
								create {EWB_FUTURE} command.make (cn, fn, filter_name)
							elseif option.same_string_general ("-aversions") then
								create {EWB_PAST} command.make (cn, fn, filter_name)
							else
								create {EWB_HISTORY} command.make (cn, fn, filter_name)
							end
							command_option := option
						else
							option_error_message := locale.formatted_string ("Missing feature name for option $1.", option)
						end
					end
				else
					option_error_message := locale.formatted_string ("Missing class and feature name for option $1.", option)
				end

			elseif option.same_string_general ("-callers") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				elseif current_option < argument_count then
					current_option := current_option + 1
					l_arg := argument (current_option)
					if l_arg.same_string_general ("-filter") then
						if current_option < argument_count then
							current_option := current_option + 1
							filter_name := argument (current_option)
							if current_option < argument_count then
									-- Fetch next option
								current_option := current_option + 1
							else
								option_error_message := locale.translation ("Missing class and feature name for option -callers")
							end
						else
							option_error_message := locale.translation ("Missing filter name for option -filter.")
						end
					end

					if not has_error and then argument (current_option).same_string_general ("-show_all") then
						show_all := True
						if current_option < argument_count then
								-- Fetch next option
							current_option := current_option + 1
						else
							option_error_message := locale.translation ("Missing class and feature name for option -callers")
						end
					end
					if
						not has_error and then
						(argument (current_option).same_string_general ("-assigners") or
						argument (current_option).same_string_general ("-creators"))
					then
						if argument (current_option).same_string_general ("-assigners") then
							show_assigners := True
						else
							show_creators := True
						end
						if current_option < argument_count then
								-- Fetch next option
							current_option := current_option + 1
						else
							option_error_message := locale.translation ("Missing class and feature name for option -callers")
						end
					end
					if not has_error then
						cn := argument (current_option)
						if current_option < argument_count then
							current_option := current_option + 1
							fn := argument (current_option)
							create ewb_senders.make (cn, fn, filter_name)
							if show_all then
								ewb_senders.set_all_callers
							end
							if show_assigners then
								ewb_senders.set_assigners_only
							elseif show_creators then
								ewb_senders.set_creators_only
							end
							command := ewb_senders
							command_option := option
						else
							option_error_message := locale.translation ("Missing feature name for option -callers")
						end
					end
				else
					option_error_message := locale.translation ("Missing class and feature name for option -callers")
				end

			elseif option.same_string_general ("-callees") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				elseif current_option < argument_count then
					current_option := current_option + 1
					l_arg := argument (current_option)
					if l_arg.same_string_general ("-filter") then
						if current_option < argument_count then
							current_option := current_option + 1
							filter_name := argument (current_option)
							if current_option < argument_count then
									-- Fetch next option
								current_option := current_option + 1
							else
								option_error_message := locale.translation ("Missing class and feature name for option -callees")
							end
						else
							option_error_message := locale.translation ("Missing filter name for option -filter.")
						end
					end

					if not has_error and then argument (current_option).same_string_general ("-show_all") then
						show_all := True
						if current_option < argument_count then
								-- Fetch next option
							current_option := current_option + 1
						else
							option_error_message := locale.translation ("Missing class and feature name for option -callers")
						end
					end
					if
						not has_error and then
						(argument (current_option).same_string_general ("-assignees") or
						argument (current_option).same_string_general ("-creators"))
					then
						if argument (current_option).same_string_general ("-assignees") then
							show_assigners := True
						else
							show_creators := True
						end
						if current_option < argument_count then
								-- Fetch next option
							current_option := current_option + 1
						else
							option_error_message := locale.translation ("Missing class and feature name for option -callers")
						end
					end
					if not has_error then
						cn := argument (current_option)
						if current_option < argument_count then
							current_option := current_option + 1
							fn := argument (current_option)
							create ewb_callees.make (cn, fn, filter_name)
							if show_all then
								ewb_callees.set_all_callees
							end
							if show_assigners then
								ewb_callees.set_assignees_only
							elseif show_creators then
								ewb_callees.set_creations_only
							end
							command := ewb_callees
							command_option := option
						else
							option_error_message := locale.translation ("Missing feature name for options -callees")
						end
					end
				else
					option_error_message := locale.translation ("Missing class and feature name for option -callees")
				end
			elseif option.same_string_general ("-c_compile") then
				is_finish_freezing_called := True

			elseif
				option.same_string_general ("-flat") or
				option.same_string_general ("-short") or
				option.same_string_general ("-flatshort")
			then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				elseif current_option < argument_count then
					current_option := current_option + 1
					cn := argument (current_option)
					if cn.same_string_general ("-filter") then
						if current_option < argument_count then
							current_option := current_option + 1
							filter_name := argument (current_option)
							if current_option < argument_count then
								current_option := current_option + 1
								cn := argument (current_option)
							else
								option_error_message := locale.formatted_string ("Missing class name, -all or -all_and_parents for option $1 after filter name.", [option])
							end
						else
							option_error_message := locale.translation ("Missing filter name for option -filter.")
						end
					end
					if not has_error then
						if option.same_string_general ("-flat") then
							if cn.same_string_general ("-all") then
								create {EWB_DOCUMENTATION} command.make_flat (filter_name, false)
							elseif cn.same_string_general ("-all_and_parents") then
								create {EWB_DOCUMENTATION} command.make_flat (filter_name, true)
							else
								create {EWB_FLAT} command.make (cn, filter_name)
							end
						elseif option.same_string_general ("-short") then
							if cn.same_string_general ("-all") then
								create {EWB_DOCUMENTATION} command.make_short (filter_name, false)
							elseif cn.same_string_general ("-all_and_parents") then
								create {EWB_DOCUMENTATION} command.make_short (filter_name, true)
							else
								create {EWB_SHORT} command.make (cn, filter_name)
							end
						else
							check option.same_string_general ("-flatshort") end
							if cn.same_string_general ("-all") then
								create {EWB_DOCUMENTATION} command.make_flat_short (filter_name, false)
							elseif cn.same_string_general ("-all_and_parents") then
								create {EWB_DOCUMENTATION} command.make_flat_short (filter_name, true)
							else
								create {EWB_FS} command.make (cn, filter_name)
							end
						end
						command_option := option
					end
				else
					option_error_message := locale.formatted_string ("Missing class name, -all or -all_and_parents for option $1.", [option])
				end

			elseif option.same_string_general ("-pretty") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				else
					no_project_needed := True

					if current_option + 1 < argument_count then
							-- Input filename and output filename are given
						in_filename := argument (current_option + 1)
						out_filename := argument (current_option + 2)
						current_option := current_option + 2

					elseif current_option < argument_count then
							-- Only input filename given (use STDOUT for output)
						in_filename := argument (current_option + 1)
						out_filename := ""
						current_option := current_option + 1

					else
							-- Incorrect number of options	
						option_error_message := locale.translation ("Missing input class file path for option -pretty")
					end

					if not has_error then
						create {EWB_PRETTY} command.make (in_filename, out_filename)
						command_option := option
					end
				end

			elseif option.same_string_general ("-reset_ide_layout") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				else
					no_project_needed := True

					if not has_error then
						create {EWB_RESET_IDE_LAYOUT} command.make
						command_option := option
					end
				end

			elseif option.same_string_general ("-filter") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				elseif current_option < argument_count then
					current_option := current_option + 1
					filter_name := argument (current_option)
					if current_option < argument_count then
						current_option := current_option + 1
						cn := argument (current_option)
						if cn.same_string_general ("-all") then
							create {EWB_DOCUMENTATION} command.make_text (filter_name)
						else
							create {EWB_TEXT} command.make (cn, filter_name)
						end
						command_option := option
					else
						option_error_message := locale.translation ("Missing class name or -all argument following filter name.")
					end
				else
					option_error_message := locale.translation ("Missing filter name for option -filter.")
				end
			elseif
				option.same_string_general ("-ancestors") or
				option.same_string_general ("-clients") or
				option.same_string_general ("-suppliers") or
				option.same_string_general ("-descendants")
			then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				elseif current_option < argument_count then
					current_option := current_option + 1
					if argument (current_option).same_string_general ("-filter") then
						if current_option < argument_count then
							current_option := current_option + 1
							filter_name := argument (current_option)
							if current_option < argument_count then
									-- Fetch next option
								current_option := current_option + 1
							else
								option_error_message := locale.formatted_string ("Missing class name for option $1.", option)
							end

						else
							option_error_message := locale.translation ("Missing filter name for option -filter.")
						end
					end
					if not has_error then
						cn := argument (current_option)
						if option.same_string_general ("-ancestors") then
							create {EWB_ANCESTORS} command.make (cn, filter_name)
						elseif option.same_string_general ("-clients") then
							create {EWB_CLIENTS} command.make (cn, filter_name)
						elseif option.same_string_general ("-suppliers") then
							create {EWB_SUPPLIERS} command.make (cn, filter_name)
						else
							check option.same_string_general ("-descendants") end
							create {EWB_DESCENDANTS} command.make (cn, filter_name)
						end
						command_option := option
					end
				else
					option_error_message := locale.formatted_string ("Missing class name for option $1.", option)
				end

			elseif option.same_string_general ("-project") then
				add_option_warning (messages.w_obsolete_command_line_option (option))
				if is_single_file_compilation then
						-- In single file compilation mode no ace file may be specified
					option_error_message := locale.translation ("Cannot mix -project, -config or -target when compiling a system using an Eiffel class as argument")
				elseif current_option < argument_count then
					current_option := current_option + 1
					create old_project_file.make_from_string (argument (current_option))
				else
					option_error_message := locale.translation ("Missing project file for option -project.")
				end

			elseif option.same_string_general ("-output_file") then
				if current_option < argument_count then
					current_option := current_option + 1
					output_file_name := argument (current_option)
					output_file_option := True
				else
					option_error_message := locale.translation ("Missing path for option -output_file.")
				end

			elseif option.same_string_general ("-project_path") then
				if is_user_settings_requested then
						-- It is an error to use `-project_path' and `use_settings' together.
					option_error_message := locale.translation ("Argument -project_path conflicts with -use_settings.")
				elseif current_option < argument_count then
					current_option := current_option + 1
					create project_path.make_from_string (argument (current_option))
					is_project_path_requested := True
				else
					option_error_message := locale.translation ("Missing project path for option -project_path.")
				end
			elseif option.same_string_general ("-ace") then
				add_option_warning (messages.w_obsolete_command_line_option (option))
				if is_single_file_compilation then
						-- In single file compilation mode no ace file may be specified
					option_error_message := locale.translation ("Cannot mix -config or -target when compiling a system using an Eiffel class as argument")
				elseif current_option < argument_count then
					current_option := current_option + 1
					create old_ace_file.make_from_string (argument (current_option))
				else
					option_error_message := locale.translation ("Missing config name for option -ace.")
				end
			elseif option.same_string_general ("-config") then
				if is_single_file_compilation then
						-- In single file compilation mode no config file may be specified
					option_error_message := locale.translation ("Cannot mix -config or -target when compiling a system using an Eiffel class as argument")
				elseif current_option < argument_count then
					current_option := current_option + 1
					create config_file_name.make_from_string (argument (current_option))
				else
					option_error_message := locale.translation ("Missing config name for option -config.")
				end
			elseif option.same_string_general ("-config_option") then
				if current_option < argument_count then
					current_option := current_option + 1
					l_configuration_settings := configuration_settings
					if not attached l_configuration_settings then
						create l_configuration_settings.make
						configuration_settings := l_configuration_settings
					end
					configuration_option_parser.parse_target_settings (argument (current_option), l_configuration_settings)
					if attached configuration_option_parser.error as e then
							-- Add option name to the error message.
						option_error_message := locale.formatted_string (locale.translation_in_context
							("Error in command-line option %"$1%": $2.", once "compiler.command-line.option"), option, e)
							-- Reset configuration settings.
						configuration_settings := Void
					end
				else
					option_error_message := locale.formatted_string (locale.translation_in_context
						("Missing configuration option for option %"$1%".", once "compiler.command-line.option"), option)
				end
			elseif option.same_string_general ("-preference") then
					-- Set specified preference to the given value.
				if current_option >= argument_count then
					option_error_message := locale.formatted_string (locale.translation_in_context
						("[
							Missing preference name for option "$1".
						]", once "compiler.command-line.option"), option)
				elseif current_option + 1 >= argument_count then
					current_option := current_option + 1
					option_error_message := locale.formatted_string (locale.translation_in_context
						("[
							Missing preference value for option "$1".
						]", once "compiler.command-line.option"), option)
				else
					current_option := current_option + 2
					if not attached preferences.get_preference ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (argument (current_option - 1))) as p then
						option_error_message := locale.formatted_string (locale.translation_in_context
							("[
								Unknown preference name for option "$1": "$2".
							]", once "compiler.command-line.option"), option, argument (current_option - 1))
					elseif not p.is_valid_string_for_selection (argument (current_option)) then
						option_error_message := locale.formatted_string (locale.translation_in_context
							("[
								Invalid preference value "$3" for preference of name "$2" in option "$1".
							]", once "compiler.command-line.option"), option, argument (current_option - 1), argument (current_option))
					else
						p.select_value_from_string (argument (current_option))
					end
				end
			elseif option.same_string_general ("-target") then
				if is_single_file_compilation then
						-- In single file compilation mode no target may be specified
					option_error_message := locale.translation ("Cannot mix -config or -target when compiling a system using an Eiffel class as argument")
				elseif current_option < argument_count then
					current_option := current_option + 1
					target_name := argument (current_option)
				else
					option_error_message := locale.translation ("Missing target name for option -target.")
				end
			elseif option.same_string_general ("-stop") or else option.same_string_general ("-batch") then
					-- The compiler stops on errors, useful for batch compilation without
					-- user intervention.
				set_stop_on_error (True)
			elseif option.same_string_general ("-clean") then
					-- Compiler will delete project and recompile from scratch without
					-- asking.
				is_clean_requested := True
			elseif option.same_string_general ("-local") then
					-- FIXME: for temporary measure so that we do not reject -local which
					-- is the behavior by default.
			elseif option.same_string_general ("-use_settings") then
					-- Compiler will read user configuration file for that project
				if not is_project_path_requested then
					is_user_settings_requested := True
						-- Unset default project path.
					project_path := Void
				else
						-- It is an error to use 'project_path' and 'use_settings' together.
					option_error_message := locale.translation ("Argument -use_settings conflicts with -project_path.")
				end
			elseif option.same_string_general ("-no_library") then
					-- Compiler will read user configuration file for that project
				has_no_library_conversion := True

			elseif option.same_string_general ("-gc_stats") then
					-- Compiler will display some GC timing at the end of a compilation.
				is_gc_stats_enabled := True
					-- Start accounting for GC statistics.
				(create {MEMORY}).enable_time_accounting

			elseif option.same_string_general ("-file") then
				if current_option < argument_count then
					current_option := current_option + 1
					set_file (argument (current_option))
				else
					option_error_message := locale.translation ("Missing file name argument for -file.")
				end
			elseif option.same_string_general ("-dumploop") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				else
					create {EWB_DUMP_LOOP} command
					command_option := option
				end
			elseif option.same_string_general ("-dumpuniverse") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				else
					create {EWB_DUMP_UNIVERSE} command
					command_option := option
				end
			elseif option.same_string_general ("-dumpclasses") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				else
					create {EWB_DUMP_CLASSES} command
					command_option := option
				end
			elseif option.same_string_general ("-dumpfeatures") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				elseif current_option < argument_count then
					current_option := current_option + 1
					cn := argument (current_option)
					if
						current_option < argument_count and then
						argument (current_option + 1).same_string_general ("verbose")
					then
						current_option := current_option + 1;
						create {EWB_DUMP_FEATURES} command.make_verbose (cn)
					else
						create {EWB_DUMP_FEATURES} command.make (cn)
					end
					command_option := option
				else
					option_error_message := locale.translation ("Missing class name argument for -dumpfeatures.")
				end
			elseif option.same_string_general ("-dumpoperands") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				elseif current_option + 1 < argument_count then
					current_option := current_option + 1
					cn := argument (current_option)
					current_option := current_option + 1
					fn := argument (current_option)
					create {EWB_DUMP_OPERANDS} command.make (cn, fn, Void)
					command_option := option
				else
					option_error_message := locale.translation ("Missing class name and feature name arguments for -dumpoperands.")
				end
			elseif option.same_string_general ("-precompile") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				else
					is_precompiling := True
				end
			elseif option.same_string_general ("-metadata_cache_path") then
				if current_option + 1 < argument_count then
					current_option := current_option + 1
					set_overridden_metadata_cache_path (argument (current_option))
				else
					option_error_message := locale.translation ("Missing path to metadata cache path.")
				end
			elseif option.same_string_general ("-library") then
					-- This option is only valid if no other config options are set
				if config_file_name = Void and target_name = Void and old_ace_file = Void and old_project_file = Void then
					if single_file_compilation_libraries = Void then
						create single_file_compilation_libraries.make (5)
					end
					if current_option < argument_count then
						current_option := current_option + 1
						l_arg := argument (current_option)
						if l_arg /= Void then
							single_file_compilation_libraries.extend (create {PATH}.make_from_string (l_arg))
						else
							option_error_message := locale.translation ("Missing library argument.")
						end
					end
				else
					option_error_message := locale.translation ("Cannot mix -config or -target when compiling a system using an Eiffel class as argument")
				end
			elseif option.same_string_general ("-compat") then
					-- This option enables the default set of options of 6.3 and earlier if not specified
					-- in the ECF file.
				if is_experimental_flag_set then
					option_error_message := locale.translation ("Cannot override -experiment with -compat.")
				else
					compiler_profile.set_compatible_mode
					is_compatible_flag_set := True
				end
			elseif option.same_string_general ("-experiment") then
					-- This option enables the new options of the compiler that are not mainstream.
				if is_compatible_flag_set then
					option_error_message := locale.translation ("Cannot override -compat with -experiment.")
				else
					compiler_profile.set_experimental_mode
					is_experimental_flag_set := True
				end
			elseif option.same_string_general ("-full") then
					-- This options enables full class checking even if not specified in ECF.
				compiler_profile.set_full_class_checking_mode
			elseif option.same_string_general ("-safe") then
					-- Use "-safe" versions of ECFs if available.
				compiler_profile.set_safe_mode
			elseif option.same_string_general ("-platform") then
					-- This options enables the choice of the platform.
				if current_option < argument_count then
					current_option := current_option + 1
					if compiler_profile.is_platform_valid (argument (current_option)) then
						compiler_profile.set_platform (argument (current_option))
					else
						option_error_message := locale.translation ("Invalid platform argument")
					end
				else
					option_error_message := locale.translation ("Platform option requires a platform name.")
				end

			elseif option.same_string_general (compiler_profile.capabilty_option) then
					-- This options specifies how capabilities are processed.
				if current_option < argument_count then
					current_option := current_option + 1
					if compiler_profile.is_capability_valid (argument (current_option)) then
						compiler_profile.set_capability (argument (current_option))
					else
						option_error_message :=
							locale.formatted_string (
								locale.translation ("Capability option value should be one of %"$1%", %"$2%", %"$3%"."),
								compiler_profile.capability_value_warning,
								compiler_profile.capability_value_error,
								compiler_profile.capability_value_strict
							)

					end
				else
					option_error_message := locale.translation ("Capability option requires a value.")
				end


			elseif option.same_string_general ("-auto_test") then
					-- FIXME: This only works if `-auto_test' is the last argument, as otherwise it will
					-- override the compilation option that was previously set.
				create {EWB_AUTO_TEST} command.make_with_arguments
					(arguments_in_range (current_option + 1, argument_count))
				current_option := argument_count + 1
				command_option := option

			elseif option.same_string_general ("-code-analysis") then
					-- FIXME: This only works if `-code-analysis' is the last argument.
				add_option_warning (messages.w_obsolete_command_line_option (option))
				if attached command then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				else
					code_analysis_command.parse_arguments (arguments_in_range (current_option + 1, argument_count))
					current_option := argument_count + 1
					if attached code_analysis_command.argument_error as e then
						option_error_message := e
					else
						command := code_analysis_command
					end
				end

			elseif option.same_string_general ("-ca_default") then
				code_analysis_command.set_defaults

			elseif option.same_string_general ("-ca_setting") then
				if current_option < argument_count then
					current_option := current_option + 1
					code_analysis_command.set_preference_file (argument (current_option))
				else
					option_error_message := code_analysis_command.ca_messages.missing_file_name ("-ca_setting")
				end

			elseif option.same_string_general ("-ca_class") then
					-- Check if a command is already set to something different from `code_analysis_command'.
				if attached command and then command /= code_analysis_command then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				elseif current_option < argument_count then
						-- Read a class name or "-all" for all classes.
					current_option := current_option + 1
					l_arg := argument (current_option)
					if l_arg.same_string_general ("-all") then
						code_analysis_command.set_all_classes
					else
						code_analysis_command.add_class (l_arg)
					end
					command := code_analysis_command
				else
					option_error_message := code_analysis_command.ca_messages.missing_class ("-ca_class")
				end

			elseif option.same_string_general ("-ca_rule") then
				if current_option < argument_count then
					current_option := current_option + 1
					code_analysis_command.add_rule (argument (current_option))
					if attached code_analysis_command.argument_error as e then
							-- Add option name to the error message.
						option_error_message := code_analysis_command.ca_messages.rule_argument_error ("-ca_rule", e)
					end
				else
					option_error_message := code_analysis_command.ca_messages.missing_rule ("-ca_rule")
				end

			elseif option.same_string_general ("-tests") then
					-- FIXME: This only works if `-tests' is the last argument, as otherwise it will
					-- override the compilation option that was previously set.
				create {EWB_TEST_EXECUTION} command
				command_option := option

			elseif is_eiffel_class_file_name (create {PATH}.make_from_string (option)) then
					-- This option is only valid if no other config options are set
				if config_file_name = Void and target_name = Void and old_ace_file = Void and old_project_file = Void then
					create single_file_compilation_filename.make_from_string (argument (current_option))
					is_single_file_compilation := True
						-- Implies finish freezing
					is_finish_freezing_called := True
						-- If no libraries are set yet, initialize empty list
					if single_file_compilation_libraries = Void then
						create single_file_compilation_libraries.make (5)
					end
				else
					option_error_message := locale.translation ("Cannot mix -config or -target when compiling a system using an Eiffel class as argument")
				end
			else
				process_special_options
			end
			current_option := current_option + 1
		end

	process_special_options
			-- Process the special option.
		local
			keep: BOOLEAN
		do
			if option.same_string_general ("-freeze") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				else
					create {EWB_FREEZE} command
					command_option := option
				end
			elseif option.same_string_general ("-finalize") then
				if command /= Void then
					option_error_message := locale.formatted_string ({STRING_32} "Option `$1' conflicts with `$2'.", [option, command_option])
				else
					if
						current_option < argument_count and then
						argument (current_option + 1).same_string_general ("-keep")
					then
						current_option := current_option + 1
						keep := True
					end
					if is_precompiling then
						create {EWB_FINALIZE_PRECOMP} command.make (keep)
					else
						create {EWB_FINALIZE} command.make (keep)
					end
					command_option := option
					is_finalizing := True
				end
			else
				option_error_message := locale.formatted_string ({STRING_32} "Unknown option `$1'.", [option])
			end
		end

feature {NONE} -- Onces

	command_line_io: COMMAND_LINE_IO
		once
			create Result
		end

feature {NONE} -- Implementation

	old_ace_file: PATH
			-- Old ace file to convert.

	old_project_file: PATH
			-- Old project file to convert.

	config_file_name: PATH
			-- Name of the configuration file.

	target_name: STRING_32
			-- Name of the target.

	project_path: PATH
			-- Name of the path where project will be compiled.

	is_eiffel_class_file_name (a_filename: PATH): BOOLEAN
			-- Is `a_filename' an Eiffel class file?
			-- This checks if the filename has an 'e' extension.
		require
			a_filename_not_void: a_filename /= Void
		do
			Result := a_filename.has_extension (eiffel_extension)
		end

	print_memory_value (a_value: NATURAL_64)
			-- Display `a_value' on screen.
		local
			l_real_64: REAL_64
			l_unit: STRING
		do
			if a_value > (1024 ^ 3) then
					-- Display in GB
				l_real_64 := a_value / (1024 ^ 3)
				l_unit := " GB"
			elseif a_value > (1024 ^ 2) then
					-- Display in MB
				l_real_64 := a_value / (1024 ^ 2)
				l_unit := " MB"
			elseif a_value > 1024 then
					-- Display in KB
				l_real_64 := a_value / 1024
				l_unit := " KB"
			else
				l_real_64 := a_value
				l_unit := "   "
			end

			io.put_string ((create {FORMAT_DOUBLE}.make (6, 2)).formatted (l_real_64))
			io.put_string (l_unit)
		end

	arguments_in_range (a_lower, a_upper: INTEGER): LINKED_LIST [READABLE_STRING_32]
			-- Arguments from position `a_lower' to `a_upper'
		require
			a_lower_valid: a_lower > 0 and a_lower <= argument_count + 1
			a_upper_valid: a_upper > 0 and a_upper <= argument_count and a_lower <= a_upper + 1
		local
			i: INTEGER
		do
			create Result.make
			from
				i := a_lower
			until
				i > a_upper
			loop
				Result.force (argument (i))
				i := i + 1
			end
		end

note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
