indexing
	description	: "Object to generate a project."

class
	WIZARD_PROJECT_GENERATOR

inherit
	BENCH_WIZARD_PROJECT_GENERATOR

create
	make

feature -- Basic Operations

	generate_code is
			-- Generate the code for a new vision2-application project
		local
			map_list: LINKED_LIST [TUPLE [STRING, STRING]]
			tuple: TUPLE [STRING, STRING]
			project_name_lowercase: STRING
			project_location: STRING
			root_class_name_lowercase: STRING
		do			
				-- cached variables
			project_name_lowercase := clone (wizard_information.project_name)
			project_name_lowercase.to_lower
			project_location := wizard_information.project_location

				-- Update the ace file location.
			wizard_information.set_ace_location (project_location + "\" + project_name_lowercase + Ace_extension)

			create map_list.make
			add_common_parameters (map_list)
				-- Add the project type
			create tuple.make
			tuple.put (Application_type_template, 1)
			tuple.put (wizard_information.application_type, 2)
			map_list.extend (tuple)		
			
				-- Add the root class name
			root_class_name_lowercase := clone (wizard_information.root_class_name)
			root_class_name_lowercase.to_lower
			if not root_class_name_lowercase.is_equal (None_class) then
				create tuple.make
				tuple.put (Root_class_name_template, 1)
				tuple.put (wizard_information.root_class_name, 2)
				map_list.extend (tuple)

					-- Add the root class external name
				create tuple.make
				tuple.put (Root_class_external_name_template, 1)
				tuple.put (wizard_information.root_class_external_name, 2)
				map_list.extend (tuple)

					-- Add the creation routine name
				create tuple.make
				tuple.put (Creation_routine_name_template, 1)
				tuple.put (wizard_information.creation_routine_name, 2)
				map_list.extend (tuple)

					-- Add the creation routine external name
				create tuple.make
				tuple.put (Creation_routine_external_name_template, 1)
				tuple.put (wizard_information.creation_routine_external_name, 2)
				map_list.extend (tuple)
			end
				-- Add the external classes paths
			create tuple.make
			tuple.put (External_classes_template, 1)
			if not wizard_information.selected_assemblies.is_empty then
				tuple.put (external_classes, 2)
			else
				tuple.put (Empty_string, 2)
			end
			map_list.extend (tuple)
				-- Add the external assemblies paths
			create tuple.make
			tuple.put (External_assemblies_template, 1)
			if not wizard_information.selected_assemblies.is_empty then
				tuple.put (external_assemblies, 2)
			else
				tuple.put (Empty_string, 2)
			end
			map_list.extend (tuple)
		
				-- Generation
			if not root_class_name_lowercase.is_equal (None_class) then
				from_template_to_project (wizard_resources_path, Ace_template_filename, project_location, project_name_lowercase + Ace_extension, map_list)
				from_template_to_project (wizard_resources_path, Application_template_filename,	project_location, root_class_name_lowercase + Eiffel_extension, map_list)
			else
				from_template_to_project (wizard_resources_path, Ace_template_with_root_class_none_filename, project_location, project_name_lowercase + Ace_extension, map_list)			
			end
		end

	tuple_from_file_content (an_index: STRING; a_content_file: STRING): TUPLE [STRING, STRING] is
		local
			file_content: STRING
			file: RAW_FILE
			file_name: FILE_NAME
		do
			create file_name.make_from_string (wizard_resources_path)
			file_name.set_file_name (a_content_file)
			
			create file.make_open_read (file_name)
			file.read_stream (file.count)

			file_content := clone (file.last_string)
			file_content.replace_substring_all (Windows_new_line, New_line)

			create Result.make
			Result.put (an_index, 1)
			Result.put (file_content, 2)

			file.close
		end

	empty_tuple (an_index: STRING): TUPLE [STRING, STRING] is
		do
			create Result.make
			Result.put (an_index, 1)
			Result.put (Empty_string, 2)
		end

feature {NONE} -- Implementation
	
	selected_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			-- Selected assemblies
			
	dependencies: LINKED_LIST [ASSEMBLY_INFORMATION]
			-- Dependencies of selected assemblies
			
	local_assemblies: HASH_TABLE [STRING, STRING]
			-- Locally imported assemblies
			-- | Key: Assembly filename
			-- | Value: Path to folder where Eiffel classes were generated
	
	local_dependencies: LINKED_LIST [STRING]
			-- Dependencies of locally imported assemblies
			-- | [assembly name, assembly location, assembly name, assembly location...]
	external_classes: STRING is
			-- List of directories where Eiffel classes are stored
		require
			non_void_selected_assemblies: wizard_information.selected_assemblies /= Void
			not_empty_selected_assemblies: not wizard_information.selected_assemblies.is_empty
		local			
			an_assembly: ASSEMBLY_INFORMATION
			assembly_name: STRING			
			a_dependency: ASSEMBLY_INFORMATION
			a_dependency_name: STRING			
			a_local_assembly: STRING
			a_path: STRING
			i: INTEGER
			a_name: STRING
			a_local_dependency: STRING
			dir: DIRECTORY
			cluster_name: STRING
			clusters: LINKED_LIST [STRING]
		do
			create Result.make (1024)
			create clusters.make
			Result.append (New_line + Tab + Tab + External_classes_comment + New_line)
			selected_assemblies := wizard_information.selected_assemblies
			from
				selected_assemblies.start
			until
				selected_assemblies.after
			loop
				an_assembly := selected_assemblies.item
				assembly_name := clone (an_assembly.name)
				assembly_name.replace_substring_all (".", "_")
				assembly_name.to_lower
				a_path := clone (an_assembly.eiffel_cluster_path)
				if a_path /= Void and then not a_path.is_empty and then a_path.substring_index (Eiffel_installation_dir_name, 1) > 0 then
					a_path.replace_substring_all (Eiffel_installation_dir_name, Eiffel_key)
					if not clusters.has (assembly_name) then
						Result.append (Tab + "all " + assembly_name + "_generated: " + Inverted_comma + a_path + Inverted_comma + New_line + New_line)
						clusters.extend (assembly_name)
					end
				end
				selected_assemblies.forth
			end
			dependencies := wizard_information.dependencies
			from
				dependencies.start
			until
				dependencies.after
			loop
				a_dependency := dependencies.item					
				a_dependency_name := clone (a_dependency.name)
				a_dependency_name.replace_substring_all (".", "_")
				a_dependency_name.to_lower
				a_path := clone (a_dependency.eiffel_cluster_path)
				if a_path /= Void and then not a_path.is_empty and then a_path.substring_index (Eiffel_installation_dir_name, 1) > 0 then
					a_path.replace_substring_all (Eiffel_installation_dir_name, Eiffel_key)
					if not clusters.has (a_dependency_name) then
						Result.append (Tab + "all " + a_dependency_name + "_generated: " + Inverted_comma + a_path + Inverted_comma + New_line + New_line)
						clusters.extend (a_dependency_name)
					end
				end
				dependencies.forth
			end		
			local_assemblies := wizard_information.local_assemblies
			from
				local_assemblies.start
				--i := 1
			until
				local_assemblies.off
			loop
				a_local_assembly := clone (local_assemblies.item_for_iteration)
				a_name := clone (local_assemblies.key_for_iteration)
				a_name := a_name.substring (a_name.last_index_of ('\', a_name.count - 4) + 1, a_name.count -4)
				a_name.to_lower
				if a_local_assembly /= Void and then not a_local_assembly.is_empty and then a_local_assembly.substring_index (Eiffel_installation_dir_name, 1) > 0 then
					a_local_assembly.replace_substring_all (Eiffel_installation_dir_name, Eiffel_key)
					--Result.append (Tab + "all local_assembly_" + i.out + "_generated: " + Inverted_comma + a_local_assembly.substring (1, a_local_assembly.count) + a_name + Inverted_comma + New_line + New_line)
					cluster_name := clone (a_name)
					cluster_name.replace_substring_all (".", "_")
					if not clusters.has (cluster_name) then
						Result.append (Tab + "all " + cluster_name + "_generated: " + Inverted_comma + a_local_assembly.substring (1, a_local_assembly.count) + a_name + Inverted_comma + New_line + New_line)
						clusters.extend (cluster_name)
					else
						from
							i := 2
							cluster_name.append ("_" + i.out)
						until
							not clusters.has (cluster_name) 
						loop
							cluster_name := cluster_name.substring (1, cluster_name.count -1)
							cluster_name.append (i.out)
							i := i + 1						
						end
						Result.append (Tab + "all " + cluster_name + "_generated: " + Inverted_comma + a_local_assembly.substring (1, a_local_assembly.count) + a_name + Inverted_comma + New_line + New_line)
						clusters.extend (cluster_name)
					end
					--i := i + 1
				end			
				local_assemblies.forth
			end		
			if local_assemblies /= Void and then not local_assemblies.is_empty then
				local_dependencies := wizard_information.local_dependencies
				from
					--i := 1
					local_dependencies.start
				until
					local_dependencies.after
				loop
					a_dependency_name := clone (local_dependencies.item)
					a_dependency_name.to_lower
					local_dependencies.forth
					if not local_dependencies.after then
						a_local_dependency := local_dependencies.item
						if not is_selected_assembly (a_local_dependency) and not is_dependency (a_local_dependency) and not local_assemblies.has (a_local_dependency) and a_dependency_name /= Void and then not a_dependency_name.is_empty then
							create dir.make (Eiffel_installation_dir_name + "\library.net\" + a_dependency_name)
							if dir.exists then
							--	Result.append (Tab + "all local_dependency_" + i.out + "_generated: " + Inverted_comma + Eiffel_key + "\library.net\" + a_dependency_name + Inverted_comma + New_line + New_line)
								cluster_name := clone (a_dependency_name)
								cluster_name.replace_substring_all (".", "_")
								if not clusters.has (cluster_name) then
									Result.append (Tab + "all " + cluster_name + "_generated: " + Inverted_comma + Eiffel_key + "\library.net\" + a_dependency_name + Inverted_comma + New_line + New_line)
									clusters.extend (cluster_name)
								else
									from
										i := 2
										cluster_name.append ("_" + i.out)
									until
										not clusters.has (cluster_name) 
									loop
										cluster_name := cluster_name.substring (1, cluster_name.count -1)
										cluster_name.append (i.out)
										i := i + 1						
									end
									Result.append (Tab + "all " + cluster_name + "_generated: " + Inverted_comma + a_local_assembly.substring (1, a_local_assembly.count) + a_name + Inverted_comma + New_line + New_line)
									clusters.extend (cluster_name)
								end
							--	i := i + 1
							end
						end
						local_dependencies.forth
					end
					
				end
			end
			Result.right_adjust
			if (Result @ Result.count) = '%N' then
				Result.remove (Result.count)
			end
			if (Result @ Result.count ) = ',' then
				Result.remove (Result.count)
			end
			Result.append (New_line)
		ensure
			non_void_text: Result /= Void
			not_empty_text: not Result.is_empty
		end			
	
	external_assemblies: STRING is
			-- List of external assemblies
		require
			non_void_selected_assemblies: wizard_information.selected_assemblies /= Void
			not_empty_selected_assemblies: not wizard_information.selected_assemblies.is_empty
		local
			an_assembly: ASSEMBLY_INFORMATION
			a_dependency: ASSEMBLY_INFORMATION
			a_local_assembly: STRING
			a_local_dependency: STRING	
			a_location: STRING
		do
			create Result.make (1024)
			Result.append (External_keyword + New_line + Tab + Assembly_keyword + New_line)
			if selected_assemblies = Void then
				selected_assemblies := wizard_information.selected_assemblies
			end
			from
				selected_assemblies.start
			until
				selected_assemblies.after
			loop
				an_assembly := selected_assemblies.item
				a_location := assembly_location (an_assembly)
				if a_location /= Void and then not a_location.is_empty then
					Result.append (Tab + Tab + Tab + Inverted_comma + a_location + Inverted_comma + Comma + New_line)				
				end
				selected_assemblies.forth
			end
			
			if dependencies = Void then
				dependencies := wizard_information.dependencies
			end
			from
				dependencies.start
			until
				dependencies.after
			loop
				a_dependency := dependencies.item
				a_location := assembly_location (a_dependency) 
				if a_location /= Void and then not a_location.is_empty then
					Result.append (Tab + Tab + Tab + Inverted_comma + a_location + Inverted_comma + Comma + New_line)
				end
				dependencies.forth
			end

			if local_assemblies = Void then
				local_assemblies := wizard_information.local_assemblies
			end
			from
				local_assemblies.start
			until
				local_assemblies.off
			loop
				a_local_assembly := clone (local_assemblies.key_for_iteration)
				if a_local_assembly /= Void and then not a_local_assembly.is_empty then
					Result.append (Tab + Tab + Tab + Inverted_comma + a_local_assembly + Inverted_comma + Comma + New_line)
				end
				local_assemblies.forth
			end	

			if local_assemblies /= Void and then not local_assemblies.is_empty then
				if local_dependencies = Void then
					local_dependencies := wizard_information.local_dependencies
				end
				from
					local_dependencies.start
				until
					local_dependencies.after
				loop
					local_dependencies.forth
					if not local_dependencies.after then
						a_local_dependency := local_dependencies.item
						if not is_selected_assembly (a_local_dependency) and not is_dependency (a_local_dependency) and not local_assemblies.has (a_local_dependency) then
							Result.append (Tab + Tab + Tab + Inverted_comma + a_local_dependency + Inverted_comma + Comma + New_line)
						end
						local_dependencies.forth
					end
				end
			end
			
			Result.right_adjust
			if (Result @ Result.count) = '%N' then
				Result.remove (Result.count)
			end
			if (Result @ Result.count ) = ',' then
				Result.remove (Result.count)
			end
		ensure
			non_void_text: Result /= Void
			not_empty_text: not Result.is_empty
		end			
	
	assembly_location (info: ASSEMBLY_INFORMATION): STRING is
			-- Location of the assembly corresponding to `info'.
		require	
			non_void_info: info /= Void
		local
			proxy: ASSEMBLY_MANAGER_INTERFACE_PROXY
			project_location: STRING
			an_assembly_filename: STRING
			dll_filename: STRING
			dll_file: RAW_FILE
			exe_filename: STRING
			exe_file: RAW_FILE
		do
			proxy := wizard_information.proxy
			Result := proxy.assembly_location (info.name, info.version, info.culture, info.public_key)
			if Result = Void or else Result.is_empty then
				project_location := clone (wizard_information.project_location)
				an_assembly_filename := clone (project_location) + "\" + clone (info.name)					
				dll_filename := clone (an_assembly_filename) + Dll_extension
				
				create dll_file.make (dll_filename)
				if dll_file.exists then
					Result := dll_filename
				else
					exe_filename := clone (an_assembly_filename) + Exe_extension
					create exe_file.make (exe_filename)
					if exe_file.exists then
						Result := exe_filename
					else
						Result := ""
					end
				end
			end
		end

feature {NONE} -- Constants

	Application_type_template: STRING is "<FL_APPLICATION_TYPE>"
			-- String to be replaced by the chosen application type

	Root_class_external_name_template: STRING is "<FL_ROOT_CLASS_EXTERNAL_NAME>"
			-- String to be replaced by the chosen root class external name
			
	Root_class_name_template: STRING is "<FL_ROOT_CLASS_NAME>"
			-- String to be replaced by the chosen root class name

	Creation_routine_name_template: STRING is "<FL_CREATION_ROUTINE_NAME>"
			-- String to be replaced by the chosen creation routine name

	Creation_routine_external_name_template: STRING is "<FL_CREATION_ROUTINE_EXTERNAL_NAME>"
			-- String to be replaced by the chosen creation routine external name
			
	External_classes_template: STRING is "<FL_EXTERNAL_CLASSES>"	
			-- String to be replaced by the paths to folders containing the Eiffel classes corresponding to the selected .NET assemblies
	
	External_assemblies_template: STRING is "<FL_EXTERNAL_ASSEMBLIES>"
			-- String to be replaced by the paths to the selected .NET assemblies
	
	Ace_extension: STRING is ".ace"
			-- Ace files extension
	
	Eiffel_extension: STRING is ".e"
			-- Eiffel classes extension
		
	Dll_extension: STRING is ".dll"
			-- DLLs extension
	
	Exe_extension: STRING is ".exe"
			-- EXEs extension
	
	Ace_template_filename: STRING is "template_ace.ace"
			-- Filename of the Ace file template used to automatically generate Ace files for .NET applications

	Ace_template_with_root_class_none_filename: STRING is "template_ace_with_root_class_none.ace"
			-- Filename of the Ace file template used to automatically generate Ace files for .NET applications
	
	Application_template_filename: STRING is "template_application.e"
			-- Filename of the template used to automatically generate a root class for .NET applications

	External_classes_comment: STRING is "-- .NET System"
			-- Comment before paths to external classes
	
	None_class: STRING is "none"
			-- `NONE' class
			
	Inverted_comma: STRING is "%""
			-- Inverted comma
	
	Comma: STRING is ","
			-- Comma
	
	External_keyword: STRING is "external"
			-- External keyword
	
	Assembly_keyword: STRING is "assembly:"
			-- Assembly keyword

	Eiffel_key: STRING is "$ISE_EIFFEL"
			-- Key of environment variable to the Eiffel delivery
	
	is_selected_assembly (a_location: STRING): BOOLEAN is
			-- Is assembly corresponding to `a_location' a selected assembly?
		require
			non_void_location: a_location /= Void
			not_emtpy_location: not a_location.is_empty
			non_void_selected_assemblies: selected_assemblies /= Void
		local
			an_assembly_info: ASSEMBLY_INFORMATION
		do
			from
				selected_assemblies.start
			until
				selected_assemblies.after or Result
			loop
				an_assembly_info := selected_assemblies.item
				Result := assembly_location (an_assembly_info).is_equal (a_location)
				selected_assemblies.forth
			end
		end
		
	is_dependency (a_location: STRING): BOOLEAN is
			-- Is assembly corresponding to `a_location' a selected assembly?
		require
			non_void_location: a_location /= Void
			not_emtpy_location: not a_location.is_empty
			non_void_dependencies: dependencies /= Void
		local
			an_assembly_info: ASSEMBLY_INFORMATION
		do
			from
				dependencies.start
			until
				dependencies.after or Result
			loop
				an_assembly_info := dependencies.item
				Result := assembly_location (an_assembly_info).is_equal (a_location)
				dependencies.forth
			end
		end
		
end -- class WIZARD_PROJECT_GENERATOR
