indexing
	description	: "Object to generate a project."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

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
		do
			generate_external_assemblies
			
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
			
			from_template_to_project (wizard_resources_path, "template_ace.ace", 		project_location, project_name_lowercase + ".ace", map_list)
			from_template_to_project (wizard_resources_path, "application.e",			project_location, "application.e", map_list)
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
		
	generate_external_assemblies is
			-- Generate external assemblies
		local
			selected_assemblies: LIST [ASSEMBLY_INFORMATION]
		do
			selected_assemblies := wizard_information.selected_assemblies
			from
				selected_assemblies.start
			until
				selected_assemblies.after
			loop
				generate_external_assembly (selected_assemblies.item)
				selected_assemblies.forth
			end
		end
		
	generate_external_assembly (an_assembly: ASSEMBLY_INFORMATION) is
			-- Generate eiffel classes for `an_assembly' from metadata
		local
			emitter_command_line: STRING
			generation_pathname: STRING
		do
			generation_pathname := generation_path (an_assembly)
			
			create emitter_command_line.make (100)
			emitter_command_line.append (Emitter_command)
			emitter_command_line.append (" ")
			emitter_command_line.append (an_assembly.path)
			emitter_command_line.append (" ")
			emitter_command_line.append (generation_pathname)

			(create {EXECUTION_ENVIRONMENT}).system (emitter_command_line)
		end
		
	generation_path (an_assembly: ASSEMBLY_INFORMATION): STRING is
			-- Create and return the path to store generated files for `an_assembly'
		local
			tmp_dir: DIRECTORY
		do
			create Result.make (50)
			Result.append (wizard_information.project_location)
			create tmp_dir.make (Result)
			if not tmp_dir.exists then
				tmp_dir.create_dir
			end
			
			if (Result @ Result.count) /= '\' then
				Result.append ("\")
			end
			Result.append ("external_assemblies")
			create tmp_dir.make (Result)
			if not tmp_dir.exists then
				tmp_dir.create_dir
			end
			
			Result.append ("\")
			Result.append (an_assembly.name)
			create tmp_dir.make (Result)
			if not tmp_dir.exists then
				tmp_dir.create_dir
			end

			Result.append ("\")
		end
		
end -- class WIZARD_PROJECT_GENERATOR
