note
	description: "Melt eiffel system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EWB_COMP

inherit
	PROJECT_CONTEXT

	EWB_EDIT

	EWB_CMD
		redefine
			executable,
			loop_action
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

	SHARED_ERROR_BEHAVIOR

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature -- Initialization

	init
		do
			if Eiffel_ace.file_name = Void then
				select_ace_file;
			end;
			if Eiffel_ace.file_name /= Void then
				print_header;
			end;
		end;

feature -- Properties

	name: STRING
		do
			Result := melt_cmd_name
		end;

	help_message: STRING_32
		do
			Result := melt_help
		end;

	abbreviation: CHARACTER
		do
			Result := melt_abb
		end;

	is_finish_freezing_called: BOOLEAN
			-- Should `finish_freezing' be called if needed after Eiffel compilation?

feature -- Status report

	executable: BOOLEAN
			-- <Precursor>
		do
				-- A system can be always compiled.
			Result := True
		end

feature -- Actions

	execute
		do
			if Eiffel_project.is_read_only then
				localized_print_error (ewb_names.read_only_project_cannot_compile)
			elseif eiffel_project.initialized then
				init;
				if Eiffel_ace.file_name /= Void then
					compile;
					if Eiffel_project.successful then
						print_tail;
						if Eiffel_project.freezing_occurred then
							process_finish_freezing (False)
						end
					end;
				end;
			end
		end;

feature -- Setting

	set_is_finish_freezing_called (v: like is_finish_freezing_called)
			-- Set `is_finish_freezing_called' with `v'.
		do
			is_finish_freezing_called := v
		ensure
			is_finish_freezing_called_set: is_finish_freezing_called = v
		end

feature {NONE} -- Update

	select_ace_file
			-- Select an Ace if it hasn't been specified.
		require
			no_lace_file: Eiffel_ace.file_name = Void
		local
			file_name: STRING_32
			s, cmd: STRING
			option: CHARACTER
			exit: BOOLEAN
			u: FILE_UTILITIES
			file: PLAIN_TEXT_FILE
		do
			from
			until
				exit
			loop
				localized_print (ewb_names.specify_the_ace_file)
				io.read_line;
				cmd := io.last_string;
				exit := True;
				if cmd.is_empty or else cmd.count > 1 then
					option := ' ';
				else
					option := cmd.item (1).lower
				end;
				inspect
					option
				when 'c' then
					Eiffel_ace.set_file_name (Void)
				when 's' then
					localized_print (ewb_names.file_name_with_default)
					io.read_line;
					s := io.last_string;
					if not s.is_empty then
						create file_name.make (s.count)
						file_name.append_string_general (s)
						Eiffel_ace.set_file_name (file_name);
					else
						create file.make_with_name ("Ace.ace");
						if file.exists then
							Eiffel_ace.set_file_name ("Ace.ace");
						else
							create file.make_with_name ("Ace")
							if file.exists then
								Eiffel_ace.set_file_name ("Ace")
							else
								Eiffel_ace.set_file_name ("Ace.ace");
							end
						end
					end;
					check_ace_file (Eiffel_ace.file_name);
				when 't' then
					localized_print (ewb_names.file_name)
					io.read_line
					s := io.last_string
					if s.is_empty then
						exit := True
					else
						create file_name.make (s.count)
						file_name.append_string_general (s)
						u.copy_file (eiffel_layout.default_scoop_config_file_name.name, file_name)
						Eiffel_ace.set_file_name (file_name.twin)
						edit (Eiffel_ace.file_name)
					end
				else
					localized_print (ewb_names.invalid_choices)
					exit := False
				end
			end
		end

	compile
			-- Melt system.
		require
			non_void_lace: Eiffel_ace.file_name /= Void
		local
			exit: BOOLEAN;
		do
			from
					-- Is the Ace file still there?
				check_ace_file (Eiffel_ace.file_name)
			until
				exit
			loop
				perform_compilation;
				if Eiffel_project.successful then
					exit := True
				elseif Eiffel_project.save_error then
					save_project_again
				else
					if stop_on_error then
						lic_die (-1)
					end;
					if command_line_io.termination_requested then
						exit := True
					end
				end
			end;
		end;

	loop_action
		do
			execute
		end;

feature {NONE} -- Output

	process_finish_freezing (finalized_dir: BOOLEAN)
			-- Perform finish_freezing step if needed or display message.
		do
			if is_finish_freezing_called then
				Eiffel_project.call_finish_freezing_and_wait (not finalized_dir)
			else
				localized_print_error (ewb_names.you_must_now_run (eiffel_layout.Finish_freezing_script))
				if finalized_dir then
					localized_print_error (project_location.final_path.name)
				else
					localized_print_error (project_location.workbench_path.name)
				end;
				io.error.put_new_line;
			end
		end;

	print_header
			-- Print header information of compilation.
		do
			Degree_output.put_header
		end

	print_tail
			-- Print completion message of compilation.
		do
			Degree_output.put_system_compiled
		end

feature {NONE} -- Compilation

	perform_compilation
			-- Melt eiffel project.
		do
			Eiffel_project.discover_melt
		end

	save_project_again
			-- Try to save the project again.
		require
			error: Eiffel_project.save_error
		local
			finished: BOOLEAN
		do
			from
			until
				finished
			loop
				if Eiffel_project.save_error then
					localized_print_error (ewb_names.error_could_not_write_to (project_location.project_file_name.name))
					io.error.put_new_line
					finished := stop_on_error or else command_line_io.termination_requested
					if finished then
						lic_die (-1)
					else
						perform_compilation
					end
				end
			end
		end

	check_ace_file (fn: READABLE_STRING_GENERAL)
			-- Check that the Ace file exists and is readable and plain
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make_with_name (fn);
			if
				not (f.exists and then f.is_readable and then f.is_plain)
			then
				if f.exists then
					localized_print_error (ewb_names.ace_file_cannot_be_read (fn))
				else
					localized_print_error (ewb_names.ace_file_does_not_exist (fn))
				end;
				lic_die (-1)
			end
		end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
