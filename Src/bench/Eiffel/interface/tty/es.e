-- Batch compiler.

class ES

inherit

	ARGUMENTS;
	SHARED_ERROR_BEHAVIOR;
	SHARED_EWB_HELP

creation

	make
	
feature -- Creation

	make is
			-- Analyze the command line options and 
			-- execute the appropriate command.
		do
			analyze_options;
			if option_error then
				print_option_error
			elseif help_only then
				print_help
			else
				command.work (Project_name, Ace_name);
			end;
		end;

feature -- Input/Output

	print_option_error is
			-- Putstring the correct usage of ewb.
		local
			i: INTEGER
		do	
			io.putstring (argument (0));
			io.putstring (": incorrect options%N"); 
			print_usage;
			io.putstring ("Options:%N"); 
			print_help
		end;

	print_usage is
		do
			io.putstring ("Usage:%N%T");
			io.putstring (argument (0));
			io.putstring (" [-help|-freeze|-finalize [-keep]|-precompile|%N%
				%%T-loop|-clients class|-suppliers class%N%
				%%T-flatshort [-troff] class|-flat class|-short [-troff] class%N%
				%%T-descendants class|-ancestors class|%N%
				%%T-aversions class feature|-dversions class feature|-implementers class feature%N%
				%%T-callers class feature|%N%
				%%T[-stop] [-ace Ace] [-project Project]]%N");
		end;

	print_help is
		do
			io.putstring ("%Tdefault (no option): recompile the system.%N");
			from
				help_messages.start
			until
				help_messages.after
			loop
				print_one_help 
					(help_messages.key_for_iteration, help_messages.item_for_iteration);
				help_messages.forth
			end
		end;

	print_one_help (opt: STRING; txt: STRING) is
		do
			io.putstring ("%T-");
			io.putstring (opt);
			io.putstring (": ");
			io.putstring (txt);
			io.putstring (".%N")
		end;

feature -- Command line options

	command: EWB_CMD;
			-- Command to be executed corresponding to
			-- command line options;

	Ace_name: STRING;
			-- Name of the Ace file.
			-- ("Ace" by default)

	Project_name: STRING;
			-- Name of the Project file.
			-- ("Project" by default)

	option_error: BOOLEAN;
			-- Has an error been encountered in the 
			-- command line options?

	current_option: INTEGER;
			-- Current index in the option list

	help_only: BOOLEAN;

	analyze_options is
		local
			i: INTEGER
		do
				-- Default Ace and Project
				-- Options
			Ace_name := "Ace";
			Project_name := ".";

			from
				current_option := 1
			until
				(current_option >= argument_count) or else
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
		local
			option: STRING;
			cn, fn: STRING;
			troffed: BOOLEAN;
			current_class_only: BOOLEAN;
			keep: BOOLEAN;
		do
			option := argument (current_option);	

			if option.is_equal ("-help") then
				help_only := True
			elseif option.is_equal ("-loop") then
				if command /= Void then
					option_error := True
				else
					!EWB_LOOP!command
				end;
			elseif option.is_equal ("-freeze") then
				if command /= Void then
					option_error := True
				else
					!EWB_FREEZE!command
				end
			elseif option.is_equal ("-finalize") then
				if command /= Void then
					option_error := True
				else
					if current_option < (argument_count - 1) then
						if argument (current_option + 1).is_equal ("-keep") then
							current_option := current_option + 1;
							keep := True;
						end;
					end;
					!EWB_FINALIZE!command.make (keep);
				end
--			elseif option.is_equal ("-clean") then
--				if command /= Void then
--					option_error := True
--				else
--					!EWB_CLEAN!command
--				end
			elseif option.is_equal ("-precompile") then
				if command /= Void then
					option_error := True
				else
					!EWB_PRECOMP!command
				end
			elseif option.is_equal ("-implementers") then
				if current_option < (argument_count - 2) then
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
				if current_option < (argument_count - 2) then
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
				if current_option < (argument_count - 2) then
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
				if current_option < (argument_count - 2) then
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
--				if current_option < (argument_count - 2) then
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
				if current_option < (argument_count - 1) then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						if argument (current_option).is_equal ("-troff") then
							troffed := True;
							if current_option < (argument_count - 1) then
									current_option := current_option + 1;
							else
								option_error := True
							end;
						end;
						if not option_error then
							if option.is_equal ("-short") then
								current_class_only := True
							end;
							cn := argument (current_option);
							!EWB_FS!command.make (cn, troffed, current_class_only)
						end
					end;
				else
					option_error := True
				end;
			elseif option.is_equal ("-flat") then
				if current_option < (argument_count - 1) then
					if command /= Void then
						option_error := True
					else
						current_option := current_option + 1;
						cn := argument (current_option);
						!EWB_FLAT!command.make (cn)
					end;
				else
					option_error := True
				end;
			elseif option.is_equal ("-ancestors") then
				if current_option < (argument_count - 1) then
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
				if current_option < (argument_count - 1) then
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
				if current_option < (argument_count - 1) then
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
				if current_option < (argument_count - 1) then
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
				if current_option < (argument_count - 1) then
					current_option := current_option + 1;
					Project_name := argument (current_option)
				else
					option_error := True
				end;
			elseif option.is_equal ("-ace") then
				if current_option < (argument_count - 1) then
					current_option := current_option + 1;
					Ace_name := argument (current_option)
				else
					option_error := True
				end;
			elseif option.is_equal ("-stop") then
					-- The compiler stops on errors
				set_stop_on_error (True);
			else
				option_error := True
			end;
			current_option := current_option + 1
		end;

end
