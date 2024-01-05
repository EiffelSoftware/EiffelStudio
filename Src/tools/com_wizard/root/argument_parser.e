note
	description: "Application argument parser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER
		rename
			make as make_parser
		export
			{NONE} all
			{ANY} execute, has_executed, is_successful
		redefine
			switch_groups,
			switch_dependencies,
			post_process_arguments
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	ANY

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize parser
		do
			make_parser (False)
			set_is_usage_displayed_on_error (False)
			set_is_showing_argument_usage_inline (True)
		end

feature -- Access

	show_graphical_wizard: BOOLEAN
			-- Indicates if the graphical user interface should be shown
		require
			successful: is_successful
		once
			Result := has_option (graphical_switch)
		end

	generate_for_client: BOOLEAN
			-- Indicates if code for and Eiffel client should be generated
		require
			successful: is_successful
		once
			Result := has_option (client_switch)
		end

	generate_for_server: BOOLEAN
			-- Indicates if code for and Eiffel server should be generated
		require
			successful: is_successful
		once
			Result := has_option (server_switch)
		end

	library_definition: READABLE_STRING_32
			-- Library definition file
		require
			successful: is_successful
			generating_from_library: generate_for_client or generate_for_server
		local
			l_opt: ARGUMENT_OPTION
		once
			if generate_for_client then
				l_opt := option_of_name (client_switch)
			elseif generate_for_server then
				l_opt := option_of_name (server_switch)
			end
			check l_opt_attached: l_opt /= Void end
			Result := l_opt.value
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_exists: (create {RAW_FILE}.make_with_name (Result)).exists
		end

	use_destination_folder: BOOLEAN
			-- Indicates if an alternative destination path should be used
		require
			successful: is_successful
			generating_code: generate_for_client or generate_for_server or add_to_eiffel_project
		once
			Result := has_option (destination_switch)
		end

	destination: READABLE_STRING_32
			-- Location to generated code with.
		require
			successful: is_successful
			generating_code: generate_for_client or generate_for_server or add_to_eiffel_project
			use_destination_folder: use_destination_folder
		once
			if has_option (destination_switch) then
				Result := option_of_name (destination_switch).value
			else
				Result := (create {EXECUTION_ENVIRONMENT}).current_working_path.name
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_exists: (create {DIRECTORY}.make (Result)).exists
		end

	backup_files: BOOLEAN
			-- Indicates if existing files should be backed up
		require
			successful: is_successful
			generating_code: generate_for_client or generate_for_server or add_to_eiffel_project
		once
			Result := has_option (backup_switch)
		end

	clean_up_destination: BOOLEAN
			-- Indicates if destination folder should be cleaned prior to generation
		require
			successful: is_successful
			generating_code: generate_for_client or generate_for_server or add_to_eiffel_project
		once
			Result := has_option (cleanup_switch)
		end

	out_of_process: BOOLEAN
			-- Indicates if an out of process components should be generated or accessed
		require
			successful: is_successful
			generating_code: generate_for_client or generate_for_server or add_to_eiffel_project
		once
			Result := has_option (out_of_process_switch)
		end

	use_custom_marshaller: BOOLEAN
			-- Indicates if a Eiffel server should use a custom marhsaller library
		require
			successful: is_successful
			generate_for_server: generate_for_server
		once
			Result := has_option (out_of_process_switch)
		end

	add_to_eiffel_project: BOOLEAN
			-- Indicate if user wants to add a COM interface to an existing project
		require
			successful: is_successful
		once
			Result := has_option (add_to_project_switch)
		end

	eiffel_configuration_file: READABLE_STRING_32
			-- Path to an Eiffel project file
		require
			successful: is_successful
			add_to_eiffel_project: add_to_eiffel_project
		once
			Result := option_of_name (add_to_project_switch).value
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_exists: (create {RAW_FILE}.make_with_name (Result)).exists
		end

	eiffel_target: READABLE_STRING_32
			-- Target found in `eiffel_configuration_file'
		require
			successful: is_successful
			add_to_eiffel_project: add_to_eiffel_project
		once
			Result := option_of_name (target_switch).value
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	use_eiffel_project_path: BOOLEAN
			-- Indicates if user wants to use a custom Eiffel project path
		require
			successful: is_successful
			add_to_eiffel_project: add_to_eiffel_project
		once
			Result := has_option (eiffel_project_path_switch)
		end

	eiffel_project_path: READABLE_STRING_32
			-- Path to an Eiffel project file
		require
			successful: is_successful
			add_to_eiffel_project: add_to_eiffel_project
			use_eiffel_project_path: use_eiffel_project_path
		once
			Result := option_of_name (eiffel_project_path_switch).value
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_exists: (create {RAW_FILE}.make_with_name (Result)).exists
		end

	use_facade_class: BOOLEAN
			-- Indicates if a facade class should be used
		require
			successful: is_successful
			add_to_eiffel_project: add_to_eiffel_project
		once
			Result := has_option (facade_switch)
		end

	facade_class: READABLE_STRING_32
			-- Facade class used to expose features from COM
		require
			successful: is_successful
			add_to_eiffel_project: add_to_eiffel_project
			use_facade_class: use_facade_class
		once
			Result := option_of_name (facade_switch).value
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	use_facade_cluster: BOOLEAN
			-- Indicates if a facade class cluster should be used
		require
			successful: is_successful
			add_to_eiffel_project: add_to_eiffel_project
			use_facade_class: use_facade_class
		once
			Result := has_option (cluster_switch)
		end

	facade_class_cluster: READABLE_STRING_32
			-- Cluster containing `facade_class'
		require
			successful: is_successful
			add_to_eiffel_project: add_to_eiffel_project
			use_facade_class: use_facade_class
			use_facade_cluster: use_facade_cluster
		once
			Result := option_of_name (cluster_switch).value
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	compile_c_code: BOOLEAN
			-- Indicate if generated C/C++ code should be compiled
		require
			successful: is_successful
			generating: generate_for_client or generate_for_server or add_to_eiffel_project
		once
			Result := has_option (compile_c_switch) or compile_eiffel_code
		end

	compile_eiffel_code: BOOLEAN
			-- Indicate if generated Eiffel code should be compiled
		require
			successful: is_successful
			generating: generate_for_client or generate_for_server or add_to_eiffel_project
		once
			Result := has_option (compile_eiffel_switch)
		end

