-- Batch compiler.

class ES

inherit

	ARGUMENTS

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
			io.error.putstring (argument (0));
			io.error.putstring (": incorrect options%N"); 
			print_usage;
			print_help
		end;

	print_usage is
		do
			io.error.putstring ("Usage: ");
			io.error.putstring (argument (0));
			io.error.putstring ("-h [-f|-F|-p|-clean|-senders class feature]%
				% [-fs [-troff] class] [-descendants class] [-ace Ace] [-project Project]%N");
		end;

	print_help is
		do
			print_one_help ("-h", "print this help message");
			print_one_help ("-f", "freeze the system");
			print_one_help ("-F", "finalize the system");
			print_one_help ("-p", "precompile the system");
			print_one_help ("-clean", "clean the compilation structures");
			print_one_help ("-ace", "specify the Ace file");
			print_one_help ("-project", "specify the compilation directory");
			print_one_help ("-senders", "print the senders of a class feature");
			print_one_help ("-descendants", "print the descendants of a class");
			print_one_help ("-fs", "print the flat-short of a class")
		end;

	print_one_help (opt: STRING; txt: STRING) is
		do
			io.error.putstring ("%T");
			io.error.putstring (opt);
			io.error.putstring (" : ");
			io.error.putstring (txt);
			io.error.putstring (".%N")
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
			-- Current indwx in the option list

	help_only: BOOLEAN;

	analyze_options is
		local
			i: INTEGER
		do
				-- Default Ace and Project
				-- Options
			Ace_name := "Ace";
			Project_name := "Project";

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
			troffed: BOOLEAN
		do
			option := argument (current_option);	

			if option.is_equal ("-h") then
				help_only := True
			elseif option.is_equal ("-f") then
				if command /= Void then
					option_error := True
				else
					!EWB_FREEZE!command
				end
			elseif option.is_equal ("-F") then
				if command /= Void then
					option_error := True
				else
					!EWB_FINALIZE!command
				end
			elseif option.is_equal ("-clean") then
				if command /= Void then
					option_error := True
				else
					!EWB_CLEAN!command
				end
			elseif option.is_equal ("-p") then
				if command /= Void then
					option_error := True
				else
					!EWB_PRECOMP!command
				end
			elseif option.is_equal ("-senders") then
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
			elseif option.is_equal ("-fs") then
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
							cn := argument (current_option);
							!EWB_FS!command.make (cn, troffed)
						end
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
			else
				option_error := True
			end;
			current_option := current_option + 1
		end;

end
