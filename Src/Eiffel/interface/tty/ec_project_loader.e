note
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

	set_should_stop_on_prompt (v: like should_stop_on_prompt)
			-- Set `should_stop_on_prompt' with `v'.
		do
			should_stop_on_prompt := v
		ensure
			should_stop_on_prompt_set: should_stop_on_prompt = v
		end

feature {NONE} -- Settings

	compile_project
			-- Compile newly created project.
		do
			-- Nothing to be done, as it is handled later in batch mode.
		end

	launch_precompile_process (a_arguments: LIST [READABLE_STRING_GENERAL])
			-- Launch precompile process `a_command'.
		local
			l_prc_factory: PROCESS_FACTORY
			l_prc_launcher: PROCESS
			l_cmd_line: STRING_32
			l_exec: EXECUTION_ENVIRONMENT
		do
--FIXME: should we add the following line?
--			is_precompilation_error := False
			if {PLATFORM}.is_thread_capable then
				create l_prc_factory
				l_prc_launcher := l_prc_factory.process_launcher (eiffel_layout.ec_command_name.name, a_arguments, Void)
				l_prc_launcher.set_separate_console (False)
				l_prc_launcher.launch
				if l_prc_launcher.launched then
					l_prc_launcher.wait_for_exit
					is_precompilation_error := l_prc_launcher.exit_code /= 0
				end
			else
				create l_cmd_line.make (512)
				l_cmd_line.append_string (eiffel_layout.ec_command_name.name)
				across a_arguments as l_args loop
					l_cmd_line.append_character (' ')
					if not l_args.item.is_empty and then l_args.item [1] /= '-' then
						l_cmd_line.append_character ('%"')
						l_cmd_line.append_string_general (l_args.item)
						l_cmd_line.append_character ('%"')
					else
						l_cmd_line.append_string_general (l_args.item)
					end
				end
				create l_exec
				l_exec.system (l_cmd_line)
			end
		end

	launch_iron_execution (a_iron_cmd: PATH; a_arguments: LIST [READABLE_STRING_GENERAL])
			-- Launch iron process `a_iron_cmd' with `a_arguments'.
		local
			l_prc_factory: PROCESS_FACTORY
			l_prc_launcher: PROCESS
			l_cmd_line: STRING_32
			l_exec: EXECUTION_ENVIRONMENT
		do
			if {PLATFORM}.is_thread_capable then
				create l_prc_factory
					-- Launch the iron command in `eiffel_layout.bin_path' (i.e $ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin)
					-- to have access to the required DLLs on Windows (libcurl,...).
				l_prc_launcher := l_prc_factory.process_launcher (a_iron_cmd.name, a_arguments, eiffel_layout.bin_path.name)
				l_prc_launcher.set_separate_console (False)
				l_prc_launcher.launch
				if l_prc_launcher.launched then
					l_prc_launcher.wait_for_exit
					is_iron_execution_error := l_prc_launcher.exit_code /= 0
				end
			else
				create l_cmd_line.make (512)
				l_cmd_line.append_string (a_iron_cmd.name)
				across a_arguments as l_args loop
					l_cmd_line.append_character (' ')
					if not l_args.item.is_empty and then l_args.item [1] /= '-' then
						l_cmd_line.append_character ('%"')
						l_cmd_line.append_string_general (l_args.item)
						l_cmd_line.append_character ('%"')
					else
						l_cmd_line.append_string_general (l_args.item)
					end
				end
				create l_exec
				l_exec.system (l_cmd_line)
			end
		end


feature {NONE} -- Error reporting

	report_non_readable_configuration_file (a_file_name: PATH)
			-- Report an error when `a_file_name' cannot be read.
		do
			localized_print (warning_messages.w_cannot_read_file (a_file_name.out))
			io.put_new_line
			set_has_error
		end

	report_cannot_read_ace_file (a_file_name: PATH; a_conf_error: CONF_ERROR)
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

	report_cannot_read_config_file (a_file_name: PATH; a_conf_error: CONF_ERROR)
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

	report_cannot_save_converted_file (a_file_name: PATH)
			-- Report an error when result of a conversion from ace to new format cannot be stored
			-- in file `a_file_name'.
		do
			localized_print (warning_messages.w_cannot_save_file (a_file_name.name))
			io.put_new_line
			set_has_error
		end

	report_cannot_create_project (a_dir_name: PATH)
			-- Report an error when we cannot create project in `a_dir_name'.
		do
			localized_print (warning_messages.w_cannot_create_project_directory (a_dir_name.name))
			io.put_new_line
			set_has_error
		end

	report_cannot_open_project (a_msg: READABLE_STRING_GENERAL)
			-- Report an error when project cannot be read/write for some reasons
			-- and possibly propose user to upgrade
		do
			localized_print (a_msg)
			io.put_new_line
			set_has_error
		end

	report_incompatible_project (a_msg: READABLE_STRING_GENERAL)
			-- Report an error when retrieving an incompatible project and possibly
			-- propose user to upgrade.
		local
			l_answered: BOOLEAN
		do
			localized_print (Warning_messages.w_project_incompatible_version (config_file_name.name, version_number,
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

	report_project_corrupted (a_msg: READABLE_STRING_GENERAL)
			-- Report an error when retrieving a project which is corrupted and possibly
			-- propose user to recompile from scratch.
		do
			localized_print (a_msg)
			io.put_new_line
			set_has_error
		end

	report_project_retrieval_interrupted (a_msg: READABLE_STRING_GENERAL)
			-- Report an error when project retrieval was stopped.
		do
			localized_print (a_msg)
			io.put_new_line
			set_has_error
		end

	report_project_incomplete (a_msg: READABLE_STRING_GENERAL)
			-- Report an error when project is incomplete and possibly propose
			-- user to recompile from scratch.
		do
			localized_print (a_msg)
			io.put_new_line
			set_has_error
		end

	report_project_loaded_successfully
			-- Report that project was loaded successfully.
		do
		end

	report_precompilation_error
			-- Report that precompilation did not work.
		do
			--|FIXME: `out' could cause information loss.
			-- encoding of the argument should have been localized.
			localized_print (warning_messages.w_project_build_precompile_error)
			io.put_new_line
			set_has_error
		end

	report_iron_packages_installation_error
			-- Report that previous iron execution did not work.
		do
			localized_print (warning_messages.w_iron_packages_installation_error)
			io.put_new_line
			set_has_error
		end

feature {NONE} -- User interaction

	ask_for_target_name (a_target: READABLE_STRING_GENERAL; a_targets: ARRAYED_LIST [READABLE_STRING_GENERAL])
			-- Ask user to choose one target among `a_targets'.
			-- If not Void, `a_target' is the one selected by user.
		local
			l_answer: READABLE_STRING_GENERAL
			l_answered: BOOLEAN
			l_need_choice: BOOLEAN
			i: INTEGER
		do
			l_need_choice := True
			if a_targets.count = 1 then
				a_targets.start
				if a_target = Void or else a_target.is_equal (a_targets.item_for_iteration) then
					create target_name.make_from_string_general (a_targets.item_for_iteration)
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
					i := 1
				until
					a_targets.after
				loop
					io.put_string (" [")
					io.put_integer (i)
					io.put_string ("] ")
					localized_print (a_targets.item_for_iteration)
					io.put_new_line
					i := i + 1
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
						l_answer := io.last_string
						if l_answer.is_integer then
							i := l_answer.to_integer
							if i = 0 then
								l_answered := True
								set_has_error
							elseif 1 <= i and i <= a_targets.count then
								l_answer := a_targets.i_th (i)
							end
						end
						if l_answered then
							--| probably user cancellation
						elseif a_targets.has (l_answer) then
							l_answered := True
							create target_name.make_from_string_general (l_answer)
						else
							localized_print (ewb_names.invalid_target)
						end
					end
				end
			end
		end

	ask_for_new_project_location (a_project_path: PATH)
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
					localized_print (ewb_names.create_new_project_in (a_project_path.name) + ewb_names.yes_or_no)
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
								create project_location.make_from_string (io.last_string)
								l_answered := True
							end
						end
					end
				end
			end
		end

	ask_compile_precompile (a_pre: CONF_PRECOMPILE)
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
					localized_print (warning_messages.w_project_build_precompile (a_pre.path).as_string_32 + ewb_names.yes_or_no)
					io.read_line
					if io.last_string.is_empty then
							-- Nothing was read.
					elseif io.last_string.item (1).as_lower = 'y' then
						is_user_wants_precompile := True
						l_answered := True
					elseif io.last_string.item (1).as_lower = 'n' then
						l_answered := True
					end
				end
			end
		end

	ask_environment_update (a_key, a_old_val: READABLE_STRING_GENERAL; a_new_val: detachable READABLE_STRING_GENERAL)
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
					localized_print (warning_messages.w_environment_changed (a_key, a_old_val, a_new_val) + ewb_names.yes_or_no)
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

	ask_iron_package_installation (a_packages: LIST [READABLE_STRING_32])
			-- <Precursor>
		local
			l_answered: BOOLEAN
		do
			iron_packages_user_wants_to_install := Void
			if should_stop_on_prompt then
				localized_print (ewb_names.iron_packages_will_automatically_be_installed (a_packages))
				iron_packages_user_wants_to_install := a_packages
			else
					--FIXME: provide a per package decision.
				from
				until
					l_answered
				loop
					localized_print (warning_messages.w_iron_packages_to_install (a_packages).as_string_32 + ewb_names.yes_or_no)
					io.read_line
					if io.last_string.is_empty then
							-- Nothing was read.
					elseif io.last_string.item (1).as_lower = 'y' then
						iron_packages_user_wants_to_install := a_packages
						l_answered := True
					elseif io.last_string.item (1).as_lower = 'n' then
						l_answered := True
					end
				end
			end
		end

note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
