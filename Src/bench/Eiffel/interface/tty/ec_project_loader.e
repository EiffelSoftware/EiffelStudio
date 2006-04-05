indexing
	description: "Command line version for project loading."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EC_PROJECT_LOADER

inherit
	PROJECT_LOADER

feature -- Access

	should_stop_on_prompt: BOOLEAN
			-- If a path of execution asks for a prompt, should we simply
			-- stop the processing and set `has_error' to True.

feature -- Settings

	set_should_stop_on_prompt (v: like should_stop_on_prompt) is
			-- Set `should_stop_on_prompt' with `v'.
		do
			should_stop_on_prompt := v
		ensure
			should_stop_on_prompt_set: should_stop_on_prompt = v
		end

feature {NONE} -- Settings

	compile_project is
			-- Compile newly created project.
		do
			-- Nothing to be done, as it is handled later in batch mode.
		end

feature {NONE} -- Error reporting

	report_non_readable_configuration_file (a_file_name: STRING) is
			-- Report an error when `a_file_name' cannot be read.
		do
			io.put_string (warning_messages.w_cannot_read_file (a_file_name))
			io.put_new_line
			set_has_error
		end

	report_non_readable_ace_file_in_epr (a_epr_name, a_file_name: STRING) is
			-- Report an error when ace file `a_file_name' cannot be accessed from epr file `a_epr_name'.
			-- Note that `a_file_name' can be Void if `a_epr_name' does not mention it.
		do
			io.put_string (warning_messages.w_cannot_read_ace_file_from_epr (a_epr_name, a_file_name))
			io.put_new_line
			set_has_error
		end

	report_cannot_read_ace_file (a_file_name: STRING; a_conf_error: CONF_ERROR) is
			-- Report an error when ace  file `a_file_name' can be read, but its content cannot
			-- be properly interpreted. The details of the error are stored in `a_conf_error'.
		local
			l_vd00: VD00
		do
			set_has_error
			create l_vd00
			l_vd00.set_error (a_conf_error)
			error_handler.insert_error (l_vd00)
			error_handler.raise_error
		end

	report_cannot_read_config_file (a_file_name: STRING; a_conf_error: CONF_ERROR) is
			-- Report an error when a config file `a_file_name' can be read, but its content cannot
			-- be properly interpreted. The details of the error are stored in `a_conf_error'.
		local
			l_vd00: VD00
		do
			set_has_error
			create l_vd00
			l_vd00.set_error (a_conf_error)
			error_handler.insert_error (l_vd00)
			error_handler.raise_error
		end

	report_cannot_save_converted_file (a_file_name: STRING) is
			-- Report an error when result of a conversion from ace to acex cannot be stored
			-- in file `a_file_name'.
		do
			io.put_string (warning_messages.w_cannot_save_file (a_file_name))
			io.put_new_line
			set_has_error
		end

	report_cannot_create_project (a_dir_name: STRING) is
			-- Report an error when we cannot create project in `a_dir_name'.
		do
			io.put_string (warning_messages.w_cannot_create_project_directory (a_dir_name))
			io.put_new_line
			set_has_error
		end

	report_cannot_open_project (a_msg: STRING) is
			-- Report an error when project cannot be read/write for some reasons
			-- and possibly propose user to upgrade
		do
			io.put_string (a_msg)
			io.put_new_line
			set_has_error
		end

	report_incompatible_project (a_msg: STRING) is
			-- Report an error when retrieving an incompatible project and possibly
			-- propose user to upgrade.
		local
			l_answered: BOOLEAN
		do
			io.put_string (Warning_messages.w_project_incompatible_version (config_file_name, version_number,
					Eiffel_project.incompatible_version_number))
			io.put_new_line
			if not should_stop_on_prompt then
				from
				until
					l_answered
				loop
					io.put_string ("Do you want to update to new version of compiler? [y|n] ")
					io.read_line
					if not io.last_string.is_empty then
						if io.last_string.item (1).as_lower = 'y' then
							should_override_project := True
							l_answered := True
						elseif io.last_string.item (1).as_lower = 'n' then
							should_override_project := False
							l_answered := True
						end
					end
				end
			end
		end

	report_project_corrupted (a_msg: STRING) is
			-- Report an error when retrieving a project which is corrupted and possibly
			-- propose user to recompile from scratch.
		do
			io.put_string (a_msg)
			io.put_new_line
			set_has_error
		end

	report_project_retrieval_interrupted (a_msg: STRING) is
			-- Report an error when project retrieval was stopped.
		do
			io.put_string (a_msg)
			io.put_new_line
			set_has_error
		end

	report_project_incomplete (a_msg: STRING) is
			-- Report an error when project is incomplete and possibly propose
			-- user to recompile from scratch.
		do
			io.put_string (a_msg)
			io.put_new_line
			set_has_error
		end

	report_project_loaded_successfully is
			-- Report that project was loaded successfully.
		do
		end

