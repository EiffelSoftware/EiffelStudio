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

					-- Add the creation routine name
				create tuple.make
				tuple.put (Creation_routine_name_template, 1)
				tuple.put (wizard_information.creation_routine_name, 2)
				map_list.extend (tuple)

			end
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
	
	
	external_assemblies: STRING is
			-- List of external assemblies
		require
			non_void_selected_assemblies: wizard_information.selected_assemblies /= Void
			not_empty_selected_assemblies: not wizard_information.selected_assemblies.is_empty
		local
			an_assembly: ASSEMBLY_INFORMATION
			l_assembly_name, l_assembly_name_2: STRING
			index: INTEGER
			selected_assemblies: LINKED_LIST [ASSEMBLY_INFORMATION]
			local_assemblies: LINKED_LIST [STRING]
		do
			create Result.make (1024)
			Result.append (Assembly_keyword + New_line)

			selected_assemblies := wizard_information.selected_assemblies
			from
				selected_assemblies.start
			until
				selected_assemblies.after
			loop
				an_assembly := selected_assemblies.item
				l_assembly_name := clone (an_assembly.name)
				l_assembly_name.replace_substring_all (".", "_")
				Result.append (Tab + l_assembly_name + "_" + " :" )
				Result.append (Tab + "%"")
				Result.append (an_assembly.name)
				Result.append ("%",")
				Result.append (Tab + "%"")
				Result.append (an_assembly.version)
				Result.append ("%",")
				Result.append (Tab + "%"")
				Result.append (an_assembly.culture)
				Result.append ("%",")
				Result.append (Tab + "%"")
				Result.append (an_assembly.public_key)
				Result.append ("%"")
				Result.append (New_line)

				selected_assemblies.forth
			end
			
			--Result.append (Local_assembly)
			Result.append (New_line)
			local_assemblies := wizard_information.local_assemblies
			from
				local_assemblies.start
			until
				local_assemblies.after
			loop
				Result.append (Tab)
				l_assembly_name := clone (local_assemblies.item)
				index := l_assembly_name.last_index_of ('\', l_assembly_name.count)
				l_assembly_name.keep_tail (l_assembly_name.count - index)
				l_assembly_name_2 := l_assembly_name
				l_assembly_name.replace_substring_all (".", "_")
				Result.append (l_assembly_name + "_" + ":")
				Result.append (Tab)
				Result.append ("%"")
				Result.append (l_assembly_name_2)
				Result.append ("%"")
				Result.append (New_line)
				
				--Result.append (Tab + local_assemblies.item)

--				an_assembly := emit (wizard_information.local_assemblies.item)				
--				Result.append (Tab + an_assembly.name + "_" + " :" )
--				Result.append (Tab + "%"")
--				Result.append (an_assembly.name)
--				Result.append ("%"")
--				if not an_assembly.version.is_empty then
--					Result.append ("," + Tab + "%"")
--					Result.append (an_assembly.version)
--					Result.append ("%",")
--					Result.append (Tab + "%"")
--					Result.append (an_assembly.culture)
--					Result.append ("%",")
--					Result.append (Tab + "%"")
--					Result.append (an_assembly.public_key)
--					Result.append ("%"")
--					Result.append (New_line)
--				end
				local_assemblies.forth
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

	emit (assembly_path: STRING): ASSEMBLY_INFORMATION is
			-- emit assembly and return its information.
		require
			non_void_assembly_path: assembly_path /= Void
			not_empty_assembly_path: not assembly_path.is_empty
		do
			create Result.make (assembly_path)
		ensure 
			non_void_result: Result /= Void
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

--	Creation_routine_external_name_template: STRING is "<FL_CREATION_ROUTINE_EXTERNAL_NAME>"
--			-- String to be replaced by the chosen creation routine external name
			
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
	
--	External_keyword: STRING is "external"
--			-- External keyword
	
	Assembly_keyword: STRING is "assembly"
			-- Assembly keyword

	Local_assembly: STRING is "local assemblies:"
			-- local assemblies.

	Eiffel_key: STRING is "$ISE_EIFFEL"
			-- Key of environment variable to the Eiffel delivery
	
--	is_selected_assembly (a_location: STRING): BOOLEAN is
--			-- Is assembly corresponding to `a_location' a selected assembly?
--		require
--			non_void_location: a_location /= Void
--			not_emtpy_location: not a_location.is_empty
--			non_void_selected_assemblies: selected_assemblies /= Void
--		local
--			an_assembly_info: ASSEMBLY_INFORMATION
--		do
--			from
--				selected_assemblies.start
--			until
--				selected_assemblies.after or Result
--			loop
--				an_assembly_info := selected_assemblies.item
--				Result := assembly_location (an_assembly_info).is_equal (a_location)
--				selected_assemblies.forth
--			end
--		end
--		
--	is_dependency (a_location: STRING): BOOLEAN is
--			-- Is assembly corresponding to `a_location' a selected assembly?
--		require
--			non_void_location: a_location /= Void
--			not_emtpy_location: not a_location.is_empty
--			non_void_dependencies: dependencies /= Void
--		local
--			an_assembly_info: ASSEMBLY_INFORMATION
--		do
--			from
--				dependencies.start
--			until
--				dependencies.after or Result
--			loop
--				an_assembly_info := dependencies.item
--				Result := assembly_location (an_assembly_info).is_equal (a_location)
--				dependencies.forth
--			end
--		end
		
end -- class WIZARD_PROJECT_GENERATOR
