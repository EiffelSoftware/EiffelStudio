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
			main_dialog_id: STRING
			project_name_lowercase: STRING
			project_location: STRING
			tuple2: TUPLE [STRING, STRING]
			a_string: STRING
			a_string2: STRING
		do
				-- cached variables
			project_name_lowercase := clone (wizard_information.project_name)
			project_name_lowercase.to_lower
			project_location := wizard_information.project_location

				-- Update the ace file location.
			wizard_information.set_ace_location (project_location+"\"+project_name_lowercase+".ace")

			create map_list.make
			add_common_parameters (map_list)

			if wizard_information.has_menu_bar then
				map_list.extend (tuple_from_file_content ("<FL_MENUBAR_ADD>", "template_menubar_add.e"))
				tuple := tuple_from_file_content ("<FL_MENUBAR_INIT>", "template_menubar_init.e")
				if wizard_information.has_about_dialog then
					tuple2 := tuple_from_file_content ("<FL_HELP_ABOUT_ADD>", "template_menu_help_about_add.e")
				else
					tuple2 := empty_tuple ("<FL_HELP_ABOUT_ADD>")
				end
				a_string ?= tuple.item(2); check a_string_not_void: a_string /= Void end;
				a_string2 ?= tuple2.item(2); check a_string2_not_void: a_string2 /= Void end;
				a_string.replace_substring_all ("<FL_HELP_ABOUT_ADD>", a_string2)
				map_list.extend (tuple)
			else
				map_list.extend (empty_tuple ("<FL_MENUBAR_INIT>"))
				map_list.extend (empty_tuple ("<FL_MENUBAR_ADD>"))
			end

			if wizard_information.has_status_bar then
				map_list.extend (tuple_from_file_content ("<FL_STATUSBAR_ADD>", "template_statusbar_add.e"))
				map_list.extend (tuple_from_file_content ("<FL_STATUSBAR_INIT>", "template_statusbar_init.e"))	
			else
				map_list.extend (empty_tuple ("<FL_STATUSBAR_ADD>"))
				map_list.extend (empty_tuple ("<FL_STATUSBAR_INIT>"))	
			end

			if wizard_information.has_tool_bar then
				map_list.extend (tuple_from_file_content ("<FL_TOOLBAR_ADD>", "template_toolbar_add.e"))
				map_list.extend (tuple_from_file_content ("<FL_TOOLBAR_INIT>", "template_toolbar_init.e"))
			else
				map_list.extend (empty_tuple ("<FL_TOOLBAR_ADD>"))
				map_list.extend (empty_tuple ("<FL_TOOLBAR_INIT>"))	
			end

			if wizard_information.has_about_dialog then
				map_list.extend (tuple_from_file_content ("<FL_ABOUTDIALOG_INIT>", "template_aboutdialog_init.e"))
			else
				map_list.extend (empty_tuple ("<FL_ABOUTDIALOG_INIT>"))
			end

			from_template_to_project (wizard_resources_path, "template_main_window.e", 	project_location, "main_window.e", map_list)
			from_template_to_project (wizard_resources_path, "interface_names.e", 		project_location, "interface_names.e", map_list)
			from_template_to_project (wizard_resources_path, "about_dialog.e",	 		project_location, "about_dialog.e", map_list)
			from_template_to_project (wizard_resources_path, "template_ace.ace", 		project_location, project_name_lowercase + ".ace", map_list)
			from_template_to_project (wizard_resources_path, "application.e",			project_location, "application.e", map_list)

			if wizard_information.has_tool_bar then
				copy_file ("new", "png", project_location)
				copy_file ("open", "png", project_location)
				copy_file ("save", "png", project_location)
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

end -- class WIZARD_PROJECT_GENERATOR
