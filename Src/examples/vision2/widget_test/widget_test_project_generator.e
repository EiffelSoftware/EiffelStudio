indexing
	description: "[
		Objects that generate stand alone widget tests which
			may be compiled by a user.
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIDGET_TEST_PROJECT_GENERATOR
	
inherit
	EXECUTION_ENVIRONMENT
	
	GENERATION_CONSTANTS

feature -- Access

	generate_project (directory: DIRECTORY; test_class_name: STRING; widget_type: STRING) is
			-- Generate project based on `test_class_name'.
		local
			project_name, project_location, test_name: STRING

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
			create filename.make_from_string (current_working_directory)
			filename.extend ("templates")
			if (create {EV_ENVIRONMENT}).supported_image_formats.has ("ICO") then
				filename.extend ("Windows")
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
			create filename.make_from_string (current_working_directory)
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
			create filename.make_from_string (current_working_directory)
			filename.extend ("templates")
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
			create filename.make_from_string (current_working_directory)
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
			test_template_file.close
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
		
	current_generation_directory: DIRECTORY
		-- Directory in which to perform generation

end -- class WIDGET_TEST_PROJECT_GENERATOR
