note
	description: "Summary description for {ER_CONSTANTS}."
	date: "$Date$"
	revision: "$Revision$"

class
	ER_MISC_CONSTANTS

inherit
	EIFFEL_ENV
		redefine
			check_environment_variable
		end

feature -- Query

	xml_file_name: STRING = "eiffel_ribbon.xml"
			-- File name for saving ribbon makrup xml file

	bml_file_name: STRING = "ribbon.bml"
			--

	header_file_name: STRING = "ribbon.h"
			--

	rc_file_name: STRING = "eiffelribbon.rc"
			--

	project_configuration_file_name: STRING = "ribbon_project.er"
			--

	tool_info_file_name: STRING = "eiffel_ribbon_info.sed"
			--

	images: DIRECTORY_NAME
			-- Image folder
		do
			Result := eiffel_ribbon
			Result.set_subdirectory ("images")
		end

	eiffel_ribbon: DIRECTORY_NAME
			-- Eiffel ribbon tool folder
		local
			l_retried: BOOLEAN
			l_shared: ER_SHARED_SINGLETON
			l_error: EV_ERROR_DIALOG
			l_interface_names: ER_INTERFACE_NAMES
		do
			if not l_retried then
				if not is_valid_environment then
					check_environment_variable
				end
				create Result.make_from_string (eiffel_install)
				Result.set_subdirectory ("tools")
				Result.set_subdirectory ("ribbon")
			else
				create Result.make
			end
		rescue
			-- `check_environment_variable' may raise exception if environment variable not valid
			 l_retried := True
			create l_shared
			create l_interface_names
			if attached ise_eiffel as l_ise_eiffel then
				create l_error.make_with_text (l_interface_names.cannot_find_ribbon_folders (l_ise_eiffel))
			else
				create l_error.make_with_text (l_interface_names.ise_eiffel_not_defined)
			end

			l_error.set_buttons (<<l_interface_names.ok>>)
			if attached l_shared.main_window_cell.item as l_win then
				l_error.show_modal_to_window (l_win)
			else
				l_error.show
			end

			retry
		end

	ise_eiffel: detachable STRING
			-- $ISE_EIFFEL value if exists
		do
			Result := get_environment ({EIFFEL_ENVIRONMENT_CONSTANTS}.ise_eiffel_env)
		end

	template: DIRECTORY_NAME
			-- Template folder name
		do
			Result := eiffel_ribbon
			Result.set_subdirectory ("template")
		end

	xml_full_file_name: detachable STRING_8
			-- (export status {NONE})
		local
			l_singleton: ER_SHARED_SINGLETON
			l_file_name: detachable FILE_NAME
			l_constants: ER_MISC_CONSTANTS
		do
			create l_singleton
			if attached l_singleton.Project_info_cell.item as l_info then
				if attached l_info.project_location as l_location then
					create l_file_name.make_from_string (l_location)
					create l_constants
					l_file_name.set_file_name (l_constants.Xml_file_name)
					Result := l_file_name
				end
			end
		end

	project_full_file_name: detachable STRING
			--
		local
			l_singleton: ER_SHARED_SINGLETON
			l_file_name: detachable FILE_NAME
		do
			create l_singleton
			if attached l_singleton.project_info_cell.item as l_info then
				if attached l_info.project_location as l_location and then not l_location.is_empty then
					create l_file_name.make_from_string (l_location)
					l_file_name.set_file_name (project_configuration_file_name)
				end
			end
			Result := l_file_name
		end

feature {NONE} -- Implementation

	application_name: STRING
			-- <Precursor>
		do
			Result := "eiffelribbon"
		end

	check_environment_variable
			-- <Precursor>
			-- If cannot find eiffelribbon info in registry, don't die, raise an exception instead
		local
			l_product_names: PRODUCT_NAMES
			l_op_env: like operating_environment
			l_file: RAW_FILE
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
				l_value := get_environment ({EIFFEL_ENVIRONMENT_CONSTANTS}.ise_eiffel_env)
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
					io.error.put_string (": the environment variable " + {EIFFEL_ENVIRONMENT_CONSTANTS}.ise_eiffel_env + " points to a non-existing directory.%N")
					l_is_valid := False
				else
						-- Set the environment variable, as it may have come from the Windows registry.
					set_environment (l_value, l_variable.var)
				end
				l_variables.forth
			end

			if not l_is_valid then
				(create {EXCEPTIONS}).raise ("Invalid environment")
			else
				-- The environment is valid
				is_valid_environment := True

					-- Set new ISE_EIFFEL variable. This is done to ensure that the workbench path is
					-- set correctly, or if in unix layout that ISE_EIFFEL is set
				if not is_unix_layout then
					set_environment (shared_path, {EIFFEL_ENVIRONMENT_CONSTANTS}.ise_eiffel_env)
				end

					-- Set Unix platform
				if is_unix_layout then
					l_value := get_environment ({EIFFEL_ENVIRONMENT_CONSTANTS}.ise_platform_env)
					if l_value = Void or else l_value.is_empty then
							-- Set platform for Unix
						set_environment (unix_layout_platform, {EIFFEL_ENVIRONMENT_CONSTANTS}.ise_platform_env)
					end
				end

				create l_dir.make (bin_path)
				if not l_dir.exists then
					io.error.put_string (l_product_names.workbench_name)
					io.error.put_string (": the path $" + {EIFFEL_ENVIRONMENT_CONSTANTS}.ise_eiffel_env + "/studio/spec/$" + {EIFFEL_ENVIRONMENT_CONSTANTS}.ise_platform_env + "/bin points to a non-existing directory!%N")
					(create {EXCEPTIONS}).die (-1)
				end
			end

				-- Make sure to define ISE_LIBRARY if not defined.
			l_value := get_environment ({EIFFEL_ENVIRONMENT_CONSTANTS}.ise_library_env)
			if l_value = Void or else l_value.is_empty then
				set_environment (lib_path, {EIFFEL_ENVIRONMENT_CONSTANTS}.ise_library_env)
			else
					-- To avoid having to edit the value of ISE_LIBRARY when compiling against
					-- a certain compiler profile, we modify the value of the ISE_LIBRARY environment
					-- variable.
				if is_compatible_mode and l_value.substring_index ("compatible", 1) = 0 then
					create l_dir_name.make_from_string (l_value)
					l_dir_name.extend ("compatible")
					set_environment (l_dir_name, {EIFFEL_ENVIRONMENT_CONSTANTS}.ise_library_env)
				end
			end

				-- Make sure to define ISE_USER_SETTINGS if not defined.
			l_value := get_environment ({EIFFEL_ENVIRONMENT_CONSTANTS}.ise_user_files_env)
			if l_value = Void or else l_value.is_empty then
				set_environment (user_files_path, {EIFFEL_ENVIRONMENT_CONSTANTS}.ise_user_files_env)
			end

			if is_valid_environment then
				create_directories

					-- Check that `eiffel_home' exists.
				create l_file.make (eiffel_home)
				if not l_file.exists or else not l_file.is_directory then
					safe_create_dir (eiffel_home)
					create l_dir.make (eiffel_home)
					is_valid_home := l_dir.exists
				else
					is_valid_home := True
				end
			end
		end
end
