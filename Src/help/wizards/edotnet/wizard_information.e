indexing
	description	: "All information about the wizard ... This class is inherited in each state "

class
	WIZARD_INFORMATION

inherit
	BENCH_WIZARD_INFORMATION
		redefine
			make
		end

create
	make

feature  -- Initialization

	make is
			-- Assign default values
		do
			Precursor
			icon_location := wizard_resources_path
			icon_location := icon_location + Icon_relative_filename
			generate_dll := False
			root_class_name := Default_root_class_name
			creation_routine_name := Default_creation_routine_name
			dotnet_assembly_filename := Empty_string
			
			create available_assemblies.make
			create selected_assemblies.make
			remove_kernel_assembly
			remove_system_assembly
			create local_assemblies.make 
		end

feature -- Setting

	set_icon_location (new_value: STRING) is
			-- Set `icon_location' to `new_value'
		do
			icon_location := new_value
		end
		
	set_generate_dll (new_value: BOOLEAN) is
			-- Set `generate_dll' to `new_value'
		do
			generate_dll := new_value
		end

	set_root_class_name (a_name: like root_class_name) is
			-- Set `root_class_name' with `a_name'.
		local
			upper_case_name: STRING
		do
			upper_case_name := clone (a_name)
			upper_case_name.to_upper
			root_class_name := upper_case_name
		end

	set_creation_routine_name (a_name: like creation_routine_name) is
			-- Set `creation_routine_name' with `a_name'.
		do
			creation_routine_name := a_name
		ensure
			creation_routine_name_set: creation_routine_name = a_name
		end

	set_dotnet_assembly_filename (a_filename: like dotnet_assembly_filename) is
			-- Set `dotnet_assembly_filename' with `a_filename'.
		do
			dotnet_assembly_filename := a_filename
		ensure
			dotnet_assembly_filename_set: dotnet_assembly_filename = a_filename
		end
	
feature -- Access

	icon_location: STRING
			-- Location of the icon choose by the user
			
	generate_dll: BOOLEAN
			-- Should the compiler generate a DLL?
			-- If set to False, it will generate an EXE.
	
	root_class_name: STRING
			-- Name of the root class of the Eiffel.NET project

	creation_routine_name: STRING
			-- Name of the creation routine of the root class

	dotnet_assembly_filename: STRING
			-- Filename of .NET assembly to emit
	
	available_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			-- Available (and not selected) Assemblies
	
	selected_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			-- Selected Assemblies

	local_assemblies: LINKED_LIST [STRING]
			-- Local assemblies
		
	application_type: STRING is
			-- "dll" if `generate_dll' is set, "exe" otherwise
		do
			if generate_dll then
				Result := Dll_type
			else
				Result := Exe_type
			end
		end

	eiffel_path_from_info (a_list: LINKED_LIST [ASSEMBLY_INFORMATION]; an_assembly: ASSEMBLY_INFORMATION): STRING is
			-- Eiffel path corresponding to `an_assembly' if `a_list' contains `an_assembly', otherwise Void
		require
			non_void_list: a_list /= Void
			non_void_assembly: an_assembly /= Void
		local
			an_info: ASSEMBLY_INFORMATION
			an_assembly_name: STRING
			an_assembly_version: STRING
			an_assembly_culture: STRING
			an_assembly_public_key: STRING
			an_info_name: STRING
			an_info_version: STRING
			an_info_culture: STRING
			an_info_public_key: STRING		
		do
			an_assembly_name := clone (an_assembly.name)
			an_assembly_name.to_lower
			an_assembly_version := clone (an_assembly.version)
			an_assembly_version.to_lower
			an_assembly_culture := clone (an_assembly.culture)
			an_assembly_culture.to_lower
			an_assembly_public_key := clone (an_assembly.public_key)
			an_assembly_public_key.to_lower
			from
				a_list.start
			until
				a_list.after or (Result /= Void)
			loop
				an_info := a_list.item
				an_info_name := clone (an_info.name)
				an_info_name.to_lower
				an_info_version := clone (an_info.version)
				an_info_version.to_lower
				an_info_culture := clone (an_info.culture)
				an_info_culture.to_lower
				an_info_public_key := clone (an_info.public_key)
				an_info_public_key.to_lower	
				if an_info_name.is_equal (an_assembly_name) and an_info_version.is_equal (an_assembly_version) and
					an_info_culture.is_equal (an_assembly_culture) and an_info_public_key.is_equal (an_assembly_public_key) then
						Result := clone (an_info.eiffel_cluster_path)
				end
				a_list.forth
			end
		end

	Mscorlib_name: STRING is "mscorlib"
			-- Name of `mscorlib.dll'
			
