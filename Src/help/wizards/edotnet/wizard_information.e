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
			icon_location := icon_location + "\eiffel.ico"
			generate_dll := False
			root_class_name := "APPLICATION"
			creation_routine_name := "make"
			
			create available_assemblies.make
			create selected_assemblies.make
			retrieve_available_assemblies
			remove_kernel_assembly
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
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			root_class_name := a_name
		ensure
			root_class_name_set: root_class_name.is_equal (a_name)
		end

	set_creation_routine_name (a_name: like creation_routine_name) is
			-- Set `creation_routine_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			creation_routine_name := a_name
		ensure
			creation_routine_name_set: creation_routine_name.is_equal (a_name)
		end
		
feature -- Access

	icon_location: STRING
			-- Location of the icon choose by the user
			
	generate_dll: BOOLEAN
			-- Should the compiler generate a DLL?
			-- If set to False, it will generate an EXE.
	
	root_class_name: STRING
			-- Name of the root class of the Eiffel # project

	creation_routine_name: STRING
			-- Name of the creation routine of the root class
		
	available_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			-- Available (and not selected) Assemblies
	
	selected_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			-- Selected Assemblies
			
	application_type: STRING is
			-- "dll" if `generate_dll' is set, "exe" otherwise
		do
			if generate_dll then
				Result := "dll"
			else
				Result := "exe"
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
		do
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
					if not a_dependency.name.is_equal ("mscorlib") and not has_assembly (tmp_list, a_dependency) then
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
	
	has_assembly (a_list: LINKED_LIST [ASSEMBLY_INFORMATION]; an_assembly: ASSEMBLY_INFORMATION): BOOLEAN is
			-- Does `a_list' contain `an_assembly'?
		require
			non_void_list: a_list /= Void
			non_void_assembly: an_assembly /= Void
		local
			an_info: ASSEMBLY_INFORMATION
		do
			from
				a_list.start
			until
				a_list.after or Result
			loop
				an_info := a_list.item
				Result := an_info.name.is_equal (an_assembly.name) and an_info.version.is_equal (an_assembly.version) and
						an_info.culture.is_equal (an_assembly.culture) and an_info.public_key.is_equal (an_assembly.public_key) and
						an_info.eiffel_cluster_path.is_equal (an_assembly.eiffel_cluster_path)
				a_list.forth
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
			i: INTEGER
			a_name: STRING
			a_version: STRING
			a_culture: STRING
			a_public_key: STRING
			a_path: STRING
			an_assembly_info: ASSEMBLY_INFORMATION
		do
			imported_assemblies := proxy.imported_assemblies
			check
				unidimensional_assemblies: imported_assemblies.dimension_count = 1
			end
			from
			until
				i = imported_assemblies.count
			loop
				a_name := imported_assemblies.array_item (i)
				a_version := imported_assemblies.array_item (i + 1)
				a_culture := imported_assemblies.array_item (i + 2)
				a_public_key := imported_assemblies.array_item (i + 3)
				a_path := imported_assemblies.array_item (i + 4)
				if a_path /= Void and then not a_path.is_empty and then a_path.substring_index ("$ISE_EIFFEL", 1) > 0 then
					a_path.replace_substring_all ("$ISE_EIFFEL", Eiffel_installation_dir_name)
				end
				create an_assembly_info.make_from_info (a_name, a_version, a_culture, a_public_key, a_path)
				available_assemblies.extend (an_assembly_info)
				i := i + 5
			end
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
				if available_assemblies.item.name.is_equal ("mscorlib") then
					found := True
					--selected_assemblies.extend (available_assemblies.item)
					available_assemblies.remove
				else
					available_assemblies.forth
				end
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
				create a_dependency.make_from_info (a_name, a_version, a_culture, a_public_key, a_path)
				Result.extend (a_dependency)
				i := i + 5
			end
		end
		
end -- class WIZARD_INFORMATION
