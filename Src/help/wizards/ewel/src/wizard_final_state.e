indexing
	description	: "Final state of the wizard."
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_FINAL_STATE

inherit
	BENCH_WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

	EXECUTION_ENVIRONMENT
		rename
			command_line as ex_command_line
		end

create
	make

feature -- Basic Operations

	build_finish is 
			-- Build user entries.
		do
			create choice_box
			choice_box.wipe_out
			choice_box.set_border_width (10)
			create progress 
			progress.set_minimum_height(20)
			progress.set_minimum_width(100)
			create progress_text
			choice_box.extend(create {EV_CELL})
			choice_box.extend(progress)
			choice_box.disable_item_expand(progress)
			choice_box.extend(progress_text)
			choice_box.extend(create {EV_CELL})

			choice_box.set_background_color (white_color)
			progress.set_background_color (white_color)
			progress_text.set_background_color (white_color)
		end

	proceed_with_current_info is
		do
			build_finish
			if wizard_information.dialog_application then
				generate_code_for_dialog
			else
				generate_code_for_frame
			end
			write_bench_notification_ok
			Precursor
		end

feature -- Access

	display_state_text is
		local
			word: STRING
		do
			title.set_text ("Completing the New WEL%NApplication Wizard")
			if wizard_information.compile_project then
				word :=" and compile "
			else
				word := " "
			end
			message.set_text (
				"You have specified the following settings:%N%
				%%N%
				%Project name: %T" + wizard_information.project_name + "%N%
				%Location:     %T" + wizard_information.location + "%N%
				%%N%
				%%N%
				%Click Finish to generate" + word + "this project")
		end

	final_message: STRING is
		do
		end

feature -- Process

	generate_code_for_dialog is
			-- Generate the code for a new dialog-application project
		local
			map_list: LINKED_LIST [TUPLE [STRING, STRING]]
			tuple: TUPLE [STRING, STRING]
			directory_name: STRING
			main_dialog_id: STRING
			project_name_lowercase: STRING
		do
			create map_list.make
			add_common_parameters (map_list)

			project_name_lowercase := clone (wizard_information.project_name)
			project_name_lowercase.to_lower

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

			from_template_to_project (wizard_resources_path, "ace.ace", wizard_information.location, project_name_lowercase + ".ace", map_list)
			from_template_to_project (wizard_resources_path, "root_template.e", wizard_information.location, "root_class.e", map_list)
			from_template_to_project (wizard_resources_path, "dialog_main_window.e", wizard_information.location, "main_window.e", map_list)
			from_template_to_project (wizard_resources_path, "dialog_template.rc", wizard_information.location, project_name_lowercase + ".rc", map_list)
			from_template_to_project (wizard_resources_path, "dialog_resource.h", wizard_information.location, "resource.h", map_list)
			from_template_to_project (wizard_resources_path, "dialog_application_ids.e", wizard_information.location, "application_ids.e", map_list)

			directory_name := current_working_directory
			change_working_directory (directory_name)

			copy_icon
			wizard_information.set_ace_location (wizard_information.location+"\"+project_name_lowercase+".ace")
		end


	generate_code_for_frame is
			-- Generate the code for a new frame-application project
		local
			map_list: LINKED_LIST [TUPLE [STRING, STRING]]
			tuple: TUPLE [STRING, STRING]
			project_name_lowercase: STRING
		do
				-- Create the replacement strings.
			create map_list.make
			add_common_parameters (map_list)

			project_name_lowercase := clone (wizard_information.project_name)
			project_name_lowercase.to_lower

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

			from_template_to_project (wizard_resources_path, "ace.ace", wizard_information.location, project_name_lowercase + ".ace", map_list)
			from_template_to_project (wizard_resources_path, "root_template.e", wizard_information.location, "root_class.e", map_list)
			from_template_to_project (wizard_resources_path, "frame_main_window.e", wizard_information.location, "main_window.e", map_list)
			from_template_to_project (wizard_resources_path, "frame_template.rc", wizard_information.location, project_name_lowercase + ".rc", map_list)
			from_template_to_project (wizard_resources_path, "frame_resource.h", wizard_information.location, "resource.h", map_list)
			from_template_to_project (wizard_resources_path, "frame_application_ids.e", wizard_information.location, "application_ids.e", map_list)

			copy_icon
			wizard_information.set_ace_location (wizard_information.location+"\"+project_name_lowercase+".ace")
		end

	copy_icon is
			-- Copy the icon
		local
			fi: RAW_FILE
			s: STRING
			project_name_lowercase: STRING
		do
			project_name_lowercase := clone(wizard_information.project_name)
			project_name_lowercase.to_lower

			create fi.make_open_read (wizard_information.icon_location)
			fi.read_stream (fi.count)
			s := fi.last_string
			fi.close

			create fi.make_open_write (wizard_information.location + "\" + project_name_lowercase + ".ico")
			fi.put_string (s)
			fi.close
		end

	write_bench_notification_ok is
			-- Write onto the file given as argument the project ace file, directory, ...
		local
			file: PLAIN_TEXT_FILE
			rescued: BOOLEAN
		do
			if not rescued then
				if callback_content /= Void then
						-- Modify the fields
					callback_content.replace_substring_all ("<SUCCESS>", "yes")
					callback_content.replace_substring_all ("<ACE>", wizard_information.ace_location)
					callback_content.replace_substring_all ("<DIRECTORY>", wizard_information.location)
					if wizard_information.compile_project then
						callback_content.replace_substring_all ("<COMPILATION>", "yes")
					else
						callback_content.replace_substring_all ("<COMPILATION>", "no")
					end
				end

				if callback_filename /= Void then
					create file.make_open_write (callback_filename)
					file.put_string (callback_content)
					file.close
				end
			end
		rescue
			rescued := True
			retry
		end

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
			-- Icon for the Eiffel Wel Wizard

end -- class WIZARD_FINAL_STATE
