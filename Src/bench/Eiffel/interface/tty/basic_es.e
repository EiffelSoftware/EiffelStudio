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
	COMMAND_LINE_PROJECT;
	SHARED_RESOURCES

creation

	make

feature -- Initialization

	make is
			-- Analyze the command line options and 
			-- execute the appropriate command.
		local
			temp: STRING
		do
			if not retried then
					-- Check that environment variables
					-- are properly set.
				temp := Execution_environment.get ("EIFFEL3");
				if (temp = Void) or else temp.empty then
					io.error.putstring
					("ISE Eiffel3: the environment variable $EIFFEL3 is not set%N");
					new_die (-1)
				end;
				temp := Execution_environment.get ("PLATFORM");
				if (temp = Void) or else temp.empty then
					io.error.putstring
					("ISE Eiffel3: the environment variable $PLATFORM is not set%N");
					new_die (-1)
				end;

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
				end;
			else
				new_die (-1)
			end;
		rescue
			discard_licence;
			io.error.putstring ("ISE Eiffel3: Session aborted%N");
			io.error.putstring ("Exception tag: ");
			temp := original_tag_name;
			if temp /= Void then
				io.error.putstring (temp);
			end;
			io.error.new_line;
			if not resources.get_boolean (r_Fail_on_rescue, False) then
				retried := True;
				retry
			end;
		end;

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
				%-loop | -clients class | -suppliers class |%N%
				%%T-flatshort [-filter filtername] class |%N%
				%%T-flat [-filter filtername] class |%N%
				%%T-short [-filter filtername] class | -filter filtername class |%N%
				%%T-descendants class | -ancestors class |%N%
				%%T-aversions class feature | -dversions class feature |%N%
				%%T-implementers class feature | -callers class feature |%N%
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
			filter_name: STRING
		do
			option := argument (current_option);	

			if option.is_equal ("-help") then
				help_only := True
			elseif option.is_equal ("-loop") then
				if command /= Void then
					option_error := True
				else
					command := loop_cmd
				end;
			elseif option.is_equal ("-implementers") then
				if current_option < (argument_count - 1) then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						cn := argument (current_option);
						current_option := current_option + 1;
						fn := argument (current_option);
						!EWB_HISTORY!command.make (cn, fn);
					end;
				else
					option_error := True
				end;
			elseif option.is_equal ("-aversions") then
				if current_option < (argument_count - 1) then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						cn := argument (current_option);
						current_option := current_option + 1;
						fn := argument (current_option);
						!EWB_PAST!command.make (cn, fn);
					end;
				else
					option_error := True
				end;
			elseif option.is_equal ("-dversions") then
				if current_option < (argument_count - 1) then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						cn := argument (current_option);
						current_option := current_option + 1;
						fn := argument (current_option);
						!EWB_FUTURE!command.make (cn, fn);
					end;
				else
					option_error := True
				end;
			elseif option.is_equal ("-callers") then
				if current_option < (argument_count - 1) then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						cn := argument (current_option);
						current_option := current_option + 1;
						fn := argument (current_option);
						!EWB_SENDERS!command.make (cn, fn);
					end;
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
--						!EWB_DEPEND!command.make (cn, fn);
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
								!EWB_SHORT!command.make (cn, filter_name)
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
						cn := argument (current_option);
						!EWB_FLAT!command.make (cn, filter_name)
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
--						!EWB_FILTER!command.make (cn, filter_name)
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
						cn := argument (current_option);
						!EWB_ANCESTORS!command.make (cn)
					end;
				else
					option_error := True
				end;
			elseif option.is_equal ("-clients") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						cn := argument (current_option);
						!EWB_CLIENTS!command.make (cn)
					end;
				else
					option_error := True
				end;
			elseif option.is_equal ("-suppliers") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						cn := argument (current_option);
						!EWB_SUPPLIERS!command.make (cn)
					end;
				else
					option_error := True
				end;
			elseif option.is_equal ("-descendants") then
				if current_option < argument_count then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						cn := argument (current_option);
						!EWB_DESCENDANTS!command.make (cn)
					end;
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
					!EWB_PRECOMP!command
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
