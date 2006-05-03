indexing
	description: "Handler loading of projects. It also takes care of converting old Project format (.ace and .epr) to new format."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROJECT_LOADER

inherit
	ANY

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

feature -- Loading

	open_project_file (a_file_name: STRING; a_target_name: STRING; a_project_path: STRING; from_scratch: BOOLEAN) is
			-- Initialize current project using `a_file_name'.
		local
			l_ext: STRING
			l_pos: INTEGER
			l_default_file_name: FILE_NAME
			l_load_ace: CONF_LOAD_LACE
			l_load_config: CONF_LOAD
			l_dir_name: STRING
			l_factory: CONF_COMP_FACTORY
		do
			create l_factory
			reset
			is_recompile_from_scrach := from_scratch
			if a_file_name = Void or else a_file_name.is_empty then
					-- We are in the case where no file was specified, so we will try either to read
					-- Ace or Ace.acex from the current working directory.
				create l_default_file_name.make_from_string (file_system.current_working_directory)
				l_default_file_name.set_file_name ("Ace.acex")
				if is_file_readable (l_default_file_name.string) then
					config_file_name := l_default_file_name.string
				else
						-- Try to locate `Ace'.
					create l_default_file_name.make_from_string (file_system.current_working_directory)
					l_default_file_name.set_file_name ("Ace")
					if is_file_readable (l_default_file_name) then
							-- Special case where `Ace' can mean either the old or new format.
						create l_load_ace.make (l_factory)
						l_load_ace.retrieve_configuration (l_default_file_name)
						if l_load_ace.is_error then
								-- Most likely it is not an Ace file, so it must be in the new format.
							config_file_name := l_default_file_name.string
						else
								-- Convert Ace file into new format.
							l_dir_name := file_system.dirname (l_default_file_name)
							ask_for_config_name (l_dir_name,
								l_load_ace.last_system.name + "." + config_extension,
								agent store_converted ((l_load_ace.last_system), ?))
						end
					else
							-- Report error stating that we could not find `Ace.acex'
							-- in the current working directory.
						create l_default_file_name.make_from_string (file_system.current_working_directory)
						l_default_file_name.set_file_name ("Ace.acex")
						report_non_readable_configuration_file (l_default_file_name.string)
					end
				end
			elseif is_file_readable (a_file_name) then
					-- Extract the extension of the file and depending
					-- on its value try different loading approach.
				l_pos := a_file_name.last_index_of ('.', a_file_name.count)
				if l_pos > 0 and then l_pos < a_file_name.count then
					l_ext := a_file_name.substring (l_pos + 1, a_file_name.count)
					if l_ext.is_equal (project_extension) then
						convert_epr (a_file_name)
					elseif l_ext.is_equal (ace_file_extension) then
						convert_ace (a_file_name)
					else
							-- Case where it is a `acex' extension or another one.
						config_file_name := a_file_name.twin
					end
				else
						-- Case where it is no extension.
					config_file_name := a_file_name.twin
				end
			else
				report_non_readable_configuration_file (a_file_name)
			end
			if not has_error then
					-- Initializes the `workbench' since we are creating/opening a project.
				workbench.make

					-- We try to load it as a normal config file.
				create l_load_config.make (l_factory)
				l_load_config.retrieve_configuration (config_file_name)
				if l_load_config.is_error then
					report_cannot_read_config_file (config_file_name, l_load_config.last_error)
				else
						-- Now we have to find `a_target_name' in this configuration file
						-- if one is specified.
					find_target_name (a_target_name, l_load_config.last_system.compilable_targets)
					if not has_error then
						lace.set_conf_system (l_load_config.last_system)
						lace.set_target_name (target_name)
						internal_project_target_name.set_name (target_name)
						lace.set_file_name (config_file_name)

							-- Try to retrieve project if already compiled.
						retrieve_or_create_project (a_project_path)

						if not has_error and then is_compilation_requested then
							compile_project
						end
					end
				end
			end
		end

feature -- Access

	has_error: BOOLEAN
			-- Did an error occur while trying to load a project file?

	is_new_project: BOOLEAN
			-- Did the loading of the project resulted in creating a new project?

	is_recompile_from_scrach: BOOLEAN
			-- Is a recompilation from scratch requested?

	is_project_location_requested: BOOLEAN is
			-- If `True', ask user for a project location, otherwise simply create
			-- project where configuration file is located.
		do
		end

	is_compilation_requested: BOOLEAN
			-- Is a compilation requested after loading the project?

