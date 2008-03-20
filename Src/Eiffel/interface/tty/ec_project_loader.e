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

	SHARED_BATCH_NAMES

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

	launch_precompile_process (a_arguments: LIST [STRING]) is
			-- Launch precompile process `a_command'.
		local
			l_prc_factory: PROCESS_FACTORY
			l_prc_launcher: PROCESS
		do
			create l_prc_factory
			l_prc_launcher := l_prc_factory.process_launcher (eiffel_layout.ec_command_name, a_arguments, Void)
			l_prc_launcher.set_separate_console (False)
			l_prc_launcher.launch
			if l_prc_launcher.launched then
				l_prc_launcher.wait_for_exit
				is_precompilation_error := l_prc_launcher.exit_code /= 0
			end
		end

feature {NONE} -- Error reporting

	report_non_readable_configuration_file (a_file_name: STRING) is
			-- Report an error when `a_file_name' cannot be read.
		do
			--|FIXME: `out' could cause information loss.
			-- encoding of the argument should have been localized.
			localized_print (warning_messages.w_cannot_read_file (a_file_name))
			io.put_new_line
			set_has_error
		end

	report_non_readable_ace_file_in_epr (a_epr_name, a_file_name: STRING) is
			-- Report an error when ace file `a_file_name' cannot be accessed from epr file `a_epr_name'.
			-- Note that `a_file_name' can be Void if `a_epr_name' does not mention it.
		do
			--|FIXME: `out' could cause information loss.
			-- encoding of the argument should have been localized.
			localized_print (warning_messages.w_cannot_read_ace_file_from_epr (a_epr_name, a_file_name))
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
			-- Report an error when result of a conversion from ace to new format cannot be stored
			-- in file `a_file_name'.
		do
			--|FIXME: `out' could cause information loss.
			-- encoding of the argument should have been localized.
			localized_print (warning_messages.w_cannot_save_file (a_file_name))
			io.put_new_line
			set_has_error
		end

	report_cannot_convert_project (a_file_name: STRING) is
			-- Report an error when result of a conversion from ace to new format cannot be stored
			-- in file `a_file_name'.
		do
			--|FIXME: `out' could cause information loss.
			-- encoding of the argument should have been localized.
			localized_print (warning_messages.w_cannot_convert_file (a_file_name))
			io.put_new_line
			set_has_error
		end

	report_cannot_create_project (a_dir_name: STRING) is
			-- Report an error when we cannot create project in `a_dir_name'.
		do
			--|FIXME: `out' could cause information loss.
			-- encoding of the argument should have been localized.
			localized_print (warning_messages.w_cannot_create_project_directory (a_dir_name))
			io.put_new_line
			set_has_error
		end

	report_cannot_open_project (a_msg: STRING_GENERAL) is
			-- Report an error when project cannot be read/write for some reasons
			-- and possibly propose user to upgrade
		do
			localized_print (a_msg)
			io.put_new_line
			set_has_error
		end

	report_incompatible_project (a_msg: STRING_GENERAL) is
			-- Report an error when retrieving an incompatible project and possibly
			-- propose user to upgrade.
		local
			l_answered: BOOLEAN
		do
			localized_print (Warning_messages.w_project_incompatible_version (config_file_name, version_number,
					Eiffel_project.incompatible_version_number))
			io.put_new_line
			if not should_stop_on_prompt then
				from
				until
					l_answered
				loop
					localized_print (ewb_names.want_to_update_new_compiler.as_string_32 + ewb_names.yes_or_no)
					io.read_line
					if not io.last_string.is_empty then
						if io.last_string.item (1).as_lower = 'y' then
							should_override_project := True
							l_answered := True
						elseif io.last_string.item (1).as_lower = 'n' then
							should_override_project := False
							set_has_error
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
			localized_print (a_msg)
			io.put_new_line
			set_has_error
		end

	report_project_retrieval_interrupted (a_msg: STRING) is
			-- Report an error when project retrieval was stopped.
		do
			localized_print (a_msg)
			io.put_new_line
			set_has_error
		end

	report_project_incomplete (a_msg: STRING) is
			-- Report an error when project is incomplete and possibly propose
			-- user to recompile from scratch.
		do
			localized_print (a_msg)
			io.put_new_line
			set_has_error
		end

	report_project_loaded_successfully is
			-- Report that project was loaded successfully.
		do
		end

	report_precompilation_error is
			-- Report that precompilation did not work.
		do
			--|FIXME: `out' could cause information loss.
			-- encoding of the argument should have been localized.
			localized_print (warning_messages.w_project_build_precompile_error)
			io.put_new_line
			set_has_error
		end

