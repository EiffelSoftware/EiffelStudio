indexing

	description: 
		"Records arguments for application execution.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_ARGS

inherit

	EWB_CMD
		rename
			name as arguments_cmd_name,
			help_message as arguments_help,
			abbreviation as arguments_abb
		redefine
			loop_action
		end

feature {NONE} -- Execution

	loop_action is
			-- Execute Current batch command
		local
			args, new_args, cmd: STRING;
		do
			args := arguments;
				-- Display previous value
			if args.is_empty then
				io.putstring ("No previous value%N")
			else
				io.putstring ("Previous value: `");
				io.putstring (args);
				io.putstring ("'%N");
			end;
				-- Get the arguments
			io.putstring ("--> Arguments: ");
			command_line_io.wait_for_return;
			new_args := clone (io.laststring);
			if new_args.is_empty then
				if not args.is_empty then
					io.putstring ("No value entered. Do you want to: %N%
								%D: delete the previous value%N%
								%K: keep the previous value (default)%N%
								%Option: ");
					io.readline;
					cmd := io.laststring;
					if cmd.count = 1 and then cmd.item (1).lower = 'd' then
						arguments.wipe_out;
					end;
				end;
			else
				arguments.copy (new_args);
			end;
		end;

	execute is
			-- This command is available only for the `loop' mode.
		do
		end;

end -- class EWB_ARGS
