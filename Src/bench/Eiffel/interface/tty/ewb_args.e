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
				io.put_string ("No previous value%N")
			else
				io.put_string ("Previous value: `");
				io.put_string (args);
				io.put_string ("'%N");
			end;
				-- Get the arguments
			io.put_string ("--> Arguments: ");
			command_line_io.wait_for_return;
			new_args := io.last_string.twin
			if new_args.is_empty then
				if not args.is_empty then
					io.put_string ("No value entered. Do you want to: %N%
								%D: delete the previous value%N%
								%K: keep the previous value (default)%N%
								%Option: ");
					io.read_line;
					cmd := io.last_string;
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
