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
			wizard_information.set_ace_location (project_location+"\"+project_name_lowercase+".ace")

			create map_list.make
			add_common_parameters (map_list)
				-- Add the project type
			create tuple.make
			tuple.put ("<FL_APPLICATION_TYPE>", 1)
			tuple.put (wizard_information.application_type, 2)
			map_list.extend (tuple)			
				-- Add the root class name
			create tuple.make
			tuple.put ("<FL_ROOT_CLASS_NAME>", 1)
			tuple.put (wizard_information.root_class_name, 2)
			map_list.extend (tuple)
				-- Add the creation routine name
			create tuple.make
			tuple.put ("<FL_CREATION_ROUTINE_NAME>", 1)
			tuple.put (wizard_information.creation_routine_name, 2)
			map_list.extend (tuple)
				-- Add the external classes paths
			create tuple.make
			tuple.put ("<FL_EXTERNAL_CLASSES>", 1)
			if not wizard_information.selected_assemblies.is_empty then
				tuple.put (external_classes, 2)
			else
				tuple.put ("", 2)
			end
			map_list.extend (tuple)
				-- Add the external assemblies paths
			create tuple.make
			tuple.put ("<FL_EXTERNAL_ASSEMBLIES>", 1)
			if not wizard_information.selected_assemblies.is_empty then
				tuple.put (external_assemblies, 2)
			else
				tuple.put ("", 2)
			end
			map_list.extend (tuple)
			
				-- Root class name
			root_class_name_lowercase := clone (wizard_information.root_class_name)
			root_class_name_lowercase.to_lower
			
			from_template_to_project (wizard_resources_path, "template_ace.ace", project_location, project_name_lowercase + ".ace", map_list)
			from_template_to_project (wizard_resources_path, "template_application.e",	project_location, root_class_name_lowercase + ".e", map_list)
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
			file_content.replace_substring_all ("%R%N", "%N")

			create Result.make
			Result.put (an_index, 1)
			Result.put (file_content, 2)

			file.close
		end

	empty_tuple (an_index: STRING): TUPLE [STRING, STRING] is
		do
			create Result.make
			Result.put (an_index, 1)
			Result.put ("", 2)
		end

feature {NONE} -- Implementation

	external_classes: STRING is
			-- List of directories where Eiffel classes are stored
		require
			non_void_selected_assemblies: wizard_information.selected_assemblies /= Void
			not_empty_selected_assemblies: not wizard_information.selected_assemblies.is_empty
		local
			selected_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			an_assembly: ASSEMBLY_INFORMATION
			assembly_name: STRING
			dependencies: LINKED_LIST [ASSEMBLY_INFORMATION]
			a_dependency: ASSEMBLY_INFORMATION
			a_dependency_name: STRING
		do
			create Result.make (1024)
			Result.append ("%N%T%T-- .NET System%N")
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
				Result.append ("%Tall " + assembly_name + "_generated: %"" + an_assembly.eiffel_cluster_path + "%"%N%N")
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
				Result.append ("%Tall " + a_dependency_name + "_generated: %"" + a_dependency.eiffel_cluster_path + "%"%N%N")
				dependencies.forth
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
			selected_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			an_assembly: ASSEMBLY_INFORMATION
			dependencies: LINKED_LIST [ASSEMBLY_INFORMATION]
			a_dependency: ASSEMBLY_INFORMATION
		do
			create Result.make (1024)
			Result.append ("external%N%Tassembly:%N")
			selected_assemblies := wizard_information.selected_assemblies
			from
				selected_assemblies.start
			until
				selected_assemblies.after
			loop
				an_assembly := selected_assemblies.item
				Result.append ("%T%T%T%"" + assembly_location (an_assembly) + "%",%N")				
				selected_assemblies.forth
			end
			
			dependencies := wizard_information.dependencies
			from
				dependencies.start
			until
				dependencies.after
			loop
				a_dependency := dependencies.item
				Result.append ("%T%T%T%"" + assembly_location (a_dependency) + "%",%N")
				dependencies.forth
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
	
end -- class WIZARD_PROJECT_GENERATOR
