indexing

	description:
		"Converts the output of the profiler-tool of %
		%the latest run into an internal representation."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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
			create conf_load.make_and_load (profiler);
			if conf_load.error_occurred then
				raise_config_error;
			else
				create prof_invoker.make (conf_load.profiler_type, arguments, proffile_dir, compile_type);
				if prof_invoker.must_invoke_profiler then
					prof_invoker.invoke_profiler;
				end;
				create prof_converter.make (<<proffile_dir, compile_type>>, conf_load.shared_prof_config);
				if prof_converter.conf_load_error then
					io.error.put_string (proffile_dir)
					io.error.put_string (": File does not exist!%N%N")
				else
					io.put_string ("Ready for queries...")
				end
			end;
		end;

feature {NONE} -- Attributes

	proffile_dir, compile_type, profiler: STRING
		-- Arguments needed for the prof_converter.

feature {NONE} -- Implementation

	raise_config_error is
			-- Explains that an error occurred while loading the
			-- profiler specific configuration file.
		do
			output_window.put_string ("An error occurred while loading the configuration for your profiler.");
			output_window.put_new_line;
			output_window.put_string ("Please check with your system administrator whether your profiler is supported.");
			output_window.put_new_line;
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EWB_GENERATE
