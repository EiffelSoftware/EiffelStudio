note

	description:
		"Environment for bitmaps, help, binaries, scripts...."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EIFFEL_ENV

inherit
	ANY

	SHARED_COMPILER_PROFILE

	EIFFEL_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	application_name: STRING_8
			-- Name of the application.
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
		end

	product_name: STRING_8
			-- Name of the product.
		once
			Result := "Eiffel"
		ensure
			not_result_is_empty: not Result.is_empty
		end

	unix_product_version_name: STRING_8
			-- Versioned name of the product.
		require
			is_unix_layout: is_unix_layout
		once
			create Result.make_from_string ("eiffelstudio" + release_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
			result_is_lower_case: Result.as_lower ~ Result
		end

	product_version_name: STRING_8
			-- Versioned name of the product.
			-- I.e. Eiffel7x
		once
			create Result.make_from_string (product_name)
			Result.append_integer ({EIFFEL_CONSTANTS}.major_version)
			Result.append_integer ({EIFFEL_CONSTANTS}.minor_version)
			if is_unix_layout then
				Result.to_lower
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	environment_info: STRING_8
			-- Information about the environment.
		require
			is_valid_environment: is_valid_environment
		do
			create Result.make (100)
			if is_unix_layout then
				Result.append ("Base Path = " + unix_layout_base_path)
			else
				Result.append ("$ISE_EIFFEL = " + install_path + "%N")
				Result.append ("$ISE_LIBRARY = " + eiffel_library + "%N")
				Result.append ("$ISE_PLATFORM = " + eiffel_platform)
				if {PLATFORM}.is_windows then
					Result.append ("%N$ISE_C_COMPILER = " + eiffel_c_compiler)
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Access

	executable_suffix: STRING_8
			-- Platform specific executable extension.
		once
			if {PLATFORM}.is_windows then
				Result := "exe"
			else
				create Result.make_empty
			end
		ensure
			executable_suffix_not_void: Result /= Void
			not_result_is_empty: {PLATFORM}.is_windows implies not Result.is_empty
		end

feature {NONE} -- Access

	required_environment_variables: ARRAYED_LIST [TUPLE [var: STRING_8; is_directory: BOOLEAN]]
			-- List of required environment variables.
		once
			create Result.make (4)
			if not is_unix_layout then
				Result.extend ([{EIFFEL_CONSTANTS}.ise_eiffel_env, True])
				Result.extend ([{EIFFEL_CONSTANTS}.ise_platform_env, False])
			end
			if {PLATFORM}.is_windows then
				Result.extend ([{EIFFEL_CONSTANTS}.ise_c_compiler_env, False])
			end
		end

	creatable_directories: ARRAYED_LIST [STRING_8]
			-- List of directories to be created at start up
		require
			is_valid_environment: is_valid_environment
		once
			if is_user_files_supported then
				create Result.make (4)
				Result.extend (user_files_path.string)
				Result.extend (hidden_files_path.string)
					Result.extend (projects_data_path.string)
			else
				create Result.make (0)
			end
		ensure
			result_contains: Result.for_all (agent (a_item: STRING_8): BOOLEAN do Result := not a_item.is_empty end)
		end

	release_suffix: STRING
			-- Suffix containing release version which is used for unix layout
		once
			if is_unix_layout then
				Result := "-" + {EIFFEL_CONSTANTS}.major_version.out + "." +
					{EIFFEL_CONSTANTS}.minor_version.out
			else
					-- No suffix in normal mode.
				Result := ""
			end
		end

feature -- Status update

	check_environment_variable
			-- Check if needed environment variables are set up.
		local
			l_product_names: PRODUCT_NAMES
			l_op_env: like operating_environment
			l_dir: DIRECTORY
			l_dir_name: DIRECTORY_NAME
			l_value: detachable STRING_8
			l_variables: like required_environment_variables
			l_variable: TUPLE [var: STRING_8; is_directory: BOOLEAN]
			l_is_valid: like is_valid_environment
		do
			initialize_from_arguments

			l_is_valid := True

			if {PLATFORM_CONSTANTS}.is_unix then
					-- On Unix platforms, if not ISE_EIFFEL is defined then it's probably the unix layout.
				l_value := get_environment ({EIFFEL_CONSTANTS}.ise_eiffel_env)
				is_unix_layout := (l_value = Void) or else l_value.is_empty
			end

				-- Check environment variables
			create l_product_names
			l_op_env := operating_environment
			l_variables := required_environment_variables
			from l_variables.start until l_variables.after loop
				l_variable := l_variables.item
				l_value := get_environment (l_variable.var)

				if
					l_value /= Void and then l_value.item (l_value.count) = l_op_env.directory_separator and then
					({PLATFORM}.is_windows or else not (l_value.is_equal ("/") or l_value.is_equal ("~/")))
				then
						-- Remove trailing directory separator
					l_value.prune_all_trailing (l_op_env.directory_separator)
				end

				if l_value = Void or else l_value.is_empty then
					io.error.put_string (l_product_names.workbench_name)
					io.error.put_string (": the environment variable " + l_variable.var + " has not been set!%N")
					l_is_valid := False
				elseif l_variable.is_directory and then not (create {DIRECTORY}.make (l_value)).exists then
					io.error.put_string (l_product_names.workbench_name)
					io.error.put_string (": the environment variable " + {EIFFEL_CONSTANTS}.ise_eiffel_env + " points to a non-existing directory.%N")
					l_is_valid := False
				else
						-- Set the environment variable, as it may have come from the Windows registry.
					set_environment (l_value, l_variable.var)
				end
				l_variables.forth
			end

			if not l_is_valid then
				on_check_environment_failure
			else
					-- The environment is valid
				is_valid_environment := True

					-- Set new ISE_EIFFEL variable. This is done to ensure that the workbench path is
					-- set correctly, or if in unix layout that ISE_EIFFEL is set
				if not is_unix_layout then
					set_environment (shared_path, {EIFFEL_CONSTANTS}.ise_eiffel_env)
				end

					-- Set Unix platform
				if is_unix_layout then
					l_value := get_environment ({EIFFEL_CONSTANTS}.ise_platform_env)
					if l_value = Void or else l_value.is_empty then
							-- Set platform for Unix
						set_environment (unix_layout_platform, {EIFFEL_CONSTANTS}.ise_platform_env)
					end
				end

				create l_dir.make (bin_path)
				if not l_dir.exists then
					io.error.put_string (l_product_names.workbench_name)
					io.error.put_string (": the path $" + {EIFFEL_CONSTANTS}.ise_eiffel_env + "/studio/spec/$" + {EIFFEL_CONSTANTS}.ise_platform_env + "/bin points to a non-existing directory!%N")
					on_check_environment_failure
				end
			end

				-- Make sure to define ISE_LIBRARY if not defined.
			l_value := get_environment ({EIFFEL_CONSTANTS}.ise_library_env)
			if l_value = Void or else l_value.is_empty then
				set_environment (lib_path, {EIFFEL_CONSTANTS}.ise_library_env)
			else
					-- To avoid having to edit the value of ISE_LIBRARY when compiling against
					-- a certain compiler profile, we modify the value of the ISE_LIBRARY environment
					-- variable.
				if is_compatible_mode and l_value.substring_index ("compatible", 1) = 0 then
					create l_dir_name.make_from_string (l_value)
					l_dir_name.extend ("compatible")
					set_environment (l_dir_name, {EIFFEL_CONSTANTS}.ise_library_env)
				end
			end

			if is_valid_environment then
				create_directories
				if is_user_files_supported then
					create l_dir.make (hidden_files_path)
					is_hidden_files_path_available := l_dir.exists
				else
						-- No place for saving hidden files.
					is_hidden_files_path_available := False
				end
			end
		ensure
			is_valid_environment: is_valid_environment
		end

feature -- Status report

	is_valid_environment: BOOLEAN
			-- Have the needed environment variables been set?

	is_valid_precompile_environment: BOOLEAN
			-- Has the precompile environment been set correctly?

	is_hidden_files_path_available: BOOLEAN
			-- Is there a valid home directory?

	is_unix_layout: BOOLEAN
			-- Is eiffelstudio installed in the unix layout?

	is_user_files_supported: BOOLEAN
			-- Determines if user files are supported on the platform.
		require
			is_valid_environment: is_valid_environment
		once
			Result := attached user_directory_name as l_home and then not l_home.is_empty
		end

	is_workbench: BOOLEAN
			-- Are we running the workbench version of the compiler?
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"EIF_IS_WORKBENCH"
		end

feature -- Status setting

	set_precompile (a_is_dotnet: BOOLEAN)
			-- Set up the ISE_PRECOMP environment variable, depending on `a_is_dotnet'.
		require
			is_valid_environment: is_valid_environment
		local
			l_precompilation_path, l_installation_precompilation_path: like precompilation_path
			l_dir: DIRECTORY
			l_source_file, l_target_file: detachable RAW_FILE
			l_path: FILE_NAME
			retried: BOOLEAN
			l_ecf_name: STRING
		do
			if not retried then
					-- Get the path for the precompiled libraries
				l_precompilation_path := precompilation_path (a_is_dotnet)

					-- Now we set the ISE_PRECOMP environment variable with that path.
					-- Note that if it was already set, the value stays the same.
				set_environment (l_precompilation_path, {EIFFEL_CONSTANTS}.ise_precomp_env)
				is_valid_precompile_environment := True

					-- Now if `l_precompilation_path' does not exist, we copy the content from
					-- the installation directory.
				create l_dir.make (l_precompilation_path)
				if not l_dir.exists then
						-- Directory does not exist
					safe_recursive_create_dir (l_precompilation_path)
					l_installation_precompilation_path := installation_precompilation_path (a_is_dotnet)
					create l_dir.make (l_installation_precompilation_path)
					if l_dir.exists and attached l_dir.linear_representation as l_files then
						from
							l_files.start
						until
							l_files.after
						loop
							l_ecf_name := l_files.item
							if
								l_ecf_name.count > 3 and then
								l_ecf_name.substring (l_ecf_name.count - 3,
									l_ecf_name.count).is_case_insensitive_equal (".ecf")
							then
								create l_path.make_from_string (l_precompilation_path)
								l_path.set_file_name (l_ecf_name)
								create l_target_file.make (l_path)
								if not l_target_file.exists then
									l_target_file.open_write
									create l_path.make_from_string (l_installation_precompilation_path)
									l_path.set_file_name (l_ecf_name)
									create l_source_file.make_open_read (l_path)
									l_source_file.copy_to (l_target_file)
									l_source_file.close
									l_target_file.close
								end
							end
							l_files.forth
						end
					else
							-- Installation directory is missing, we won't do anything
							-- and will let the compilation fails with a missing precompilation
							-- message if used.
					end
				end
			end
		ensure
			is_valid_precompile_environment: is_valid_precompile_environment
		rescue
				-- For some reasons, there was a failure, which most likely happened
				-- while trying to copy the precompilation ECFs over. We simply ignore
				-- the error and continue normally. A compilation error will be triggered
				-- later.
			retried := True
			if l_source_file /= Void and then not l_source_file.is_closed then
				l_source_file.close
			end
			if l_target_file /= Void and then not l_target_file.is_closed then
				l_target_file.close
			end
			retry
		end

feature {NONE} -- Helpers

	environment: ENVIRONMENT_ACCESS
			-- Shared access to an instance of {ENVIRONMENT_ACCESS}.
		once
			create Result
		end

feature -- IL environment

	default_il_environment: IL_ENVIRONMENT
			-- Default il environment, using the newest available runtime.
		once
			create Result
		end

feature -- Query

	user_priority_file_name (a_file_name: STRING_GENERAL; a_must_exist: BOOLEAN): detachable FILE_NAME
			-- Retrieve a Eiffel installation file, taking a user replacement as priority
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_is_empty: not a_file_name.is_empty
		local
			l_install: STRING
			l_file: STRING
			l_extension: STRING
			l_actual_file: RAW_FILE
		do
			l_install := install_path.string
			if l_install.count < a_file_name.count then
				l_file := a_file_name.as_string_8.string
				if l_file.substring (1, l_install.count).is_equal (l_install) then
					l_extension := l_file.substring (l_install.count + 1, l_file.count)
					l_extension.prune_all_leading (operating_environment.directory_separator)
					create Result.make_from_string (user_files_path)
					Result.extend (l_extension)

					create l_actual_file.make (Result)
					if a_must_exist and then (not l_actual_file.exists or else (l_actual_file.is_device or l_actual_file.is_directory)) then
							-- The file does not exist or is not actually a file.
						Result := Void
					end
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_exists: (Result /= Void and a_must_exist) implies (create {RAW_FILE}.make (Result)).exists
		end

	user_priority_path (a_dir: STRING_GENERAL; a_must_exist: BOOLEAN): detachable DIRECTORY_NAME
			-- Retrieve a Eiffel installation file, taking a user replacement as priority
		require
			a_dir_attached: a_dir /= Void
			not_a_dir_is_empty: not a_dir.is_empty
		local
			l_install: STRING
			l_extension: STRING
			l_dir: STRING_8
		do
			l_install := install_path.string
			if l_install.count < a_dir.count then
				l_dir := a_dir.as_string_8.string
				if l_dir.substring (1, l_install.count).is_equal (l_install) then
					l_extension := l_dir.substring (l_install.count + 1, l_dir.count)
					l_extension.prune_all_leading (operating_environment.directory_separator)
					create Result.make_from_string (user_files_path)
					Result.extend (l_extension)

					if a_must_exist and then not (create {DIRECTORY}.make (Result)).exists then
							-- The directory does not exist
						Result := Void
					end
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_exists: (Result /= Void and a_must_exist) implies (create {DIRECTORY}.make (Result)).exists
		end

	platform_priority_file_name (a_file_name: READABLE_STRING_GENERAL; a_use_simple: BOOLEAN; a_must_exist: BOOLEAN): detachable FILE_NAME
			-- Retrieve a Eiffel installation path, taking a platform specific path as a priority
			--
			-- `a_dir': A base directory to affix with the platform name.
			-- `a_use_simple': True to use the Windows/Unix platform name; False to use ISE_PLATFORM.
			-- `a_must_exist': True if the directory must exist to return a result; False otherwise.
			-- `Result': A platform path or Void if the path does not exist.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_is_empty: not a_file_name.is_empty
		local
			l_file: STRING
			l_path: like platform_priority_path
			i: INTEGER
		do
			l_file := a_file_name.as_string_8
			i := l_file.last_index_of (operating_environment.directory_separator, l_file.count)
			if i > 0 then
				l_path := platform_priority_path (l_file.substring (1, i - 1), a_use_simple, a_must_exist)
				if l_path /= Void then
					create Result.make_from_string (l_path)
					Result.extend (l_file.substring (i + 1, l_file.count))
					if a_must_exist and then not (create {RAW_FILE}.make (Result)).exists then
							-- The directory does not exist
						Result := Void
					end
				end

			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_exists: (Result /= Void and a_must_exist) implies (create {RAW_FILE}.make (Result)).exists
		end

	platform_priority_path (a_dir: READABLE_STRING_GENERAL; a_use_simple: BOOLEAN; a_must_exist: BOOLEAN): detachable DIRECTORY_NAME
			-- Retrieve a Eiffel installation path, taking a platform specific path as a priority
			--
			-- `a_dir': A base directory to affix with the platform name.
			-- `a_use_simple': True to use the Windows/Unix platform name; False to use ISE_PLATFORM.
			-- `a_must_exist': True if the directory must exist to return a result; False otherwise.
			-- `Result': A platform path or Void if the path does not exist.
		require
			a_dir_attached: a_dir /= Void
			not_a_dir_is_empty: not a_dir.is_empty
		local
			l_platform: like eiffel_platform
		do
			create Result.make_from_string (a_dir.as_string_8)
			if a_use_simple then
				if {PLATFORM}.is_windows then
					Result.extend (windows_name)
				else
					Result.extend (unix_name)
				end
			else
				l_platform := eiffel_platform
				if not l_platform.is_empty then
					Result.extend (l_platform)
				elseif a_must_exist then
					Result := Void
				end
			end
			if a_must_exist and then Result /= Void and then not (create {DIRECTORY}.make (Result)).exists then
					-- The directory does not exist
				Result := Void
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_exists: (Result /= Void and a_must_exist) implies (create {DIRECTORY}.make (Result)).exists
		end

feature -- Directories (top-level)

	install_path: DIRECTORY_NAME
			-- Absolute path to the Eiffel installation.
			--
			-- Note: This is the Eiffel installation location for most platforms but you should
			--       be using the platform independent `shared_path'.
		require
			is_valid_environment: is_valid_environment
		local
			l_name: STRING
			l_name_wb: STRING
		once
			if is_unix_layout then
				l_name := shared_path
			else
				l_name := eiffel_install
			end
			check l_name_attached: l_name /= Void end
			if is_workbench then
				l_name_wb := l_name.twin
				l_name_wb.append_character ('_')
				l_name_wb.append (wkbench_suffix)
				if (create {DIRECTORY}.make (l_name_wb)).exists then
						-- The workbench version exists, so use that directory instead.
					l_name := l_name_wb
				end
			end
			check
				l_name_not_void: l_name /= Void
				not_l_name_is_empty: not l_name.is_empty
			end
			create Result.make_from_string (l_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	docs_path: DIRECTORY_NAME
			-- Folder contains Eiffel documention.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_share_path.twin
				Result.extend_from_array (<<docs_name, unix_product_version_name>>)
			else
				Result := install_path.twin
				Result.extend (docs_name)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	dotnet_path: DIRECTORY_NAME
			-- Location of .NET specific data
		require
			is_valid_environment: is_valid_environment
		once
			Result := install_path.twin
			Result.extend (dotnet_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	library_path: DIRECTORY_NAME
			-- Eiffel library path
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (eiffel_library)
			Result.extend (library_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	installation_precompilation_path (a_is_dotnet: BOOLEAN): DIRECTORY_NAME
			-- Eiffel path where the ECFs are located in the installation directory.
			-- With platform: $ISE_EIFFEL/precomp/spec/$ISE_PLATFORM
			-- Without: /usr/share/eiffelstudio-7.x/precomp/spec/unix
		require
			is_valid_environment: is_valid_environment
		local
			l_dn_name: STRING
		do
			Result := shared_path.twin
			Result.extend (precomp_name)
			Result.extend (spec_name)
			if a_is_dotnet then
					-- Append '-dotnet' to platform name
				create l_dn_name.make (eiffel_platform.count + 7)
				l_dn_name.append (eiffel_platform)
				l_dn_name.append ("-dotnet")
				Result.extend (l_dn_name)
			else
				Result.extend (eiffel_platform)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	precompilation_path (a_is_dotnet: BOOLEAN): DIRECTORY_NAME
			-- Actual location of the precompiled libraries.
			-- When ISE_PRECOMP is defined:
			--   $ISE_PRECOMP
			-- Otherwise if `is_user_files_supported':
			--   On Windows: C:\Users\manus\Documents\Eiffel User Files\7.x\precomp\spec\$ISE_PLATFORM
			--   On Mac: ~/Eiffel User Files/7.x/precomp/spec/$ISE_PLATFORM
			--   On Unix: ~/.es/Eiffel User Files/7.x/precomp/spec/$ISE_PLATFORM
			-- Otherwise
			--   $ISE_EIFFEL/studio/spec/$ISE_PLATFORM
		require
			is_valid_environment: is_valid_environment
		local
			l_value: like get_environment
			l_dn_name: STRING
		do
			l_value := get_environment ({EIFFEL_CONSTANTS}.ise_precomp_env)
			if l_value = Void or else l_value.is_empty then
				if is_user_files_supported then
					Result := user_files_path.twin
					Result.extend (precomp_name)
					Result.extend (spec_name)
					if a_is_dotnet then
							-- Append '-dotnet' to platform name
						create l_dn_name.make (eiffel_platform.count + 7)
						l_dn_name.append (eiffel_platform)
						l_dn_name.append ("-dotnet")
						Result.extend (l_dn_name)
					else
						Result.extend (eiffel_platform)
					end
				else
						-- No user file is specified, we use the installation
						-- directory and if this is not writable, users will
						-- get an error.
					Result := installation_precompilation_path (a_is_dotnet)
				end
			else
				create Result.make_from_string (l_value)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	application_path: DIRECTORY_NAME
			-- Location of the compile distribution.
			--
			-- Note: This is the Eiffel installation location for most platforms but you should
			--       be using the platform independent `shared_application_path'.
		require
			not_unix_layout: not is_unix_layout
			is_valid_environment: is_valid_environment
		once
			Result := install_path.twin
			Result.extend (distribution_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature  -- Directories (dotnet)

	assemblies_path: DIRECTORY_NAME
			-- Location of Eiffel Assembly Cache.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (dotnet_path)
			Result.extend (assemblies_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Directories (distribution)

	bitmaps_path: DIRECTORY_NAME
			-- Path containing the bitmaps for the graphical environment.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (shared_application_path)
			Result.extend (bitmaps_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	built_ins_path (a_is_platform_neutral, a_is_dotnet: BOOLEAN): DIRECTORY_NAME
			-- Path where implementation for `built_ins' are found.
		require
			is_valid_environment: is_valid_environment
		do
			create Result.make_from_string (shared_application_path)
			Result.extend (built_ins_name)
			if a_is_platform_neutral then
				Result.extend (neutral_name)
			else
				if a_is_dotnet then
					Result.extend (dotnet_name)
				else
					Result.extend (classic_name)
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	config_path: DIRECTORY_NAME
			-- Path containing the Eiffel compiler configuration files.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (shared_application_path)
			Result.extend ("config")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	generation_templates_path: DIRECTORY_NAME
			-- Path containing the Eiffel compiler code generation template files.
		require
			is_valid_environment: is_valid_environment
		once
			Result := config_path.twin
			Result.extend_from_array (<<eiffel_platform, templates_name>>)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	eifinit_path: DIRECTORY_NAME
			-- Path containing the Eiffel initialization configuration files.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (shared_application_path)
			Result.extend ("eifinit")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	filter_path: DIRECTORY_NAME
			-- Path containing the documentation filters.
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.twin
			Result.extend (filters_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	help_path: DIRECTORY_NAME
			-- Path containing the help files.
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.twin
			Result.extend (help_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	error_path: DIRECTORY_NAME
			-- Path containing the compiler error description files.
		require
			is_valid_environment: is_valid_environment
		once
			Result := help_path.twin
			Result.extend (errors_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	default_templates_path: DIRECTORY_NAME
			-- Path containing the default templates.
		require
			is_valid_environment: is_valid_environment
		once
			Result := help_path.twin
			Result.extend (defaults_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	language_path: DIRECTORY_NAME
			-- Path containing the internationalized mo files.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_locale_path.twin
				Result.extend (unix_product_version_name)
			else
				create Result.make_from_string (shared_application_path)
				Result.extend_from_array (<<lang_name, mo_files_name>>)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	metrics_path: DIRECTORY_NAME
			-- Location of the metric configuration files
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (shared_application_path)
			Result.extend (metrics_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	profile_path: DIRECTORY_NAME
			-- Location of the profiler configuration files
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (shared_application_path)
			Result.extend (profiler_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	templates_path: DIRECTORY_NAME
			-- Path to user code template, to merge with the ones from the installation.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (shared_application_path)
			Result.extend (templates_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	template_default_path: DIRECTORY_NAME
			-- Path containing the templates for default Eiffel files.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (templates_path)
			Result.extend (defaults_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	bin_path: DIRECTORY_NAME
			-- Location of binary compiler components.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (unix_layout_base_path)
				Result.extend (bin_name)
			else
				create Result.make_from_string (shared_application_path)
				Result.extend_from_array (<<spec_name, eiffel_platform, bin_name>>)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	runtime_include_path: DIRECTORY_NAME
			-- Location of Eiffel runtime include files.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_base_path.twin
				Result.extend_from_array (<<include_name, unix_product_version_name>>)
			else
				Result := shared_application_path.twin
				Result.extend_from_array (<<spec_name, eiffel_platform, include_name>>)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	runtime_lib_path: DIRECTORY_NAME
			-- Location of Eiffel runtime lib files.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_lib_path.twin
			else
				Result := shared_application_path.twin
				Result.extend_from_array (<<spec_name, eiffel_platform, lib_name>>)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	wizards_path: DIRECTORY_NAME
			-- Location of new project wizards.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (lib_application_path)
			Result.extend (wizards_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	new_project_wizards_path: DIRECTORY_NAME
			-- Location of new project wizards.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (wizards_path)
			Result.extend ("new_projects")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	precompilation_wizard_resources_path: DIRECTORY_NAME
			-- Location of precompiled wizard resources
		require
			is_valid_environment: is_valid_environment
		once
			Result := wizards_path.twin
			Result.extend_from_array (<<"others", "precompile">>)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	tools_path: DIRECTORY_NAME
			-- Path containing the modular files for Eiffel tools.
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.twin
			Result.extend ("tools")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	testing_tool_path: DIRECTORY_NAME
			-- Path containing testing tool files.
		require
			is_valid_environment: is_valid_environment
		once
			Result := tools_path.twin
			Result.extend ("testing")
		end

	auto_test_path: DIRECTORY_NAME
			-- Path containing auto test specific files
		require
			is_valid_environment: is_valid_environment
		once
			Result := testing_tool_path.twin
			Result.extend ("auto_test")
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Directories (top-level user)

	hidden_files_path: DIRECTORY_NAME
			-- Hidden application configuration Eiffel files.
			-- With ISE_APP_DATA defined:
			--   $ISE_APP_DATA
			-- When hidden files is available:
			--   On Windows: C:\Users\manus\AppData\Local\Eiffel Software\.es\7.x
			--   On Unix & Mac: ~/.es/7.x
			-- Otherwise we use a subdirectory of `user_files_path':
			--   `user_files_path'\settings
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		local
			l_dir: detachable STRING_8
		once
			l_dir := get_environment ({EIFFEL_CONSTANTS}.ise_app_data_env)
			if l_dir = Void or else l_dir.is_empty then
					-- Attempt to use home location.
				if
					operating_environment.home_directory_supported and then
					attached (create {EXECUTION_ENVIRONMENT}).home_directory_name as l_home
				then
					create Result.make_from_string (l_home)
					safe_create_dir (Result)
					if {PLATFORM}.is_windows then
						Result.extend (eiffel_software_name)
						safe_create_dir (Result)
					end
					Result.extend (hidden_directory_name)
					safe_create_dir (Result)

					create l_dir.make (4)
					l_dir.append_integer ({EIFFEL_CONSTANTS}.major_version)
					l_dir.append_character ('.')
					l_dir.append_integer ({EIFFEL_CONSTANTS}.minor_version)
					Result.extend (l_dir)
					safe_create_dir (Result)
				else
						-- No user set variable or the home directory is not supported
					Result := user_files_path.twin
					safe_create_dir (Result)
					Result.extend (settings_name)
					safe_create_dir (Result)
				end
			else
					-- Use environment variable
				create Result.make_from_string (l_dir)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	user_files_path: DIRECTORY_NAME
			-- User based Eiffel files which are generally visible to the users
			-- With ISE_USER_FILES is defined:
			--   $ISE_USER_FILES
			-- Otherwise
			--   On Windows: C:\Users\manus\Documents\Eiffel User Files\7.x
			--   On Mac: ~/Eiffel User Files/7.x
			--   On Unix: ~/.es/Eiffel User Files/7.x
			-- When purge the ES stored configuration data, it will not erase the files
			-- under this path
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		local
			l_dir: detachable STRING_8
			l_needs_suffix: BOOLEAN
		once
				-- If user have set the ISE_USER_FILES environment variable, use it.
			l_dir := get_environment ({EIFFEL_CONSTANTS}.ise_user_files_env)
			if l_dir = Void or else l_dir.is_empty then
				check attached user_directory_name as l_user_files then
					create Result.make_from_string (l_user_files)
						-- On Unix platform only, the files will be located under the hidden directory
						-- where EiffelStudio stores settings, otherwise it is in the home directory
						-- of the user (i.e. not hidden).
					if not {PLATFORM}.is_windows and then not {PLATFORM}.is_mac then
						Result.extend (hidden_directory_name)
						safe_create_dir (Result)
						l_needs_suffix := False
					else
							-- We need to add a suffix if we are in workbench mode
							-- as otherwise we would be using the same path as finalized.
						l_needs_suffix := True
					end
						-- Now we can freely create our directory structure for `user_files'.
					create l_dir.make (30)
					l_dir.append (product_name)
					l_dir.append (" User Files")
					if is_workbench and l_needs_suffix then
						l_dir.append_character (' ')
						l_dir.append_character ('(')
						l_dir.append (wkbench_suffix)
						l_dir.append_character (')')
					end
					Result.extend (l_dir)
					safe_create_dir (Result)

						-- Per version directory structure to avoid clutter.
					create l_dir.make (4)
					l_dir.append_integer ({EIFFEL_CONSTANTS}.major_version)
					l_dir.append_character ('.')
					l_dir.append_integer ({EIFFEL_CONSTANTS}.minor_version)
					Result.extend (l_dir)
					safe_create_dir (Result)
				end
			else
					-- Use environment variable
				create Result.make_from_string (l_dir)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Private Settings Directories

	projects_data_path: DIRECTORY_NAME
			-- Path to settings for all projects loaded by EiffelStudio.
			--| This contains for each ECF file loaded by EiffelStudio the target
			--| and location where project is compiled.
			--| They are hidden by default to the user.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		once
			Result := hidden_files_path.twin
			Result.extend (projects_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	docking_data_path: DIRECTORY_NAME
			-- Path to docking settings for EiffelStudio.
			--| They are hidden by default to the user.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		once
			Result := hidden_files_path.twin
			Result.extend (docking_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	session_data_path: DIRECTORY_NAME
			-- Path to session data associated to a project loaded by EiffelStudio.
			--| They are hidden by default to the user.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		once
			Result := hidden_files_path.twin
			Result.extend (session_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	temporary_path: DIRECTORY_NAME
			-- Path to temporary directory that EiffelStudio can use to store temporary files.
			--| They are hidden by default to the user.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		once
				--| FIXME: Manu 2011/11/05: It might be a good idea to fix FILE_NAME
				--| and add a way to create a temporary file in FILE directory to avoid
				--| security issues if someone creates a file with the same file name
				--| as the one that will be used later by EiffelStudio.
			Result := hidden_files_path.twin
			Result.extend ("tmp")
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- User Directories

	user_templates_path: DIRECTORY_NAME
				-- Path to user code template, to merge with the ones from the installation.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		once
			Result := user_files_path.twin
			Result.extend (templates_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	user_projects_path: DIRECTORY_NAME
			-- Location of Eiffel projects.
		local
			l_var: detachable STRING
		once
			l_var := get_environment ({EIFFEL_CONSTANTS}.ise_projects_env)
			if l_var = Void or else l_var.is_empty then
				if {PLATFORM}.is_windows or else {PLATFORM}.is_mac then
					Result := user_files_path.twin
					Result.extend (projects_name)
				elseif operating_environment.home_directory_supported and then attached environment.home_directory_name as l_home then
					create Result.make_from_string (l_home)
				else
						-- FIXME: What path should we put there?
					create Result.make_from_string ("\Invalid path")
				end
			else
				create Result.make_from_string (l_var)
			end
			remove_trailing_dir_separator (Result)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Files

	default_config_file_name: FILE_NAME
			-- Default Eiffel confiration file name location
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (default_templates_path)
			Result.set_file_name (default_config_file)
			if is_user_files_supported then
					-- Check user override file.
				if attached user_priority_file_name (Result, True) as l_user then
					Result := l_user
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	predefined_metrics_file: FILE_NAME
			-- File to store predefined metrics
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (metrics_path)
			Result.set_file_name ("predefined_metrics.xml")
			if is_user_files_supported then
					-- Check user override file.
				if attached user_priority_file_name (Result, True) as l_user then
					Result := l_user
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	compiler_configuration: FILE_NAME
			-- Platform specific system level resource specification file
			-- ($ISE_EIFFEL/eifinit/application_name/spec/$ISE_PLATFORM)
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (eifinit_path)
			Result.set_file_name ("general")
			Result.add_extension ("cfg")
			if is_user_files_supported then
					-- Check user override file.
				if attached user_priority_file_name (Result, True) as l_user then
					Result := l_user
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	msil_culture_name: FILE_NAME
			-- Culture specification file
		require
			is_valid_environment: is_valid_environment
			is_windows: {PLATFORM}.is_windows
		once
			create Result.make_from_string (eifinit_path)
			Result.extend_from_array (<<spec_name, Platform_abstraction>>)
			Result.set_file_name ("culture")
			if is_user_files_supported then
					-- Check user override file.
				if attached user_priority_file_name (Result, True) as l_user then
					Result := l_user
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	libraries_config_name: FILE_NAME
			-- Libraries lookup configuration file name
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (eifinit_path)
			Result.set_file_name ("libraries")
			Result.add_extension ("cfg")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	precompiles_config_name: FILE_NAME
			-- Precompiled libraries lookup configuration file name
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (eifinit_path)
			Result.set_file_name ("precompiles")
			Result.add_extension ("cfg")
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Files (user)

	user_docking_file_name (a_file_name: STRING): FILE_NAME
			-- Path of standard docking layout.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			create Result.make_from_string (docking_data_path)
			Result.set_file_name (a_file_name)
			Result.add_extension (docking_file_extension)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	user_docking_standard_file_name (a_window_id: NATURAL_32): FILE_NAME
			-- Path of standard docking layout.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
			valid: a_window_id > 0
		do
			Result := user_docking_file_name (docking_standard_file + "_" + a_window_id.out)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	user_docking_debug_file_name (a_window_id: NATURAL_32): FILE_NAME
			-- Path of standard docking layout.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
			valid: a_window_id > 0
		do
			Result := user_docking_file_name (docking_debug_file + "_" + a_window_id.out)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	user_external_command_file_name (a_file_name: STRING): FILE_NAME
			-- Path to external commands ini file
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			create Result.make_from_string (user_files_path)
			Result.set_file_name (a_file_name)
			Result.add_extension ("ini")
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Directories (platform independent)

	shared_path: DIRECTORY_NAME
			-- Location of shared files (platform independent).
			-- With platform: $ISE_EIFFEL.
			-- Without: /usr/share/eiffelstudio-7.x
		require
			is_valid_environment: is_valid_environment
		local
			l_name: STRING_8
			l_name_wb: STRING_8
		once
			if is_unix_layout then
				Result := unix_layout_share_path.twin
				Result.extend (unix_product_version_name)
				l_name := Result
			else
				l_name := eiffel_install
			end
			if is_workbench then
				l_name_wb := l_name.twin
				l_name_wb.append_character ('_')
				l_name_wb.append (wkbench_suffix)
				if (create {DIRECTORY}.make (l_name_wb)).exists then
						-- The workbench version exists, so use that directory instead.
					l_name := l_name_wb
				end
			end
			check
				not_l_name_is_empty: not l_name.is_empty
			end
			create Result.make_from_string (l_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	shared_application_path: DIRECTORY_NAME
			-- Location of shared files specific for the current application (platform independent).
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_path.twin
			Result.extend (distribution_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	lib_path: DIRECTORY_NAME
			-- Location of libs files (platform dependent).
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_lib_path.twin
				Result.extend (unix_product_version_name)
			else
				Result := install_path.twin
			end
			if is_experimental_mode then
				Result.extend ("experimental")
			elseif is_compatible_mode then
				Result.extend ("compatible")
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	lib_application_path: DIRECTORY_NAME
			-- Location of lib files specific for the current application (platform dependent).
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_lib_path.twin
				Result.extend (unix_product_version_name)
			else
				Result := install_path.twin
			end
			Result.extend (distribution_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Files (commands)

	estudio_command_name: FILE_NAME
			-- Complete path to `estudio'.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (bin_path)
			Result.set_file_name (estudio_name)
			if not executable_suffix.is_empty then
				Result.add_extension (executable_suffix)
			end
		ensure
			not_reuslt_is_empty: not Result.is_empty
		end

	ec_command_name: FILE_NAME
			-- Absolute path to `ec'.
		require
			is_valid_environment: is_valid_environment
		local
			l_args: ARGUMENTS
		once
			if is_workbench and application_name.same_string ("ec") then
					-- We have to launch ourself to perform a compilation that would make sense
					-- but only if we are the `ec' application, not if we are something else.
				create l_args
				create Result.make_from_string (l_args.command_name)
			else
				create Result.make_from_string (bin_path)
				Result.set_file_name (ec_name)
				if not executable_suffix.is_empty then
					Result.add_extension (executable_suffix)
				end
			end
		ensure
			not_reuslt_is_empty: not Result.is_empty
		end

	studio_command_line (a_ecf, a_target, a_project_path: detachable READABLE_STRING_GENERAL; a_is_gui, a_is_clean: BOOLEAN): STRING
			-- Build a proper command line to open/compile a project with EiffelStudio
			-- on a specific target `a_target' if specified, in a location `a_project_path' if specified.
			-- If `a_is_gui' is True, EiffelStudio is launched, otherwise the command line.
			-- If `a_is_clean' is True, the compiler will delete the existing project.
		local
			l_profile: STRING
		do
			create Result.make (256)
			Result.append_character ('%"')
			if a_is_gui then
					-- Because on Windows we have a console if launching `ec' we use the
					-- wrapper `estudio', but this is not needed in theory.
				Result.append (estudio_command_name)
			else
				Result.append (ec_command_name)
			end
			Result.append_character ('%"')
			l_profile := command_line_profile_option
			if not l_profile.is_empty then
				Result.append_character (' ')
				Result.append (l_profile)
			end
			if a_is_clean then
				Result.append (" -clean")
			end
			if a_ecf /= Void and then not a_ecf.is_empty then
				Result.append (" -config %"")
				Result.append (a_ecf.as_string_8)
				Result.append_character ('%"')
			end
			if a_target /= Void and then not a_target.is_empty then
				Result.append (" -target %"")
				Result.append (a_target.as_string_8)
				Result.append_character ('"')
			end
			if a_project_path /= Void and then not a_project_path.is_empty then
				Result.append (" -project_path %"")
				Result.append (a_project_path.as_string_8)
				Result.append_character ('"')
			end
		end

	freeze_command_name: FILE_NAME
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (bin_path)
			Result.set_file_name (finish_freezing_script)
			if not executable_suffix.is_empty then
				Result.add_extension (executable_suffix)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	emake_command_name: FILE_NAME
			-- Complete path to `emake'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (lib_application_path)
			else
				create Result.make_from_string (bin_path)
			end
			Result.set_file_name (emake_name)
			if not executable_suffix.is_empty then
				Result.add_extension (executable_suffix)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	quick_finalize_command_name: FILE_NAME
			-- Complete path to `quick_finalize'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (lib_application_path)
			else
				create Result.make_from_string (bin_path)
			end
			Result.set_file_name (quick_finalize_name)
			if not executable_suffix.is_empty then
				Result.add_extension (executable_suffix)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	x2c_command_name: FILE_NAME
			-- Complete path to `x2c'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (lib_application_path)
			else
				create Result.make_from_string (bin_path)
			end
			Result.set_file_name (x2c_name)
			if not executable_suffix.is_empty then
				Result.add_extension (executable_suffix)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	prelink_command_name: FILE_NAME
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (lib_application_path)
			else
				create Result.make_from_string (bin_path)
			end
			Result.set_file_name (prelink_name)
			if not executable_suffix.is_empty then
				Result.add_extension (executable_suffix)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	ecdbgd_command_name: FILE_NAME
			-- Complete path to `ecdbgd'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				create Result.make_from_string (lib_application_path)
			else
				create Result.make_from_string (bin_path)
			end
			Result.set_file_name (ecdbg_name)
			if not executable_suffix.is_empty then
				Result.add_extension (executable_suffix)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	compile_library_command_name: FILE_NAME
			-- Complete path to `compile_library.bat'.
		require
			is_valid_environment: is_valid_environment
			is_windows: {PLATFORM}.is_windows
		once
			create Result.make_from_string (bin_path)
			Result.set_file_name ("compile_library")
			Result.add_extension ("bat")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	precompilation_wizard_command_name: FILE_NAME
			-- Command to be executed to launch the precompilation wizard.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (precompilation_wizard_resources_path)
			Result.extend_from_array (<<spec_name, eiffel_platform>>)
			Result.set_file_name ("wizard")
			if not executable_suffix.is_empty then
				Result.add_extension (executable_suffix)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Executable names

	estudio_name: STRING_8
			-- Name of estudio command
		once
			create Result.make_from_string ("estudio")
			Result.append (release_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	ec_name: STRING_8
			-- Full executable name of ec.
		local
			l_var: like get_environment
		once
			l_var := get_environment ({EIFFEL_CONSTANTS}.ec_name_env)
			if l_var /= Void then
				Result := l_var
			else
				create Result.make (6)
				Result.append ("ec")
				Result.append (release_suffix)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	finish_freezing_script: STRING_8
			-- Name of post-eiffel compilation processing to launch C code.
		once
			create Result.make_from_string ("finish_freezing")
			Result.append (release_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	quick_finalize_name: STRING_8 = "quick_finalize"
			-- Name of estudio command

	x2c_name: STRING_8 = "x2c"
			-- Complete path to `x2c'.

	emake_name: STRING_8 = "emake"
			-- Name of emake command.

	prelink_name: STRING_8 = "prelink"
			-- Name of estudio command.

	ecdbg_name: STRING_8 = "ecdbgd"
			-- Name of console line debugger command.

feature {NONE} -- Configuration of layout

	unix_layout_base_path: DIRECTORY_NAME
			-- Base for the unix layout. e.g. "/usr".
		once
			create Result.make
			Result.set_directory ("usr")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	unix_layout_share_path: DIRECTORY_NAME
			-- share for the unix layout. e.g. "/usr/share".
		once
			Result := unix_layout_base_path.twin
			Result.extend ("share")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	unix_layout_lib_path: DIRECTORY_NAME
			-- Directory name for lib. e.g. "/usr/lib".
		once
			Result := unix_layout_base_path.twin
			Result.extend ("lib ")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	unix_layout_locale_path: DIRECTORY_NAME
			-- Directory name for lib. e.g. "/usr/share/locale"
		once
			Result := unix_layout_share_path.twin
			Result.extend ("locale")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	unix_layout_platform: STRING_8 = "unix";
			-- Platform to use for the unix layout.

feature -- Environment access

	get_environment (a_var: STRING_8): detachable STRING
			-- Get `a_var' from the environment, taking into account the `application_name' to lookup the defaults.
		require
			a_var_attached: a_var /= Void
			not_a_var_is_empty: not a_var.is_empty
		do
			Result := environment.get_from_application (a_var, application_name)
		end

feature -- Environment update

	set_environment (a_value, a_var: STRING_8)
			-- Update environment variable `a_key' to be `a_value'.
		require
			a_var_ok: a_var /= Void and then not a_var.is_empty and then not a_var.has ('%U')
			a_value_ok: a_value /= Void and then not a_value.has ('%U')
		do
			environment.put (a_value.string, a_var)
		ensure
			value_updated: get_environment (a_var) /= Void implies get_environment (a_var) ~ a_value.string
		end

feature -- Version limitation

	has_diagram: BOOLEAN = True
			-- Does this version have the diagram tool?

	has_metrics: BOOLEAN = True
			-- Does this version have the metrics?

	has_profiler: BOOLEAN = True
			-- Does this version have the profiler?

	has_documentation_generation: BOOLEAN = True
			-- Does this version have the documentation generation?

	has_xmi_generation: BOOLEAN = True
			-- Does this version have the XMI generation?

	has_dll_generation: BOOLEAN = True
			-- Does this version have the DLL generation?

	has_signable_generation: BOOLEAN = True;
			-- Does this version allow the signing of .NET assemblies

feature {NONE} -- Basic operations

	create_directories
			-- Creates the default directories
		require
			is_valid_environment: is_valid_environment
		local
			l_directories: like creatable_directories
		do
			l_directories := creatable_directories
			l_directories.do_all (agent safe_create_dir)
		end

	safe_create_dir (a_dir: STRING)
			-- Try to create a directory `a_dir'.
		require
			a_dir_not_void: a_dir /= Void
		local
			l_dir: DIRECTORY
			l_dir_name: STRING
			retried: BOOLEAN
		do
			if not retried then
				create l_dir.make (a_dir)
				if not l_dir.exists then
					l_dir.create_dir
				end
			else
				if a_dir.count > 1 and then a_dir.item (a_dir.count) = operating_environment.directory_separator then
					l_dir_name := a_dir.substring (1, a_dir.count - 1)
					safe_create_dir (l_dir_name)
				end
			end
		rescue
			retried := True
			retry
		end

	safe_recursive_create_dir (a_dir: STRING)
			-- Try to create a directory `a_dir'.
		require
			a_dir_not_void: a_dir /= Void
		local
			l_dir: DIRECTORY
			l_dir_name: STRING
			retried: BOOLEAN
		do
			if not retried then
				create l_dir.make (a_dir)
				if not l_dir.exists then
					l_dir.recursive_create_dir
				end
			else
				if a_dir.count > 1 and then a_dir.item (a_dir.count) = operating_environment.directory_separator then
					l_dir_name := a_dir.substring (1, a_dir.count - 1)
					safe_recursive_create_dir (l_dir_name)
				end
			end
		rescue
			retried := True
			retry
		end

feature -- Environment variables

	eiffel_install: STRING_8
			-- ISE_EIFFEL name
		do
			if attached get_environment ({EIFFEL_CONSTANTS}.ise_eiffel_env) as l_result then
				Result := l_result
				remove_trailing_dir_separator (Result)
			else
				Result := ""
			end
		ensure
			not_result_is_empty: is_valid_environment implies not Result.is_empty
		end

	eiffel_c_compiler: STRING_8
			-- ISE_C_COMPILER name.
		require
			windows: {PLATFORM}.is_windows
		do
			if attached get_environment ({EIFFEL_CONSTANTS}.ise_c_compiler_env) as l_result then
				Result := l_result
			else
				Result := ""
			end
		ensure
			not_result_is_empty: is_valid_environment implies not Result.is_empty
		end

	eiffel_c_compiler_version: STRING_8
			-- ISE_C_COMPILER_CODE name.
		require
			windows: {PLATFORM}.is_windows
		do
			if attached get_environment ({EIFFEL_CONSTANTS}.ise_c_compiler_ver_env) as l_result then
				Result := l_result
			else
				Result := ""
			end
		end

	eiffel_platform: STRING_8
			-- ISE_PLATFORM name.
		do
			if attached get_environment ({EIFFEL_CONSTANTS}.ise_platform_env) as l_result then
				Result := l_result
			else
				Result := ""
			end
		ensure
			not_result_is_empty: is_valid_environment implies not Result.is_empty
		end

	eiffel_library: STRING_8
			-- ISE_LIBRARY directory name.
		require
			is_valid_environment: is_valid_environment
		do
			if attached get_environment ({EIFFEL_CONSTANTS}.ise_library_env) as l_result then
				Result := l_result
				remove_trailing_dir_separator (Result)
			else
				Result := ""
			end
		ensure
			not_result_is_empty: is_valid_environment implies not Result.is_empty
		end

	platform_abstraction: STRING_8
			-- Abstraction between Windows and Unix.
		once
			if {PLATFORM}.is_windows then
				Result := windows_name
			else
				Result := unix_name
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- File constants

	default_config_file: STRING_8 = "default.ecf"
			-- Default ECF file name

	default_project_location_for_windows: STRING_8
			-- Default project location on windows.
		require
			is_windows: {PLATFORM}.is_windows
		once
			Result := "C:\projects"
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Directory constants (platform)

	dotnet_name: STRING = "dotnet"
			-- .NET folder name.

	neutral_name: STRING_8 = "neutral"
			-- Neutral platform folder name.

	classic_name: STRING_8 = "classic"
			-- Classic Eiffel folder name.

	windows_name: STRING_8 = "windows"
			-- Windows generic platform folder name.

	unix_name: STRING_8 = "unix"
			-- Unix generic platform folder name.

	wkbench_suffix: STRING_8 = "workbench"
			-- Workbench suffix for paths

feature -- Directory constants (top-level)

	distribution_name: STRING_8
			-- Name of compiler distribution.
			--
			--| Redefine for alternative compiler distributions.
		once
			Result := "studio"
		ensure
			not_result_is_empty: not Result.is_empty
		end

	docs_name: STRING = "docs"
			-- Documentation folder name.

	library_name: STRING = "library"
			-- Library folder name.

	precomp_name: STRING = "precomp"
			-- Precompile library location

feature -- Directory constants (dotnet)

	assemblies_name: STRING_8 = "assemblies"
			-- .NET assembly cache folder name.

feature -- Directory constants (distribution)

	bin_name: STRING_8 = "bin"
			-- Binary folder name

	bitmaps_name: STRING_8 = "bitmaps"
			-- Bitmpa folder name.

	borland_name: STRING_8 = "BCC55"
			-- Borland C compiler folder name.

	built_ins_name: STRING_8 = "built_ins"
			-- Built-in code classes folder name.

	defaults_name: STRING_8 = "defaults"
			-- Default templates folder name.

	errors_name: STRING_8 = "errors"
			-- Error file descriptions folder name.

	etc_name: STRING_8 = "etc"
			-- Etc library folder name

	filters_name: STRING_8 = "filters"
			-- Documentation filters folder name.

	help_name: STRING_8 = "help"
			-- Help files folder name.

	include_name: STRING_8 = "include"
			-- External include folder name

	lang_name: STRING_8 = "lang"
			-- Language folder name.

	lib_name: STRING_8 = "lib"
			-- External library folder name

	metrics_name: STRING_8 = "metrics"
			-- Metrics folder name.

	mo_files_name: STRING_8 = "mo_files"
			-- Language MO files folder name.

	profiler_name: STRING_8 = "profiler"
			-- Profiler folder name.

	templates_name: STRING_8 = "templates"
			-- Code templates folder name.

	spec_name: STRING_8 = "spec"
			-- Specific folder name

	wizards_name: STRING_8 = "wizards"
			-- Wizards folder name

feature -- Directory constants (user)

	docking_name: STRING_8 = "docking"
			-- User docking data folder name.

	projects_name: STRING_8 = "projects"
			-- Eiffel user projects folder name

	settings_name: STRING_8 = "settings"
			-- User settings folder name.

	session_name: STRING_8 = "session"
			-- User session data folder name.

	eiffel_software_name: STRING_8 = "Eiffel Software"
			-- Company folder name

feature -- File constants (user)

	docking_debug_file: STRING_8 = "debug"
			-- Debugger layout docking file name

	docking_standard_file: STRING_8 = "standard"
			-- Editor layout docking file name

	docking_file_extension: STRING_8 = "dck"

	eis_storage_file: STRING_8 = "eis_storage"
			-- EIS storage file name.

feature {NONE} -- Formatting

	remove_trailing_dir_separator (a_dir: detachable STRING)
			-- Removes the trailing directory separator of a directory.
		require
			a_dir_attached: a_dir /= Void
		local
			l_count: INTEGER
		do
			if not a_dir.is_empty then
				l_count := a_dir.count
				if
					l_count > 1 and then a_dir.item (l_count) = operating_environment.directory_separator and then
					l_count > 2 and then a_dir.item (l_count - 1) /= operating_environment.directory_separator
				then
					a_dir.keep_head (l_count - 1)
				end
			end
		end

feature {NONE} -- Implementation

	on_check_environment_failure
			-- Action to be taken when `check_environment_fails'.
		do
			(create {EXCEPTIONS}).die (-1)
		end

	hidden_directory_name: STRING_8
			-- Name of the hidden_directory where settings will be stored on unix based platforms.
		once
			Result := ".es"
			if is_workbench then
				Result.append_character ('_')
				Result.append (wkbench_suffix)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	user_directory_name: detachable STRING
			-- Directory name corresponding to the user directory
			-- On Windows: C:\Users\manus\Documents
			-- On Unix & Mac: $HOME
		local
			l_ptr: like eif_user_directory_name
			l_dir: C_STRING
		once
			l_ptr := eif_user_directory_name
			if l_ptr /= default_pointer then
				create l_dir.own_from_pointer (l_ptr)
				Result := l_dir.string
			end
			if Result /= Void and then not Result.is_empty then
					-- Nothing to do here, we take what we got from the OS.
			elseif
				operating_environment.home_directory_supported and then
				attached (create {EXECUTION_ENVIRONMENT}).home_directory_name as l_home
			then
					-- We use $HOME.
				Result := l_home
			else
					-- No possibility of a user directory, we let the caller handle that.
				Result := Void
			end
		end

	eif_user_directory_name: POINTER
			-- Directory name corresponding to the user directory
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
				#ifdef EIF_WINDOWS
				#ifndef CSIDL_PERSONAL
				#define CSIDL_PERSONAL 0x0005 /* roaming, user\My Documents */
				#endif
					char l_path[MAX_PATH + 1];
					BOOL fResult = FALSE;
					FARPROC sh_get_folder_path = NULL;
					HMODULE shell32_module = LoadLibrary (L"shell32.dll");

					if (shell32_module) {
						sh_get_folder_path = GetProcAddress (shell32_module, "SHGetSpecialFolderPathA");
						if (sh_get_folder_path) {
							fResult = (FUNCTION_CAST_TYPE(BOOL, WINAPI, (HWND, LPSTR, DWORD, BOOL)) sh_get_folder_path) (
								NULL, l_path, CSIDL_PERSONAL, TRUE);
						}
						FreeLibrary(shell32_module);
					}

					if (fResult) {
						char* result = (char*)malloc (sizeof (char) * (strlen (l_path) + 1));
						memcpy (result, l_path, strlen (l_path) + 1);
						return result;
					} else {
						return NULL;
					}
				#else
					return NULL;
				#endif
			]"
		end

feature -- Preferences

	Eiffel_preferences: STRING_8
			-- Preferences location
		require
			is_valid_environment: is_valid_environment
		local
			fname: FILE_NAME
		once
			if {PLATFORM}.is_windows then
				Result := "HKEY_CURRENT_USER\Software\ISE\" + product_version_name + "\" + application_name + "\Preferences"
				if is_workbench then
					Result.append_character ('_')
					Result.append (wkbench_suffix)
				end
			else
				create fname.make_from_string (hidden_files_path)
				fname.set_file_name (application_name + "rc" + {EIFFEL_CONSTANTS}.major_version.out + {EIFFEL_CONSTANTS}.minor_version.out)
				Result := fname.string
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	general_preferences: FILE_NAME
			-- Platform independent preferences.
		require
			is_valid_environment: is_valid_environment
		once
			create Result.make_from_string (eifinit_path)
			Result.set_file_name ("default")
			Result.add_extension ("xml")
			if attached user_priority_file_name (Result, True) as l_fn then
				Result := l_fn
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	platform_preferences: FILE_NAME
			-- Platform specific preferences.
		once
			create Result.make_from_string (eifinit_path)
			Result.extend_from_array (<<spec_name, platform_abstraction>>)
			Result.set_file_name ("default")
			Result.add_extension ("xml")
			if attached user_priority_file_name (Result, True) as l_fn then
				Result := l_fn
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

;note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
