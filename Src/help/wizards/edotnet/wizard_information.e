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
			emit_directory := Default_directory
			eiffel_formatting := True
			
			create available_assemblies.make
			create selected_assemblies.make
			retrieve_available_assemblies
			remove_kernel_assembly
			remove_system_assembly
			create local_assemblies.make (1)
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
		do
			root_class_name := a_name
		ensure
			root_class_name_set: root_class_name = a_name
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

	set_emit_directory (a_filename: like emit_directory) is
			-- Set `emit_directory' with `a_filename'.
		do
			emit_directory := a_filename
		ensure
			emit_directory_set: emit_directory = a_filename
		end	
	
	set_eiffel_formatting (a_value: like eiffel_formatting) is
			-- Set `eiffel_formatting' with `a_value'.
		do
			eiffel_formatting := a_value
		ensure
			eiffel_formatting_set: eiffel_formatting = a_value
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
	
	emit_directory: STRING
			-- Path to folder where assembly corresponding to `dotnet_assembly_filename' should be generated
	
	eiffel_formatting: BOOLEAN
			-- Should the emitter generate Eiffel-friendly names?
			
	available_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			-- Available (and not selected) Assemblies
	
	selected_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			-- Selected Assemblies
	
	local_assemblies: HASH_TABLE [STRING, STRING]
			-- Local assemblies
			-- | Key: Assembly filename
			-- | Value: Path to folder where assembly was emitted
		
	application_type: STRING is
			-- "dll" if `generate_dll' is set, "exe" otherwise
		do
			if generate_dll then
				Result := Dll_type
			else
				Result := Exe_type
			end
		end
	
	proxy: ASSEMBLY_MANAGER_INTERFACE_PROXY is
			-- Assembly manager proxy
		once
			create Result.make
		ensure
			non_void_proxy: Result /= Void
		end
		
	dependencies: LINKED_LIST [ASSEMBLY_INFORMATION] is
			-- Dependencies corresponding to `selected_assemblies'
		require
			non_void_selected_assemblies: selected_assemblies /= Void
			not_empty_selected_assemblies: not selected_assemblies.is_empty
		local
			an_assembly: ASSEMBLY_INFORMATION
			an_assembly_dependencies: LINKED_LIST [ASSEMBLY_INFORMATION]
			a_dependency: ASSEMBLY_INFORMATION
			tmp_list: LINKED_LIST [ASSEMBLY_INFORMATION]
		once
			from
				create tmp_list.make
				selected_assemblies.start
			until
				selected_assemblies.after
			loop
				an_assembly := selected_assemblies.item
				an_assembly_dependencies := assembly_dependencies (an_assembly)
				from
					an_assembly_dependencies.start
				until
					an_assembly_dependencies.after
				loop
					a_dependency := an_assembly_dependencies.item					
					if not a_dependency.name.is_equal (Mscorlib_name) and not has_assembly (tmp_list, a_dependency) then
						tmp_list.extend (a_dependency)
					end
					an_assembly_dependencies.forth
				end
				selected_assemblies.forth
			end	
			from
				create Result.make
				tmp_list.start
			until
				tmp_list.after
			loop
				an_assembly := tmp_list.item
				if not has_assembly (selected_assemblies, an_assembly) then
					Result.extend (an_assembly)
				end
				tmp_list.forth
			end
		end

	local_dependencies: LINKED_LIST [STRING] is
			-- Dependencies corresponding to `local_assemblies'
		require
			non_void_local_assemblies: local_assemblies /= Void
			not_empty_local_assemblies: not local_assemblies.is_empty
		local
			an_assembly_location: STRING
			an_assembly_dependencies: LINKED_LIST [STRING]
			a_dependency: STRING
			a_key: STRING
			an_item: STRING
		do
			from
				create Result.make
				local_assemblies.start
			until
				local_assemblies.off
			loop
				a_key := local_assemblies.key_for_iteration
				an_item := local_assemblies.item_for_iteration
				an_assembly_dependencies := local_assembly_dependencies (local_assemblies.key_for_iteration, local_assemblies.item_for_iteration)
				if an_assembly_dependencies /= Void then
					from
						an_assembly_dependencies.start
					until
						an_assembly_dependencies.after
					loop
						a_dependency := an_assembly_dependencies.item					
						if a_dependency.substring_index ("mscorlib", 1) < 1 and not Result.has (a_dependency) then
							Result.extend (a_dependency)
						end
						an_assembly_dependencies.forth
					end
				end
				local_assemblies.forth
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
				local_assemblies.off or Result
			loop
				a_key := clone (local_assemblies.key_for_iteration)
				a_key.to_lower
				Result := a_key.is_equal (lower_filename)
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
				imported_assemblies := proxy.imported_assemblies
				if proxy.last_importation_successful then
					intern_retrieve_available_assemblies (imported_assemblies)
				else
					if confirmation_dialog = Void then
						display_confirmation_dialog
					end
				end
			else
				if confirmation_dialog = Void then
					display_confirmation_dialog
				end
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

	assembly_dependencies (info: ASSEMBLY_INFORMATION): LINKED_LIST [ASSEMBLY_INFORMATION] is
			-- Dependencies from assembly corresponding to `info'.
		require
			non_void_info: info /= Void
		local
			retrieved_dependencies: ECOM_ARRAY [STRING]
			a_name: STRING
			a_version: STRING
			a_culture: STRING
			a_public_key: STRING
			a_path: STRING
			i: INTEGER
			a_dependency: ASSEMBLY_INFORMATION
		do
			retrieved_dependencies := proxy.assembly_dependencies (info.name, info.version, info.culture, info.public_key)
			check
				unidimensional_array: retrieved_dependencies.dimension_count = 1
			end
			from
				create Result.make
			until
				i = retrieved_dependencies.count
			loop
				a_name := retrieved_dependencies.array_item (i)
				a_version := retrieved_dependencies.array_item (i + 1)
				a_culture := retrieved_dependencies.array_item (i + 2)
				a_public_key := retrieved_dependencies.array_item (i + 3)
				a_path := retrieved_dependencies.array_item (i + 4)
				if (a_name /= Void and then not a_name.is_empty) and (a_version /= Void and then not a_version.is_empty) and (a_culture /= Void and then not a_culture.is_empty)
					and (a_public_key /= Void and then not a_public_key.is_empty) and (a_path /= Void and then not a_path.is_empty) then
					create a_dependency.make_from_info (a_name, a_version, a_culture, a_public_key, a_path)
					Result.extend (a_dependency)
				end
				i := i + 5
			end
		end
	
	intern_retrieve_available_assemblies (imported_assemblies: ECOM_ARRAY [STRING]) is
			-- Retrieve imported assemblies from the Eiffel Assembly Cache.
		require
			unidimensional_assemblies: imported_assemblies.dimension_count = 1
		local
			i: INTEGER
			a_name: STRING
			a_version: STRING
			a_culture: STRING
			a_public_key: STRING
			a_path: STRING
			an_assembly_info: ASSEMBLY_INFORMATION		
		do
			from
			until
				i = imported_assemblies.count
			loop
				a_name := imported_assemblies.array_item (i)
				a_version := imported_assemblies.array_item (i + 1)
				a_culture := imported_assemblies.array_item (i + 2)
				a_public_key := imported_assemblies.array_item (i + 3)
				a_path := imported_assemblies.array_item (i + 4)
				if a_path /= Void and then not a_path.is_empty and then a_path.substring_index (Eiffel_key, 1) > 0 then
					a_path.replace_substring_all (Eiffel_key, Eiffel_installation_dir_name)
				end
				create an_assembly_info.make_from_info (a_name, a_version, a_culture, a_public_key, a_path)
				available_assemblies.extend (an_assembly_info)
				i := i + 5
			end
		end

	local_assembly_dependencies (a_filename, a_path: STRING): LINKED_LIST [STRING] is
			-- Dependencies location of local assembly corresponding to `a_filename', which was imported in `a_path'
		require
			non_void_filename: a_filename /= Void
			not_empty_filename: not a_filename.is_empty
			non_void_path: a_path /= Void
			not_empty_path: not a_path.is_empty
		local
			locals: ECOM_ARRAY [STRING]
			i: INTEGER
			a_location: STRING
		do
			locals := proxy.local_assembly_dependencies (a_filename)
			check
				unidimensional_array: locals.dimension_count = 1
			end
		
			from
				create Result.make
			until
				i = locals.count
			loop
				a_location := locals.array_item (i)
				if (a_location /= Void and then not a_location.is_empty) then 
					Result.extend (a_location)
				end
				i := i + 1
			end
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
		local
			imported_assemblies: ECOM_ARRAY [STRING]
		do
			confirmation_dialog := Void
			retrieve_available_assemblies 
		end
	
	on_ignore is
			-- Force access to the Eiffel Assembly Cache.
		local
			imported_assemblies: ECOM_ARRAY [STRING]
		do
			proxy.clean_assemblies
			imported_assemblies := proxy.imported_assemblies
			intern_retrieve_available_assemblies (imported_assemblies)	
			remove_kernel_assembly
			remove_system_assembly
			create local_assemblies.make (1)
		end
	
	Default_directory: STRING is 
			-- Default emit directory ($ISE_EIFFEL\library.net\)
		once
			Result := clone (Eiffel_installation_dir_name)
			Result.append (Dotnet_library_relative_path)
		ensure
			non_void_directory: Result /= Void
			not_empty_directory: not Result.is_empty
		end

feature {NONE} -- Constants

	Dotnet_library_relative_path: STRING is "\library.net\"
			-- Path to `library.net' folder relatively to the Eiffel delivery
	
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
