indexing
	description:
		"Batch compiler without invoking the -loop. This is the root%
		%class for the personal version (which does allow c compilation)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES

inherit
	ARGUMENTS

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

	EIFFEL_LAYOUT

	SHARED_BATCH_NAMES

create
	make

feature -- Initialization

	make is
			-- Initialization
		local
			l_layout: ES_EIFFEL_LAYOUT
			l_eifgen_init: INIT_SERVERS
			l_preference_access: PREFERENCES
			new_resources: TTY_RESOURCES
			l_ec_preferences: EC_PREFERENCES
			l_compiler_setting: SETTABLE_COMPILER_OBJECTS
		do
				-- Check that environment variables
				-- are properly set.
			if not is_eiffel_layout_defined then
				create l_layout
				l_layout.check_environment_variable
				set_eiffel_layout (l_layout)
			end

				--| Initialization of the run-time, so that at the end of a store/retrieve
				--| operation (like retrieving or storing the project, creating the CASEGEN
				--| directory, generating the profile information, ...) the run-time is initialized
				--| back to the values which permits the compiler to access correctly the EIFGEN
				--| directory
			create l_eifgen_init.make

				-- Initialization of compiler resources
			create new_resources.initialize

				-- Initialization of compiler resources.
			create l_preference_access.make_with_defaults_and_location (
				<<eiffel_layout.general_preferences, eiffel_layout.platform_preferences>>, eiffel_layout.eiffel_preferences)
			create l_ec_preferences.make (l_preference_access)
			create l_compiler_setting
			l_compiler_setting.set_preferences (l_ec_preferences)

				-- Remaining initialization			
			initialize

				-- Execution
			execute

			l_eifgen_init.dispose
		end

	initialize is
			-- Initialize batch compiler
		do
				-- Initialize compiler encoding converter.
			(create {SHARED_ENCODING_CONVERTER}).set_encoding_converter (create {EC_ENCODING_CONVERTER})
		end

	execute is
			-- Analyze the command line options and
			-- execute the appropriate command.
		local
			temp: STRING
			new_resources: TTY_RESOURCES
			file_degree_output: FILE_DEGREE_OUTPUT
			compilation: EWB_COMP
			ewb_loop: EWB_LOOP
			e_displayer: DEFAULT_ERROR_DISPLAYER
			l_loader: EC_PROJECT_LOADER
			l_generated_file, l_target_file: RAW_FILE
		do
			if not retried then
						-- Read the resource files
				create new_resources.initialize

				if not new_resources.error_occurred then
					if configure_resources.get_boolean ("compiler_need_flush", False) then
							-- Flushing was requested. Needed for `eweasel' on Windows
							-- so that there is no blocking.
						enable_automatic_output_flushing
					end
					analyze_options
					if option_error then
						print_option_error
					elseif help_only then
						print_help
					elseif version_only then
						print_version
					elseif not file_error then
						if output_window = Void then
							command.set_output_window (Error_window)
						else
							command.set_output_window (output_window)
						end

							--| Initialization of the display
						create e_displayer.make (Error_window);
						Eiffel_project.set_error_displayer (e_displayer)
						if output_file_option then
							create file_degree_output.make (output_file_name)
							Eiffel_project.set_degree_output (file_degree_output)
						end

							-- Load project
						create l_loader
						l_loader.set_should_stop_on_prompt (stop_on_error)
						l_loader.set_ignore_user_configuration_file (not is_user_settings_requested)
						l_loader.set_has_library_conversion (not has_no_library_conversion)
						if is_single_file_compilation then
							l_loader.open_single_file_compilation_project (single_file_compilation_filename, single_file_compilation_libraries, project_path, is_clean_requested)
						elseif old_project_file /= Void then
							l_loader.open_project_file (old_project_file, Void, project_path, is_clean_requested)
						elseif old_ace_file /= Void then
							l_loader.open_project_file (old_ace_file, Void, project_path, is_clean_requested)
						else
							l_loader.open_project_file (config_file_name, target_name, project_path, is_clean_requested)
						end

						if not error_occurred and not l_loader.has_error then
							compilation ?= command
							if compilation /= Void then
								compilation.set_is_finish_freezing_called (is_finish_freezing_called)
							end
							ewb_loop ?= command
							if
								compilation = Void and then ewb_loop = Void
							then
								create {EWB_QUICK_MELT} compilation
								compilation.execute
								if system.successful then
									command.execute
								end
							else
								command.execute
							end

							if is_single_file_compilation and then l_loader.eiffel_project.successful then
									-- Copy generated executable in single file compilation to project location
								if is_finalizing then
									create l_generated_file.make (l_loader.eiffel_project.project_directory.final_executable_file_name)
								else
									create l_generated_file.make (l_loader.eiffel_project.project_directory.workbench_executable_file_name)
								end
									-- Check if generated file exists. If the C compilation fails, the file will not be generated.
								if l_generated_file.exists then
									 -- If generated file exists, copy it to the target location
									create l_target_file.make (l_loader.eiffel_project.project_directory.single_file_compilation_executable_file_name)
									l_generated_file.open_read
									l_target_file.open_write
									l_generated_file.copy_to (l_target_file)
									l_target_file.close
									l_generated_file.close
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

feature -- Properties

	error_occurred: BOOLEAN;
			-- Did an error occur during the initialization
			-- process?

	retried: BOOLEAN;
			-- For rescues

	command: EWB_CMD
			-- Command to be executed corresponding to
			-- command line options

	output_window: FILE_WINDOW
			-- Window where the output is displayed

	file_error: BOOLEAN
			-- Has an error been encountered in opening the
			-- file for redirection?

	option_error: BOOLEAN
			-- Has an error been encountered in the
			-- command line options?

	current_option: INTEGER
			-- Current index in the option list

	help_only: BOOLEAN
			-- Print help information?

	version_only: BOOLEAN
			-- Print version information?

	output_file_option: BOOLEAN
			-- Redirect output to `output_file_name'?

	output_file_name: STRING
			-- File which Output is redirected into
			-- if `output_file_option' is set to True.

	option: STRING
			-- Current option being analyzed

	single_file_compilation_filename: STRING
			-- File name of Eiffel class file in single file compilation mode

	single_file_compilation_libraries: LIST [STRING]
			-- List of specified libraries in single file compilation mode

	is_finish_freezing_called: BOOLEAN
			-- Should a freeze or a finalize call `finish_freezing' after generating
			-- C code

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

	help_messages: HASH_TABLE [STRING_GENERAL, STRING] is
			-- Help message table
		once
			create Result.make (35)
			Result.put (ace_help, ace_cmd_name)
			Result.put (ancestors_help, ancestors_cmd_name)
			Result.put (aversions_help, aversions_cmd_name)
			Result.put (config_help, config_cmd_name)
			Result.put (callers_help, callers_cmd_name)
			Result.put (callees_help, callees_cmd_name)
			Result.put (clients_help, clients_cmd_name)
			Result.put (descendants_help, descendants_cmd_name)
			Result.put (dversions_help, dversions_cmd_name)
			Result.put (file_help, file_cmd_name)
			Result.put (filter_help, filter_cmd_name)
			Result.put (flat_help, flat_cmd_name)
			Result.put (flatshort_help, flatshort_cmd_name)
			Result.put (help_help, help_cmd_name)
			Result.put (implementers_help, implementers_cmd_name)
			Result.put (library_help, library_cmd_name)
			Result.put (loop_help, loop_cmd_name)
			Result.put (debug_help, debug_info_name)
			Result.put (melt_help, melt_cmd_name)
			Result.put (overwrite_old_project_help, overwrite_old_project_cmd_name)
			Result.put (project_help, project_cmd_name)
			Result.put (project_path_help, project_path_cmd_name)
			Result.put (quick_melt_help, quick_melt_cmd_name)
			Result.put (short_help, short_cmd_name)
			Result.put (single_file_compilation_help, single_file_compilation_cmd_name)
			Result.put (stop_help, stop_cmd_name)
			Result.put (suppliers_help, suppliers_cmd_name)
			Result.put (target_help, target_cmd_name)
			Result.put (use_settings_help, use_settings_cmd_name)
			Result.put (no_library_help, no_library_cmd_name)
			Result.put (version_help, version_cmd_name)
			Result.put (batch_help, batch_cmd_name)
			Result.put (clean_help, clean_cmd_name)
			Result.put (gui_help, gui_cmd_name)
			Result.put (gc_stats_help, gc_stats_cmd_name)
			add_help_special_cmds
		end

	loop_cmd: EWB_LOOP is
			-- Loop command
		do
			create Result
		end