feature -- Status Report

	has_assembly (a_list: LINKED_LIST [ASSEMBLY_INFORMATION]; an_assembly: ASSEMBLY_INFORMATION): BOOLEAN is
			-- Does `a_list' contain `an_assembly'?
		require
			non_void_list: a_list /= Void
			non_void_assembly: an_assembly /= Void
		local
			an_info: ASSEMBLY_INFORMATION
			an_assembly_name: STRING
			an_assembly_version: STRING
			an_assembly_culture: STRING
			an_assembly_public_key: STRING
			an_info_name: STRING
			an_info_version: STRING
			an_info_culture: STRING
			an_info_public_key: STRING		
		do
			an_assembly_name := clone (an_assembly.name)
			an_assembly_name.to_lower
			an_assembly_version := clone (an_assembly.version)
			an_assembly_version.to_lower
			an_assembly_culture := clone (an_assembly.culture)
			an_assembly_culture.to_lower
			an_assembly_public_key := clone (an_assembly.public_key)
			an_assembly_public_key.to_lower
			from
				a_list.start
			until
				a_list.after or Result
			loop
				an_info := a_list.item
				an_info_name := clone (an_info.name)
				an_info_name.to_lower
				an_info_version := clone (an_info.version)
				an_info_version.to_lower
				an_info_culture := clone (an_info.culture)
				an_info_culture.to_lower
				an_info_public_key := clone (an_info.public_key)
				an_info_public_key.to_lower	
				Result := an_info_name.is_equal (an_assembly_name) and an_info_version.is_equal (an_assembly_version) and
						an_info_culture.is_equal (an_assembly_culture) and an_info_public_key.is_equal (an_assembly_public_key) 
				a_list.forth
			end
		end
	
	has_local_assembly (a_filename: STRING): BOOLEAN is
			-- Does `local_assemblies' contain local assembly corresponding to `a_filename'?
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: not a_filename.is_empty
		local
			lower_filename: STRING
			a_key: STRING
		do
			lower_filename := clone (a_filename)
			lower_filename.to_lower
			from
				local_assemblies.start
			until
				local_assemblies.after or Result
			loop
				if lower_filename.is_equal (local_assemblies.item) then
					Result := True
				end
				local_assemblies.forth
			end

		end