feature {NONE} -- Post Processing

	post_process_arguments
			-- A chance to evaluate all set arguments for validity can conformance.
			-- Set an error if an switch or value does not adhear to any custom rules.
		do
			Precursor {ARGUMENT_OPTION_PARSER}
			if not is_logo_information_suppressed then
					-- No logo for graphical version of wizard.
				is_logo_information_suppressed := show_graphical_wizard
			end
			if
				is_successful and then not is_help_usage_displayed and then
				not (add_to_eiffel_project or show_graphical_wizard or generate_for_client or generate_for_server)
			then
				add_error (e_switch_group_unrecognized_error)
			end
		end

feature -- Usage

	name: STRING_8 = "Eiffel COM Wizard"
			-- Full name of application

	copyright: STRING = "Copyright Eiffel Software 2005-2024. All Rights Reserved."
			-- <Precursor>

feature {NONE} -- Usage

	version: STRING_8
			-- Version number of application
		do
			create Result.make (10)
			Result.append_integer ({EIFFEL_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append ((create {EIFFEL_CONSTANTS}).two_digit_minimum_minor_version)
			Result.append_character ('.')
				-- We put (9999 + 1) because if we were to put 10000 the 4 zeros
				-- will get replaced by the delivery scripts (see comments for `svn_revision').
			Result.append_integer (svn_revision // (9999 + 1))
			Result.append_character ('.')
			Result.append_integer (svn_revision \\ (9999 + 1))
		end

	svn_revision: INTEGER
			-- SVN revision that build the compiler.
			-- We use `0000' because it is replaced by the actual svn revision number
			-- when doing a delivery.
		do
			Result := 0000
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (0)
			Result.extend (create {ARGUMENT_FILE_SWITCH}.make (server_switch, "Build a new Eiffel COM component using a specified library definition.", False, False, "LIBRARY", "A Type Library (*.tlb) or IDL File (*.idl).", False))
			Result.extend (create {ARGUMENT_FILE_SWITCH}.make (client_switch, "Build an Eiffel client to access a COM component using a specified library.", False, False, "LIBRARY", "A Type Library (*.tlb), IDL File (*.idl) or another COM server component (*.exe, *.ocx, *.dll, ...).", False))

			Result.extend (create {ARGUMENT_FILE_SWITCH}.make (add_to_project_switch, "Add a COM interface to an existing Eiffel project.", False, False, "ECF_PATH", "Path to an Eiffel configuration file.", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (target_switch, "Eiffel configuration file target to merged the COM project into, used with -add", False, False, "TARGET", "A target found in the specified Eiffel configuration file.", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (facade_switch, "Expose features from <CLASS_NAME> to COM, used with -add", False, False, "CLASS_NAME", "An Eiffel class in the specified project.", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (cluster_switch, "Cluster containing facade class name, used with -add", False, False, "CLUSTER_NAME", "A cluster found in the specified Eiffel project.", False))
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (eiffel_project_path_switch, "Path to the Eiffel project,  used with -add", True, False, "PROJECT_PATH", "Path to an Eiffel project root folder, where the EIFGENs folder is located.", False))

			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (destination_switch, "Generates files into an alternative folder.", True, False, "DESTINATION_PATH", "Path to generated files into.", False))

			Result.extend (create {ARGUMENT_SWITCH}.make (cleanup_switch, "Clean destination folder prior to code generation.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (backup_switch, "Backs up overriden files by adding the extension '.bac'", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (out_of_process_switch, "Access or build an out-of-process (exe) component.%NBy default in-process component DLLs are accessed or built.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (marshaller_switch, "Build custom marshaller DLL for COM Eiffel servers.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (compile_c_switch, "Compiles generated C/C++ code.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (compile_eiffel_switch, "Compiles generated Eiffel code. Implies -compilec", True, False))

			Result.extend (create {ARGUMENT_SWITCH}.make (graphical_switch, "Display graphical wizard", True, False))
		ensure then
			result_attached: Result /= Void
		end

	switch_groups: ARRAYED_LIST [ARGUMENT_GROUP]
			-- Valid switch grouping
		once
			create Result.make (0)
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (client_switch), switch_of_name (destination_switch), switch_of_name (out_of_process_switch), switch_of_name (compile_c_switch), switch_of_name (compile_eiffel_switch), switch_of_name (backup_switch), switch_of_name (cleanup_switch)>>, False))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (server_switch), switch_of_name (destination_switch), switch_of_name (out_of_process_switch), switch_of_name (marshaller_switch), switch_of_name (compile_c_switch), switch_of_name (compile_eiffel_switch), switch_of_name (backup_switch), switch_of_name (cleanup_switch)>>, False))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (add_to_project_switch), switch_of_name (destination_switch), switch_of_name (out_of_process_switch), switch_of_name (compile_c_switch), switch_of_name (backup_switch)>>, False))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (graphical_switch)>>, False))
		ensure then
			result_attached: Result /= Void
		end

	switch_dependencies: HASH_TABLE [ARRAY [ARGUMENT_SWITCH], ARGUMENT_SWITCH]
			-- Switch appurtenances (dependencies)
			-- Note: Switch appurtenances are implictly added to a group where a switch is present
		once
			create Result.make (1)
			Result.put (<<switch_of_name (target_switch), switch_of_name (cluster_switch), switch_of_name (facade_switch), switch_of_name (eiffel_project_path_switch)>>, switch_of_name (add_to_project_switch))
		ensure then
			result_attached: Result /= Void
		end

