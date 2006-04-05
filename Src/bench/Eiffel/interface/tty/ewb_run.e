indexing

	description: 
		"Command to run an eiffel application."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_RUN

inherit

	EWB_CMD
		rename
			name as run_cmd_name,
			help_message as run_help,
			abbreviation as run_abb
		redefine
			loop_action
		end;
	SHARED_EXEC_ENVIRONMENT;
	PROJECT_CONTEXT

feature {NONE} -- Implementation

	loop_action is
			-- Execute the generated application
		local
			appl_name: STRING;
			f_name: FILE_NAME;
			f: RAW_FILE;
			make_f: INDENT_FILE;
			error: BOOLEAN;
			cmd_exec: COMMAND_EXECUTOR
		do
			if Eiffel_system = Void or else Eiffel_system.name = Void then
				output_window.put_string (Warning_messages.W_must_compile_first)
				output_window.put_new_line
			else
				appl_name := Eiffel_system.application_name (True);
				create f.make (appl_name);
				if not f.exists then
					output_window.put_string (Warning_messages.w_file_not_exist (appl_name))
					output_window.put_new_line
				else
					create f_name.make_from_string (Workbench_generation_path);
					f_name.set_file_name (Makefile_SH);
					create make_f.make (f_name);
					if make_f.exists and then make_f.date > f.date then
						output_window.put_string (Warning_messages.w_MakefileSH_more_recent)
						output_window.put_new_line
						error := True
					end;
					if not error then
						create cmd_exec;
						cmd_exec.execute_with_args (appl_name, arguments);
					end;
				end
			end
		end;

	execute is
			-- This command is available only for the `loop' mode
		do
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EWB_RUN