feature -- Access

	is_precompiled_option: BOOLEAN is
			-- Is the current option `precompile'?
		do
			Result := option.is_equal ("-precompile")
		end

	is_precompiled_licensed_option: BOOLEAN is
			-- Is the current option `precompile_licensed'?
		do
			Result := option.is_equal ("-precompile_licensed")
		end

feature -- Setting

	set_file (filename: STRING) is
			-- Set the output_window file to `filename'.
		do
			create output_window.make (filename)
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

feature -- Output

	print_option_error is
			-- Print the correct usage of ewb.
		do
			localized_print (argument (0))
			localized_print (ewb_names.incorrect_options);
			print_usage
		end

	print_usage is
			-- Print the usage of command line options.
		do
			localized_print (ewb_names.usage)
			localized_print (argument (0))
			io.put_string (" [-help | -version | -batch | -clean | -use_settings | ")
			add_usage_special_cmds
			io.put_string ("-loop | -debug | -quick_melt | -melt | ")
			if eiffel_layout.Has_documentation_generation then
				io.put_string ("-clients [-filter filtername] class |%N%
					%%T-suppliers [-filter filtername] class |%N%
					%%T-flatshort [-filter filtername] [-all | -all_and_parents | class] |%N%
					%%T-flat [-filter filtername] [-all | -all_and_parents | class] |%N%
					%%T-short [-filter filtername] [-all | -all_and_parents | class] | %N%
					%%T-filter filtername [-all | class] |%N%
					%%T-descendants [-filter filtername] class |%N")
				io.put_string ("%
					%%T-ancestors [-filter filtername] class |%N%
					%%T-aversions [-filter filtername] class feature |%N%
					%%T-dversions [-filter filtername] class feature |%N%
					%%T-implementers [-filter filtername] class feature |%N%
					%%T-callers [-filter filtername] [-show_all] [-assigners | -creators] class feature |%N%
					%%T-callees [-filter filtername] [-show_all] [-assignees | -creators] class feature |%N")
			end
			io.put_string ("%
				%%T[-config config.ecf | -target target |%N%
				%%T(obsolete) -ace Ace | (obsolete) -project Project_file_name] |%N%
				%%T[class_file.e [-library library_name]] |%N%
				%%T-stop | -no_library |%N%
				%%T-project_path Project_directory_path | -file File |%N%
				%%T-gc_stats]%N")
		end

	print_version is
			-- Print Version Number
		do
			localized_print ("ISE " + Workbench_name + " version " + Version_number + "%N")
		end

	print_help is
			-- Print the help.
		local
			command_list: SORTED_TWO_WAY_LIST [STRING]
			keys: ARRAY [STRING]
			i, nb: INTEGER
			cmd_name: STRING
		do
			print_usage
			localized_print (ewb_names.options);
			localized_print (ewb_names.default_quick_melt_the_system)

			create command_list.make
			keys := help_messages.current_keys
			from
				i := keys.lower
				nb := keys.upper
			until
				i > nb
			loop
				command_list.extend (keys @ i)
				i := i + 1
			end
			from
				command_list.start
			until
				command_list.after
			loop
				cmd_name := command_list.item
				print_one_help (cmd_name, help_messages.item (cmd_name))
				command_list.forth
			end
		end

	print_one_help (opt: STRING; txt: STRING_GENERAL) is
		do
			io.put_string ("%T-")
			io.put_string (opt)
			io.put_string (": ")
			localized_print (txt)
			io.put_string (".%N")
		end

	print_gc_statistics is
			-- Display some GC statistics if `is_gc_stats_enabled'.
		local
			l_mem: MEMORY
			l_mem_info: MEM_INFO
			l_full_gc_info, l_part_gc_info: GC_INFO
		do
			if is_gc_stats_enabled then
				create l_mem
				l_mem_info := l_mem.memory_statistics ({MEM_CONST}.eiffel_memory)
				print ("Total memory is " + l_mem_info.total.out + "%N")
				print ("Used memory is " + (l_mem_info.used + l_mem_info.overhead).out + "%N")
				print ("Free memory is " + l_mem_info.free.out + "%N")

				l_full_gc_info := l_mem.gc_statistics ({MEM_CONST}.full_collector)
				print ("GC full cycle is " + l_full_gc_info.cycle_count.out + "%N")
				print ("GC full cycle is " + l_full_gc_info.cpu_time_average.out + "%N")

				l_part_gc_info := l_mem.gc_statistics ({MEM_CONST}.incremental_collector)
				print ("GC incremental cycle is " + l_part_gc_info.cycle_count.out + "%N")
				print ("GC incremental cycle is " + l_part_gc_info.cpu_time_average.out + "%N")
				print ("CPU time " + l_part_gc_info.cpu_total_time.out + "%N")
				print ("Kernel time " + l_part_gc_info.sys_total_time.out + "%N")
				print ("Full Collection period " + l_mem.collection_period.out + "%N")
				print ("GC percentage time " +
					(100 * (((l_full_gc_info.cycle_count * l_full_gc_info.cpu_time_average) +
					 (l_part_gc_info.cycle_count * l_part_gc_info.cpu_time_average)) /
					 l_part_gc_info.cpu_total_time)).out + "%N%N")
			end
		end

