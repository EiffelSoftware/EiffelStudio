indexing

	description:
			"Converts the output of the profiler-tool of %
			% the latest run into an internal representation.";
	date:		"$Date$";
	revision:	"$Revision $"

class EWB_GENERATE

inherit
	EWB_CMD
		rename
			name as generate_cmd_name,
			help_message as generate_help,
			abbreviation as generate_abb
		redefine
			loop_action
		end

feature {NONE} -- Execution

	loop_action is
		local
			command_arguments: EWB_ARGUMENTS;
			new_commands: INTEGER;
		do
			command_arguments := command_line_io.command_arguments
			if command_arguments.argument_count /= 3 then
				io.putstring ("--> Filename and compile_type: ");
				command_line_io.get_name;
				new_commands := 1;
			end;
			proffile_dir := command_arguments.item (2 - new_commands);
			compile_type := command_arguments.item (3 - new_commands);
			execute;
		end;

	-- don't know excactly how, but that comes...
	-- it should become external executable.
	execute is
		local
			prof_converter: PROF_CONVERTER
		do
			!! prof_converter.make (<<proffile_dir, compile_type>>);
		end;

feature {NONE} -- Attributes

	proffile_dir, compile_type: STRING
		-- Arguments needed for the prof_converter.

end -- class EWB_GENERATE
