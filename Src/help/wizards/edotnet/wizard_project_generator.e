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
			create tuple.make
			tuple.put (Root_class_name_template, 1)
			tuple.put (wizard_information.root_class_name, 2)
			map_list.extend (tuple)
				-- Add the creation routine name
			create tuple.make
			tuple.put (Creation_routine_name_template, 1)
			tuple.put (wizard_information.creation_routine_name, 2)
			map_list.extend (tuple)
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
			
				-- Root class name
			root_class_name_lowercase := clone (wizard_information.root_class_name)
			root_class_name_lowercase.to_lower
			
			from_template_to_project (wizard_resources_path, Ace_template_filename, project_location, project_name_lowercase + Ace_extension, map_list)
			from_template_to_project (wizard_resources_path, Application_template_filename,	project_location, root_class_name_lowercase + Eiffel_extension, map_list)
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
			i: INTEGER
		do
			create Result.make (1024)
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
				Result.append (Tab + "all " + assembly_name + "_generated: " + Inverted_comma + an_assembly.eiffel_cluster_path + Inverted_comma + New_line + New_line)
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
				Result.append (Tab + "all " + a_dependency_name + "_generated: " + Inverted_comma + a_dependency.eiffel_cluster_path + Inverted_comma +  New_line + New_line)
				dependencies.forth
			end		
			local_assemblies := wizard_information.local_assemblies
			from
				local_assemblies.start
				i := 1
			until
				local_assemblies.off
			loop
				a_local_assembly := clone (local_assemblies.item_for_iteration)
				if a_local_assembly /= Void and then not a_local_assembly.is_empty then
					Result.append (Tab + "all local_assembly_" + i.out + "_generated: " + Inverted_comma + a_local_assembly + Inverted_comma + New_line + New_line)
					i := i + 1
				end			
				local_assemblies.forth
			end		
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
			local_dependencies: LINKED_LIST [ASSEMBLY_INFORMATION]
			a_local_dependency: ASSEMBLY_INFORMATION			
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
				Result.append (Tab + Tab + Tab + Inverted_comma + assembly_location (an_assembly) + Inverted_comma + Comma + New_line)				
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
				Result.append (Tab + Tab + Tab + Inverted_comma + assembly_location (a_dependency) + Inverted_comma + Comma + New_line)
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
				local_dependencies := wizard_information.local_dependencies
				from
					local_dependencies.start
				until
					local_dependencies.after
				loop
					a_local_dependency := local_dependencies.item
					Result.append (Tab + Tab + Tab + Inverted_comma + assembly_location (a_local_dependency) + Inverted_comma + Comma + New_line)
					dependencies.forth
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
		do
			proxy := wizard_information.proxy
			Result := proxy.assembly_location (info.name, info.version, info.culture, info.public_key)
		end

feature {NONE} -- Constants

	Application_type_template: STRING is "<FL_APPLICATION_TYPE>"
			-- String to be replaced by the chosen application type
	
	Root_class_name_template: STRING is "<FL_ROOT_CLASS_NAME>"
			-- String to be replaced by the chosen root class name

	Creation_routine_name_template: STRING is "<FL_CREATION_ROUTINE_NAME>"
			-- String to be replaced by the chosen creation routine name
	
	External_classes_template: STRING is "<FL_EXTERNAL_CLASSES>"	
			-- String to be replaced by the paths to folders containing the Eiffel classes corresponding to the selected .NET assemblies
	
	External_assemblies_template: STRING is "<FL_EXTERNAL_ASSEMBLIES>"
			-- String to be replaced by the paths to the selected .NET assemblies
	
	Ace_extension: STRING is ".ace"
			-- Ace files extension
	
	Eiffel_extension: STRING is ".e"
			-- Eiffel classes extension
	
	Ace_template_filename: STRING is "template_ace.ace"
			-- Filename of the Ace file template used to automatically generate Ace files for .NET applications
	
	Application_template_filename: STRING is "template_application.e"
			-- Filename of the template used to automatically generate a root class for .NET applications
	
	External_classes_comment: STRING is "-- .NET System"
			-- Comment before paths to external classes
	
	Inverted_comma: STRING is "%""
			-- Inverted comma
	
	Comma: STRING is ","
			-- Comma
	
	External_keyword: STRING is "external"
			-- External keyword
	
	Assembly_keyword: STRING is "assembly:"
			-- Assembly keyword
			
end -- class WIZARD_PROJECT_GENERATOR
