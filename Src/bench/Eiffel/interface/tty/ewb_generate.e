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
			from
			until
				command_arguments.argument_count + new_commands = 3
			loop
				io.putstring ("--> Filename and compile_type: ");
				command_line_io.get_name;
				new_commands := 1;
			end;
			from
				proffile_dir := command_arguments.item (2 - new_commands);
			until
				command_arguments.item (3 - new_commands).is_equal ("workbench") or else 
				command_arguments.item (3 - new_commands).is_equal ("final")
			loop
				io.putstring ("--> compile_type: ");
				command_line_io.get_name;
				new_commands := 2;
			end;
			compile_type := command_arguments.item (3 - new_commands);
			execute;
		end;

	execute is
		local
			prof_converter: CONVERTER_CALLER
			conf_load: CONFIGURATION_LOADER
			prof_invoker: PROFILER_INVOKER
		do
			!! conf_load.make_and_load;
			if conf_load.error_occured then
				raise_config_error;
			else
				!! prof_invoker.make (conf_load.profiler, arguments, proffile_dir, compile_type);
				if prof_invoker.must_invoke_profiler then
					prof_invoker.invoke_profiler;
				end;
				!! prof_converter.make (<<proffile_dir, compile_type>>, conf_load.shared_prof_config);
			end;
		end;

feature {NONE} -- Attributes

	proffile_dir, compile_type: STRING
		-- Arguments needed for the prof_converter.

feature {NONE} -- Implementation

	raise_config_error is
			-- Explains that an error occured while loading the
			-- profiler specific configuration file.
		do
			output_window.put_string ("An error occured while loading the configuration for your profiler.");
			output_window.new_line;
			output_window.put_string ("Please check with your system administrator whether your profiler is supported.");
			output_window.new_line;
		end

end -- class EWB_GENERATE
