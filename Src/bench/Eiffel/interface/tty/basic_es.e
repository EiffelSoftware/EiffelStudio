indexing

	description: 
		"Batch compiler without invoking the -loop. This is the root%
		%class for the personal version (which does allow c compilation).";
	date: "$Date$";
	revision: "$Revision $"

class BASIC_ES

inherit

	ARGUMENTS;
	SHARED_ERROR_BEHAVIOR;
	SHARED_EWB_HELP;
	SHARED_EWB_CMD_NAMES;
	WINDOWS;
	SHARED_EXEC_ENVIRONMENT;
	COMMAND_LINE_PROJECT
		redefine
			new_license
		end;
	SHARED_CONFIGURE_RESOURCES

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
			new_resources: TTY_RESOURCES
			expiration: INTEGER
		do
			if not retried then
					-- Check that environment variables
					-- are properly set.
				temp := Execution_environment.get ("EIFFEL4");
				if (temp = Void) or else temp.empty then
					io.error.putstring
					("ISE Eiffel4: the environment variable $EIFFEL4 is not set%N");
					new_die (-1)
				end;
				temp := Execution_environment.get ("PLATFORM");
				if (temp = Void) or else temp.empty then
					io.error.putstring
					("ISE Eiffel4: the environment variable $PLATFORM is not set%N");
					new_die (-1)
				end;

					-- Call `init_licence' only if `licensed' is `True'
				if not licensed or else init_licence then
					if not licence.is_unlimited then
					expiration := licence.time_left
						if expiration <= 30 then
							io.error.putstring ("Your license will expire in ")
							io.error.putint (expiration)
							io.error.putstring (" days.%N")
						end
					end
						-- Read the resource files
					!! new_resources.initialize;

					analyze_options;
					if option_error then
						print_option_error
					elseif help_only then
						print_help
					elseif not file_error then
						if output_window = Void then
							command.set_output_window (error_window)
						else
							command.set_output_window (output_window)
							output_window.close;
						end;
						init_project; 
						if not error_occurred then
							if project_is_new then
								make_new_project (
									equal (command.name,
									loop_cmd_name));
							else
								retrieve_project;
							end
						end;
						if not error_occurred then
							command.execute
						end;
						discard_licence
					end
				end;
			else
				new_die (-1)
			end;
		rescue
			discard_licence;
			io.error.putstring ("ISE Eiffel4: Session aborted%N");
			io.error.putstring ("Exception tag: ");
			temp := original_tag_name;
			if temp /= Void then
				io.error.putstring (temp);
			end;
			io.error.new_line;
			if not fail_on_rescue then
				retried := True;
				retry
			end;
		end;

feature -- License manager

	init_licence: BOOLEAN is
			-- Initialization of the license
		local
			
		do
			licence.set_version (4.0);
			licence.set_application_name ("eiffelbench");
			licence.get_licence;
			Result := licence.licensed;
		end;

	new_license: LICENCE is
			-- New instance of a license
		do
			!BENCH_LICENCE!Result.make
		end
 
feature -- Properties

	command: EWB_CMD;
			-- Command to be executed corresponding to
			-- command line options;

	output_window: FILE_WINDOW;
			-- Window where the output is displayed

	file_error: BOOLEAN;
			-- Has an error been encountered in opening the 
			-- file for redirection?

	option_error: BOOLEAN;
			-- Has an error been encountered in the 
			-- command line options?

	current_option: INTEGER;
			-- Current index in the option list

	help_only: BOOLEAN;
			-- Print help information?

	option: STRING;
			-- Current option being analyzed

	help_messages: EXTEND_TABLE [STRING, STRING] is
			-- Help message table
		once
			!!Result.make (22);
			Result.put (ace_help, ace_cmd_name);
			Result.put (ancestors_help, ancestors_cmd_name);
			Result.put (aversions_help, aversions_cmd_name);
			Result.put (callers_help, callers_cmd_name);
			Result.put (clients_help, clients_cmd_name);
			Result.put (descendants_help, descendants_cmd_name);
			Result.put (dversions_help, dversions_cmd_name);
			Result.put (file_help, file_cmd_name);
			Result.put (filter_help, filter_cmd_name);
			Result.put (flat_help, flat_cmd_name);
			Result.put (flatshort_help, flatshort_cmd_name);
			Result.put (help_help, help_cmd_name);
			Result.put (implementers_help, implementers_cmd_name);
			Result.put (loop_help, loop_cmd_name);
			Result.put (project_help, project_cmd_name);
			Result.put (quick_melt_help, quick_melt_cmd_name);
			Result.put (short_help, short_cmd_name);
			Result.put (stop_help, stop_cmd_name);
			Result.put (suppliers_help, suppliers_cmd_name);
			add_help_special_cmds
		end;

	loop_cmd: BASIC_EWB_LOOP is
			-- Loop command 
		do
			!! Result
		end;

