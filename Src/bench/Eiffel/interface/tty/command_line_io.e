indexing

	description: 
		"Input/output operation for batch command line processing.";
	date: "$Date$";
	revision: "$Revision $"

class COMMAND_LINE_IO 

feature -- Properties

	output_window: OUTPUT_WINDOW;
			-- Output window

	last_input: STRING;
			-- Last input string

	abort: BOOLEAN;
			-- Does the user want to abort the command?

feature -- Input/output

	termination_requested: BOOLEAN is
		local
			str: STRING
		do
			io.error.putstring ("%N%
				%Press <Return> to resume compilation or <Q> to quit%N");
			wait_for_return;
			str := clone (io.laststring)
			str.to_lower;
			Result := ((str.count >= 1) and then (str.item (1) = 'q'))
		end;

	confirmed (message: STRING): BOOLEAN is
		local
			c: CHARACTER
		do
			io.putstring (message);
			io.putstring (" [y/n]? ");
			io.readchar;
			c := io.lastchar;
			if c /= '%N' then
				io.next_line;
			end;
			Result := ((c = 'Y') or (c = 'y'))
		end;

	wait_for_return is
		do
			io.readline;
		rescue
			retry
		end;

	get_last_input is
			-- Get the last input entered by the user
		do
			last_input := command_arguments.current_item;
		end;

	more_arguments: BOOLEAN is
			-- Are there more arguments?
		do
			Result := command_arguments.more_arguments
		end;

	get_name is
			-- Get the name of the last entered text
		local
			i, j: INTEGER
			item: CHARACTER
			arg: STRING
			count: INTEGER
		do
			wait_for_return
			count := io.laststring.count
			create arg.make (count)
			command_arguments.wipe_out
			from
				i := 1
				j := 1
			until
				(i > count)
			loop
				item := io.laststring.item (i)
				if (item = ' ') or else (item = '%T') then
					if arg.count /= 0 then
						command_arguments.force (arg, j)
						j := j + 1
						create arg.make (count - i)
					end
				else
					arg.extend (item)
				end
				i := i + 1
			end
			if j = 1 or else arg.count /= 0 then
					-- If we are processing more than one word, we don't
					-- want to keep the trailing white spaces
				command_arguments.force (arg, j)
			end
		end

	get_class_name is
		do
			if not more_arguments then
				io.putstring ("--> Class name: ");
				get_name;
			end;
			get_last_input;
			last_input.to_lower;
			if last_input.is_empty then
				abort := True
			end;
		end;

	get_feature_name is
		do
			if not more_arguments then
				io.putstring ("--> Feature name: ");
				get_name;
			end;
			get_last_input;
			last_input.to_lower;
			if last_input.is_empty then
				abort := True
			end;
		end;

	get_filter_name is
		do
			if not more_arguments then
				io.putstring ("--> Filter name: ");
				get_name;
			end;
			get_last_input;
		end;

	get_option_value (an_option: STRING; value: BOOLEAN) is
			-- Get a valid from `an_option' of either
			-- true or false.
			-- Set `last_input' to "False" or "True"
		require
			valid_name: an_option /= Void
		local
			tmp: STRING
		do
			if not more_arguments then
				io.putstring ("--> ");
				io.putstring (an_option);
				io.putstring (" [")
				if value then
					io.putstring ("yes")
				else
					io.putstring ("no")
				end;
				io.putstring ("]: ")
				get_name;
			end;
			get_last_input;
			if last_input = Void or else last_input.is_empty then
				last_input := value.out
			else
				tmp := clone (last_input);
				tmp.to_lower;
				if tmp.is_equal ("yes") or else tmp.is_equal ("y") then
					last_input := (True).out
				else
					last_input := (False).out
				end
			end
		ensure
			last_input_is_boolean: last_input.is_boolean
		end;

	get_prof_file_name is
		do
			if not more_arguments then
				io.putstring ("--> Profile information file name (default: `profinfo'): ");
				get_name
			end;
			get_last_input;
		end;

	get_compile_type is
		do
			if not more_arguments then
				from
					io.putstring ("--> Compile type (default: `workbench'): ");
					get_name;
					get_last_input
				until
					last_input.is_empty or else last_input.is_equal ("workbench") or else
					last_input.is_equal ("final")
				loop
					io.putstring ("--> Compile type (default: `workbench'): ");
					get_name;
					get_last_input
				end
			else
				get_last_input
			end
		end;

	get_profiler is
		do
			if not more_arguments then
				io.putstring ("--> Used profiler (default: `eiffel'): ");
				get_name
			end;
			get_last_input
		end;

	reset_abort is
		do
			abort := False
		ensure
			not_abort: not abort
		end;

	print_too_many_arguments is
		require
			more_arguments: more_arguments
		local
			not_first: BOOLEAN
		do
			io.error.putstring ("%
				%Too many arguments. The following arguments will be ignored:%N");
			from
			until
				not more_arguments
			loop
				if not_first then
					io.error.putchar (' ');
				end;
				not_first := True;
				io.error.putstring (command_arguments.current_item);
			end;
			io.error.new_line;
			io.error.new_line;
		end;

feature -- Setting

	set_output_window (display: OUTPUT_WINDOW) is
		do
			output_window := display
		end;

feature {EWB_CMD} -- Implementation

	command_arguments: EWB_ARGUMENTS is
		once
			!!Result.make (1, 2);
		end;

end -- class COMMAND_LINE_IO
