note

	description: "Environment for bitmaps, help, binaries, scripts...."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EIFFEL_ENV

inherit
	ANY

	LOCALIZED_PRINTER

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

	product_name_for_version (a_version_name: READABLE_STRING_GENERAL): STRING_32
			-- Name of the product for version `a_version` formatted as "MM.mm".
			-- I.e. Eiffel_MM.mm
		do
			create Result.make_from_string_general (product_name)
			Result.append_character ('_')
			Result.append_string_general (a_version_name)
			if is_unix_layout then
				Result.to_lower
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	product_version_name: STRING_32
			-- Versioned name of the product.
			-- I.e. Eiffel_MM.mm
		once
			Result := product_name_for_version (version_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	version_name: STRING_8
			-- Version string.
			-- I.e. MM.mm
		once
			create Result.make (5)
			Result.append_string (two_digit_minimum_major_version)
			Result.append_character ('.')
			Result.append_string (two_digit_minimum_minor_version)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	environment_info: STRING_32
			-- Information about the environment.
		require
			is_valid_environment: is_valid_environment
		do
			create Result.make (100)
			if is_unix_layout then
				Result.append_string_general ("Base Path = ")
				Result.append (unix_layout_base_path.name)
			else
				Result.append_string_general ("$" + {EIFFEL_CONSTANTS}.ise_eiffel_env)
				Result.append_string_general (" = ")
				Result.append (install_path.name)
				Result.append_string_general ("%N")
				Result.append_string_general ("$" + {EIFFEL_CONSTANTS}.ise_library_env)
				Result.append_string_general (" = ")
				Result.append (eiffel_library.name)
				Result.append_string_general ("%N")
				Result.append_string_general ("$" + {EIFFEL_CONSTANTS}.ise_platform_env)
				Result.append_string_general (" = ")
				Result.append_string_general (eiffel_platform)
				if {PLATFORM}.is_windows then
					Result.append_string_general ("%N")
					Result.append_string_general ("$" + {EIFFEL_CONSTANTS}.ise_c_compiler_env)
					Result.append_string_general (" = ")
					Result.append_string_general (eiffel_c_compiler)
					if attached eiffel_c_compiler_version as eccv and then not eccv.is_whitespace then
						Result.append_string_general ("%N")
						Result.append_string_general ("$" + {EIFFEL_CONSTANTS}.ise_c_compiler_ver_env)
						Result.append_string_general (" = ")
						Result.append_string_general (eccv)
					end
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	copyright_year: STRING = "2023"
			-- Copyright year.

feature -- Access

	executable_suffix: STRING_8
			-- Platform specific executable extension.
		once
			if {PLATFORM}.is_windows then
				Result := ".exe"
			else
				create Result.make_empty
			end
		ensure
			instance_free: class
			executable_suffix_not_void: Result /= Void
			not_result_is_empty: {PLATFORM}.is_windows implies not Result.is_empty
		end

feature {NONE} -- Access

	required_environment_variables: ARRAYED_LIST [TUPLE [var: READABLE_STRING_8; is_directory: BOOLEAN]]
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

	creatable_directories: ARRAYED_LIST [PATH]
			-- List of directories to be created at start up
		require
			is_valid_environment: is_valid_environment
		once
			if is_user_files_supported then
				create Result.make (3)
				Result.extend (user_files_path)
				Result.extend (hidden_files_path)
				Result.extend (projects_data_path)
			else
				create Result.make (0)
			end
		ensure
			result_contains: Result.for_all (agent (a_item: PATH): BOOLEAN do Result := not a_item.is_empty end)
		end

	release_suffix: STRING
			-- Suffix containing release version which is used for Unix layout
		once
			if is_unix_layout then
				Result := "-" + version_name
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
			l_value: detachable STRING_32
			l_variables: like required_environment_variables
			l_variable: like required_environment_variables.item
			l_is_valid: like is_valid_environment
			u: FILE_UTILITIES
		do
			compiler_profile.initialize_from_arguments

			l_is_valid := True

			if {PLATFORM}.is_unix then
					-- On Unix platforms, if not ISE_EIFFEL is defined then it's probably the Unix layout.
				l_value := get_environment_32 ({EIFFEL_CONSTANTS}.ise_eiffel_env)
				is_unix_layout := (l_value = Void) or else l_value.is_empty
			end

				-- Check environment variables
			create l_product_names
			l_op_env := operating_environment
			l_variables := required_environment_variables
			from l_variables.start until l_variables.after loop
				l_variable := l_variables.item
				l_value := get_environment_32 (l_variable.var)

				if
					l_value /= Void and then l_value.item (l_value.count) = l_op_env.directory_separator and then
					({PLATFORM}.is_windows or else not (l_value.same_string_general ("/") or l_value.same_string_general ("~/")))
				then
						-- Remove trailing directory separator
					l_value.prune_all_trailing (l_op_env.directory_separator)
				end

				if l_value = Void or else l_value.is_empty then
					io.error.put_string (l_product_names.workbench_name)
					io.error.put_string (": the environment variable " + l_variable.var + " has not been set!%N")
					l_is_valid := False
				elseif l_variable.is_directory and then not u.directory_exists (l_value) then
					io.error.put_string (l_product_names.workbench_name)
					io.error.put_string (": the environment variable " + {EIFFEL_CONSTANTS}.ise_eiffel_env + " points to a non-existing directory:%N")
					localized_print_error (l_value)
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
					-- set correctly, or if in Unix layout that ISE_EIFFEL is set
				if not is_unix_layout then
					set_environment (shared_path.name, {EIFFEL_CONSTANTS}.ise_eiffel_env)
				end

					-- Set Unix platform
				if is_unix_layout then
					l_value := get_environment_32 ({EIFFEL_CONSTANTS}.ise_platform_env)
					if l_value = Void or else l_value.is_empty then
							-- Set platform for Unix
						set_environment (unix_layout_platform, {EIFFEL_CONSTANTS}.ise_platform_env)
					end
				end

				if not directory_path_exists (bin_path) then
					io.error.put_string (l_product_names.workbench_name)
					io.error.put_string (": the path $" + {EIFFEL_CONSTANTS}.ise_eiffel_env + "/" + distribution_name + "/spec/$" + {EIFFEL_CONSTANTS}.ise_platform_env + "/bin points to a non-existing directory:%N")
					io.error.put_string (bin_path.utf_8_name)
					on_check_environment_failure
				end
			end

				-- Make sure ISE_LIBRARY and EIFFEL_LIBRARY are defined.
			check_ise_eiffel_library_environment_variables

				-- Make sure to have ISE_IRON_PATH and/or IRON_PATH defined.
			check_iron_environment_variables

				-- Continue checking and initializing the environement
			if is_valid_environment then
				create_directories
				if is_user_files_supported then
					is_hidden_files_path_available := directory_path_exists (hidden_files_path)
				else
						-- No place for saving hidden files.
					is_hidden_files_path_available := False
				end
			end

				-- Initialize User specific precompiled libraries
			init_precompile_directory (False)
			if {PLATFORM}.is_windows then
					-- We only initialize .NET precompiled libraries on Windows.
				init_precompile_directory (True)
			end

				-- Check dotnet related settings
			check_dotnet_environment
		ensure
			is_valid_environment: is_valid_environment
		end

	check_ise_eiffel_library_environment_variables
			-- Make sure to define ISE_LIBRARY and EIFFEL_LIBRARY if not defined.
			--  if $ISE_LIBRARY not defined then
			--      $ISE_LIBRARY=$EIFFEL_LIBRARY
			--  end
			--  if $ISE_LIBRARY not defined then
			--      use ISE_EIFFEL to set ISE_LIBRARY
			--  else
			--      make sure ISE_LIBRARY supports compatible
			--  end
			--  if $EIFFEL_LIBRARY not defined then
			--      $EIFFEL_LIBRARY = $ISE_LIBRARY
			--  end
			--
			-- Note: if a value is set, we never change it (apart from "compatible" support))
		local
			l_ise_library, l_eiffel_library: detachable READABLE_STRING_GENERAL
		do
			l_eiffel_library := get_environment_32 ({EIFFEL_CONSTANTS}.eiffel_library_env)
			l_ise_library := get_environment_32 ({EIFFEL_CONSTANTS}.ise_library_env)

				-- If ISE_LIBRARY is not defined, use EIFFEL_LIBRARY's value (if any)
			if l_ise_library = Void or else l_ise_library.is_empty then
				l_ise_library := l_eiffel_library
			end

				-- If ISE_LIBRARY is not defined, use the `lib_path'
			if l_ise_library = Void or else l_ise_library.is_empty then
				l_ise_library := lib_path.name
			else
					-- To avoid editing value of ISE_LIBRARY when compiling against specific compiler profile
					-- modify the value of the ISE_LIBRARY environment variable.
				l_ise_library := path_under_compiler_profile (l_ise_library)
			end
			check ise_library_set: l_ise_library /= Void end

				-- If EIFFEL_LIBRARY is not defined, use ISE_LIBRARY
			if l_eiffel_library = Void or else l_eiffel_library.is_empty then
				l_eiffel_library := l_ise_library
			else
					-- To avoid editing value of EIFFEL_LIBRARY when compiling against specific compiler profile
					-- modify the value of the EIFFEL_LIBRARY environment variable.
				l_eiffel_library := path_under_compiler_profile (l_eiffel_library)
			end
			check eiffel_library_set: l_eiffel_library /= Void end

				-- Ensure environment variables are set
			set_environment (l_ise_library, {EIFFEL_CONSTANTS}.ise_library_env)
			set_environment (l_eiffel_library, {EIFFEL_CONSTANTS}.eiffel_library_env)
		end

	check_iron_environment_variables
			-- Make sure to have ISE_IRON_PATH and/or IRON_PATH defined.
		local
			l_ise_iron, l_iron: detachable READABLE_STRING_GENERAL
		do
			l_iron := get_environment_32 ({EIFFEL_CONSTANTS}.iron_path_env)
			if l_iron /= Void and then l_iron.is_empty then
				l_iron := Void
			end
			l_ise_iron := get_environment_32 ({EIFFEL_CONSTANTS}.ise_iron_path_env)
			if l_ise_iron /= Void and then l_ise_iron.is_empty then
				l_ise_iron := Void
			end

			if l_ise_iron = Void then
				if l_iron = Void then
						-- both are Void
				else
					l_ise_iron := l_iron
				end
			elseif l_iron = Void then
				l_iron := l_ise_iron -- here l_ise_iron /= Void
			else
					-- Conflict, but ISE_IRON_PATH has priority
					-- thus update IRON_PATH
				l_iron := l_ise_iron
			end
			check same_iron_path: l_iron = l_ise_iron end

			if l_iron = Void or l_ise_iron = Void then
				check l_ise_iron = Void and l_iron = Void end
				l_ise_iron := iron_path.name
				l_iron := l_ise_iron
			end

				-- Ensure environment variables are set
			set_environment (l_ise_iron, {EIFFEL_CONSTANTS}.ise_iron_path_env)
			set_environment (l_iron, {EIFFEL_CONSTANTS}.iron_path_env)
		end

feature -- Status report

	is_valid_environment: BOOLEAN
			-- Have the needed environment variables been set?

	is_hidden_files_path_available: BOOLEAN
			-- Is there a valid home directory?

	is_unix_layout: BOOLEAN
			-- Is eiffelstudio installed in the Unix layout?

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

	init_precompile_directory (a_is_dotnet: BOOLEAN)
			-- If ISE_PRECOMP is not set, initialize user specific precompilation directory
			-- taking into account `a_is_dotnet' to compute the path.
		require
			is_valid_environment: is_valid_environment
		local
			l_precompilation_path, l_installation_precompilation_path: like precompilation_path
			l_dir: DIRECTORY
			l_source_file, l_target_file: detachable RAW_FILE
			l_path: PATH
			retried: BOOLEAN
		do
			if not retried then
					-- Get the path for the precompiled libraries
				l_precompilation_path := precompilation_path (a_is_dotnet)

					-- Now if `l_precompilation_path' does not exist, we copy the content from
					-- the installation directory.
				create l_dir.make (l_precompilation_path.name)
				if not l_dir.exists then
						-- Directory does not exist
					safe_recursive_create_dir (l_precompilation_path)
					l_installation_precompilation_path := installation_precompilation_path (a_is_dotnet)
					create l_dir.make_with_path (l_installation_precompilation_path)
					if l_dir.exists and attached l_dir.entries as l_files then
						from
							l_files.start
						until
							l_files.after
						loop
								-- Only pickup properly formatted ECF project name.
							if l_files.item.has_extension ("ecf") then
								l_path := l_precompilation_path.extended_path (l_files.item)
								create l_target_file.make_with_path (l_path)
								if not l_target_file.exists then
									l_target_file.open_write
									l_path := l_installation_precompilation_path.extended_path (l_files.item)
									create l_source_file.make_with_path (l_path)
									l_source_file.open_read
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

	set_precompile (a_is_dotnet: BOOLEAN)
			-- Set up the ISE_PRECOMP environment variable, depending on `a_is_dotnet'.
		require
			is_valid_environment: is_valid_environment
		do
				-- Now we set the ISE_PRECOMP environment variable with the precompiled library path.
				-- Note that if it was already set, the value stays the same.
			set_environment (precompilation_path (a_is_dotnet).name, {EIFFEL_CONSTANTS}.ise_precomp_env)
		end