feature {NONE} -- Switches

	add_to_project_switch: STRING = "a|add"
	backup_switch: STRING = "b|backup"
	client_switch: STRING = "l|client"
	destination_switch: STRING = "d|destination"
	eiffel_project_path_switch: STRING = "p|projectpath"
	facade_switch: STRING = "f|facade"
	graphical_switch: STRING = "g|graphical"
	compile_c_switch: STRING = "c|compilec"
	compile_eiffel_switch: STRING = "e|compileeiffel"
	marshaller_switch: STRING = "m|marshaller"
	out_of_process_switch: STRING = "o|outofprocess"
	cleanup_switch: STRING = "x|cleanup"
	server_switch: STRING = "s|server"
	cluster_switch: STRING = "u|cluster"
	target_switch: STRING = "t|target"

invariant
	exclusive_options: -- I long for XOR to work correctly!
		(is_successful and not is_help_usage_displayed) implies
			(add_to_eiffel_project and not (show_graphical_wizard or generate_for_client or generate_for_server)) or
			(show_graphical_wizard and not (add_to_eiffel_project or generate_for_client or generate_for_server)) or
			(generate_for_client and not (add_to_eiffel_project or show_graphical_wizard or generate_for_server)) or
			(generate_for_server and not (add_to_eiffel_project or show_graphical_wizard or generate_for_client))

;note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
