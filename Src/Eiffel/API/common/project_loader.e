note
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
			{ANY} eiffel_project
		end

	PROJECT_CONTEXT
		rename
			project_location as compiler_project_location
		export
			{NONE} all
		end

	SYSTEM_CONSTANTS
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

	SHARED_FLAGS
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	SHARED_OVERRIDDEN_METADATA_CACHE_PATH
		export
			{NONE} all
		end

	CONF_ACCESS

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		end

	SHARED_COMPILER_PROFILE
		rename
			reset as reset_compiler_profile
		end

feature -- Loading

	open_project_file (a_file_name: STRING; a_target_name: STRING; a_project_path: STRING; from_scratch: BOOLEAN)
			-- Initialize current project using `a_file_name'.
		local
			l_ext: STRING_8
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
			project_location := a_project_path
			if a_file_name = Void or else a_file_name.is_empty then
					-- We are in the case where no file was specified, so we will try either to read
					-- Ace or Ace.ecf from the current working directory.
				create l_default_file_name.make_from_string (file_system.current_working_directory)
				l_default_file_name.set_file_name ("Ace")
				l_default_file_name.add_extension (config_extension)
				if is_file_readable (l_default_file_name.string) then
					config_file_name := l_default_file_name.string
				else
						-- Try to locate `Ace'.
					create l_default_file_name.make_from_string (file_system.current_working_directory)
					l_default_file_name.set_file_name ("Ace")
					if is_file_readable (l_default_file_name) then
							-- Special case where `Ace' can mean either the old or new format.
						create l_load_ace.make (l_factory, config_extension)
						if not has_library_conversion then
							l_load_ace.disable_library_conversions
						end
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
							-- Report error stating that we could not find `Ace.ecf'
							-- in the current working directory.
						create l_default_file_name.make_from_string (file_system.current_working_directory)
						l_default_file_name.set_file_name ("Ace")
						l_default_file_name.add_extension (config_extension)
						report_non_readable_configuration_file (l_default_file_name.string)
					end
				end
			elseif is_file_readable (a_file_name) then
					-- Extract the extension of the file and depending
					-- on its value try different loading approach.
				l_pos := a_file_name.last_index_of ('.', a_file_name.count)
				if l_pos > 0 and then l_pos < a_file_name.count then
					create l_ext.make_from_string (a_file_name.substring (l_pos + 1, a_file_name.count))
					if l_ext.is_equal (project_extension) then
						convert_epr (a_file_name)
					elseif l_ext.is_equal (ace_file_extension) then
						convert_ace (a_file_name)
					elseif l_ext.is_equal (config_extension) then
							-- Case where it is a `ecf' extension. or another one.
						config_file_name := a_file_name.twin
					else
							-- Unknown extension, let's try as an ecf and if not successful as ace.
						config_file_name := a_file_name.twin
						create l_load_config.make (l_factory)
						l_load_config.retrieve_configuration (config_file_name)
						if l_load_config.is_error and l_load_config.is_invalid_xml then
								-- Could not load the file, but it was not XML. Try to convert it
								-- from lace.
							convert_ace (config_file_name)
							l_load_config := Void
						end
					end
				else
						-- Case where it is no extension.
					config_file_name := a_file_name.twin
					create l_load_config.make (l_factory)
					l_load_config.retrieve_configuration (config_file_name)
					if l_load_config.is_error and l_load_config.is_invalid_xml then
							-- Could not load the file, but it was not XML. Try to convert it
							-- from lace.
						convert_ace (config_file_name)
						l_load_config := Void
					end
				end
			else
				report_non_readable_configuration_file (a_file_name)
			end
			if not has_error then
					-- Initializes the `workbench' since we are creating/opening a project.
				workbench.make

					-- If `l_load_config' is not Void, it is possible that it was the result
					-- of one of the above calls when trying to guess type of config file,
					-- thus no need to read the config file a second time.
				if l_load_config = Void then
						-- We try to load it as a normal config file.
					create l_load_config.make (l_factory)
					l_load_config.retrieve_configuration (config_file_name)
				end
				if l_load_config.is_error then
					report_cannot_read_config_file (config_file_name, l_load_config.last_error)
				else
						-- Now we have to find `a_target_name' in this configuration file
						-- if one is specified.
					find_target_name (a_target_name, l_load_config.last_system)
					if not has_error then
						if not is_project_creation_or_opening_not_requested then
							lace.set_conf_system (l_load_config.last_system)
							lace.set_target_name (target_name)
							compiler_project_location.set_target (target_name)
							lace.set_file_name (config_file_name)

								-- Try to retrieve project if already compiled.
							retrieve_or_create_project (a_project_path)
							if not has_error then
									-- check if precompiles are ok, otherwise (re)create them
								if is_recompile_from_scrach then
									eiffel_layout.set_precompile (lace.target.setting_msil_generation)
								end
								lace.check_precompile
								if lace.is_precompile_invalid then
