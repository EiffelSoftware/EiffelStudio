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

feature {NONE} -- Constants

	Application_type_template: STRING is "<FL_APPLICATION_TYPE>"
			-- String to be replaced by the chosen application type

	Root_class_name_template: STRING is "<FL_ROOT_CLASS_NAME>"
			-- String to be replaced by the chosen root class name

	Creation_routine_name_template: STRING is "<FL_CREATION_ROUTINE_NAME>"
			-- String to be replaced by the chosen creation routine name

	Ace_extension: STRING is ".ace"
			-- Ace files extension

	Eiffel_extension: STRING is ".e"
			-- Eiffel classes extension

	Ace_template_filename: STRING is "template_ace.ace"
			-- Filename of the Ace file template used to automatically generate Ace files for .NET applications

	Ace_template_with_root_class_none_filename: STRING is "template_ace_with_root_class_none.ace"
			-- Filename of the Ace file template used to automatically generate Ace files for .NET applications

	Application_template_filename: STRING is "template_application.e"
			-- Filename of the template used to automatically generate a root class for .NET applications

	None_class: STRING is "none"
			-- `NONE' class

	Comma: STRING is ","
			-- Comma

end -- class WIZARD_PROJECT_GENERATOR