feature {NONE} -- User interaction

	ask_for_config_name (a_dir_name, a_file_name: STRING; a_action: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Given `a_dir_name' and a proposed `a_file_name' name for the new format, ask the
			-- user if he wants to create `a_file_name' or a different name. If he said yes, then
			-- execute `a_action' with chosen file_name, otherwise do nothing.
		local
			l_file_name: FILE_NAME
			l_answered: BOOLEAN
		do
			if should_stop_on_prompt then
				localized_print (ewb_names.batch_mode (a_file_name))
				io.put_new_line
				create l_file_name.make_from_string (a_dir_name)
				l_file_name.set_file_name (a_file_name)
				a_action.call ([l_file_name.string])
			else
				from
				until
					l_answered
				loop
					io.put_string (ewb_names.save_new_configuration_as (a_file_name).as_string_32 + ewb_names.yes_or_no)
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
							localized_print (ewb_names.enter_name_for_configuration_file)
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

	ask_for_target_name (a_target: STRING; a_targets: DS_ARRAYED_LIST [STRING]) is
			-- Ask user to choose one target among `a_targets'.
			-- If not Void, `a_target' is the one selected by user.
		local
			l_answered: BOOLEAN
			l_need_choice: BOOLEAN
		do
			l_need_choice := True
			if a_targets.count = 1 then
				a_targets.start
				if a_target = Void or else a_target.is_equal (a_targets.item_for_iteration) then
					target_name := a_targets.item_for_iteration.twin
					l_need_choice := False
				end
			end
			if l_need_choice then
				if a_targets.is_empty then
					localized_print (ewb_names.project_contains_no_compilable_target)
					io.put_new_line
					set_has_error
					l_need_choice := False
				end
			end
			if l_need_choice then
				if a_target = Void then
					localized_print (ewb_names.has_more_than_one_target)
				else
					localized_print (ewb_names.target_does_not_exist (a_target))
				end
				io.put_new_line
				from
					a_targets.start
				until
					a_targets.after
				loop
					io.put_string (" - ")
					io.put_string (a_targets.item_for_iteration)
					io.put_new_line
					a_targets.forth
				end

				if should_stop_on_prompt then
					localized_print (ewb_names.can_not_choose_a_target)
					io.put_new_line
					set_has_error
				else
					from
						io.put_new_line
						localized_print (ewb_names.select_the_target_you_want)
					until
						l_answered
					loop
						io.read_line
						if a_targets.has (io.last_string) then
							l_answered := True
							target_name := io.last_string.twin
						else
							localized_print (ewb_names.invalid_target)
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
				localized_print (ewb_names.cannot_choose_name_because_of)
				set_has_error
			else
				from
				until
					l_answered
				loop
					localized_print (ewb_names.create_new_project_in (a_project_path).as_string_32 + ewb_names.yes_or_no)
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
							localized_print (ewb_names.enter_location_for_new_project)
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

	ask_compile_precompile is
			-- Should a needed precompile be automatically built?
		local
			l_answered: BOOLEAN
		do
			if should_stop_on_prompt then
				localized_print (ewb_names.precompile_will_automtically_be_built)
				is_user_wants_precompile := True
			else
				from
				until
					l_answered
				loop
					localized_print (warning_messages.w_project_build_precompile.as_string_32 + ewb_names.yes_or_no)
					io.read_line
					if io.last_string.item (1).as_lower = 'y' then
						is_user_wants_precompile := True
						l_answered := True
					elseif io.last_string.item (1).as_lower = 'n' then
						l_answered := True
					end
				end
			end
		end

	ask_environment_update (a_key, a_old_val, a_new_val: STRING) is
			-- Should new environment values be accepted?
		local
			l_answered: BOOLEAN
		do
			if should_stop_on_prompt then
				localized_print (ewb_names.new_enviroment_value_for (a_key))
				is_update_environment := True
			else
				from
				until
					l_answered
				loop
					localized_print (warning_messages.w_environment_changed (a_key, a_old_val, a_new_val).as_string_32 + ewb_names.yes_or_no)
					io.read_line
					if io.last_string.is_empty then
					elseif io.last_string.item (1).as_lower = 'y' then
						is_update_environment := True
						l_answered := True
					elseif io.last_string.item (1).as_lower = 'n' then
						is_update_environment := False
						l_answered := True
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