-- print error message									
								elseif lace.is_precompilation_needed then
									ask_compile_precompile
									if is_user_wants_precompile then
										compile_precompile (lace.precompile)
										if is_precompilation_error then
											report_precompilation_error
										end
									end
								end
								if is_recompile_from_scrach and then is_compilation_requested then
									compile_project
								end
							end
						else
							is_project_ok := True
						end
					end
				end
			end
		end

	convert_project (a_file_name: STRING)
			-- Try to convert `a_filename' from 5.6 format to current without compilation.
			-- Converted file is stored in `converted_file_name'.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		local
			l_pos: INTEGER
			l_ext: STRING
			l_convertion_done: BOOLEAN
		do
			if is_file_readable (a_file_name) then
				l_pos := a_file_name.last_index_of ('.', a_file_name.count)
				if l_pos > 0 and then l_pos < a_file_name.count then
					l_ext := a_file_name.substring (l_pos + 1, a_file_name.count)
					if l_ext.is_equal (project_extension) then
						convert_epr (a_file_name)
						l_convertion_done := True
					end
				end
				if not l_convertion_done then
						-- Try to read an Ace file.
					convert_ace (a_file_name)
				end
			else
				report_cannot_convert_project (a_file_name)
			end
			if not has_error then
				converted_file_name := config_file_name.twin
			end
		end

	open_single_file_compilation_project (a_class_filename: STRING; a_libraries: LIST [STRING]; a_project_path: STRING; from_scratch: BOOLEAN)
			-- Open project for a single file compilation.
			--
			-- `a_class_filename': Filename of Eiffel class which acts as root
			-- `a_libraries': List of libraries which should be included
			-- `a_project_path': Path of project
			-- `from_scratch': Indicates if a clean is requested before compilation
		require
			a_libraries_not_void: a_libraries /= Void
			a_class_filename_not_void: a_class_filename /= Void
		local
			l_directory, l_filename, l_target_name, l_config_file_name: STRING
			l_file: RAW_FILE
			l_factory: CONF_FACTORY
			l_system: CONF_SYSTEM
			l_target: CONF_TARGET
			l_load: CONF_LOAD
		do
				-- First split the class name into components. A possible classname is 'path/to/file/hello_world.e'
				-- This will be split into:
				--   l_directory: 'path/to/file'
				--   l_filename: 'hello_world.e'
				--   l_target_name: 'hello_world'
			l_directory := file_system.dirname (a_class_filename)
			l_filename := file_system.basename (a_class_filename)
			l_target_name := l_filename.twin
			l_target_name.remove_tail (2)
			l_config_file_name := file_system.pathname (l_directory, l_target_name + "." + config_extension)

			create l_factory
				-- Only create ecf if it does not exist yet
			create l_file.make (l_config_file_name)
			if l_file.exists then
					-- ecf exists, load it
				create l_load.make (l_factory)
				l_load.retrieve_configuration (l_config_file_name)
				if l_load.is_error then
						-- ecf could not be loaded, an error will be triggered
						-- later when the config file will be loaded again by
						-- the `open_project_file' feature
				else
					l_system := l_load.last_system
						-- Check if target exists
					if l_system.targets.has (l_target_name) then
							-- Default target exists,
						l_target := l_system.targets.item (l_target_name)

							-- Add libraries
						a_libraries.do_all (agent add_library_to_target (?, l_target))

							-- Check console application flag
						if l_target.libraries.current_keys.there_exists (agent is_gui_library (?)) then
							l_target.update_setting ("console_application", "false")
						end
					else
							-- Target does not exist yet, create it
						add_single_file_compilation_target (l_system, l_target_name, l_target_name.as_upper, "make", a_libraries)
					end
						-- Save config file to disk
					l_system.store
				end
			else
					-- ecf does not exist, create it

					-- Configuration system
				l_system := l_factory.new_system_generate_uuid (l_target_name)
				l_system.set_file_name (l_config_file_name)

					-- Add the target for single file compilation
				add_single_file_compilation_target (l_system, l_target_name, l_target_name.as_upper, "make", a_libraries)

					-- Save config file to disk
				l_system.store
			end

				-- Now that an ecf exists, call the normal project loading with the new ecf.
			open_project_file (l_config_file_name, l_target_name, a_project_path, from_scratch)
		end

feature -- Access

	has_error: BOOLEAN
			-- Did an error occur while trying to load a project file?

	is_project_ok: BOOLEAN
			-- If `is_project_creation_or_opening_not_requested' is not set, `is_project_ok' states
			-- whether or not current is properly set for a compilation.

	is_recompile_from_scrach: BOOLEAN
			-- Is a recompilation from scratch requested?

	is_project_location_requested: BOOLEAN
			-- If `True', ask user for a project location, otherwise simply create
			-- project where configuration file is located.
		do
		end

	is_project_creation_or_opening_not_requested: BOOLEAN
			-- Will project be open or created when calling `open_project_file'.

	is_compilation_requested: BOOLEAN
			-- Is a compilation requested after loading the project?

	ignore_user_configuration_file: BOOLEAN
			-- Will user configuration file be used for current compilation?

	converted_file_name: STRING
			-- Name of new format config file chosen by user.

	has_library_conversion: BOOLEAN
			-- Should cluster be transformed into libraries whenever possible?