feature -- Update

	add_usage_special_cmds is
		do
			io.put_string ("-freeze | %N%T-finalize [-keep] | -precompile [-finalize [-keep]] | -c_compile |%N%T")
		end

	add_help_special_cmds is
		do
			help_messages.put (freeze_help, freeze_cmd_name)
			help_messages.put (precompile_help, precompile_cmd_name)
			help_messages.put (finalize_help, finalize_cmd_name)
			Help_messages.put (c_compile_help, c_compile_cmd_name)
		end

	analyze_options is
			-- Analyze the options entered by the user.
		do
					-- Default Project Options
			from
				current_option := 1
			until
				(current_option > argument_count) or else
				option_error
			loop
				analyze_one_option
			end
				-- Default command
			if (not option_error) and then (command = Void) then
				if is_precompiling then
					create {EWB_PRECOMP} command
				else
					create {EWB_QUICK_MELT} command
				end
			end
		end

	analyze_one_option is
			-- Analyze current option.
		local
			cn, fn: STRING
			filter_name: STRING
			show_all: BOOLEAN
			show_assigners: BOOLEAN
			show_creators: BOOLEAN
			ewb_senders: EWB_SENDERS
			ewb_callees: EWB_CALLEES
			l_arg: STRING
		do
			filter_name := ""
			option := argument (current_option);

			if option.is_equal ("-help") then
				help_only := True
			elseif option.is_equal ("-loop") then
				if command /= Void then
					option_error := True
				else
					command := loop_cmd
				end
			elseif option.is_equal ("-version") then
				version_only := True
			elseif option.is_equal ("-quick_melt") then
				if command = Void then
					create {EWB_QUICK_MELT} command
				else
					option_error := True
				end
			elseif option.is_equal ("-melt") then
				if command = Void then
					create {EWB_COMP} command
				else
					option_error := True
				end
			elseif option.is_equal ("-" + debug_cmd_name) then
				if command = Void then
					create {EWB_DEBUG} command
				else
					option_error := True
				end
			elseif eiffel_layout.has_documentation_generation and then option.is_equal ("-implementers") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end
						if not option_error then
							if current_option < argument_count then
								cn := argument (current_option)
								current_option := current_option + 1
								fn := argument (current_option)
								create {EWB_HISTORY} command.make (cn, fn, filter_name)
							else
								option_error := True
							end
						end
					end
				else
					option_error := True
				end
			elseif eiffel_layout.has_documentation_generation and then option.is_equal ("-aversions") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end
						if not option_error then
							if current_option < argument_count then
								cn := argument (current_option)
								current_option := current_option + 1
								fn := argument (current_option)
								create {EWB_PAST} command.make (cn, fn, filter_name)
							else
								option_error := True
							end
						end
					end
				else
					option_error := True
				end
			elseif eiffel_layout.has_documentation_generation and then option.is_equal ("-dversions") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end
						if not option_error then
							if current_option < argument_count then
								cn := argument (current_option)
								current_option := current_option + 1
								fn := argument (current_option)
								create {EWB_FUTURE} command.make (cn, fn, filter_name)
							else
								option_error := True
							end
						end
					end
				else
					option_error := True
				end
			elseif eiffel_layout.has_documentation_generation and then option.is_equal ("-callers") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end
						if argument (current_option).is_equal ("-show_all") then
							show_all := True
							current_option := current_option + 1
						end
						if argument (current_option).is_equal ("-assigners") then
							show_assigners := True
							current_option := current_option + 1
						elseif argument (current_option).is_equal ("-creators") then
							show_creators := True
							current_option := current_option + 1
						end
						if not option_error then
							if current_option < argument_count then
								cn := argument (current_option)
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
							else
								option_error := True
							end
						end
					end
				else
					option_error := True
				end
			elseif eiffel_layout.has_documentation_generation and then option.is_equal ("-callees") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end
						if argument (current_option).is_equal ("-show_all") then
							show_all := True
							current_option := current_option + 1
						end
						if argument (current_option).is_equal ("-assignees") then
							show_assigners := True
							current_option := current_option + 1
						elseif argument (current_option).is_equal ("-creators") then
							show_creators := True
							current_option := current_option + 1
						end
						if not option_error then
							if current_option < argument_count then
								cn := argument (current_option)
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
								command := ewb_senders
							else
								option_error := True
							end
						end
					end
				else
					option_error := True
				end
