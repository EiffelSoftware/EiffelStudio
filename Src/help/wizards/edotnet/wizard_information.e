indexing
	description	: "All information about the wizard ... This class is inherited in each state "
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

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
			
			create available_assemblies.make
			create selected_assemblies.make
			retrieve_available_assemblies
			select_kernel_assembly
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

feature -- Access

	icon_location: STRING
			-- Location of the icon choose by the user
			
	generate_dll: BOOLEAN
			-- Should the compiler generate a DLL?
			-- If set to False, it will generate an EXE.
			
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
			
feature -- Basic operation

	retrieve_available_assemblies is
			-- Retrieve the assemblies available on this machine and
			-- fill `Available_assemblies'.
		require
			available_assemblies_exists: available_assemblies /= Void
		local
			cur_filename: FILE_NAME
			assembly_info: ASSEMBLY_INFORMATION
			corpath_directory_name: STRING
			corpath_directory: DIRECTORY
			assembly_files: ARRAYED_LIST [STRING]
		do
			corpath_directory_name := execution_environment.get ("CORPATH")
			if corpath_directory_name /= Void then
				if (corpath_directory_name @ corpath_directory_name.count) = Operating_environment.Directory_separator then
					corpath_directory_name := corpath_directory_name.substring (1, corpath_directory_name.count - 1)
				end
				create corpath_directory.make (corpath_directory_name)
				if corpath_directory.exists then
					assembly_files := corpath_directory.linear_representation
					
					from
						assembly_files.start
					until
						assembly_files.after
					loop
						create cur_filename.make_from_string (corpath_directory_name)
						cur_filename.set_file_name (assembly_files.item)
						create assembly_info.make (cur_filename)
						if assembly_info.valid_assembly then
							available_assemblies.extend (assembly_info)
						end
						assembly_files.forth
					end
				end
			end
		end
	
	select_kernel_assembly is
			-- Automatically select the kernel assembly (mscorlib.dll)
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
					selected_assemblies.extend (available_assemblies.item)
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
