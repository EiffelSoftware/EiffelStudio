indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FINAL_STATE

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

	TABLE_OF_SYMBOLS

	EXECUTION_ENVIRONMENT
		rename
			command_line as ex_command_line
		end

	INTERFACE_MANAGER

create
	make

feature -- Basic Operations

	build_finish is 
			-- Build user entries.
		local
			h1: EV_HORIZONTAL_BOX
		do
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
				if wizard_information.dialog_with_no_rc then
					generate_code_for_dialog_no_rc
				else
					generate_code_for_dialog
				end
			else
				generate_code_for_frame
			end
			Precursor
		end

feature -- Access

	display_state_text is
		local
			word: STRING
		do
			title.set_text ("Final Step")
			if not wizard_information.compile_project then
				word:=" not "
			else
				word:= " "
			end
			message.set_text ("Your project is going to be generated in:" + wizard_information.location + "%
								%%N%NAfter the generation, EiffelBench will" + word + "be launched")
		end

	final_message: STRING is
		do
		end

feature -- Process

	generate_code_for_dialog is
		local
			map_list: LINKED_LIST [TUPLE [STRING, STRING]]
			tuple: TUPLE [STRING, STRING]
			fl_tag, new_s: STRING
			folder: DIRECTORY
			directory_name: STRING
		do
			copy_rc_file

			create map_list.make
			create tuple.make
			tuple.put ("<FL_PROJECT_NAME>", 1)
			tuple.put (wizard_information.project_name, 2)
			map_list.extend (tuple)
			create tuple.make
			tuple.put ("<FL_LOCATION>", 1)
			tuple.put (wizard_information.location, 2)
			map_list.extend (tuple)
			from_template_to_project (wizard_resources_path, "ace.ace", wizard_information.location, "ace.ace", map_list)

			create map_list.make
			create tuple.make
			tuple.put ("<FL_MAIN_CLASS>", 1)
			tuple.put (wizard_information.root_dialog_name, 2)
			map_list.extend (tuple)
			from_template_to_project (wizard_resources_path, "root_template.e", wizard_information.location, "root_class.e", map_list)


			directory_name := current_working_directory
			change_working_directory (wizard_information.location)
			tds.generate_wel_code
			change_working_directory (directory_name)

			copy_all_icons_and_bitmaps

		end


	generate_code_for_frame is
		local
			map_list: LINKED_LIST [TUPLE [STRING, STRING]]
			tuple: TUPLE [STRING, STRING]
			fl_tag, new_s: STRING
		do
			create map_list.make
			create tuple.make
			tuple.put ("<FL_PROJECT_NAME>", 1)
			tuple.put (wizard_information.project_name, 2)
			map_list.extend (tuple)
			create tuple.make
			tuple.put ("<FL_LOCATION>", 1)
			tuple.put (wizard_information.location, 2)
			map_list.extend (tuple)
			from_template_to_project (wizard_resources_path, "ace.ace", wizard_information.location, "ace.ace", map_list)

			create map_list.make
			create tuple.make
			tuple.put ("<FL_ICON_NAME>", 1)
			tuple.put (wizard_information.project_name + ".ico", 2)
			map_list.extend (tuple)
			from_template_to_project (wizard_resources_path, "template.rc", wizard_information.location, wizard_information.project_name + ".rc", map_list)

			create map_list.make
			create tuple.make
			tuple.put ("<FL_APPLICATION_TYPE>", 1)
			tuple.put ("WEL_FRAME_WINDOW", 2)
			map_list.extend (tuple)
			create tuple.make
			tuple.put ("<FL_CREATION>", 1)
			tuple.put ("make_top (%"Wizard generated%")", 2)
			map_list.extend (tuple)
			from_template_to_project (wizard_resources_path, "main_window_template.e", wizard_information.location, "main_window.e", map_list)

			copy_icon

			create map_list.make
			create tuple.make
			tuple.put ("<FL_MAIN_CLASS>", 1)
			tuple.put ("MAIN_WINDOW", 2)
			map_list.extend (tuple)
			from_template_to_project (wizard_resources_path, "root_template.e", wizard_information.location, "root_class.e", map_list)

--			copy_file ("root_class", "e" , wizard_information.location)

			copy_file ("application_ids", "e", wizard_information.location)

		end

	generate_code_for_dialog_no_rc is
		local
			map_list: LINKED_LIST [TUPLE [STRING, STRING]]
			tuple: TUPLE [STRING, STRING]
		do
			create map_list.make
			create tuple.make
			tuple.put ("<FL_PROJECT_NAME>", 1)
			tuple.put (wizard_information.project_name, 2)
			map_list.extend (tuple)
			create tuple.make
			tuple.put ("<FL_LOCATION>", 1)
			tuple.put (wizard_information.location, 2)
			map_list.extend (tuple)
			from_template_to_project (wizard_resources_path, "ace.ace", wizard_information.location, "ace.ace", map_list)

			create map_list.make
			create tuple.make
			tuple.put ("<FL_MAIN_CLASS>", 1)
			tuple.put ("DIALOG", 2)
			map_list.extend (tuple)
			from_template_to_project (wizard_resources_path, "root_template.e", wizard_information.location, "root_class.e", map_list)

			copy_file ("dialog", "e", wizard_information.location)
		end

	copy_rc_file is
		local
			f1,f_name: FILE_NAME
			fi: RAW_FILE
			s: STRING
		do
			create fi.make_open_read (wizard_information.full_path_rc)
			fi.read_stream (fi.count)
			s := fi.last_string
			fi.close
			create fi.make_open_write (wizard_information.location + "\" + wizard_information.project_name + ".rc")
			fi.put_string (s)
			fi.close
		end

	copy_icon is
		local
			f1,f_name: FILE_NAME
			fi: RAW_FILE
			s: STRING
		do
			create fi.make_open_read (wizard_information.icon_location)
			fi.read_stream (fi.count)
			s := fi.last_string
			fi.close

			create fi.make_open_write (wizard_information.location + "\" + wizard_information.project_name + ".ico")
			fi.put_string (s)
			fi.close
		end

	copy_all_icons_and_bitmaps is
		local
			t_icon: TDS_ICON
			l_of_icon: LINKED_LIST [STRING]
			t_bitmap: TDS_BITMAP
			l_of_bitmap: LINKED_LIST [STRING]
			t_cursor: TDS_CURSOR
			l_of_cursor: LINKED_LIST [STRING]
			path, dir: STRING
		do
			from
				tds.start
				create l_of_icon.make
				create l_of_bitmap.make
				create l_of_cursor.make
			until
				tds.off
			loop
				t_icon ?= tds.item_for_iteration
				if t_icon /= Void then
					fill_list (l_of_icon, t_icon)
				else
					t_bitmap ?= tds.item_for_iteration
					if t_bitmap /= Void then
						fill_list (l_of_bitmap, t_bitmap)
					else
						t_cursor ?= tds.item_for_iteration
						if t_cursor /= Void then
							fill_list (l_of_cursor, t_cursor)
						end
					end
				end				
				tds.forth
			end
					-- Retrieve the path of the resource file directory
			path:= wizard_information.full_path_rc
			path.replace_substring_all (wizard_information.rc_location, "")
			path.replace_substring ("", path.count, path.count)

			dir:= current_working_directory
			change_working_directory (path)

			copy_pix (l_of_icon)
			copy_pix (l_of_bitmap)
			copy_pix (l_of_cursor)
			copy_include_file

			change_working_directory (dir)

	end

	fill_list (l_pix: LINKED_LIST [STRING]; pix: TDS_RESOURCE) is
		do
			from
				pix.start
			until
				pix.after
			loop
				l_pix.extend (clone (pix.item.filename))
				pix.forth
			end
		end

	copy_pix (l_pix: LINKED_LIST [STRING]) is
		local
			filename: STRING
		do
			from 
				l_pix.start
			until
				l_pix.after
			loop
				filename:= l_pix.item
				filename.replace_substring_all ("%"", "")
				from_template_to_project (current_working_directory, filename, wizard_information.location, filename, Void)
				l_pix.forth
			end
		end

	copy_include_file is
		local
			filename: STRING
		do
			from
				l_of_include_file.start
			until
				l_of_include_file.after
			loop
				filename:= l_of_include_file.item
				filename.replace_substring_all ("%"", "")
				from_template_to_project (current_working_directory, filename, wizard_information.location, filename, Void)
				l_of_include_file.forth
			end

		end

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
		-- Icon for the Eiffel Wel Wizard

end -- class WIZARD_FINAL_STATE