--			elseif option.is_equal ("-dependents") then
--				if current_option < (argument_count - 1) then
--					if command /= Void then
--						option_error := True
--					else
--						current_option := current_option + 1
--						cn := argument (current_option)
--						current_option := current_option + 1
--						fn := argument (current_option)
--						!EWB_DEPEND!command.make (cn, fn, filter_name)
--					end
--				else
--					option_error := True
--				end
			elseif option.is_equal ("-c_compile") then
				is_finish_freezing_called := True
			elseif
				eiffel_layout.has_documentation_generation and then
				(option.is_equal ("-short") or else
				option.is_equal ("-flatshort"))
			then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end
						if not option_error then
							cn := argument (current_option)
							if option.is_equal ("-short") then
								if cn.is_equal ("-all") then
									create {EWB_DOCUMENTATION} command.make_short (filter_name, false)
								elseif cn.is_equal ("-all_and_parents") then
									create {EWB_DOCUMENTATION} command.make_short (filter_name, true)
								else
									create {EWB_SHORT} command.make (cn, filter_name)
								end
							elseif cn.is_equal ("-all") then
								create {EWB_DOCUMENTATION} command.make_flat_short (filter_name, false)
							elseif cn.is_equal ("-all_and_parents") then
								create {EWB_DOCUMENTATION} command.make_flat_short (filter_name, true)
							else
								create {EWB_FS} command.make (cn, filter_name)
							end
						end
					end
				else
					option_error := True
				end
			elseif eiffel_layout.has_documentation_generation and then option.is_equal ("-flat") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end
						if not option_error then
							cn := argument (current_option)
							if cn.is_equal ("-all") then
								create {EWB_DOCUMENTATION} command.make_flat (filter_name, false)
							elseif cn.is_equal ("-all_and_parents") then
								create {EWB_DOCUMENTATION} command.make_flat (filter_name, true)
							else
								create {EWB_FLAT} command.make (cn, filter_name)
							end
						end
					end
				else
					option_error := True
				end
			elseif eiffel_layout.has_documentation_generation and then option.is_equal ("-filter") then
				if current_option + 1 < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1
						filter_name := argument (current_option)
						current_option := current_option + 1
						cn := argument (current_option)
						if cn.is_equal ("-all") then
							create {EWB_DOCUMENTATION} command.make_text (filter_name)
						else
							create {EWB_TEXT} command.make (cn, filter_name)
						end
					end
				else
					option_error := True
				end
			elseif eiffel_layout.has_documentation_generation and then option.is_equal ("-ancestors") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end
						if not option_error then
							cn := argument (current_option)
							create {EWB_ANCESTORS} command.make (cn, filter_name)
						end
					end
				else
					option_error := True
				end
			elseif eiffel_layout.has_documentation_generation and then option.is_equal ("-clients") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end
						if not option_error then
							cn := argument (current_option)
							create {EWB_CLIENTS} command.make (cn, filter_name)
						end
					end
				else
					option_error := True
				end
			elseif eiffel_layout.has_documentation_generation and then option.is_equal ("-suppliers") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end
						if not option_error then
							cn := argument (current_option)
							create {EWB_SUPPLIERS} command.make (cn, filter_name)
						end
					end
				else
					option_error := True
				end
			elseif eiffel_layout.has_documentation_generation and then option.is_equal ("-descendants") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end
						if not option_error then
							cn := argument (current_option)
							create {EWB_DESCENDANTS} command.make (cn, filter_name)
						end
					end
				else
					option_error := True
				end
			elseif option.is_equal ("-project") then
				if is_single_file_compilation then
						-- In single file compilation mode no ace file may be specified
					option_error := True
				elseif current_option < argument_count then
					current_option := current_option + 1
					l_arg := argument (current_option)
					if l_arg /= Void then
						old_project_file := l_arg
					else
						option_error := True
					end
				else
					option_error := True
				end

			elseif option.is_equal ("-output_file") then
				if current_option < argument_count then
					current_option := current_option + 1
					output_file_name := argument (current_option)
					if output_file_name /= Void and then not output_file_name.is_empty then
						output_file_option := True
					end
				else
					option_error := True
				end

			elseif option.is_equal ("-project_path") then
				if current_option < argument_count then
					current_option := current_option + 1
					l_arg := argument (current_option)
					if l_arg /= Void then
						project_path := l_arg
					else
						option_error := True
					end
				else
					option_error := True
				end
			elseif option.is_equal ("-ace") then
				if is_single_file_compilation then
						-- In single file compilation mode no ace file may be specified
					option_error := True
				elseif current_option < argument_count then
					current_option := current_option + 1
					l_arg := argument (current_option)
					if l_arg /= Void then
						old_ace_file := l_arg
					else
						option_error := True
					end
				else
					option_error := True
				end
			elseif option.is_equal ("-config") then
				if is_single_file_compilation then
						-- In single file compilation mode no config file may be specified
					option_error := True
				elseif current_option < argument_count then
					current_option := current_option + 1
					l_arg := argument (current_option)
					if l_arg /= Void then
						config_file_name := l_arg
					else
						option_error := True
					end
				else
					option_error := True
				end
			elseif option.is_equal ("-target") then
				if is_single_file_compilation then
						-- In single file compilation mode no target may be specified
					option_error := True
				elseif current_option < argument_count then
					current_option := current_option + 1
					l_arg := argument (current_option)
					if l_arg /= Void then
						target_name := l_arg
					else
						option_error := True
					end
				end
			elseif option.is_equal ("-stop") or else option.is_equal ("-batch") then
					-- The compiler stops on errors, useful for batch compilation without
					-- user intervention.
				set_stop_on_error (True)
			elseif option.is_equal ("-clean") then
					-- Compiler will delete project and recompile from scratch without
					-- asking.
				is_clean_requested := True
			elseif option.is_equal ("-local") then
					-- FIXME: for temporary measure so that we do not reject -local which
					-- is the behavior by default.
			elseif option.is_equal ("-use_settings") then
					-- Compiler will read user configuration file for that project
				is_user_settings_requested := True

			elseif option.is_equal ("-no_library") then
					-- Compiler will read user configuration file for that project
				has_no_library_conversion := True

			elseif option.is_equal ("-gc_stats") then
					-- Compiler will display some GC timing at the end of a compilation.
				is_gc_stats_enabled := True
					-- Start accounting for GC statistics.
				(create {MEMORY}).enable_time_accounting

			elseif option.is_equal ("-file") then
				if current_option < argument_count then
					current_option := current_option + 1
					set_file (argument (current_option))
				else
					option_error := True
				end
			elseif option.is_equal ("-dumploop") then
					create {EWB_DUMP_LOOP} command
			elseif option.is_equal ("-dumpuniverse") then
				if current_option < argument_count then
					create {EWB_DUMP_UNIVERSE} command
				else
					option_error := True
				end
			elseif option.is_equal ("-dumpclasses") then
				if current_option < argument_count then
					create {EWB_DUMP_CLASSES} command
				else
					option_error := True
				end
			elseif option.is_equal ("-dumpfeatures") then
				if current_option < argument_count then
					current_option := current_option + 1
					cn := argument (current_option)
					if
						current_option < argument_count and then
						argument (current_option + 1).is_equal ("verbose")
					then
						current_option := current_option + 1;
						create {EWB_DUMP_FEATURES} command.make_verbose (cn)
					else
						create {EWB_DUMP_FEATURES} command.make (cn)
					end
				else
					option_error := True
				end
			elseif option.is_equal ("-dumpoperands") then
				if current_option + 1 < argument_count then
					current_option := current_option + 1
					cn := argument (current_option)
					current_option := current_option + 1
					fn := argument (current_option)
					create {EWB_DUMP_OPERANDS} command.make (cn, fn, Void)
				else
					option_error := True
				end
			elseif is_precompiled_option then
				if command /= Void then
					option_error := True
				else
					is_precompiling := True
				end
			elseif is_precompiled_licensed_option then
				if command /= Void then
					option_error := True
				else
					create {EWB_PRECOMP} command
				end
			elseif option.is_equal ("-metadata_cache_path") then
				if current_option + 1 < argument_count then
					current_option := current_option + 1
					set_overridden_metadata_cache_path (argument (current_option))
				else
					option_error := True
				end
			elseif option.is_equal ("-library") then
					-- This option is only valid if no other config options are set
				if config_file_name = Void and target_name = Void and old_ace_file = Void and old_project_file = Void then
					if single_file_compilation_libraries = Void then
						create {LINKED_LIST [STRING]}single_file_compilation_libraries.make
					end
					if current_option < argument_count then
						current_option := current_option + 1
						l_arg := argument (current_option)
						if l_arg /= Void then
							single_file_compilation_libraries.extend (l_arg)
						else
							option_error := True
						end
					end
				else
					option_error := True
				end
			elseif is_eiffel_class_file_name (option) then
					-- This option is only valid if no other config options are set
				if config_file_name = Void and target_name = Void and old_ace_file = Void and old_project_file = Void then
					single_file_compilation_filename := argument (current_option)
					is_single_file_compilation := True
						-- Implies finish freezing
					is_finish_freezing_called := True
						-- If no libraries are set yet, initialize empty list
					if single_file_compilation_libraries = Void then
						create {LINKED_LIST [STRING]} single_file_compilation_libraries.make
					end
				else
					option_error := True
				end
			else
				process_special_options
			end
			current_option := current_option + 1
		end

	process_special_options is
			-- Process the special option.
		local
			keep: BOOLEAN
		do
			if option.is_equal ("-freeze") then
				if command /= Void then
					option_error := True
				else
					create {EWB_FREEZE} command
				end
			elseif option.is_equal ("-finalize") then
				if command /= Void then
					option_error := True
				else
					if current_option < argument_count then
						if argument (current_option + 1).is_equal ("-keep") then
							current_option := current_option + 1
							keep := True
						end
					end
					if is_precompiling then
						create {EWB_FINALIZE_PRECOMP} command.make (keep)
					else
						create {EWB_FINALIZE} command.make (keep)
					end
					is_finalizing := True
				end
			else
				option_error := True
			end
		end

feature {NONE} -- Externals

	 enable_automatic_output_flushing is
			-- Set `compiler_need_flush' to `1' so that all output are not
			-- buffered.
		external
			"C inline use <eif_console.h>"
		alias
			"compiler_need_flush = 1;"
		end

feature {NONE} -- Onces

	command_line_io: COMMAND_LINE_IO is
		once
			create Result
		end

feature {NONE} -- Implementation

	old_ace_file: STRING
			-- Old ace file to convert.

	old_project_file: STRING
			-- Old project file to convert.

	config_file_name, target_name, project_path: STRING;
			-- Name of the config file, target and path where project will be compiled.

	is_eiffel_class_file_name (a_filename: STRING): BOOLEAN is
			-- Is `a_filename' an Eiffel class file?
			-- This checks if the filename has an 'e' extension.
		require
			a_filename_not_void: a_filename /= Void
		local
			l_extension: STRING
		do
			l_extension := a_filename.twin
			l_extension.keep_tail (2)
			Result := l_extension.is_equal ("." + eiffel_extension)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class ES
