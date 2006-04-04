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

	EIFFEL_ENV

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

create
	make

feature -- Initialization

	make is
			-- Analyze the command line options and
			-- execute the appropriate command.
		local
			temp: STRING
			eifgen_init: INIT_SERVERS
			new_resources: TTY_RESOURCES
			file_degree_output: FILE_DEGREE_OUTPUT
			compilation: EWB_COMP
			ewb_loop: EWB_LOOP
			e_displayer: DEFAULT_ERROR_DISPLAYER
			l_loader: EC_PROJECT_LOADER
		do
			if not retried then
					-- Check that environment variables
					-- are properly set.
				check_environment_variable

					--| Initialization of the run-time, so that at the end of a store/retrieve
					--| operation (like retrieving or storing the project, creating the CASEGEN
					--| directory, generating the profile information, ...) the run-time is initialized
					--| back to the values which permits the compiler to access correctly the EIFGEN
					--| directory
				create eifgen_init.make

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
						if old_project_file /= Void then
							l_loader.open_project_file (old_project_file, Void, Void, is_clean_requested)
						elseif old_ace_file /= Void then
							l_loader.open_project_file (old_ace_file, Void, Void, is_clean_requested)
						else
							l_loader.open_project_file (config_file_name, target_name, project_path_name, is_clean_requested)
						end

						if not error_occurred and not l_loader.has_error then
							compilation ?= command
							if compilation /= Void then
								compilation.set_is_finish_freezing_called (is_finish_freezing_called)
							end
							ewb_loop ?= command
							if
								l_loader.is_new_project and then
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
						end
					end
				end
			end
			if output_window /= Void and then not output_window.is_closed then
				output_window.close
			end
		rescue
			if error_handler.is_developer_exception then
				Error_handler.trace
				if command_line_io.termination_requested then
					retried := True
					retry
				else
					command := Void
					retry
				end
			else
				io.error.put_string ("ISE Eiffel 5: Session aborted%N")
				io.error.put_string ("Exception tag: ")
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

	project_path_name: STRING;
			-- Path where to look for the EIFGEN directory and the
			-- project file.

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

	is_finish_freezing_called: BOOLEAN
			-- Should a freeze or a finalize call `finish_freezing' after generating
			-- C code

	is_precompiling: BOOLEAN
			-- Should compilation actual precompile?

	is_clean_requested: BOOLEAN
			-- Should we recompile from scratch?

	help_messages: HASH_TABLE [STRING, STRING] is
			-- Help message table
		once
			create Result.make (30)
			Result.put (ace_help, ace_cmd_name)
			Result.put (ancestors_help, ancestors_cmd_name)
			Result.put (aversions_help, aversions_cmd_name)
			Result.put (config_help, config_cmd_name)
			Result.put (callers_help, callers_cmd_name)
			Result.put (clients_help, clients_cmd_name)
			Result.put (descendants_help, descendants_cmd_name)
			Result.put (dversions_help, dversions_cmd_name)
			Result.put (file_help, file_cmd_name)
			Result.put (filter_help, filter_cmd_name)
			Result.put (flat_help, flat_cmd_name)
			Result.put (flatshort_help, flatshort_cmd_name)
			Result.put (help_help, help_cmd_name)
			Result.put (implementers_help, implementers_cmd_name)
			Result.put (loop_help, loop_cmd_name)
			Result.put (melt_help, melt_cmd_name)
			Result.put (overwrite_old_project_help, overwrite_old_project_cmd_name)
			Result.put (project_help, project_cmd_name)
			Result.put (project_path_help, project_path_cmd_name)
			Result.put (quick_melt_help, quick_melt_cmd_name)
			Result.put (short_help, short_cmd_name)
			Result.put (stop_help, stop_cmd_name)
			Result.put (suppliers_help, suppliers_cmd_name)
			Result.put (target_help, target_cmd_name)
			Result.put (version_help, version_cmd_name)
			Result.put (batch_help, batch_cmd_name)
			Result.put (clean_help, clean_cmd_name)
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
				io.error.put_string ("File %"" + filename + "%" exists.%NPlease delete it first.%N")
				file_error := True
			else
				output_window.open_file
				if not output_window.exists then
					io.error.put_string ("Cannot create file: ")
					io.error.put_string (filename)
					io.error.put_new_line
					file_error := True
				end
			end
		end

feature -- Output

	print_option_error is
			-- Print the correct usage of ewb.
		do
			io.put_string (argument (0))
			io.put_string (": incorrect options%N");
			print_usage
		end

	print_usage is
			-- Print the usage of command line options.
		do
			io.put_string ("Usage:%N%T")
			io.put_string (argument (0))
			io.put_string (" [-help | -version | -batch | -clean | ")
			add_usage_special_cmds
			io.put_string ("-loop | -quick_melt | -melt | ")
			if Has_documentation_generation then
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
					%%T-callers [-filter filtername] [-show_all] [-assigners | -creators] class feature |%N")
			end
			io.put_string ("%
				%%T-config config.acex | -target target |%N%
				%%T(obsolete) -ace Ace | (obsolete) -project Project_file_name|%N%
				%%T-stop |%N%
				%%T-project_path Project_directory_path | -file File]%N")
		end

	print_version is
			-- Print Version Number
		do
			io.put_string ("ISE " + Workbench_name + " version " + Version_number + "%N")
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
			io.put_string ("%NOptions:%N");
			io.put_string ("%Tdefault (no option): quick melt the system.%N%N")

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

	print_one_help (opt: STRING; txt: STRING) is
		do
			io.put_string ("%T-")
			io.put_string (opt)
			io.put_string (": ")
			io.put_string (txt)
			io.put_string (".%N")
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
					create {EWB_PRECOMP} command.make (False)
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
			elseif has_documentation_generation and then option.is_equal ("-implementers") then
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
			elseif has_documentation_generation and then option.is_equal ("-aversions") then
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
			elseif has_documentation_generation and then option.is_equal ("-dversions") then
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
			elseif has_documentation_generation and then option.is_equal ("-callers") then
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
				has_documentation_generation and then
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
			elseif has_documentation_generation and then option.is_equal ("-flat") then
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
			elseif has_documentation_generation and then option.is_equal ("-filter") then
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
			elseif has_documentation_generation and then option.is_equal ("-ancestors") then
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
			elseif has_documentation_generation and then option.is_equal ("-clients") then
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
			elseif has_documentation_generation and then option.is_equal ("-suppliers") then
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
			elseif has_documentation_generation and then option.is_equal ("-descendants") then
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
				if current_option < argument_count then
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
				if current_option < argument_count then
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
				if current_option < argument_count then
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
				if current_option < argument_count then
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
					create {EWB_PRECOMP} command.make (True)
				end
			elseif option.is_equal ("-metadata_cache_path") then
				if current_option + 1 < argument_count then
					current_option := current_option + 1
					set_overridden_metadata_cache_path (argument (current_option))
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
						create {EWB_FINALIZE_PRECOMP} command.make (False, keep)
					else
						create {EWB_FINALIZE} command.make (keep)
					end

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