feature -- Basic operation

	retrieve_available_assemblies is
			-- Retrieve the assemblies available in the Eiffel assembly cache and
			-- fill `Available_assemblies'.
		require
			available_assemblies_exists: available_assemblies /= Void
		local
			imported_assemblies: ECOM_ARRAY [STRING]
			retried: BOOLEAN
		do
			if not retried then
			end
		rescue
			retried := True
			retry
		end
	
	remove_kernel_assembly is
			-- Remove the kernel assembly (mscorlib.dll) from the list of `available_assemblies'.
		local
			found: BOOLEAN
		do
			from
				available_assemblies.start
			until
				found or available_assemblies.after
			loop
				if available_assemblies.item.name.is_equal (Mscorlib_name) then
					found := True
					--selected_assemblies.extend (available_assemblies.item)
					available_assemblies.remove
				else
					available_assemblies.forth
				end
			end	
		end

	remove_system_assembly is
			-- Remove the assembly (System.dll) from the list of `available_assemblies'.
		local
			found: BOOLEAN
			an_assembly_name: STRING
		do
			from
				available_assemblies.start
			until
				found or available_assemblies.after
			loop
				an_assembly_name := clone (available_assemblies.item.name)
				an_assembly_name.to_lower
				if an_assembly_name.is_equal (System_name) then
					found := True
					if not has_assembly (selected_assemblies, available_assemblies.item) then
						selected_assemblies.extend (available_assemblies.item)
					end
					available_assemblies.remove
				else
					available_assemblies.forth
				end
			end	
		end

	update_lists is
			-- Update list of assemblies
		local
			last_available_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			assemblies_to_remove: LINKED_LIST [ASSEMBLY_INFORMATION]
			an_assembly: ASSEMBLY_INFORMATION
		do
			last_available_assemblies := clone (available_assemblies)
			available_assemblies.wipe_out
			retrieve_available_assemblies
			remove_kernel_assembly
			remove_system_assembly
			from
				create assemblies_to_remove.make
				available_assemblies.start
			until
				available_assemblies.after
			loop
				an_assembly := available_assemblies.item
				if not has_assembly (last_available_assemblies, an_assembly) and not has_assembly (selected_assemblies, an_assembly) then
					selected_assemblies.extend (an_assembly)
					assemblies_to_remove.extend (an_assembly)
				end
				if has_assembly (selected_assemblies, an_assembly) then
					assemblies_to_remove.extend (an_assembly)
				end
				available_assemblies.forth
			end
			from
				assemblies_to_remove.start
			until
				assemblies_to_remove.after
			loop
				an_assembly := assemblies_to_remove.item
				available_assemblies.prune_all (an_assembly)
				assemblies_to_remove.forth
			end		
		end
		
feature {NONE} -- Implementation

	Default_project_name: STRING is
			-- Default project name
		do
			Result := "my_dotnet_application"
		end

	display_confirmation_dialog is
			-- Display confirmation dialog
		local
			buttons_labels: ARRAY [STRING]
		do
			create buttons_labels.make (1, 3)
			buttons_labels.put (interface_names.b_Abort, 1)
			buttons_labels.put (interface_names.b_Retry, 2)
			buttons_labels.put (Interface_names.b_Ignore, 3)
			create confirmation_dialog.make_with_text (Confirmation_message)
			confirmation_dialog.set_buttons (buttons_labels)
			confirmation_dialog.button (interface_names.b_Abort).select_actions.extend (~on_abort)
			confirmation_dialog.button (interface_names.b_Retry).select_actions.extend (~on_retry)
			confirmation_dialog.button (interface_names.b_Ignore).select_actions.extend (~on_ignore)
			confirmation_dialog.set_default_push_button (confirmation_dialog.button (interface_names.b_Abort))
			confirmation_dialog.set_title (t_Confirmation_dialog)
			confirmation_dialog.show
		end

	confirmation_dialog: EV_QUESTION_DIALOG
			-- Confirmation dialog
	
	on_abort is
			-- Close confirmation message.
		do
			confirmation_dialog.destroy
			current_application.destroy
		end
		
	on_retry is
			-- Retry assembly importation.
		do
			confirmation_dialog := Void
			retrieve_available_assemblies 
		end
	
	on_ignore is
			-- Force access to the Eiffel Assembly Cache.
		local
			imported_assemblies: ECOM_ARRAY [STRING]
		do
--			proxy.clean_assemblies
--			imported_assemblies := proxy.imported_assemblies
--			intern_retrieve_available_assemblies (imported_assemblies)	
--			remove_kernel_assembly
--			remove_system_assembly
--			create local_assemblies.make (1)
		end
	
--	Default_directory: STRING is 
--			-- Default emit directory ($ISE_EIFFEL\library.net\)
--		once
--			Result := clone (Eiffel_installation_dir_name)
--			Result.append (Dotnet_library_relative_path)
--		ensure
--			non_void_directory: Result /= Void
--			not_empty_directory: not Result.is_empty
--		end

feature {NONE} -- Constants

	Icon_relative_filename: STRING is "\eiffel.ico"
			-- Filename of `eiffel.ico' relatively to `icon_location'
	
	Default_root_class_name: STRING is "APPLICATION"
			-- Default root class name

	Default_creation_routine_name: STRING is "make"
			-- Default creation routine name
			
	Dll_type: STRING is "dll"
			-- DLL type
	
	Exe_type: STRING is "exe"
			-- EXE type
	
	System_name: STRING is "system"
			-- Name of `System.dll'
	
	Eiffel_key: STRING is "$ISE_EIFFEL"
			-- Key of environment variable to the Eiffel delivery
	
	t_Confirmation_dialog: STRING is ".NET Wizard - Error"
			-- Title of confirmation dialog

	Confirmation_message: STRING is "The Eiffel Assembly Cache is currently accessed by another process. Do you want to force access anyway?%N%N%
						%- Abort: To close this dialog without doing anything.%N%
						%- Retry: To retry in case the other process has exited.%N%
						%- Ignore: To ignore the access violation and force access to the Eiffel Assembly Cache."
			-- Confirmation message	
	
end -- class WIZARD_INFORMATION
