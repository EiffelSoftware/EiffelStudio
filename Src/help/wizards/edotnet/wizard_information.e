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
				if a_path.substring_index ("$ISE_EIFFEL", 1) > 0 then
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
		
end -- class WIZARD_INFORMATION