feature {NONE} -- User interaction

	ask_for_config_name (a_dir_name, a_file_name: STRING; a_action: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Given `a_dir_name' and a proposed `a_file_name' name for the new acex format, ask the
			-- user if he wants to create `a_file_name' or a different name. If he said yes, then
			-- execute `a_action' with chosen file_name, otherwise do nothing.
		local
			l_file_name: FILE_NAME
			l_answered: BOOLEAN
		do
			if should_stop_on_prompt then
				io.put_string ("You cannot choose the name of the new configuration")
				io.put_new_line
				io.put_string ("because of the -stop/-batch option.")
				io.put_new_line
				set_has_error
			else
				from
				until
					l_answered
				loop
					io.put_string ("Save new configuration format as '")
					io.put_string (a_file_name)
					io.put_string ("'? [y|n] ")
					io.read_line
					if io.last_string.item (1).as_lower = 'y' then
						create l_file_name.make_from_string (a_dir_name)
						l_file_name.set_file_name (a_file_name)
						a_action.call ([l_file_name.string])
						l_answered := True
					elseif io.last_string.item (1).as_lower = 'n' then
						from
							io.put_new_line
						until
							l_answered
						loop
							io.put_string ("Enter name for configuration file: ")
							io.read_line
							if not io.last_string.is_empty then
								create l_file_name.make_from_string (a_dir_name)
								l_file_name.set_file_name (io.last_string)
								a_action.call ([l_file_name.string])
								l_answered := True
							end
						end
					end
				end
			end
		end

	ask_for_target_name (a_targets: HASH_TABLE [CONF_TARGET, STRING]) is
			-- Ask user to choose one target among `a_targets'.
		local
			l_answered: BOOLEAN
		do
			if a_targets.count = 1 then
				a_targets.start
				target_name := a_targets.key_for_iteration.twin
			else
				io.put_string ("This project has more than one target: ")
				io.put_new_line
				from
					a_targets.start
				until
					a_targets.after
				loop
					io.put_string (" - ")
					io.put_string (a_targets.key_for_iteration)
					io.put_new_line
					a_targets.forth
				end

				if should_stop_on_prompt then
					io.put_string ("You cannot choose a target because of the -stop/-batch option.")
					io.put_new_line
					set_has_error
				else
					from
						io.put_new_line
						io.put_string ("Select the target you want : ")
					until
						l_answered
					loop
						io.read_line
						if a_targets.has (io.last_string) then
							l_answered := True
							target_name := io.last_string.twin
						else
							io.put_string ("Invalid target, select the target you want: ")
						end
					end
				end
			end
		end

	ask_for_new_project_location (a_project_path: STRING) is
			-- Given a proposed location `a_project_path', ask user if he wants
			-- this location or another one.
		local
			l_answered: BOOLEAN
		do
			if should_stop_on_prompt then
				io.put_string ("You cannot choose the name of the project location")
				io.put_new_line
				io.put_string ("because of the -stop/-batch option.")
				io.put_new_line
				set_has_error
			else
				from
				until
					l_answered
				loop
					io.put_string ("Create new project in '")
					io.put_string (a_project_path)
					io.put_string ("'? [y|n] ")
					io.read_line
					if io.last_string.item (1).as_lower = 'y' then
						project_location := a_project_path.twin
						l_answered := True
					elseif io.last_string.item (1).as_lower = 'n' then
						from
							io.put_new_line
						until
							l_answered
						loop
							io.put_string ("Enter location for new project: ")
							io.read_line
							if not io.last_string.is_empty then
								project_location := io.last_string.twin
								l_answered := True
							end
						end
					end
				end
			end
		end

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
end