feature -- Settings

	set_is_compilation_requested (v: like is_compilation_requested)
			-- Set `is_compilation_requested' with `v'.
		do
			is_compilation_requested := v
		ensure
			is_compilation_requested_set: is_compilation_requested = v
		end

	enable_project_creation_or_opening_not_requested
			-- Ensure `is_project_creation_or_opening_not_requested'. This is of course
			-- only possible if a compilation was not requested.
		require
			not_is_compilation_requested: not is_compilation_requested
		do
			is_project_creation_or_opening_not_requested := True
		ensure
			is_project_creation_or_opening_not_requested_set: is_project_creation_or_opening_not_requested
		end

	set_ignore_user_configuration_file (v: like ignore_user_configuration_file)
			-- Set `ignore_user_configuration_file' with `v'.
		do
			ignore_user_configuration_file := v
		ensure
			ignore_user_configuration_file_set: ignore_user_configuration_file = v
		end

	set_has_library_conversion (v: like has_library_conversion)
			-- Set `has_library_conversion' with `v'.
		do
			has_library_conversion := v
		ensure
			has_library_conversion_set: has_library_conversion = v
		end

feature {NONE} -- Settings

	set_should_override_project (v: like should_override_project)
			-- Set `should_override_project' with `v'.
		do
			should_override_project := v
		ensure
			should_override_project_set: should_override_project = v
		end

	set_has_error
			-- Set `has_error' to True.
		do
			has_error := True
		ensure
			has_error_set: has_error
		end

	reset
			-- Reset variabes.
		do
			has_error := False
			is_compilation_requested := False
			is_project_ok := False
			config_file_name := Void
			target_name := Void
			project_location := Void
			should_override_project := False
		end

feature {NONE} -- Implementation: access

	config_file_name: STRING
			-- Name of new format config file chosen by user.

	target_name: STRING
			-- Name of a target chose by user.

	project_location: STRING
			-- Location of project chosen by user.

	should_override_project: BOOLEAN
			-- If project was incompatible, did user want to override it
			-- and create a new one instead?

	is_deletion_cancelled: BOOLEAN
			-- Was last deletion operation cancelled?

feature -- Status report

	is_file_readable (a_file_name: STRING): BOOLEAN
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

	is_file_writable (a_file_name: STRING): BOOLEAN
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

	is_directory_readable (a_dir_name: STRING): BOOLEAN
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

	is_user_wants_precompile: BOOLEAN
			-- Does the user want to compile the needed precompile?

	is_precompilation_error: BOOLEAN
			-- Was there an error during the generation of a needed precompile?

	is_update_environment: BOOLEAN
			-- Should changed environment variables be used?

feature {NONE} -- Status report

	is_config_file_name_valid: BOOLEAN
			-- Is `config_file_name' valid? That is to say exist, and is readable?
		do
			Result := config_file_name /= Void and then not config_file_name.is_empty and then
				is_file_readable (config_file_name)
		end

