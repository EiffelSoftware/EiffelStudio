indexing
	description: 
		"Batch compiler without invoking the -loop. This is the root%
		%class for the personal version (which does allow c compilation)."
	date: "$Date$"
	revision: "$Revision$"

class
	ES

inherit
	COMMAND_LINE_PROJECT

	ARGUMENTS

	SHARED_CONFIGURE_RESOURCES

	SHARED_EWB_HELP

	SHARED_EWB_CMD_NAMES

	EIFFEL_ENV

creation
	make, make_unlicensed

feature -- Initialization

	make is
			-- Analyze the command line options and
			-- execute the appropriate command.
		do
			invoke_batch (True)
		end

	make_unlicensed is
			-- Analyze the command line options and
			-- execute the appropriate command.
		do
			invoke_batch (False)
		end

feature {NONE} -- Initialization

	invoke_batch (licensed: BOOLEAN) is
			-- Analyze the command line options and 
			-- execute the appropriate command.
			-- `licensed' indicates whether we need to check the
			-- license or not.
		local
			temp: STRING
			eifgen_init: INIT_SERVERS
			new_resources: TTY_RESOURCES
			file_degree_output: FILE_DEGREE_OUTPUT
			compilation: EWB_COMP
			ewb_loop: EWB_LOOP
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

					-- Call `init_license' only if `licensed' is `True'
				if not licensed or else init_license then
					if has_limited_license then
						io.error.putstring (expiration_message)
					end
							-- Read the resource files
					create new_resources.initialize

					if not new_resources.error_occurred then
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
							init_project (Project_file_name)
							if not error_occurred then
								if project_is_new then
									make_new_project (equal (command.name, loop_cmd_name))
								else
									retrieve_project
								end
							end
	
							if output_file_option then
								create file_degree_output.make (output_file_name)
								Eiffel_project.set_degree_output (file_degree_output)
							end
	
							if not error_occurred then
								compilation ?= command
								ewb_loop ?= command
								if
									project_is_new and then
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
							discard_licenses
						end
					end
				end
				if output_window /= Void and then not output_window.is_closed then
					output_window.close
				end
			else
				die (-1)
			end
		rescue
			discard_licenses
			io.error.putstring ("ISE Eiffel 5: Session aborted%N")
			io.error.putstring ("Exception tag: ")
			temp := original_tag_name
			if output_window /= Void and then not output_window.is_closed then
				output_window.close
			end
			if temp /= Void then
				io.error.putstring (temp)
			end
			io.error.new_line
			if not fail_on_rescue then
				retried := True
				retry
			end
		end

feature -- Properties

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

	help_messages: EXTEND_TABLE [STRING, STRING] is
			-- Help message table
		once
			create Result.make (25)
			Result.put (ace_help, ace_cmd_name)
			Result.put (ancestors_help, ancestors_cmd_name)
			Result.put (aversions_help, aversions_cmd_name)
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
			Result.put (project_help, project_cmd_name)
			Result.put (project_path_help, project_path_cmd_name)
			Result.put (quick_melt_help, quick_melt_cmd_name)
			Result.put (short_help, short_cmd_name)
			Result.put (stop_help, stop_cmd_name)
			Result.put (suppliers_help, suppliers_cmd_name)
			Result.put (version_help, version_cmd_name)
			Result.put (batch_help, batch_cmd_name)
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
				io.error.putstring ("File %"" + filename + "%" exists.%NPlease delete it first.%N")
				file_error := True
			else
				output_window.open_file
				if not output_window.exists then
					io.error.putstring ("Cannot create file: ")
					io.error.putstring (filename)
					io.error.new_line
					file_error := True
				end
			end
		end

feature -- Output

	print_option_error is
			-- Print the correct usage of ewb.
		do	
			io.putstring (argument (0))
			io.putstring (": incorrect options%N"); 
			print_usage
		end

	print_usage is
			-- Print the usage of command line options.
		do
			io.putstring ("Usage:%N%T")
			io.putstring (argument (0))
			io.putstring (" [-help | -version | -batch ")
			add_usage_special_cmds
			io.putstring ("-loop | -quick_melt | ")
			if Has_documentation_generation then
				io.put_string ("-clients [-filter filtername] class |%N%
					%%T-suppliers [-filter filtername] class |%N%
					%%T-flatshort [-filter filtername] [-all | -all_and_parents | class] |%N%
					%%T-flat [-filter filtername] [-all | -all_and_parents | class] |%N%
					%%T-short [-filter filtername] [-all | -all_and_parents | class] | %N%
					%%T-filter filtername [-all | class] |%N%
					%%T-descendants [-filter filtername] class |%N")
				io.putstring ("%
					%%T-ancestors [-filter filtername] class |%N%
					%%T-aversions [-filter filtername] class feature |%N%
					%%T-dversions [-filter filtername] class feature |%N%
					%%T-implementers [-filter filtername] class feature |%N%
					%%T-callers [-filter filtername] [-show_all] class feature |%N%T")
			end
			io.put_string ("%
				%[-stop] [-ace Ace] [-project Project_file_name]|%N%
				%%T[-project_path Project_directory_path] [-file File]]%N")
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
			io.putstring ("%NOptions:%N"); 
			io.putstring ("%Tdefault (no option): recompile the system.%N%N")

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
			io.putstring ("%T-")
			io.putstring (opt)
			io.putstring (": ")
			io.putstring (txt)
			io.putstring (".%N")
		end

feature -- Update

	add_usage_special_cmds is
		do
			io.putstring ("-freeze | -finalize [-keep] | -precompile |%N%T")
		end

	add_help_special_cmds is
		do
			help_messages.put (freeze_help, freeze_cmd_name)
			help_messages.put (precompile_help, precompile_cmd_name)
			help_messages.put (finalize_help, finalize_cmd_name)
		end

	analyze_options is
			-- Analyze the options entered by the user.
		do
					-- Default Project Options
			Project_directory_name.set_directory (clone (Execution_environment.current_working_directory))
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
				!EWB_COMP!command
			end
		end

	analyze_one_option is
			-- Analyze current option.
		local
			cn, fn: STRING
			filter_name: STRING
			show_all: BOOLEAN
			ewb_senders: EWB_SENDERS
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
				!EWB_QUICK_MELT! command 
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
								!EWB_HISTORY!command.make (cn, fn, filter_name)
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
								!EWB_PAST!command.make (cn, fn, filter_name)
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
								!EWB_FUTURE!command.make (cn, fn, filter_name)
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
						if not option_error then
							if current_option < argument_count then
								cn := argument (current_option)
								current_option := current_option + 1
								fn := argument (current_option)
								create ewb_senders.make (cn, fn, filter_name)
								if show_all then
									ewb_senders.set_all_callers
								end;	
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
								!EWB_DOCUMENTATION! command.make_flat (filter_name, false)
							elseif cn.is_equal ("-all_and_parents") then
								!EWB_DOCUMENTATION! command.make_flat (filter_name, true)
							else
								!EWB_FLAT!command.make (cn, filter_name)
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
							!EWB_DOCUMENTATION! command.make_text (filter_name)
						else
							!EWB_TEXT!command.make (cn, filter_name)
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
							!EWB_ANCESTORS!command.make (cn, filter_name)
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
							!EWB_CLIENTS!command.make (cn, filter_name)
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
					project_file_name := argument (current_option)
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
					project_path_name := argument (current_option)
				else
					option_error := True
				end
			elseif option.is_equal ("-ace") then
				if current_option < argument_count then
					current_option := current_option + 1
					Ace_name := argument (current_option)
				else
					option_error := True
				end
			elseif option.is_equal ("-stop") or else option.is_equal ("-batch") then
					-- The compiler stops on errors, useful for batch compilation without
					-- user intervention.
				set_stop_on_error (True)
			elseif option.is_equal ("-file") then
				if current_option < argument_count then
					current_option := current_option + 1
					set_file (argument (current_option))
				else
					option_error := True
				end
			elseif option.is_equal ("-dumploop") then
					create {EWB_DUMP_LOOP} command.do_nothing
			elseif option.is_equal ("-dumpuniverse") then
				if current_option < argument_count then
					create {EWB_DUMP_UNIVERSE} command.do_nothing
				else
					option_error := True
				end
			elseif option.is_equal ("-dumpclasses") then
				if current_option < argument_count then
					create {EWB_DUMP_CLASSES} command.do_nothing
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
					create {EWB_PRECOMP} command.make (False)
				end
			elseif is_precompiled_licensed_option then
				if command /= Void then
					option_error := True
				else
					create {EWB_PRECOMP} command.make (True)
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
					create {EWB_FINALIZE} command.make (keep)
				end
			else
				option_error := True
			end
		end

end -- class ES
