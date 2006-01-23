indexing
	description: "[
		Objects that generate stand alone widget tests which
			may be compiled by a user.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIDGET_TEST_PROJECT_GENERATOR
	
inherit
	INSTALLATION_LOCATOR
	
	GENERATION_CONSTANTS

feature -- Access

	generate_project (directory: DIRECTORY; test_class_name: STRING; widget_type: STRING) is
			-- Generate project based on `test_class_name'.
		require
			installation_directory_not_void: installation_location /= Void
		local
			project_name, test_name: STRING
		do
			current_generation_directory := directory
			test_name := test_class_name.as_upper
			project_name := test_class_name
			generate_ace_file (project_name)
			generate_application_file (test_name)
			generate_test_file (project_name, widget_type)
			generate_common_test
		end
		
feature {NONE} -- Implementation

	generate_ace_file (project_name: STRING) is
			-- Generate an ace file for a project named
			-- `project_name'.
		local
			ace_template_file: PLAIN_TEXT_FILE
			filename: FILE_NAME
			ace_text: STRING
		do
			create filename.make_from_string (installation_location)
			filename.extend ("templates")
			if (create {PLATFORM}).is_windows then
				filename.extend ("windows")
			else
				filename.extend ("unix")
			end
			filename.extend ("ace_template.ace")
			create ace_template_file.make_open_read (filename)
			ace_template_file.start
			ace_template_file.read_stream (ace_template_file.count)
			ace_text := ace_template_file.last_string
			ace_template_file.close
			add_generated_string (ace_text, project_name, "<PROJECT_NAME>")
			add_generated_string (ace_text, current_generation_directory.name, "<PROJECT_LOCATION>")
			create filename.make_from_string (current_generation_directory.name)
			filename.extend (ace_file_name)
			create ace_template_file.make (filename.out)
			ace_template_file.open_write
			ace_template_file.start
			ace_template_file.putstring (ace_text)
			ace_template_file.close
		end
		
	generate_application_file (test_name: STRING) is
			-- Generate an application file for thsi project.
		local
			application_template_file: PLAIN_TEXT_FILE
			filename: FILE_NAME
			application_text: STRING
		do
			create filename.make_from_string (installation_location)
			filename.extend ("templates")
			filename.extend ("application_template.e")
			create application_template_file.make_open_read (filename)
			application_template_file.start
			application_template_file.read_stream (application_template_file.count)
			application_text := application_template_file.last_string
			application_template_file.close
			add_generated_string (application_text, test_name, "<TEST_NAME>")
			create filename.make_from_string (current_generation_directory.name)
			filename.extend (Application_file_name)
			create application_template_file.make (filename.out)
			application_template_file.open_write
			application_template_file.start
			application_template_file.putstring (application_text)
			application_template_file.close
		end
		
	generate_common_test is
			-- Generate the common test file.
		local
			common_template_file: PLAIN_TEXT_FILE
			filename: FILE_NAME
			common_text: STRING
		do
			create filename.make_from_string (installation_location)
			filename.extend ("templates")
			filename.extend ("generation_only")
			filename.extend (Common_test_file_name)
			create common_template_file.make_open_read (filename)
			common_template_file.start
			common_template_file.read_stream (common_template_file.count)
			common_text := common_template_file.last_string
			common_template_file.close
			create filename.make_from_string (current_generation_directory.name)
			filename.extend (common_test_file_name)
			create common_template_file.make (filename.out)
			common_template_file.open_write
			common_template_file.start
			common_template_file.putstring (common_text)
			common_template_file.close
		end
		
	generate_test_file (test_name, widget_type: STRING) is
			-- generate the file containing the test.
		local
			test_template_file: PLAIN_TEXT_FILE
			filename: FILE_NAME
			test_text: STRING
		do
			create filename.make_from_string (installation_location)
			filename.extend ("tests")
			filename.extend (widget_type.as_lower)
			filename.extend (test_name + ".e")
			create test_template_file.make_open_read (filename)
			test_template_file.start
			test_template_file.read_stream (test_template_file.count)
			test_text := test_template_file.last_string
			test_template_file.close
			create filename.make_from_string (current_generation_directory.name)
			filename.extend (test_name + ".e")
			create test_template_file.make (filename.out)
			test_template_file.open_write
			test_template_file.start
			test_template_file.putstring (test_text)
				-- Now we must copy the necessary pixmaps across to the generation
				-- directory. We retrieve this information from the header of the test.
			copy_required_pixmaps (test_text)
			test_template_file.close
		end
		
	copy_required_pixmaps (class_text: STRING) is
			-- Copy pixmaps required by `class_text' as defined in the class header.
		local
			index_of_pixmaps_required, current_image_number: INTEGER
			index_of_start_quote, index_of_end_quote: INTEGER
			string_to_process: STRING
			index_of_comma: INTEGER
			file_name: FILE_NAME
			file: RAW_FILE
			file_contents: STRING
		do
			index_of_pixmaps_required := class_text.substring_index ("pixmaps_required:", 1)
			if index_of_pixmaps_required > 0 then
				index_of_start_quote := class_text.substring_index ("%"", index_of_pixmaps_required)
				index_of_end_quote := class_text.substring_index ("%"", index_of_start_quote + 1)	
				string_to_process := class_text.substring (index_of_start_quote + 1, index_of_end_quote - 1)
					-- Remove all spaces.
				string_to_process.prune_all (' ')
				from
					index_of_comma := 1
				until
					index_of_comma = 0
				loop
					index_of_comma := string_to_process.index_of (',', 1)
					if index_of_comma = 0 then
						current_image_number := string_to_process.to_integer
					elseif index_of_comma = 1 then
						-- Should never be in this state, but just in case, we simply prune the comma.
						string_to_process := string_to_process.substring (index_of_comma + 1, string_to_process.count)
					else
						current_image_number := (string_to_process.substring (1, index_of_comma - 1)).to_integer
						string_to_process := string_to_process.substring (index_of_comma + 1, string_to_process.count)
					end
					create file_name.make_from_string (installation_location)
					file_name.extend ("bitmaps")
					file_name.extend ("png")
					file_name.extend ("image" + current_image_number.out + ".png")
					create file.make (file_name)
					file.open_read
					file.read_stream (file.count)
					file_contents := file.last_string
					file.close
					
					create file_name.make_from_string (current_generation_directory.name)
					file_name.extend ("image" + current_image_number.out + ".png")
					create file.make (file_name.out)
					file.open_write
					file.start
					file.putstring (file_contents)
					file.close
				end
			end
		end
		
		
	add_generated_string (a_class_text, new, tag: STRING) is
			-- Replace `tag' in `class_text' with `new'.
			-- If `new' is Void then add "".
		require
			a_class_text_not_void: a_class_text /= Void
			tag_contained: a_class_text.has_substring (tag)
			new_not_void: new /= Void
		local
			temp_index: INTEGER
		do
			temp_index := a_class_text.substring_index (tag, 1)
			a_class_text.replace_substring_all (tag, "")
			a_class_text.insert_string (new, temp_index)
		end
		
	current_generation_directory: DIRECTORY;
		-- Directory in which to perform generation

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class WIDGET_TEST_PROJECT_GENERATOR