feature -- Access

	is_precompiled_option: BOOLEAN is
			-- Is the current option `precompile'?
			--| Encoded key for precompilation for
			--| personal version
		local
			s: STRING
		do
			!!s.make (8);
			s.extend ('-');
			s.append_integer (6851006);
			Result := option.is_equal (s)
		end;

	is_precompiled_licensed_option: BOOLEAN is
			-- Is the current option `precompile_licensed'?
			--| Encoded key for precompilation for
			--| personal version
		local
			s: STRING
		do
			!!s.make (18);
			s.extend ('-');
			s.append_integer (6851006);
			s.append ("_licensed");
			Result := option.is_equal (s)
		end;

feature -- Setting

	set_file (filename: STRING) is
			-- Set the output_window file to `filename'.
		do
			!! output_window.make (filename);
			if output_window.exists then
				io.error.putstring ("File exists.%N");
				file_error := True;
			else
				output_window.open_file;
				if not output_window.exists then
					io.error.putstring ("Cannot create file: ");
					io.error.putstring (filename);
					io.error.new_line;
					file_error := True;
				end;
			end;
		end;

feature -- Output

	print_option_error is
			-- Print the correct usage of ewb.
		local
			i: INTEGER
		do	
			io.putstring (argument (0));
			io.putstring (": incorrect options%N"); 
			print_usage;
		end;

	print_usage is
			-- Print the usage of command line options.
		do
			io.putstring ("Usage:%N%T");
			io.putstring (argument (0));
			io.putstring (" [-help | ");
			add_usage_special_cmds;
			io.putstring ("%
				%-loop | -quick_melt | -clients [-filter filtername] class |%N%
				%%T-suppliers [-filter filtername] class |%N%
				%%T-flatshort [-filter filtername] [-all | -all_and_parents | class] |%N%
				%%T-flat [-filter filtername] [-all | -all_and_parents | class] |%N%
				%%T-short [-filter filtername] [-all | -all_and_parents | class] | %N%
				%%T-filter filtername [-all | class] |%N%
				%%T-descendants [-filter filtername] class |%N%
				%%T-ancestors [-filter filtername] class |%N%
				%%T-aversions [-filter filtername] class feature |%N%
				%%T-dversions [-filter filtername] class feature |%N%
				%%T-implementers [-filter filtername] class feature |%N%
				%%T-callers [-filter filtername] [-show_all] class feature |%N%
				%%T[-stop] [-ace Ace] [-project Project] [-file File]]%N");
		end;

	print_help is
			-- Print the help.
		local
			command_list: SORTED_TWO_WAY_LIST [STRING];
			keys: ARRAY [STRING];
			i, nb: INTEGER;
			cmd_name: STRING;
		do
			print_usage;
			io.putstring ("%NOptions:%N"); 
			io.putstring ("%Tdefault (no option): recompile the system.%N%N");

			!!command_list.make;
			keys := help_messages.current_keys;
			from
				i := keys.lower;
				nb := keys.upper;
			until
				i > nb
			loop
				command_list.extend (keys @ i);
				i := i + 1;
			end;
			from
				command_list.start
			until
				command_list.after
			loop
				cmd_name := command_list.item;
				print_one_help (cmd_name, help_messages.item (cmd_name));
				command_list.forth
			end;
		end;

	print_one_help (opt: STRING; txt: STRING) is
		do
			io.putstring ("%T-");
			io.putstring (opt);
			io.putstring (": ");
			io.putstring (txt);
			io.putstring (".%N")
		end;

feature -- Update

	add_usage_special_cmds is
		do
		end;

	add_help_special_cmds is
		do
		end;

	analyze_options is
			-- Analyze the options entered by the user.
		local
			i: INTEGER
		do
					-- Default Project Options
			Project_name := clone (Operating_environment.Current_directory_name_representation);

			from
				current_option := 1
			until
				(current_option > argument_count) or else
				option_error	
			loop
				analyze_one_option
			end;

				-- Default command
			if (not option_error) and then (command = Void) then
				!EWB_COMP!command
			end
		end;

	analyze_one_option is
			-- Analyze current option.
		local
			cn, fn: STRING;
			filter_name: STRING;
			show_all: BOOLEAN;
			ewb_senders: EWB_SENDERS
		do
			filter_name := "";
			option := argument (current_option);	

			if option.is_equal ("-help") then
				help_only := True
			elseif option.is_equal ("-loop") then
				if command /= Void then
					option_error := True
				else
					command := loop_cmd
				end;
			elseif option.is_equal ("-quick_melt") then
				!EWB_QUICK_MELT! command 
			elseif option.is_equal ("-implementers") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1;
								filter_name := argument (current_option);
								current_option := current_option + 1
							else
								option_error := True
							end
						end;
						if not option_error then
							cn := argument (current_option);
							current_option := current_option + 1;
							fn := argument (current_option);
							!EWB_HISTORY!command.make (cn, fn, filter_name)
						end
					end
				else
					option_error := True
				end;
			elseif option.is_equal ("-aversions") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1;
								filter_name := argument (current_option);
								current_option := current_option + 1
							else
								option_error := True
							end
						end;
						if not option_error then
							cn := argument (current_option);
							current_option := current_option + 1;
							fn := argument (current_option);
							!EWB_PAST!command.make (cn, fn, filter_name)
						end
					end
				else
					option_error := True
				end;
			elseif option.is_equal ("-dversions") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1;
								filter_name := argument (current_option);
								current_option := current_option + 1
							else
								option_error := True
							end
						end;
						if not option_error then
							cn := argument (current_option);
							current_option := current_option + 1;
							fn := argument (current_option);
							!EWB_FUTURE!command.make (cn, fn, filter_name)
						end
					end
				else
					option_error := True
				end;
			elseif option.is_equal ("-callers") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1;
								filter_name := argument (current_option);
								current_option := current_option + 1
							else
								option_error := True
							end
						end;
						if argument (current_option).is_equal ("-show_all") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1;
								show_all := True
							else
								option_error := True
							end
						end;
						if not option_error then
							cn := argument (current_option);
							current_option := current_option + 1;
							fn := argument (current_option);
							!! ewb_senders.make (cn, fn, filter_name);
							if show_all then
								ewb_senders.set_all_callers
							end;	
							command := ewb_senders
						end
					end
				else
					option_error := True
				end;
--			elseif option.is_equal ("-dependents") then
--				if current_option < (argument_count - 1) then
--					if command /= Void then
--						option_error := True
--					else
--						current_option := current_option + 1;
--						cn := argument (current_option);
--						current_option := current_option + 1;
--						fn := argument (current_option);
--						!EWB_DEPEND!command.make (cn, fn, filter_name);
--					end;
--				else
--					option_error := True
--				end;
			elseif 
				option.is_equal ("-short") or else
				option.is_equal ("-flatshort") 
			then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1;
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end;
						if not option_error then
							cn := argument (current_option);
							if option.is_equal ("-short") then
								if cn.is_equal ("-all") then
									!EWB_DOCUMENTATION! command.make_short (filter_name, false)
								elseif cn.is_equal ("-all_and_parents") then
									!EWB_DOCUMENTATION! command.make_short (filter_name, true)
								else
									!EWB_SHORT!command.make (cn, filter_name)
								end
							elseif cn.is_equal ("-all") then
								!EWB_DOCUMENTATION! command.make_flat_short (filter_name, false)
							elseif cn.is_equal ("-all_and_parents") then
								!EWB_DOCUMENTATION! command.make_flat_short (filter_name, true)
							else
								!EWB_FS!command.make (cn, filter_name)
							end;
						end
					end;
				else
					option_error := True
				end;
			elseif option.is_equal ("-flat") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1;
								filter_name := argument (current_option)
								current_option := current_option + 1
							else
								option_error := True
							end
						end;
						if not option_error then
							cn := argument (current_option);
							if cn.is_equal ("-all") then
								!EWB_DOCUMENTATION! command.make_flat (filter_name, false)
							elseif cn.is_equal ("-all_and_parents") then
								!EWB_DOCUMENTATION! command.make_flat (filter_name, true)
							else
								!EWB_FLAT!command.make (cn, filter_name)
							end
						end;
					end;
				else
					option_error := True
				end;
			elseif option.is_equal ("-filter") then
				if current_option + 1 < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						filter_name := argument (current_option)
						current_option := current_option + 1;
						cn := argument (current_option);
						if cn.is_equal ("-all") then
							!EWB_DOCUMENTATION! command.make_text (filter_name)
						else
							!EWB_TEXT!command.make (cn, filter_name)
						end
					end;
				else
					option_error := True
				end;
			elseif option.is_equal ("-ancestors") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1;
								filter_name := argument (current_option);
								current_option := current_option + 1
							else
								option_error := True
							end
						end;
						if not option_error then
							cn := argument (current_option);
							!EWB_ANCESTORS!command.make (cn, filter_name)
						end
					end
				else
					option_error := True
				end;
			elseif option.is_equal ("-clients") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1;
								filter_name := argument (current_option);
								current_option := current_option + 1
							else
								option_error := True
							end
						end;
						if not option_error then
							cn := argument (current_option);
							!EWB_CLIENTS!command.make (cn, filter_name)
						end
					end
				else
					option_error := True
				end;
			elseif option.is_equal ("-suppliers") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1;
								filter_name := argument (current_option);
								current_option := current_option + 1
							else
								option_error := True
							end
						end;
						if not option_error then
							cn := argument (current_option);
							!EWB_SUPPLIERS!command.make (cn, filter_name)
						end
					end
				else
					option_error := True
				end;
			elseif option.is_equal ("-descendants") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						if argument (current_option).is_equal ("-filter") then
							if current_option + 1 < argument_count then
								current_option := current_option + 1;
								filter_name := argument (current_option);
								current_option := current_option + 1
							else
								option_error := True
							end
						end;
						if not option_error then
							cn := argument (current_option);
							!EWB_DESCENDANTS!command.make (cn, filter_name)
						end
					end
				else
					option_error := True
				end;
			elseif option.is_equal ("-project") then
				if current_option < argument_count then
					current_option := current_option + 1;
					Project_name := argument (current_option)
				else
					option_error := True
				end;
			elseif option.is_equal ("-ace") then
				if current_option < argument_count then
					current_option := current_option + 1;
					Ace_name := argument (current_option)
				else
					option_error := True
				end;
			elseif option.is_equal ("-stop") then
					-- The compiler stops on errors
				set_stop_on_error (True);
			elseif option.is_equal ("-file") then
				if current_option < argument_count then
					current_option := current_option + 1;
					set_file (argument (current_option));
				else
					option_error := True
				end;
			elseif is_precompiled_option then
				if command /= Void then
					option_error := True
				else
					!EWB_PRECOMP!command.make (False)
				end
			elseif is_precompiled_licensed_option then
				if command /= Void then
					option_error := True
				else
					!EWB_PRECOMP!command.make (True)
				end
			else
				process_special_options
			end;
			current_option := current_option + 1
		end;

	process_special_options is
			-- Set option_error to True.
		do
			option_error := True
		end;

end -- class BASIC_ES
