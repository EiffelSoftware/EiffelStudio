indexing

	description:
		"Converts the output of the profiler-tool of %
		%the latest run into an internal representation.";
	date: "$Date$";
	revision: "$Revision $"

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
		do
			command_line_io.get_prof_file_name;
			if command_line_io.last_input.is_empty then
				proffile_dir := "profinfo"
			else
				proffile_dir := command_line_io.last_input
			end
			command_line_io.get_compile_type;
			if command_line_io.last_input.is_empty then
				compile_type := "workbench"
			else
				compile_type := command_line_io.last_input
			end;
			command_line_io.get_profiler;
			if command_line_io.last_input.is_empty then
				profiler := "eiffel"
			else
				profiler := command_line_io.last_input
			end;
			execute;
		end;

	execute is
		local
			prof_converter: CONVERTER_CALLER
			conf_load: CONFIGURATION_LOADER
			prof_invoker: PROFILER_INVOKER
		do
			!! conf_load.make_and_load (profiler);
			if conf_load.error_occured then
				raise_config_error;
			else
				!! prof_invoker.make (conf_load.profiler_type, arguments, proffile_dir, compile_type);
				if prof_invoker.must_invoke_profiler then
					prof_invoker.invoke_profiler;
				end;
				!! prof_converter.make (<<proffile_dir, compile_type>>, conf_load.shared_prof_config);
				if prof_converter.conf_load_error then
					io.error.put_string (proffile_dir)
					io.error.putstring (": File does not exist!%N%N")
				else
					io.putstring ("Ready for queries...")
				end
			end;
		end;

feature {NONE} -- Attributes

	proffile_dir, compile_type, profiler: STRING
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