feature -- Settings

	set_is_compilation_requested (v: like is_compilation_requested) is
			-- Set `is_compilation_requested' with `v'.
		do
			is_compilation_requested := v
		ensure
			is_compilation_requested_set: is_compilation_requested = v
		end

feature {NONE} -- Settings

	set_should_override_project (v: like should_override_project) is
			-- Set `should_override_project' with `v'.
		do
			should_override_project := v
		ensure
			should_override_project_set: should_override_project = v
		end

	set_has_error is
			-- Set `has_error' to True.
		do
			has_error := True
		ensure
			has_error_set: has_error
		end

	reset is
			-- Reset variabes.
		do
			has_error := False
			is_new_project := False
			is_compilation_requested := False
			config_file_name := Void
			target_name := Void
			project_location := Void
			project_dir := Void
			project_file := Void
			should_override_project := False
		end

feature {NONE} -- Implementation: access

	config_file_name: STRING
			-- Name of new format config file chosen by user.

	target_name: STRING
			-- Name of a target chose by user.

	project_location: STRING
			-- Location of project chosen by user.

	project_dir: PROJECT_DIRECTORY
			-- Location of the project directory.

	project_file: PROJECT_EIFFEL_FILE
			-- Location of the file where all the information
			-- about the current project are saved.

	should_override_project: BOOLEAN
			-- If project was incompatible, did user want to override it
			-- and create a new one instead?

	is_deletion_cancelled: BOOLEAN
			-- Was last deletion operation cancelled?

feature {NONE} -- Status report

	is_file_readable (a_file_name: STRING): BOOLEAN is
			-- Does file of path `a_file_name' exist and is readable?
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			Result := l_file.exists and then l_file.is_readable
		end

	is_file_writable (a_file_name: STRING): BOOLEAN is
			-- Does file of path `a_file_name' exist and can be written/created?
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			Result := (l_file.exists and then l_file.is_writable) or else l_file.is_creatable
		end

	is_directory_readable (a_dir_name: STRING): BOOLEAN is
			-- Does directory of path `a_dir_name' exist and is readable?
		require
			a_dir_name_not_void: a_dir_name /= Void
			a_dir_name_not_empty: not a_dir_name.is_empty
		local
			l_dir: DIRECTORY
		do
			create l_dir.make (a_dir_name)
			Result := l_dir.exists and then l_dir.is_readable
		end

	is_config_file_name_valid: BOOLEAN is
			-- Is `config_file_name' valid? That is to say exist, and is readable?
		do
			Result := config_file_name /= Void and then not config_file_name.is_empty and then
				is_file_readable (config_file_name)
		end

feature {NONE} -- Settings

	convert_epr (a_file_name: STRING) is
			-- Convert `a_file_name' which is supposely in the `epr' format to the
			-- new `acex' format.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			a_file_name_readable: is_file_readable (a_file_name)
		local
			l_ace: STRING
		do
			l_ace := retrieved_ace_from_epr (a_file_name)
			if l_ace = Void or else l_ace.is_empty or else not is_file_readable (l_ace) then
				report_non_readable_ace_file_in_epr (a_file_name, l_ace)
			else
				convert_ace (l_ace)
			end
		ensure
			config_file_name_set: not has_error implies is_config_file_name_valid
		end

	convert_ace (a_file_name: STRING) is
			-- Convert `a_file_name' which is supposely in the `ace' format to the
			-- new `acex' format.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			a_file_name_readable: is_file_readable (a_file_name)
		local
			l_load: CONF_LOAD_LACE
			l_dir_name: STRING
			l_factory: CONF_COMP_FACTORY
		do
				-- load config from ace
			create l_factory
			create l_load.make (l_factory)
			l_load.retrieve_configuration (a_file_name)
			if l_load.is_error then
				report_cannot_read_ace_file (a_file_name, l_load.last_error)
			else
					-- Ask user for a new name for the converted config file.
					-- If user does not specify one, then the processing will stop right there.
				l_dir_name := file_system.dirname (a_file_name)
				ask_for_config_name (l_dir_name,  l_load.last_system.name + "." + config_extension,
					agent store_converted ( l_load.last_system, ?))
			end
		ensure
			config_file_name_set: not has_error implies is_config_file_name_valid
		end

	store_converted  (a_conf_system: CONF_SYSTEM; a_file_name: STRING) is
			-- Store updated configuration into `file_name'.
		require
			a_conf_system_not_void: a_conf_system /= Void
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		local
			l_print: CONF_PRINT_VISITOR
			l_file: PLAIN_TEXT_FILE
		do
			create l_print.make
			a_conf_system.process (l_print)
			check
				no_error: not l_print.is_error
			end
			if is_file_writable (a_file_name) then
				create l_file.make_open_write (a_file_name)
				l_file.put_string (l_print.text)
				l_file.close
				config_file_name := a_file_name
			else
				report_cannot_save_converted_file (a_file_name)
			end
		ensure
			config_file_name_set: not has_error implies config_file_name = a_file_name
			config_file_name_valid: not has_error implies is_config_file_name_valid
		end

	retrieve_or_create_project (a_project_path: STRING) is
			-- Retrieve or create project.
		local
			msg: STRING
			l_project_file_name: FILE_NAME
		do
				--| Define temporary default directory structure for project
			lace.process_user_file (a_project_path)

			Project_directory_name.wipe_out
			Project_directory_name.set_directory (lace.project_path)
			create l_project_file_name.make_from_string (temp_target_path)
			l_project_file_name.set_file_name (project_file_name)
			create project_file.make (l_project_file_name)
			create project_dir.make (temp_eiffel_gen_path, project_file)

				-- If `project_file' actually exists we will try to retrieve it.
				-- Otherwise, it means that we are trying to compile a new project.
			if project_file.exists and not is_recompile_from_scrach then
					-- Retrieve the project
				Eiffel_project.make (project_dir)

				if not eiffel_project.error_occurred then
						-- Nothing to be done here
					report_project_loaded_successfully
				else
					if Eiffel_project.retrieval_error then
						if Eiffel_project.manager.is_created then
							Eiffel_project.manager.on_project_close
						end

						if Eiffel_project.is_incompatible then
							msg := warning_messages.w_project_incompatible_version (
								config_file_name, version_number, Eiffel_project.incompatible_version_number)
							report_incompatible_project (msg)
						else
							if Eiffel_project.is_corrupted then
								msg := Warning_messages.w_project_corrupted (project_dir.name)
								report_project_corrupted (msg)
							elseif Eiffel_project.retrieval_interrupted then
								msg := Warning_messages.w_project_interrupted (project_dir.name)
								report_project_retrieval_interrupted (msg)
							end
						end

					elseif Eiffel_project.incomplete_project then
						msg := Warning_messages.w_project_directory_not_exist (project_file.name, project_dir.name)
						report_project_incomplete (msg)

					elseif Eiffel_project.read_write_error then
						msg := Warning_messages.w_cannot_open_project
						report_cannot_open_project (msg)
					end
						-- Project was somehow incompatible, and user may have selected to
						-- override the existing project and recompile from scratch.
					if should_override_project then
						create_project (lace.project_path, False)
						post_create_project
					end
				end
			else
					-- Project file did not exist.
				create_project (lace.project_path, is_project_location_requested)
				post_create_project
			end
		end

	create_project (a_project_path: STRING; a_should_prompt_for_project_location: BOOLEAN) is
			-- Try to create a project and ask for project's location if `a_should_prompt_for_project_location'.
		require
			a_project_path_not_void: a_project_path /= Void
			a_project_path_not_empty: not a_project_path.is_empty
		local
			retried: BOOLEAN
			l_project_file_name: FILE_NAME
			l_dir: DIRECTORY
		do
			if not retried then
				if a_should_prompt_for_project_location then
					ask_for_new_project_location (a_project_path)
					if not has_error then
						lace.process_user_file (project_location)
						Project_directory_name.wipe_out
						Project_directory_name.set_directory (lace.project_path)
						create l_project_file_name.make_from_string (temp_target_path)
						l_project_file_name.set_file_name (project_file_name)
						create project_file.make (l_project_file_name)
						create project_dir.make (temp_eiffel_gen_path, project_file)
					end
				else
					project_location := a_project_path
				end
				if not has_error then
					create l_dir.make (project_location)
					eiffel_project.make_new (l_dir, project_dir, True, deletion_agent, cancel_agent)
					if is_deletion_cancelled then
						set_has_error
					else
						is_new_project := True
					end
				end
			else
				if project_location /= Void then
					report_cannot_create_project (project_location)
				else
					report_cannot_create_project (a_project_path)
				end
			end
		rescue
			retried := True
			retry
		end

	post_create_project is
			-- Action to be done just after creating a project.
		do
		end

	compile_project is
			-- Compile newly created project.
		require
			is_new_project: is_new_project
			is_compilation_requested: is_compilation_requested
		deferred
		end

	find_target_name (a_proposed_target: STRING; a_targets: HASH_TABLE [CONF_TARGET, STRING]) is
			-- Given `a_proposed_target', try to find it in `a_targets'. If not found or if `a_proposed_target'
			-- is not valid, ask the user to choose a target among `a_targets'.
		require
			a_targets_not_void: a_targets /= Void
		local
			l_not_found: BOOLEAN
		do
			if a_proposed_target /= Void then
				a_targets.search (a_proposed_target)
				if a_targets.found then
					target_name := a_proposed_target.twin
				else
					l_not_found := True
				end
			else
				l_not_found := True
			end
			if l_not_found then
				ask_for_target_name (a_targets)
			end
		ensure
			target_name_set: not has_error implies target_name /= Void and then not target_name.is_empty
		end

feature {NONE} -- Error reporting

	report_non_readable_configuration_file (a_file_name: STRING) is
			-- Report an error when `a_file_name' cannot be read.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		deferred
		ensure
			has_error_set: has_error
		end

	report_non_readable_ace_file_in_epr (a_epr_name, a_file_name: STRING) is
			-- Report an error when ace file `a_file_name' cannot be accessed from epr file `a_epr_name'.
			-- Note that `a_file_name' can be Void if `a_epr_name' does not mention it.
		require
			a_epr_name_not_void: a_epr_name /= Void
			a_epr_name_not_empty: not a_epr_name.is_empty
		deferred
		ensure
			has_error_set: has_error
		end

	report_cannot_read_ace_file (a_file_name: STRING; a_conf_error: CONF_ERROR) is
			-- Report an error when ace  file `a_file_name' can be read, but its content cannot
			-- be properly interpreted. The details of the error are stored in `a_conf_error'.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			a_conf_error_not_void: a_conf_error /= Void
		deferred
		ensure
			has_error_set: has_error
		end

	report_cannot_read_config_file (a_file_name: STRING; a_conf_error: CONF_ERROR) is
			-- Report an error when a config file `a_file_name' can be read, but its content cannot
			-- be properly interpreted. The details of the error are stored in `a_conf_error'.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			a_conf_error_not_void: a_conf_error /= Void
		deferred
		ensure
			has_error_set: has_error
		end

	report_cannot_save_converted_file (a_file_name: STRING) is
			-- Report an error when result of a conversion from ace to acex cannot be stored
			-- in file `a_file_name'.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		deferred
		ensure
			has_error_set: has_error
		end

	report_cannot_create_project (a_dir_name: STRING) is
			-- Report an error when we cannot create project in `a_dir_name'.
		require
			a_dir_name_not_void: a_dir_name /= Void
			a_dir_name_not_empty: not a_dir_name.is_empty
		deferred
		ensure
			has_error_set: has_error
		end

	report_cannot_open_project (a_msg: STRING) is
			-- Report an error when project cannot be read/write for some reasons
			-- and possibly propose user to upgrade
		require
			a_msg_not_void: a_msg /= Void
		deferred
		end

	report_incompatible_project (a_msg: STRING) is
			-- Report an error when retrieving an incompatible project and possibly
			-- propose user to upgrade.
		require
			a_msg_not_void: a_msg /= Void
		deferred
		end

	report_project_corrupted (a_msg: STRING) is
			-- Report an error when retrieving a project which is corrupted and possibly
			-- propose user to recompile from scratch.
		require
			a_msg_not_void: a_msg /= Void
		deferred
		end

	report_project_retrieval_interrupted (a_msg: STRING) is
			-- Report an error when project retrieval was stopped.
		require
			a_msg_not_void: a_msg /= Void
		deferred
		end

	report_project_incomplete (a_msg: STRING) is
			-- Report an error when project is incomplete and possibly propose
			-- user to recompile from scratch.
		require
			a_msg_not_void: a_msg /= Void
		deferred
		end

	report_project_loaded_successfully is
			-- Report that project was loaded successfully.
		require
			is_config_file_name_valid: is_config_file_name_valid
			target_name_not_void: target_name /= Void
			target_name_not_empty: not target_name.is_empty
		deferred
		end