feature {NONE} -- Settings

	convert_epr (a_file_name: STRING)
			-- Convert `a_file_name' which is supposely in the `epr' format to the
			-- new configuration format.
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

	convert_ace (a_file_name: STRING)
			-- Convert `a_file_name' which is supposely in the `ace' format to the
			-- new configuration format.
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
			create l_load.make (l_factory, config_extension)
			if not has_library_conversion then
				l_load.disable_library_conversions
			end
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

	store_converted  (a_conf_system: CONF_SYSTEM; a_file_name: STRING)
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

	retrieve_or_create_project (a_project_path: STRING)
			-- Retrieve or create project.
		local
			msg: STRING_32
		do
				--| Define temporary default directory structure for project
			lace.process_user_file (a_project_path, not ignore_user_configuration_file)

			compiler_project_location.set_location (lace.project_path)

				-- If `compiler_project_location.project_file' actually exists we will try to retrieve it.
				-- Otherwise, it means that we are trying to compile a new project.
			if compiler_project_location.project_file.exists and not is_recompile_from_scrach then
					-- Retrieve the project
				Eiffel_project.make (compiler_project_location)

				if not eiffel_project.error_occurred then
					check_used_environemnt
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
								msg := Warning_messages.w_project_corrupted (compiler_project_location.path)
								report_project_corrupted (msg)
							elseif Eiffel_project.retrieval_interrupted then
								msg := Warning_messages.w_project_interrupted (compiler_project_location.path)
								report_project_retrieval_interrupted (msg)
							end
						end

					elseif Eiffel_project.incomplete_project then
						msg := Warning_messages.w_project_directory_not_exist (compiler_project_location.project_file_name, compiler_project_location.path)
						report_project_incomplete (msg)

					elseif Eiffel_project.read_write_error then
						msg := Warning_messages.w_cannot_open_project
						report_cannot_open_project (msg)
					end
						-- Project was somehow incompatible, and user may have selected to
						-- override the existing project and recompile from scratch.
					if should_override_project then
						is_recompile_from_scrach := True
						create_project (lace.project_path, False)
						post_create_project
					end
				end
			else
					-- Project file did not exist.
				is_recompile_from_scrach := True
				create_project (lace.project_path, is_project_location_requested)
				post_create_project
			end
		end

	check_used_environemnt
			-- Check if the current environment values still have the same values as the ones stored in the project settings.
		local
			l_envs: HASH_TABLE [STRING, STRING]
			l_key, l_old_val, l_new_val: STRING
		do
			if
				eiffel_project.system_defined and then eiffel_project.initialized and then
				eiffel_system.workbench.is_already_compiled and then
				eiffel_system.workbench.last_reached_degree <= 5
			then
				from
					l_envs := eiffel_system.workbench.universe.target.environ_variables
					l_envs.start
				until
					l_envs.after
				loop
					l_key := l_envs.key_for_iteration
					l_old_val := l_envs.item_for_iteration
					l_new_val := eiffel_layout.get_environment (l_key)
					if {PLATFORM}.is_windows then
						l_old_val.to_lower
						if l_new_val /= Void then
							l_new_val.to_lower
						end
					end
					if
						not l_key.is_case_insensitive_equal (eiffel_layout.default_il_environment.ise_dotnet_framework_env) and then
						not l_key.is_case_insensitive_equal ({EIFFEL_ENVIRONMENT_CONSTANTS}.ise_precomp_env) and then
						not equal (l_new_val, l_old_val)
					then
						ask_environment_update (l_key, l_old_val, l_new_val)
						if is_update_environment then
							if l_new_val /= Void then
								l_envs.force (l_new_val, l_key)
							else
								l_envs.remove (l_key)
							end
							system.force_rebuild
						else
							eiffel_layout.set_environment (l_old_val, l_key)
						end
					end
					l_envs.forth
				end
			end
		end

	create_project (a_project_path: STRING; a_should_prompt_for_project_location: BOOLEAN)
			-- Try to create a project and ask for project's location if `a_should_prompt_for_project_location'.
		require
			a_project_path_not_void: a_project_path /= Void
			a_project_path_not_empty: not a_project_path.is_empty
		local
			retried: BOOLEAN
			l_dir: DIRECTORY
		do
			if not retried then
				if a_should_prompt_for_project_location then
					ask_for_new_project_location (a_project_path)
					if not has_error then
						lace.process_user_file (project_location, not ignore_user_configuration_file)
						compiler_project_location.set_location (lace.project_path)
					end
				else
					project_location := a_project_path
				end
				if not has_error then
					create l_dir.make (project_location)
					eiffel_project.make_new (l_dir, compiler_project_location, True, deletion_agent, cancel_agent)
					if is_deletion_cancelled then
						set_has_error
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

	post_create_project
			-- Action to be done just after creating a project.
		do
		end

	compile_project
			-- Compile newly created project.
		require
			not_has_error: not has_error
			is_compilation_requested: is_compilation_requested
			is_project_ready_for_compilation: not is_project_creation_or_opening_not_requested
		deferred
		end

	compile_precompile (a_precompile: CONF_PRECOMPILE)
			-- Generate the precompile `a_precompile'.
		require
			a_precompile_not_void: a_precompile /= Void
		local
			l_path: STRING
			l_target: CONF_TARGET
			l_args: ARRAYED_LIST [STRING]
			l_profile: STRING
		do
			l_target := a_precompile.target
			create l_args.make (10)
			l_profile := command_line_profile_option
			if not l_profile.is_empty then
				l_args.extend (l_profile)
			end
			l_args.extend ("-config")
			l_args.extend (a_precompile.location.evaluated_path)
			l_args.extend ("-precompile")
			l_args.extend ("-clean")
			l_args.extend ("-c_compile")
			l_args.extend ("-batch")
			if l_target.setting_msil_generation then
				l_args.extend ("-finalize")
				l_path := overridden_metadata_cache_path
				if l_path = Void then
					l_path := l_target.setting_metadata_cache_path
				end
				if l_path /= Void and then not l_path.is_empty then
						-- remove trailing \ as it makes problem with the escaping of arguments
					if l_path.item (l_path.count) = '\' then
						l_path.remove_tail (1)
					end
					l_args.extend ("-metadata_cache_path")
					l_args.extend (l_path)
				end
			end
			l_args.extend ("-project_path")
			if a_precompile.eifgens_location /= Void then
				l_path := a_precompile.eifgens_location.evaluated_path
				if l_path.item (l_path.count) = '\' then
					l_path.remove_tail (1)
				end
			else
					-- If no path is specified we default to the location of the ecf.
				l_path := a_precompile.location.evaluated_directory
			end
			l_args.extend (l_path)
			launch_precompile_process (l_args)
		end

	launch_precompile_process (a_arguments: LIST [STRING])
			-- Launch precompile process `a_command'.
		require
			a_arguments_ok: a_arguments /= Void
		deferred
		end

	find_target_name (a_proposed_target: STRING; a_system: CONF_SYSTEM)
			-- Given `a_proposed_target', try to find it in `a_targets'. If not found or if `a_proposed_target'
			-- is not valid, ask the user to choose a target among `a_targets'.
		require
			a_system_not_void: a_system /= Void
		local
			l_not_found: BOOLEAN
			l_list: DS_ARRAYED_LIST [STRING]
			l_targets: HASH_TABLE [CONF_TARGET, STRING]
			l_user_options_factory: USER_OPTIONS_FACTORY
			l_last_target: STRING
			l_last_target_matched: BOOLEAN
		do
			l_targets := a_system.compilable_targets
			if a_proposed_target /= Void then
				target_name := a_proposed_target.as_lower

				l_targets.search (target_name)
				if not l_targets.found then
					l_not_found := True
					target_name := Void
				end
			else
				l_not_found := True
			end
			if l_not_found then
					-- Try and find the previously used target.
				create l_user_options_factory
				l_user_options_factory.load (a_system.file_name)
				if
					l_user_options_factory.successful and then
					attached l_user_options_factory.last_options as l_options
				then
					l_last_target := l_options.target_name
				else
					l_last_target := ""
				end

					-- Order targets in alphabetical order after last selected target (if any)
				from
					create l_list.make_equal (l_targets.count)
					l_targets.start
				until
					l_targets.after
				loop
					if l_last_target ~ l_targets.key_for_iteration then
							-- We want the last target first in the list.
						l_last_target_matched := True
					else
						l_list.put_last (l_targets.key_for_iteration)
					end
					l_targets.forth
				end
				l_list.sort (create {DS_QUICK_SORTER [STRING]}.make (create {KL_COMPARABLE_COMPARATOR [STRING]}.make))
				if l_last_target_matched then
						-- Set the last used target as first in the list.
					l_list.put_first (l_last_target)
				end
				ask_for_target_name (a_proposed_target, l_list)
			end
		ensure
			target_name_set: not has_error implies target_name /= Void and then not target_name.is_empty
		end

feature {NONE} -- Error reporting

	report_non_readable_configuration_file (a_file_name: STRING)
			-- Report an error when `a_file_name' cannot be read.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		deferred
		ensure
			has_error_set: has_error
		end

	report_non_readable_ace_file_in_epr (a_epr_name, a_file_name: STRING)
			-- Report an error when ace file `a_file_name' cannot be accessed from epr file `a_epr_name'.
			-- Note that `a_file_name' can be Void if `a_epr_name' does not mention it.
		require
			a_epr_name_not_void: a_epr_name /= Void
			a_epr_name_not_empty: not a_epr_name.is_empty
		deferred
		ensure
			has_error_set: has_error
		end

	report_cannot_read_ace_file (a_file_name: STRING; a_conf_error: CONF_ERROR)
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

	report_cannot_read_config_file (a_file_name: STRING; a_conf_error: CONF_ERROR)
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

	report_cannot_save_converted_file (a_file_name: STRING)
			-- Report an error when result of a conversion from ace to new format cannot be stored
			-- in file `a_file_name'.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		deferred
		ensure
			has_error_set: has_error
		end

	report_cannot_convert_project (a_file_name: STRING)
			-- Report an error when result of a conversion from ace `a_file_name' to new format failed.
		require
			a_file_name_not_void: a_file_name /= Void
			a_file_name_not_empty: not a_file_name.is_empty
		deferred
		ensure
			has_error_set: has_error
		end

	report_cannot_create_project (a_dir_name: STRING)
			-- Report an error when we cannot create project in `a_dir_name'.
		require
			a_dir_name_not_void: a_dir_name /= Void
			a_dir_name_not_empty: not a_dir_name.is_empty
		deferred
		ensure
			has_error_set: has_error
		end

	report_cannot_open_project (a_msg: STRING_GENERAL)
			-- Report an error when project cannot be read/write for some reasons
			-- and possibly propose user to upgrade
		require
			a_msg_not_void: a_msg /= Void
		deferred
		end

	report_incompatible_project (a_msg: STRING_GENERAL)
			-- Report an error when retrieving an incompatible project and possibly
			-- propose user to upgrade.
		require
			a_msg_not_void: a_msg /= Void
		deferred
		end

	report_project_corrupted (a_msg: STRING_GENERAL)
			-- Report an error when retrieving a project which is corrupted and possibly
			-- propose user to recompile from scratch.
		require
			a_msg_not_void: a_msg /= Void
		deferred
		end

	report_project_retrieval_interrupted (a_msg: STRING_GENERAL)
			-- Report an error when project retrieval was stopped.
		require
			a_msg_not_void: a_msg /= Void
		deferred
		end

	report_project_incomplete (a_msg: STRING_GENERAL)
			-- Report an error when project is incomplete and possibly propose
			-- user to recompile from scratch.
		require
			a_msg_not_void: a_msg /= Void
		deferred
		end

	report_project_loaded_successfully
			-- Report that project was loaded successfully.
		require
			is_config_file_name_valid: is_config_file_name_valid
			target_name_not_void: target_name /= Void
			target_name_not_empty: not target_name.is_empty
		deferred
		end

	report_precompilation_error
			-- Report that the precompilation of a precompile did not work.
		deferred
		end

feature {NONE} -- User interaction

	ask_for_config_name (a_dir_name, a_file_name: STRING; a_action: PROCEDURE [ANY, TUPLE [STRING]])
			-- Given `a_dir_name' and a proposed `a_file_name' name for the new format, ask the
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

	ask_for_target_name (a_target: STRING; a_targets: DS_ARRAYED_LIST [STRING])
			-- Ask user to choose one target among `a_targets'.
			-- If not Void, `a_target' is the one selected by user.
		require
			a_targets_not_void: a_targets /= Void
		deferred
		ensure
			target_name_set: not has_error implies target_name /= Void
		end

	ask_for_new_project_location (a_project_path: STRING)
			-- Given a proposed location `a_project_path', ask user if he wants
			-- this location or another one.
		require
			a_project_path_not_void: a_project_path /= Void
		deferred
		ensure
			project_location_set: not has_error implies project_location /= Void
		end

	ask_compile_precompile
			-- Should a needed precompile be automatically built?
		deferred
		end

	ask_environment_update (a_key, a_old_val, a_new_val: STRING)
			-- Should new environment values be accepted?
		require
			a_key_ok: a_key /= Void and then not a_key.is_empty and then not a_key.has ('%U')
			a_old_val_ok: a_old_val /= Void and then not a_old_val.has ('%U')
		deferred
		end

feature {NONE} -- Deletion

	deletion_agent: PROCEDURE [ANY, TUPLE [ARRAYED_LIST [STRING]]]
			-- Agent for displaying progress when deleting files of a project.

	cancel_agent: FUNCTION [ANY, TUPLE, BOOLEAN]
			-- Agent for cancelling deletion of a project.

feature {NONE} -- Constants

	warning_messages: WARNING_MESSAGES
			-- All warnings used in the interface
		once
			create Result
		end

feature {NONE} -- Implementation

	retrieved_ace_from_epr (a_file_name: STRING): STRING
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
			line, value: STRING
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

	add_single_file_compilation_target (a_system: CONF_SYSTEM; a_target_name, a_root_class_name, a_root_feature_name: STRING; a_libraries: LIST [STRING])
			-- Add a target to `a_system' consisting of given parameters.
			--
			-- `a_system': The configuration system which the target will be added to
			-- `a_target_name': Name of target to add to the system
			-- `a_root_class_name': Name of root class
			-- `a_root_feature_name': Name of root feature
			-- `a_libraries': List of libraries which will be added to the target
		require
			a_system_not_void: a_system /= Void
			a_target_name_not_void: a_target_name /= Void
			a_root_class_name_not_void: a_root_class_name /= Void
			a_root_feature_name_not_void: a_root_feature_name /= Void
		local
			l_factory: CONF_FACTORY
			l_target: CONF_TARGET
			l_root: CONF_ROOT
			l_file_location: CONF_FILE_LOCATION
			l_directory_location: CONF_DIRECTORY_LOCATION
			l_cluster: CONF_CLUSTER
			l_library: CONF_LIBRARY
			l_precompile: CONF_PRECOMPILE
		do
			create l_factory

				-- Configuration target
			l_target := l_factory.new_target (a_target_name, a_system)
			a_system.add_target (l_target)

				-- Root class and feature
			l_root := l_factory.new_root (Void, a_root_class_name, a_root_feature_name, False)
			l_target.set_root (l_root)

				-- Default to console application
			l_target.update_setting ("console_application", "true")

				-- Add libraries to target
			if a_libraries /= Void then
				a_libraries.do_all (agent add_library_to_target (?, l_target))
			end

				-- Check if there are any gui libraries and set flag accordingly
			if l_target.libraries.current_keys.there_exists (agent is_gui_library (?)) then
				l_target.update_setting ("console_application", "false")
			end

				-- Add 'current directory' as root cluster
			l_directory_location := l_factory.new_location_from_path ("./", l_target)
			l_cluster := l_factory.new_cluster (a_target_name, l_directory_location, l_target)
			l_target.add_cluster (l_cluster)

				-- Add base library
			l_file_location := l_factory.new_location_from_full_path ("$ISE_LIBRARY/library/base/base.ecf", l_target)
			l_library := l_factory.new_library ("base", l_file_location, l_target)
			l_target.add_library (l_library)

			if l_target.precompile = Void then
					-- No precompile is set, add base as precompile
				l_precompile := l_factory.new_precompile ("base_pre", "$ISE_PRECOMP/base.ecf", l_target)
				l_target.set_precompile (l_precompile)
			end
		ensure
			target_exists: a_system.targets.has (a_target_name)
		end

	add_library_to_target (a_library: STRING; a_target: CONF_TARGET)
			-- Add library `a_library' to `a_target'.
			--
			-- `a_library': Either the name of a library or the location of an ecf file
			-- `a_target': Configuration target where library is added
		require
			a_library_not_void: a_library /= Void
			a_target_not_void: a_target /= Void
		local
			l_factory: CONF_FACTORY
			l_library_name, l_extension, l_ecf_path: STRING
			l_file_location: CONF_FILE_LOCATION
			l_library: CONF_LIBRARY
		do
			create l_factory
				-- Get extension of library argument
			l_extension := a_library.twin
			l_extension.keep_tail (4)
				-- Check if extension denotes a configuration file
			if l_extension.is_equal ("." + config_extension) then
					-- The library is specified as full path to ecf file
				l_file_location := l_factory.new_location_from_full_path (a_library, a_target)
					-- Name of config file is taken as name of library
				l_library_name := file_system.basename (a_library)
				l_library_name.remove_tail (4)
			else
					-- The library is specified as name only
				l_library_name := a_library.twin
					-- Guess location
				l_ecf_path := "$ISE_LIBRARY/library/" + a_library + "/" + a_library + "." + config_extension
				l_file_location := l_factory.new_location_from_full_path (l_ecf_path, a_target)
					-- Todo: smarter guess, check if ECF exists in this location and try also $ISE_LIBRARY/framework/
					-- Todo: check if location exist and raise an error if it does not
					-- Todo: check if library can be used as precompile (e.g. Vision2)
			end
				-- Add library to ecf target
			l_library := l_factory.new_library (l_library_name, l_file_location, a_target)
			a_target.add_library (l_library)
		end

	is_gui_library (a_library: STRING): BOOLEAN
			-- Is `a_library' a GUI library?
			-- At the moment this only checks if 'Vision2' or 'WEL' is present.
		require
			a_library_not_void: a_library /= Void
		do
			Result := a_library.is_equal ("vision2") or a_library.is_equal ("wel")
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
