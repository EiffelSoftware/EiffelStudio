indexing

	description:
			"Specification of the inputfile for the query";
	default:	"First run: *.profile_information, Subsequential: last_output OR some file";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_INPUT

inherit
	EWB_CMD
		rename
			name as input_cmd_name,
			abbreviation as input_abb
		redefine
			loop_action
		end;
	SHARED_QUERY_VALUES

create
	make_loop

feature -- Creation

	make_loop is
		do
			first_run := true;
			filenames.force ("*.pfi", filenames.count + 1);
		end;

feature {NONE} -- Help message

	help_message: STRING is
		local
			i: INTEGER
		do
			Result := input_help.twin
			Result.append ("%N%T%T%T%T");
			if filenames.count = 0 then
				Result.append ("[last_output]");
			else
				from
					i := 1;
					Result.extend ('[');
				until
					i > filenames.count
				loop
					Result.append (filenames.item (i));
					i := i + 1
					if i <= filenames.count then
						Result.extend (' ');
					end;
				end;
				Result.extend (']');
			end;
		end;

feature {NONE} -- Execute

	loop_action is
		local
			command_arguments: EWB_ARGUMENTS;
			i: INTEGER;
			empty_array: ARRAY [STRING];
		do
			create empty_array.make (1, 0);
			command_arguments := command_line_io.command_arguments;
			if first_run and command_arguments.argument_count = 1 then
				filenames.copy (empty_array);
				filenames.force ("*.pfi", filenames.count + 1);
			else
				if command_arguments.argument_count = 1 then
					if filenames.count = 1 then
						command_arguments.force ("last_output", 1);
					else
						io.put_string ("--> Filename(s): ");
						command_line_io.get_name;
					end;
					i := 1;
				else
					i := 2;
				end;
				filenames.copy (empty_array);
				from
				until
					i > command_arguments.argument_count
				loop
					filenames.force (command_arguments.item (i), filenames.count + 1);
					i := i + 1;
				end;
			end;
			execute;
		end;

	-- don't know exactly how, but that comes.
	-- IDEA: wipe_out current and replace with user's.
	execute is
		do
			first_run := false;
		end;

feature {NONE} -- Attributes

	first_run: BOOLEAN

end -- class EWB_INPUT