feature {NONE} -- User interaction

	ask_for_config_name (a_dir_name, a_file_name: STRING; a_action: PROCEDURE [ANY, TUPLE [STRING]]) is
			-- Given `a_dir_name' and a proposed `a_file_name' name for the new acex format, ask the
			-- user if he wants to create `a_file_name' or a different name. If he said yes, then
			-- execute `a_action' with chosen file_name, otherwise do nothing.
		require
			a_dir_name_not_void: a_dir_name /= Void
			a_dir_name_not_empty: not a_dir_name.is_empty
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
			a_action_not_void: a_action /= Void
		deferred
		end

	ask_for_target_name (a_targets: HASH_TABLE [CONF_TARGET, STRING]) is
			-- Ask user to choose one target among `a_targets'.
		require
			a_targets_not_void: a_targets /= Void
		deferred
		end

	ask_for_new_project_location (a_project_path: STRING) is
			-- Given a proposed location `a_project_path', ask user if he wants
			-- this location or another one.
		require
			a_project_path_not_void: a_project_path /= Void
		deferred
		ensure
			project_location_set: not has_error implies project_location /= Void
		end

feature {NONE} -- Deletion

	deletion_agent: PROCEDURE [ANY, TUPLE [ARRAYED_LIST [STRING]]]
			-- Agent for displaying progress when deleting files of a project.

	cancel_agent: FUNCTION [ANY, TUPLE, BOOLEAN]
			-- Agent for cancelling deletion of a project.