feature {NONE} -- Helpers

	path_under_compiler_profile (a_path: READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- To avoid editing value of variable (like ISE_LIBRARY) when compiling against specific compiler profile
			-- modify the value of the related environment variable.
		local
			p: PATH
		do
			if compiler_profile.is_compatible_mode and a_path.substring_index ("compatible", 1) = 0 then
				create p.make_from_string (a_path)
				Result := p.extended ("compatible").name
			elseif compiler_profile.is_experimental_mode and a_path.substring_index ("experimental", 1) = 0 then
				create p.make_from_string (a_path)
				Result := p.extended ("experimental").name
			else
				Result := a_path
			end
		end

	environment: ENVIRONMENT_ACCESS
			-- Shared access to an instance of {ENVIRONMENT_ACCESS}.
		once
			create Result
		end

feature -- IL environment

	default_il_environment: IL_ENVIRONMENT_I
			-- Default il environment, using the newest available runtime.
		once
			create {IL_ENVIRONMENT} Result
		end

feature -- Query

	user_priority_file_name (a_file_path: PATH; a_must_exist: BOOLEAN): detachable PATH
			-- Retrieve a Eiffel installation file, taking a user replacement as priority
		require
			a_file_name_attached: a_file_path /= Void
			not_a_file_is_empty: not a_file_path.is_empty
		local
			l_install: READABLE_STRING_32
			l_extension: READABLE_STRING_32
			l_actual_file: RAW_FILE
			l_file_name: READABLE_STRING_32
		do
			l_file_name := a_file_path.name
			l_install := install_path.name
			if l_install.count < l_file_name.count then
				if l_file_name.substring_index (l_install, 1) = 1 and l_file_name.valid_index (l_install.count + 2) then
						-- We do +2 to remove the directory separator from the common part
						-- between `l_file_name' and `l_install'.
					l_extension := l_file_name.substring (l_install.count + 2, l_file_name.count)
					Result := user_files_path.extended (l_extension)
					create l_actual_file.make_with_path (Result)
					if a_must_exist and then (not l_actual_file.exists or else (l_actual_file.is_device or l_actual_file.is_directory)) then
							-- The file does not exist or is not actually a file.
						Result := Void
					end
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_exists: (Result /= Void and a_must_exist) implies file_path_exists (Result)
		end

	platform_priority_file_name (a_file_name: READABLE_STRING_GENERAL; a_use_simple: BOOLEAN; a_must_exist: BOOLEAN): detachable PATH
			-- Retrieve a Eiffel installation path, taking a platform specific path as a priority
			--
			-- `a_file_name': A base directory to affix with the platform name.
			-- `a_use_simple': True to use the Windows/Unix platform name; False to use ISE_PLATFORM.
			-- `a_must_exist': True if the directory must exist to return a result; False otherwise.
			-- `Result': A platform path or Void if the path does not exist.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_file: STRING_32
			l_path: like platform_priority_path
			i: INTEGER
		do
			create l_file.make_from_string (a_file_name.to_string_32)
			i := l_file.last_index_of (operating_environment.directory_separator, l_file.count)
			if i > 0 then
				l_path := platform_priority_path (l_file.substring (1, i - 1), a_use_simple, a_must_exist)
				if l_path /= Void then
					Result := l_path.extended (l_file.substring (i + 1, l_file.count))
					if a_must_exist and then not file_path_exists (Result) then
							-- The directory does not exist
						Result := Void
					end
				end

			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_exists: (Result /= Void and a_must_exist) implies file_path_exists (Result)
		end

	platform_priority_path (a_dir: READABLE_STRING_GENERAL; a_use_simple: BOOLEAN; a_must_exist: BOOLEAN): detachable PATH
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
			create Result.make_from_string (a_dir)
			if a_use_simple then
				if {PLATFORM}.is_windows then
					Result := Result.extended (windows_name)
				else
					Result := Result.extended (unix_name)
				end
			else
				l_platform := eiffel_platform
				if not l_platform.is_empty then
					Result := Result.extended (l_platform)
				elseif a_must_exist then
					Result := Void
				else
				end
			end
			if a_must_exist and then Result /= Void and then not directory_path_exists (Result) then
					-- The directory does not exist
				Result := Void
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			result_exists: (Result /= Void and a_must_exist) implies directory_path_exists (Result)
		end

	docs_path: PATH
			-- Folder contains Eiffel documentation.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_share_path.extended (docs_name).extended (unix_product_version_name)
			else
				Result := install_path.extended (docs_name)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Directories (top-level)

	install_path: PATH
			-- Absolute path to the Eiffel installation.
			--
			-- Note: This is the Eiffel installation location for most platforms but you should
			--       be using the platform independent `shared_path'.
		require
			is_valid_environment: is_valid_environment
		local
			l_wk_path: PATH
			u: FILE_UTILITIES
		once
			if is_unix_layout then
				Result := shared_path
			else
				Result := eiffel_install
			end
			check result_attached: Result /= Void end
			if is_workbench then
				l_wk_path := Result.appended ("_").appended (wkbench_suffix)
				if u.directory_path_exists (l_wk_path) then
						-- The workbench version exists, so use that directory instead.
					Result := l_wk_path
				end
			end
			check
				Result_not_void: Result /= Void
				not_result_is_empty: not Result.is_empty
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	library_path: PATH
			-- Eiffel library path
		require
			is_valid_environment: is_valid_environment
		once
			Result := eiffel_library.extended (library_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	installation_precompilation_path (a_is_dotnet: BOOLEAN): PATH
			-- Eiffel path where the ECFs are located in the installation directory.
			-- With platform: $ISE_EIFFEL/precomp/spec/$ISE_PLATFORM
			-- Without: /usr/share/eiffelstudio-MM.mm/precomp/spec/unix
		require
			is_valid_environment: is_valid_environment
		local
			l_dn_name: STRING_32
		do
			Result := shared_path.extended (precomp_name).extended (spec_name)
			if a_is_dotnet then
					-- Append '-dotnet' to platform name
				create l_dn_name.make (eiffel_platform.count + 7)
				l_dn_name.append_string_general (eiffel_platform)
				l_dn_name.append_string_general ("-dotnet")
				Result := Result.extended (l_dn_name)
			else
				Result := Result.extended (eiffel_platform)
			end

		ensure
			not_result_is_empty: not Result.is_empty
		end

	precompilation_path (a_is_dotnet: BOOLEAN): PATH
			-- Actual location of the precompiled libraries.
			-- When ISE_PRECOMP is defined:
			--   $ISE_PRECOMP
			-- Otherwise if `is_user_files_supported':
			--   On Windows: C:\Users\username\Documents\Eiffel User Files\MM.mm\precomp\spec\$ISE_PLATFORM
			--   On Mac: ~/Eiffel User Files/MM.mm/precomp/spec/$ISE_PLATFORM
			--   On Unix: ~/.es/Eiffel User Files/MM.mm/precomp/spec/$ISE_PLATFORM
			-- Otherwise
			--   $ISE_EIFFEL/precomp/spec/$ISE_PLATFORM
		require
			is_valid_environment: is_valid_environment
		local
			l_value: like get_environment_32
			l_dn_name: STRING_32
		do
			l_value := get_environment_32 ({EIFFEL_CONSTANTS}.ise_precomp_env)
			if l_value = Void or else l_value.is_empty then
				if is_user_files_supported then
					Result := user_files_path.extended (precomp_name).extended (spec_name)
					if a_is_dotnet then
							-- Append '-dotnet' to platform name
						create l_dn_name.make (eiffel_platform.count + 7)
						l_dn_name.append_string_general (eiffel_platform)
						l_dn_name.append_string_general ("-dotnet")
						Result := Result.extended (l_dn_name)
					else
						Result := Result.extended (eiffel_platform)
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

feature -- IRON

	iron_command_name: PATH
			-- path where the iron command is located in the installation directory.
			-- With platform: $ISE_EIFFEL/tools/spec/$ISE_PLATFORM/bin/iron{.exe}
			-- Without: /usr/share/eiffelstudio-MM.mm/tools/iron
		require
			is_valid_environment: is_valid_environment
		do
			Result := application_tools_bin_path.extended (iron_name + executable_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	installation_iron_path: PATH
			-- path where the iron is located in the installation directory.
			-- With platform: $ISE_EIFFEL/tools/iron
			-- Without: /usr/share/eiffelstudio-MM.mm/tools/iron
		require
			is_valid_environment: is_valid_environment
		do
			Result := shared_application_tools_path.extended (iron_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	iron_path: PATH
			-- Actual location of the iron installed libraries.
			-- When IRON_PATH is defined:
			--   $IRON_PATH
			-- Otherwise if ISE_IRON_PATH is defined
			--	 $ISE_IRON_PATH
			-- Otherwise if `is_user_files_supported':
			--   On Windows: C:\Users\username\Documents\Eiffel User Files\MM.mm\iron
			--   On Mac: ~/Eiffel User Files/MM.mm/iron
			--   On Unix: ~/.es/Eiffel User Files/MM.mm/iron
			-- Otherwise
			--   $ISE_EIFFEL/iron
		require
			is_valid_environment: is_valid_environment
		local
			l_value: like get_environment_32
		do
			l_value := get_environment_32 ({EIFFEL_CONSTANTS}.iron_path_env)
			if l_value = Void or else l_value.is_empty then
				l_value := get_environment_32 ({EIFFEL_CONSTANTS}.ise_iron_path_env)
			end
			if l_value = Void or else l_value.is_empty then
				if is_user_files_supported then
					Result := user_files_path.extended (iron_name)
				else
						-- No user file is specified, we use the installation
						-- directory and if this is not writable, users will
						-- get an error.
					Result := installation_iron_path
				end
			else
				create Result.make_from_string (l_value)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature  -- Directories (dotnet)

	assemblies_path: PATH
			-- Location of Eiffel Assembly Cache.
			-- If `is_user_files_supported':
			--   On Windows: C:\Users\username\Documents\Eiffel User Files\MM.mm\dotnet\assemblies
			--   On Mac: ~/Eiffel User Files/MM.mm/dotnet/assemblies
			--   On Unix: ~/.es/Eiffel User Files/MM.mm/dotnet/assemblies
			-- Otherwise
			--   $ISE_EIFFEL/dotnet/assemblies

		require
			is_valid_environment: is_valid_environment
		once
			if is_user_files_supported then
				Result := user_files_path
			else
					-- No user file is specified, we use the installation
					-- directory and if this is not writable, users will
					-- get an error.
				Result := install_path
			end
			Result := Result.extended (dotnet_name).extended (assemblies_name)
			if use_json_dotnet_md_cache then
				Result := Result.extended ("json")
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	emdc_command_name: PATH
			-- Complete path to `emdc'.
		require
			is_valid_environment: is_valid_environment
		once
			Result := bin_path.extended (emdc_name).appended (executable_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	nemdc_command_name: PATH
			-- Complete path to `nemdc'.
		require
			is_valid_environment: is_valid_environment
		once
			Result := bin_path.extended ("netcore").extended (nemdc_name).appended (executable_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Cache settings		

	check_dotnet_environment
			-- Check .Net environment
		do
			if
				not {PLATFORM}.is_windows
			then
					-- On non Windows platform (Linux, ...), always use "emdc".
				use_emdc_consumer := True
			elseif
				attached get_environment_32 ("ISE_EMDC") as v1 and then v1.count > 0 and then
				not (v1.is_case_insensitive_equal ("false") or v1.is_case_insensitive_equal ("no"))
			then
				use_emdc_consumer := True
			else
				use_emdc_consumer := False
			end
			update_use_json_dotnet_md_cache
		end

	update_use_json_dotnet_md_cache
			-- Update `use_json_dotnet_md_cache` accordingly to `use_emdc_consumer` and the environment.
		do
			if use_emdc_consumer then
					-- By default, use JSON content
				use_json_dotnet_md_cache := True

					-- unless ISE_EMDC_JSON is "false"
				if
					attached get_environment_32 ("ISE_EMDC_JSON") as v2 and then
					v2.count > 0 and then
					( v2.is_case_insensitive_equal ("false")
					  or v2.is_case_insensitive_equal ("no")
					)
				then
					use_json_dotnet_md_cache := False
				end
			else
				use_json_dotnet_md_cache := False
			end
		end

	use_emdc_consumer: BOOLEAN
			-- Use emdc executable as .Net meta consumer?

	use_json_dotnet_md_cache: BOOLEAN
			-- Use JSON for cache storage.

	set_use_emdc_consumer (b: BOOLEAN; a_permanent: BOOLEAN)
			-- Set `use_emdc_consumer` to `b`
			-- and if `a_permanent` is True, update the environment accordingly	
		do
			use_emdc_consumer := b
			if a_permanent then
				if b then
					environment.set_application_item ("ISE_EMDC", application_name, version_name, "true")
				else
					environment.set_application_item ("ISE_EMDC", application_name, version_name, "false")
				end
			end
			update_use_json_dotnet_md_cache
		end

	set_use_json_dotnet_md_cache (b: BOOLEAN; a_permanent: BOOLEAN)
			-- Set `use_json_dotnet_md_cache` to `b`
			-- and if `a_permanent` is True, update the environment accordingly
		do
			use_json_dotnet_md_cache := b
			if a_permanent then
				if b then
					environment.set_application_item ("ISE_EMDC_JSON", application_name, version_name, "true")
				else
					environment.set_application_item ("ISE_EMDC_JSON", application_name, version_name, "false")
				end
			end
		end

feature -- Directories (distribution)

	bitmaps_path: PATH
			-- Path containing the bitmaps for the graphical environment.
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.extended (bitmaps_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	built_ins_path (a_is_platform_neutral, a_is_dotnet: BOOLEAN): PATH
			-- Path where implementation for `built_ins' are found.
		require
			is_valid_environment: is_valid_environment
		local
			n: READABLE_STRING_GENERAL
		do
			if a_is_platform_neutral then
				n := neutral_name
			else
				if a_is_dotnet then
					n := dotnet_name
				else
					n := classic_name
				end
			end
			Result := shared_application_path.extended (built_ins_name).extended (n)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	config_path: PATH
			-- Path containing the Eiffel compiler configuration files.
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.extended ("config")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	generation_templates_path: PATH
			-- Path containing the Eiffel compiler code generation template files.
		require
			is_valid_environment: is_valid_environment
		once
			Result := config_path.extended (eiffel_platform).extended (templates_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	eifinit_path: PATH
			-- Path containing the Eiffel initialization configuration files.
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.extended ("eifinit")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	filter_path: PATH
			-- Path containing the documentation filters.
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.extended (filters_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	help_path: PATH
			-- Path containing the help files.
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.extended (help_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	error_path: PATH
			-- Path containing the compiler error description files.
		require
			is_valid_environment: is_valid_environment
		once
			Result := help_path.extended (errors_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	default_templates_path: PATH
			-- Path containing the default templates.
		require
			is_valid_environment: is_valid_environment
		once
			Result := help_path.extended (defaults_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	language_path: PATH
			-- Path containing the internationalized mo files.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_locale_path.extended (unix_product_version_name)
			else
				Result := shared_application_path.extended (lang_name).extended (mo_files_name)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	metrics_path: PATH
			-- Location of the metric configuration files
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.extended (metrics_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	profile_path: PATH
			-- Location of the profiler configuration files
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.extended (profiler_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	templates_path: PATH
			-- Path to user code template, to merge with the ones from the installation.
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.extended (templates_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	template_default_path: PATH
			-- Path containing the templates for default Eiffel files.
		require
			is_valid_environment: is_valid_environment
		once
			Result := templates_path.extended (defaults_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	bin_path: PATH
			-- Location of binary compiler components.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_base_path
			else
				Result := shared_application_path.extended (spec_name).extended (eiffel_platform)
			end
			Result := Result.extended (bin_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	application_tools_bin_path: PATH
			-- Location of binary tools components.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_base_path
			else
				Result := shared_application_tools_path.extended (spec_name).extended (eiffel_platform)
			end
			Result := Result.extended (bin_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	runtime_include_path: PATH
			-- Location of Eiffel runtime include files.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_base_path.extended (include_name).extended (unix_product_version_name)
			else
				Result := shared_application_path.extended (spec_name).extended (eiffel_platform).extended (include_name)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	runtime_lib_path: PATH
			-- Location of Eiffel runtime lib files.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_lib_path
			else
				Result := shared_application_path.extended (spec_name).extended (eiffel_platform).extended (lib_name)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	wizards_path: PATH
			-- Location of new project wizards.
		require
			is_valid_environment: is_valid_environment
		once
			Result := lib_application_path.extended (wizards_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	new_project_wizards_path: PATH
			-- Location of new project wizards.
		require
			is_valid_environment: is_valid_environment
		once
			Result := wizards_path.extended ("new_projects")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	precompilation_wizard_resources_path: PATH
			-- Location of precompiled wizard resources
		require
			is_valid_environment: is_valid_environment
		once
			Result := wizards_path.extended ("others").extended ("precompile")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	tools_path: PATH
			-- Path containing the modular files for Eiffel tools.
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_application_path.extended ("tools")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	testing_tool_path: PATH
			-- Path containing testing tool files.
		require
			is_valid_environment: is_valid_environment
		once
			Result := tools_path.extended ("testing")
		end

	auto_test_path: PATH
			-- Path containing auto test specific files
		require
			is_valid_environment: is_valid_environment
		once
			Result := testing_tool_path.extended ("auto_test")
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Directories (top-level user)

	versionless_hidden_files_path (a_create_dir: BOOLEAN): PATH
			-- Hidden application configuration Eiffel files for version `a_version` (formatted as MM.mm).
			-- With ISE_APP_DATA defined:
			--   $ISE_APP_DATA
			-- When hidden files is available:
			--   On Windows: C:\Users\username\AppData\Local\Eiffel Software\.es\MM.mm
			--   On Unix & Mac: ~/.es/MM.mm
			-- Otherwise we use a subdirectory of `user_files_path':
			--   `user_files_path'\settings
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		once
				-- Attempt to use home location.
			if
				operating_environment.home_directory_supported and then
				attached environment.home_directory_path as l_home
			then
				Result := l_home
				if a_create_dir then
					safe_create_dir (Result)
				end

				if {PLATFORM}.is_windows then
					Result := Result.extended (eiffel_software_name)
				end
				Result := Result.extended (hidden_directory_name)
				if a_create_dir then
					safe_create_dir (Result)
				end
			else
					-- No user set variable or the home directory is not supported
				if a_create_dir then
					safe_create_dir (user_files_path)
				end
				Result := versionless_user_files_path (a_create_dir).extended (settings_name)
				if a_create_dir then
					safe_create_dir (Result)
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	hidden_files_path_for_version (a_version: READABLE_STRING_GENERAL; a_create_dir: BOOLEAN): PATH
			-- Hidden application configuration Eiffel files for version `a_version` (formatted as MM.mm).
			-- With ISE_APP_DATA defined:
			--   $ISE_APP_DATA
			-- When hidden files is available:
			--   On Windows: C:\Users\username\AppData\Local\Eiffel Software\.es\MM.mm
			--   On Unix & Mac: ~/.es/MM.mm
			-- Otherwise we use a subdirectory of `user_files_path':
			--   `user_files_path'\settings
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		do
			Result := versionless_hidden_files_path (a_create_dir)
			Result := Result.extended (a_version)
			if a_create_dir then
				safe_create_dir (Result)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	hidden_files_path: PATH
			-- Hidden application configuration Eiffel files.
			-- With ISE_APP_DATA defined:
			--   $ISE_APP_DATA
			-- When hidden files is available:
			--   On Windows: C:\Users\username\AppData\Local\Eiffel Software\.es\MM.mm
			--   On Unix & Mac: ~/.es/MM.mm
			-- Otherwise we use a subdirectory of `user_files_path':
			--   `user_files_path'\settings
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		local
			l_dir: detachable STRING_32
		once
			l_dir := get_environment_32 ({EIFFEL_CONSTANTS}.ise_app_data_env)
			if l_dir = Void or else l_dir.is_empty then
				Result := hidden_files_path_for_version (version_name, True)
			else
					-- Use environment variable
				create Result.make_from_string (l_dir)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	versionless_user_files_path (a_create_dir: BOOLEAN): PATH
			-- User based Eiffel files which are generally visible to the users for version `a_version`.
			-- Create dir only if `a_create_dir` is True.
			-- With ISE_USER_FILES is defined:
			--   $ISE_USER_FILES
			-- Otherwise
			--   On Windows: C:\Users\username\Documents\Eiffel User Files\MM.mm
			--   On Mac: ~/Eiffel User Files/MM.mm
			--   On Unix: ~/.es/Eiffel User Files/MM.mm
			-- When purge the ES stored configuration data, it will not erase the files
			-- under this path
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		local
			l_dir: detachable STRING_32
			l_needs_suffix: BOOLEAN
		once
				-- If user have set the ISE_USER_FILES environment variable, use it.
			check attached user_directory_name as l_user_directory_name then
					-- On Unix platform only, the files will be located under the hidden directory
					-- where EiffelStudio stores settings, otherwise it is in the home directory
					-- of the user (i.e. not hidden).
				Result := l_user_directory_name
				if not {PLATFORM}.is_windows and then not {PLATFORM}.is_mac then
					Result := Result.extended (hidden_directory_name)
					if a_create_dir then
						safe_create_dir (Result)
					end
					l_needs_suffix := False
				else
						-- We need to add a suffix if we are in workbench mode
						-- as otherwise we would be using the same path as finalized.
					l_needs_suffix := True
				end

					-- Now we can freely create our directory structure for `user_files'.
				create l_dir.make (30)
					-- On Unix platform only, we use a lower case version of the directory
					-- without space.
				if not {PLATFORM}.is_windows and then not {PLATFORM}.is_mac then
					l_dir.append_string_general (product_name.as_lower)
					l_dir.append_string_general ("_user_files")
				else
					l_dir.append_string_general (product_name)
					l_dir.append_string_general (" User Files")
				end
				if is_workbench and l_needs_suffix then
					l_dir.append_character (' ')
					l_dir.append_character ('(')
					l_dir.append_string_general (wkbench_suffix)
					l_dir.append_character (')')
				end
				Result := Result.extended (l_dir)
				if a_create_dir then
					safe_create_dir (Result)
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	user_files_path_for_version (a_version: READABLE_STRING_GENERAL; a_create_dir: BOOLEAN): PATH
			-- User based Eiffel files which are generally visible to the users for version `a_version`.
			-- Create dir only if `a_create_dir` is True.
			-- With ISE_USER_FILES is defined:
			--   $ISE_USER_FILES
			-- Otherwise
			--   On Windows: C:\Users\username\Documents\Eiffel User Files\MM.mm
			--   On Mac: ~/Eiffel User Files/MM.mm
			--   On Unix: ~/.es/Eiffel User Files/MM.mm
			-- When purge the ES stored configuration data, it will not erase the files
			-- under this path
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		do
			Result := versionless_user_files_path (a_create_dir)
				-- Per version directory structure to avoid clutter.
			Result := Result.extended (a_version)
			if a_create_dir then
				safe_create_dir (Result)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	user_files_path: PATH
			-- User based Eiffel files which are generally visible to the users
			-- With ISE_USER_FILES is defined:
			--   $ISE_USER_FILES
			-- Otherwise
			--   On Windows: C:\Users\username\Documents\Eiffel User Files\MM.mm
			--   On Mac: ~/Eiffel User Files/MM.mm
			--   On Unix: ~/.es/Eiffel User Files/MM.mm
			-- When purge the ES stored configuration data, it will not erase the files
			-- under this path
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		local
			l_dir: detachable STRING_32
		once
				-- If user have set the ISE_USER_FILES environment variable, use it.
			l_dir := get_environment_32 ({EIFFEL_CONSTANTS}.ise_user_files_env)
			if l_dir = Void or else l_dir.is_empty then
				Result := user_files_path_for_version (version_name, True)
			else
					-- Use environment variable
				create Result.make_from_string (l_dir)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Private Settings Directories

	projects_data_path: PATH
			-- Path to settings for all projects loaded by EiffelStudio.
			--| This contains for each ECF file loaded by EiffelStudio the target
			--| and location where project is compiled.
			--| They are hidden by default to the user.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		once
			Result := hidden_files_path.extended (projects_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	docking_data_path_for_version (a_version_name: READABLE_STRING_GENERAL; a_create_dir: BOOLEAN): PATH
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		do
			Result := hidden_files_path_for_version (a_version_name, a_create_dir).extended (docking_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	docking_data_path: PATH
			-- Path to docking settings for EiffelStudio.
			--| They are hidden by default to the user.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		once
			Result := docking_data_path_for_version (version_name, True)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	session_data_path: PATH
			-- Path to session data associated to a project loaded by EiffelStudio.
			--| They are hidden by default to the user.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		once
			Result := hidden_files_path.extended (session_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	temporary_path: PATH
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

			Result := hidden_files_path.extended ("tmp")
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- User Directories

	user_templates_path: PATH
				-- Path to user code template, to merge with the ones from the installation.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
		once
			Result := user_files_path.extended (templates_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	user_projects_path: PATH
			-- Location of Eiffel projects.
		local
			l_var: detachable STRING_32
		once
			l_var := get_environment_32 ({EIFFEL_CONSTANTS}.ise_projects_env)
			if l_var = Void or else l_var.is_empty then
				if {PLATFORM}.is_windows or else {PLATFORM}.is_mac then
					Result := user_files_path.extended (projects_name)
				elseif operating_environment.home_directory_supported and then attached environment.home_directory_path as l_home then
					Result := l_home
				else
						-- FIXME: What path should we put there?
					create Result.make_from_string ("\Invalid path")
				end
			else
				create Result.make_from_string (l_var)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Files

	default_config_file_name: PATH
			-- Default Eiffel confiration file name location for non-SCOOP projects.
		require
			is_valid_environment: is_valid_environment
		once
			Result := default_templates_path.extended (default_config_file)
			if is_user_files_supported then
					-- Check user override file.
				if attached user_priority_file_name (Result, True) as l_user then
					Result := l_user
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	default_scoop_config_file_name: PATH
			-- Default Eiffel confiration file name location for SCOOP projects.
		require
			is_valid_environment: is_valid_environment
		once
			Result := default_templates_path.extended (default_scoop_config_file)
			if is_user_files_supported then
					-- Check user override file.
				if attached user_priority_file_name (Result, True) as l_user then
					Result := l_user
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	predefined_metrics_file: PATH
			-- File to store predefined metrics
		require
			is_valid_environment: is_valid_environment
		once
			Result := metrics_path.extended ("predefined_metrics.xml")
			if is_user_files_supported then
					-- Check user override file.
				if attached user_priority_file_name (Result, True) as l_user then
					Result := l_user
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	compiler_configuration: PATH
			-- Platform specific system level resource specification file
			-- ($ISE_EIFFEL/eifinit/application_name/spec/$ISE_PLATFORM)
		require
			is_valid_environment: is_valid_environment
		once
			Result := eifinit_path.extended ("general.cfg")
			if is_user_files_supported then
					-- Check user override file.
				if attached user_priority_file_name (Result, True) as l_user then
					Result := l_user
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	msil_culture_name: PATH
			-- Culture specification file
		require
			is_valid_environment: is_valid_environment
			is_windows: {PLATFORM}.is_windows
		once
			Result := eifinit_path.extended (spec_name).extended (platform_abstraction).extended ("culture")
			if is_user_files_supported then
					-- Check user override file.
				if attached user_priority_file_name (Result, True) as l_user then
					Result := l_user
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	libraries_config_name: PATH
			-- Libraries lookup configuration file name
		require
			is_valid_environment: is_valid_environment
		once
			Result := eifinit_path.extended ("libraries.cfg")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	precompiles_config_name: PATH
			-- Precompiled libraries lookup configuration file name
		require
			is_valid_environment: is_valid_environment
		once
			Result := eifinit_path.extended ("precompiles.cfg")
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Files (user)

	user_docking_file_name (a_file_name: STRING): PATH
			-- Path of standard docking layout.
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			Result := docking_data_path.extended (a_file_name + "." + docking_file_extension)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	user_docking_standard_file_name (a_window_id: NATURAL_32): like user_docking_file_name
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

	user_docking_debug_file_name (a_window_id: NATURAL_32): like user_docking_file_name
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

	user_external_command_file_name (a_file_name: READABLE_STRING_GENERAL): PATH
			-- Path to external commands ini file
		require
			is_valid_environment: is_valid_environment
			is_user_files_supported: is_user_files_supported
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		do
			Result := user_files_path.extended (a_file_name).appended_with_extension ("ini")
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Directories (platform independent)

	shared_path: PATH
			-- Location of shared files (platform independent).
			-- With platform: $ISE_EIFFEL.
			-- Without: /usr/share/eiffelstudio-MM.mm
		require
			is_valid_environment: is_valid_environment
		local
			l_wk_path: PATH
			u: FILE_UTILITIES
		once
			if is_unix_layout then
				Result := unix_layout_share_path.extended (unix_product_version_name)
			else
				Result := eiffel_install
			end
			if is_workbench then
				l_wk_path := Result.appended ("_").appended (wkbench_suffix)
				if u.directory_path_exists (l_wk_path) then
						-- The workbench version exists, so use that directory instead.
					Result := l_wk_path
				end
			end
			check
				not_result_is_empty: not Result.is_empty
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	shared_application_path: PATH
			-- Location of shared files specific for the current application (platform independent).
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_path.extended (distribution_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	shared_application_tools_path: PATH
			-- Location of shared files specific for the current application's tools (platform independent).
		require
			is_valid_environment: is_valid_environment
		once
			Result := shared_path.extended (distribution_tools_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	lib_path: PATH
			-- Location of libs files (platform dependent).
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_lib_path.extended (unix_product_version_name)
			else
				Result := install_path.twin
			end
			if compiler_profile.is_experimental_mode then
				Result := Result.extended ("experimental")
			elseif compiler_profile.is_compatible_mode then
				Result := Result.extended ("compatible")
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	lib_application_path: PATH
			-- Location of lib files specific for the current application (platform dependent).
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := unix_layout_lib_path.extended (unix_product_version_name)
			else
				Result := install_path
			end
			Result := Result.extended (distribution_name)
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Files (commands)

	estudio_command_name: PATH
			-- Complete path to `estudio'.
		require
			is_valid_environment: is_valid_environment
		once
			Result := bin_path.extended (estudio_name + executable_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	ec_command_name: PATH
			-- Absolute path to `ec'.
		require
			is_valid_environment: is_valid_environment
		local
			l_args: ARGUMENTS_32
			fut: FILE_UTILITIES
			l_ec_name: like ec_name
			p: PATH
		once
			if is_workbench and (attached application_name as appname and then appname.same_string ("ec")) then
					-- We have to launch ourself to perform a compilation that would make sense
					-- but only if we are the `ec' application, not if we are something else.
				create l_args
				create Result.make_from_string (l_args.command_name)
			else
				l_ec_name := ec_name
				create p.make_from_string (l_ec_name)
				if p.is_absolute and then fut.file_path_exists (p) then
					Result := p
				else
					Result := bin_path.extended (l_ec_name + executable_suffix)
				end
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	studio_command_line (a_ecf: detachable PATH; a_target: detachable READABLE_STRING_GENERAL; a_project_path: detachable PATH; a_is_gui, a_is_clean: BOOLEAN): STRING_32
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
				Result.append (estudio_command_name.name)
			else
				Result.append (ec_command_name.name)
			end
			Result.append_character ('%"')
			l_profile := compiler_profile.command_line
			if not l_profile.is_empty then
				Result.append_character (' ')
				Result.append_string_general (l_profile)
			end
			if a_is_clean then
				Result.append_string_general (" -clean")
			end
			if a_ecf /= Void and then not a_ecf.is_empty then
				Result.append_string_general (" -config %"")
				Result.append (a_ecf.name)
				Result.append_character ('%"')
			end
			if a_target /= Void and then not a_target.is_empty then
				Result.append_string_general (" -target %"")
				Result.append_string_general (a_target)
				Result.append_character ('"')
			end
			if a_project_path /= Void and then not a_project_path.is_empty then
				Result.append_string_general (" -project_path %"")
				Result.append (a_project_path.name)
				Result.append_character ('"')
			end
		end

	freeze_command_name: PATH
		require
			is_valid_environment: is_valid_environment
		once
			Result := bin_path.extended (finish_freezing_script + executable_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	emake_command_name: PATH
			-- Complete path to `emake'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := lib_application_path
			else
				Result := bin_path
			end
			Result := Result.extended (emake_name + executable_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	quick_finalize_command_name: PATH
			-- Complete path to `quick_finalize'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := lib_application_path
			else
				Result := bin_path
			end
			Result := Result.extended (quick_finalize_name + executable_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	x2c_command_name: PATH
			-- Complete path to `x2c'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := lib_application_path
			else
				Result := bin_path
			end
			Result := Result.extended (x2c_name + executable_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	prelink_command_name: PATH
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := lib_application_path
			else
				Result := bin_path
			end
			Result := Result.extended (prelink_name + executable_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	ecdbgd_command_name: PATH
			-- Complete path to `ecdbgd'.
		require
			is_valid_environment: is_valid_environment
		once
			if is_unix_layout then
				Result := lib_application_path
			else
				Result := bin_path
			end
			Result := Result.extended (ecdbg_name + executable_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	compile_library_command_name: PATH
			-- Complete path to `compile_library.bat'.
		require
			is_valid_environment: is_valid_environment
			is_windows: {PLATFORM}.is_windows
		once
			Result := bin_path.extended ("compile_library.bat")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	precompilation_wizard_command_name: PATH
			-- Command to be executed to launch the precompilation wizard.
		require
			is_valid_environment: is_valid_environment
		once
			Result := precompilation_wizard_resources_path.extended (spec_name).extended (eiffel_platform).extended ("wizard" + executable_suffix)
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

	ec_name: STRING_32
			-- Full executable name of ec.
		local
			l_var: like get_environment_32
		once
			l_var := get_environment_32 ({EIFFEL_CONSTANTS}.ec_name_env)
			if l_var /= Void then
				Result := l_var
			else
				create Result.make (6)
				Result.append ({STRING_32} "ec")
				Result.append_string_general (release_suffix)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	finish_freezing_script: STRING_32
			-- Name of post-eiffel compilation processing to launch C code.
		once
			Result := {STRING_32} "finish_freezing"
			Result.append_string_general (release_suffix)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	quick_finalize_name: STRING_32 = "quick_finalize"
			-- Name of estudio command

	x2c_name: STRING_8 = "x2c"
			-- Complete path to `x2c'.

	emake_name: STRING_32 = "emake"
			-- Name of emake command.

	prelink_name: STRING_8 = "prelink"
			-- Name of estudio command.

	ecdbg_name: STRING_8 = "ecdbgd"
			-- Name of console line debugger command.

	emdc_name: STRING_8 = "emdc"
			-- Name of the .Net metadata consumer executable (emdc).

	nemdc_name: STRING_8 = "nemdc"
			-- Name of the .Net CORE metadata consumer executable (emdc).

feature {NONE} -- Configuration of layout

	unix_layout_base_path: PATH
			-- Base for the Unix layout. e.g. "/usr".
		once
			create Result.make_from_string ("/usr")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	unix_layout_share_path: PATH
			-- share for the Unix layout. e.g. "/usr/share".
		once
			Result := unix_layout_base_path.extended ("share")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	unix_layout_lib_path: PATH
			-- Directory name for lib. e.g. "/usr/lib".
		once
			Result := unix_layout_base_path.extended ("lib")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	unix_layout_locale_path: PATH
			-- Directory name for lib. e.g. "/usr/share/locale"
		once
			Result := unix_layout_share_path.extended ("locale")
		ensure
			not_result_is_empty: not Result.is_empty
		end

	unix_layout_platform: STRING_8 = "unix";
			-- Platform to use for the Unix layout.

feature -- Environment access

	get_environment_8 (a_var: READABLE_STRING_GENERAL): detachable STRING_8
			-- Get `a_var' from the environment, taking into account the `application_name' to lookup the defaults.
		require
			a_var_attached: a_var /= Void
			not_a_var_is_empty: not a_var.is_empty
		do
			if attached get_environment_32 (a_var) as l_string then
				Result := l_string.to_string_8
			end
		end

	get_environment_32 (a_var: READABLE_STRING_GENERAL): detachable STRING_32
			-- Get `a_var' from the environment, taking into account the `application_name' to lookup the defaults.
		require
			a_var_attached: a_var /= Void
			not_a_var_is_empty: not a_var.is_empty
		do
			Result := environment.application_item (a_var, application_name, version_name)
		end

feature -- Environment update

	set_environment (a_value, a_var: READABLE_STRING_GENERAL)
			-- Update environment variable `a_key' to be `a_value'.
		require
			a_var_ok: a_var /= Void and then not a_var.is_empty and then not a_var.has ('%U')
			a_value_ok: a_value /= Void and then not a_value.has ('%U')
		do
			environment.put (a_value, a_var)
		ensure
			value_updated: attached get_environment_32 (a_var) as v implies v.same_string_general (a_value)
		end

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

	safe_create_dir (a_dir: PATH)
			-- Try to create a directory `a_dir'.
		require
			a_dir_not_void: a_dir /= Void
		local
			u: FILE_UTILITIES
		do
			u.create_directory (a_dir.name)
		end

	safe_recursive_create_dir (a_dir: PATH)
			-- Try to create a directory `a_dir'.
		require
			a_dir_not_void: a_dir /= Void
		local
			u: FILE_UTILITIES
		do
			u.create_directory (a_dir.name)
		end

feature -- Environment variables

	eiffel_install: PATH
			-- ISE_EIFFEL name
		do
			if attached get_environment_32 ({EIFFEL_CONSTANTS}.ise_eiffel_env) as l_result then
				remove_trailing_dir_separator (l_result)
				create Result.make_from_string (l_result)
			else
				create Result.make_from_string (".") -- Current Working Directory
			end
		ensure
			not_result_is_empty: is_valid_environment implies not Result.is_empty
		end

	eiffel_c_compiler: STRING_8
			-- ISE_C_COMPILER name.
		require
			windows: {PLATFORM}.is_windows
		do
			if attached get_environment_32 ({EIFFEL_CONSTANTS}.ise_c_compiler_env) as l_result then
				Result := l_result.to_string_8
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
			if attached get_environment_32 ({EIFFEL_CONSTANTS}.ise_c_compiler_ver_env) as l_result then
				Result := l_result.to_string_8
			else
				Result := ""
			end
		end

	eiffel_platform: STRING_8
			-- ISE_PLATFORM name.
		do
			if attached get_environment_32 ({EIFFEL_CONSTANTS}.ise_platform_env) as l_result then
				Result := l_result.to_string_8
			else
				Result := ""
			end
		ensure
			not_result_is_empty: is_valid_environment implies not Result.is_empty
		end

	eiffel_library: PATH
			-- ISE_LIBRARY directory name.
		require
			is_valid_environment: is_valid_environment
		do
			if attached get_environment_32 ({EIFFEL_CONSTANTS}.ise_library_env) as l_result then
				remove_trailing_dir_separator (l_result) -- may be useless with PATH
				create Result.make_from_string (l_result)
			else
				create Result.make_from_string (".") -- Current Working Directory ...
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
			-- Default ECF file name for non-SCOOP projects.

	default_scoop_config_file: STRING_8 = "default-scoop.ecf"
			-- Default ECF file name for SCOOP projects.

feature -- Directory constants (platform)

	dotnet_name: STRING_32 = "dotnet"
			-- .NET folder name.

	neutral_name: STRING_32 = "neutral"
			-- Neutral platform folder name.

	classic_name: STRING_32 = "classic"
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

	distribution_tools_name: STRING_8
			-- Name of tools distribution.
			--
			--| Redefine for alternative tools distributions.
		once
			Result := "tools"
		ensure
			not_result_is_empty: not Result.is_empty
		end

	docs_name: STRING = "docs"
			-- Documentation folder name.

	library_name: STRING = "library"
			-- Library folder name.

	precomp_name: STRING = "precomp"
			-- Precompile library location

	iron_name: STRING = "iron"
			-- Iron libraries location

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

	built_ins_name: STRING_32 = "built_ins"
			-- Built-in code classes folder name.

	defaults_name: STRING_8 = "defaults"
			-- Default templates folder name.

	errors_name: STRING_32 = "errors"
			-- Error file descriptions folder name.

	etc_name: STRING_8 = "etc"
			-- Etc library folder name

	filters_name: STRING_8 = "filters"
			-- Documentation filters folder name.

	help_name: STRING_32 = "help"
			-- Help files folder name.

	include_name: STRING_8 = "include"
			-- External include folder name

	lang_name: STRING_8 = "lang"
			-- Language folder name.

	lib_name: STRING_8 = "lib"
			-- External library folder name

	metrics_name: STRING_32 = "metrics"
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

	remove_trailing_dir_separator (a_dir: STRING_GENERAL)
			-- Removes the trailing directory separator of a directory.
		require
			a_dir_attached: a_dir /= Void
		local
			l_count: INTEGER
			dirsep: NATURAL_32
		do
			if not a_dir.is_empty then
				l_count := a_dir.count
				dirsep := operating_environment.directory_separator.natural_32_code
				if
					l_count > 1 and then a_dir.code (l_count) = dirsep and then
					l_count > 2 and then a_dir.code (l_count - 1) /= dirsep
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

	hidden_directory_name: STRING_32
			-- Name of the hidden_directory where settings will be stored on Unix based platforms.
		once
			create Result.make_from_string_general (".es")
			if is_workbench then
				Result.append_character ('_')
				Result.append_string_general (wkbench_suffix)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	user_directory_name: detachable PATH
			-- Directory name corresponding to the user directory
			-- On Windows: C:\Users\username\Documents
			-- On Unix & Mac: $HOME
		once
			Result := environment.user_directory_path
		end

feature -- Preferences

	Eiffel_preferences: STRING_32
			-- Preferences location
		require
			is_valid_environment: is_valid_environment
		once
			Result := eiffel_preferences_for_version (version_name, True)
		ensure
			not_result_is_empty: not Result.is_empty
		end

	eiffel_preferences_for_version (a_version_name: READABLE_STRING_GENERAL; a_create_dir: BOOLEAN): STRING_32
			-- Preferences location for version `a_version_name`.
		require
			is_valid_environment: is_valid_environment
		local
			p: PATH
			l_prod_version_name: like product_name_for_version
		do
			l_prod_version_name := product_name_for_version (a_version_name)
			if {PLATFORM}.is_windows then
				create Result.make_from_string_general ({STRING_32} "HKEY_CURRENT_USER\SOFTWARE\ISE\")
				if is_workbench then
					Result.append_string_general (wkbench_suffix)
					Result.append_character ('\')
				end
				Result.append_string_general (l_prod_version_name)
				Result.append_character ('\')
				Result.append_string_general (application_name)
				Result.append_string_general ("\Preferences")
			else
				p := hidden_files_path_for_version (version_name, a_create_dir)
				p := p.extended (l_prod_version_name).appended_with_extension ("rc")
				create Result.make_from_string_general (p.name)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	general_preferences: PATH
			-- Platform independent preferences.
		require
			is_valid_environment: is_valid_environment
		once
			Result := eifinit_path.extended ("default.xml")
			if attached user_priority_file_name (Result, True) as l_fn then
				Result := l_fn
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	platform_preferences: PATH
			-- Platform specific preferences.
		once
			Result := eifinit_path.extended (spec_name).extended (platform_abstraction).extended ("default.xml")
			if attached user_priority_file_name (Result, True) as upf then
				Result := upf
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

feature -- Existing installations

	installed_product_version_names: ARRAYED_LIST [STRING]
			-- List of product version name for existing installations.
		local
			s: READABLE_STRING_GENERAL
		once
			if attached environment.installed_product_version_names (Current) as lst then
				create Result.make (lst.count)
				across
					lst as ic
				loop
					s := ic
					if s.is_valid_as_string_8 then
						Result.extend (s.to_string_8)
					end
				end
			else
				create Result.make (0)
			end
		end

	installed_version_names: ARRAYED_LIST [STRING]
			-- List of version name for existing installations.
		local
			s: STRING
			v: STRING
			l_prod_name: STRING
			lst: like installed_product_version_names
		once
			lst := installed_product_version_names
			create Result.make (lst.count)
			l_prod_name := product_name + "_"
			across
				lst as ic
			loop
				s := ic
				if s.starts_with (l_prod_name) then
					v := s.tail (s.count - l_prod_name.count)
				else
					v := s
				end
				if v.is_empty or else not v[1].is_digit then
						-- Expecting major.minor value  (i.e:  23.06...)
				else
					Result.force (v)
				end
			end
		end

feature {NONE} -- Helper

	directory_path_exists (p: PATH): BOOLEAN
			-- Directory path `p' exists?
		local
			u: FILE_UTILITIES
		do
			Result := u.directory_path_exists (p)
		end

	file_path_exists (p: PATH): BOOLEAN
			-- Path `p' exists?
		local
			u: FILE_UTILITIES
		do
			Result := u.file_path_exists (p)
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
