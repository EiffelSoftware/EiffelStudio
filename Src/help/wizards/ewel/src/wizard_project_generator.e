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
			-- Generate code for the project.
		do
			if wizard_information.dialog_application then
				generate_code_for_dialog
			else
				generate_code_for_frame
			end
		end

feature {NONE} -- Implementation

	generate_code_for_dialog is
			-- Generate the code for a new dialog-application project
		local
			map_list: LINKED_LIST [TUPLE [STRING, STRING]]
			tuple: TUPLE [STRING, STRING]
			main_dialog_id: STRING
			project_name_lowercase: STRING
			project_location: STRING
		do
				-- cached variables
			project_name_lowercase := clone (wizard_information.project_name)
			project_name_lowercase.to_lower
			project_location := wizard_information.project_location

			create map_list.make
			add_common_parameters (map_list)

			create tuple.make
			tuple.put ("<FL_MAIN_CLASS>", 1)
			tuple.put ("MAIN_WINDOW", 2)
			map_list.extend (tuple)

			create tuple.make
			tuple.put ("<FL_APPLICATION_TYPE>", 1)
			tuple.put ("WEL_MAIN_DIALOG", 2)
			map_list.extend (tuple)
			
			create main_dialog_id.make (0)
			main_dialog_id.append (wizard_information.project_name)
			main_dialog_id.to_lower
			main_dialog_id.prepend ("Idd_")
			main_dialog_id.append ("_dialog")
			create tuple.make
			tuple.put ("<FL_CREATION>", 1)
			tuple.put ("make_by_id ("+main_dialog_id+")", 2)
			map_list.extend (tuple)

			from_template_to_project (wizard_resources_path, "ace.ace", 					project_location, project_name_lowercase + ".ace", map_list)
			from_template_to_project (wizard_resources_path, "root_template.e", 			project_location, "root_class.e", map_list)
			from_template_to_project (wizard_resources_path, "dialog_main_window.e", 		project_location, "main_window.e", map_list)
			from_template_to_project (wizard_resources_path, "dialog_template.rc", 			project_location, project_name_lowercase + ".rc", map_list)
			from_template_to_project (wizard_resources_path, "dialog_resource.h", 			project_location, "resource.h", map_list)
			from_template_to_project (wizard_resources_path, "dialog_application_ids.e", 	project_location, "application_ids.e", map_list)
			copy_icon
			wizard_information.set_ace_location (project_location+"\"+project_name_lowercase+".ace")
		end


	generate_code_for_frame is
			-- Generate the code for a new frame-application project
		local
			map_list: LINKED_LIST [TUPLE [STRING, STRING]]
			tuple: TUPLE [STRING, STRING]
			project_name_lowercase: STRING
			project_location: STRING
		do
				-- cached variables
			project_name_lowercase := clone (wizard_information.project_name)
			project_name_lowercase.to_lower
			project_location := wizard_information.project_location

				-- Create the replacement strings.
			create map_list.make
			add_common_parameters (map_list)

			create tuple.make
			tuple.put ("<FL_ICON_NAME>", 1)
			tuple.put (project_name_lowercase + ".ico", 2)
			map_list.extend (tuple)

			create tuple.make
			tuple.put ("<FL_APPLICATION_TYPE>", 1)
			tuple.put ("WEL_FRAME_WINDOW", 2)
			map_list.extend (tuple)

			create tuple.make
			tuple.put ("<FL_MAIN_CLASS>", 1)
			tuple.put ("MAIN_WINDOW", 2)
			map_list.extend (tuple)

			from_template_to_project (wizard_resources_path, "ace.ace", 				project_location, project_name_lowercase + ".ace", map_list)
			from_template_to_project (wizard_resources_path, "root_template.e", 		project_location, "root_class.e", map_list)
			from_template_to_project (wizard_resources_path, "frame_main_window.e",		project_location, "main_window.e", map_list)
			from_template_to_project (wizard_resources_path, "frame_template.rc",	 	project_location, project_name_lowercase + ".rc", map_list)
			from_template_to_project (wizard_resources_path, "frame_resource.h", 		project_location, "resource.h", map_list)
			from_template_to_project (wizard_resources_path, "frame_application_ids.e", project_location, "application_ids.e", map_list)

			copy_icon
			wizard_information.set_ace_location (project_location+"\"+project_name_lowercase+".ace")
		end

	copy_icon is
			-- Copy the icon
		local
			fi: RAW_FILE
			s: STRING
			project_name_lowercase: STRING
		do
			project_name_lowercase := clone (wizard_information.project_name)
			project_name_lowercase.to_lower

			create fi.make_open_read (wizard_information.icon_location)
			fi.read_stream (fi.count)
			s := fi.last_string
			fi.close

			create fi.make_open_write (wizard_information.project_location + "\" + project_name_lowercase + ".ico")
			fi.put_string (s)
			fi.close
		end

end -- class WIZARD_PROJECT_GENERATOR