feature {NONE} -- Constants

	warning_messages: WARNING_MESSAGES is
			-- All warnings used in the interface
		once
			create Result
		end

feature {NONE} -- Implementation

	retrieved_ace_from_epr (a_file_name: STRING): STRING is
			-- Parse the project header file to get the following information:
			-- version_number_tag
			-- precompilation_id
			-- ace file path (in version 5.0.18 and above)
			--| The format is the followin:
			--| -- system name is xxx
			--| version_number_tag
			--| precompilation_id
			--| ace file path
			--| -- end of info
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		local
			line, string_tag, value: STRING
			index, line_number: INTEGER
			retried: BOOLEAN
			l_storage: RAW_FILE
		do
			if not retried then
				create l_storage.make (a_file_name)
				if l_storage.exists then
					l_storage.open_read
					from
						l_storage.read_line
						l_storage.read_line
						line := l_storage.last_string.twin
					until
						line_number > 4 or else line.is_equal (info_flag_end)
					loop
							-- Read the Ace file path if any specified.
						index := line.index_of (':', 1)
						if ace_file_path_tag.is_equal (line.substring (1, index - 1)) then
							value := line.substring (index + 1, line.count)
							Result := value.twin
						end

						line_number := line_number + 1
						l_storage.read_line
						line := l_storage.last_string.twin
					end
				end
			else
				if l_storage /= Void and then not l_storage.is_closed then
					l_storage.close
				end
			end
		rescue
			retried := True
			retry
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
