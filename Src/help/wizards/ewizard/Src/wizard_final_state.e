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

creation
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
			process_info
			Precursor
		end

feature -- Process

	process_info is
		local
			dir: DIRECTORY
			fi: PLAIN_TEXT_FILE
			l: LINKED_LIST [TUPLE [STRING, STRING]]
			list_of_name: LINKED_LIST [STRING]
			tuple1, tuple2: TUPLE [STRING, STRING]
			class_name: STRING
			i: INTEGER
		do
			create list_of_name.make
			list_of_name.make
			list_of_name.extend ("FIRST")
			list_of_name.extend ("SECOND")
			list_of_name.extend ("THIRD")
			list_of_name.extend ("FOURTH")
			list_of_name.extend ("FIFTH")
			list_of_name.extend ("SIXTH")
			list_of_name.extend ("SEVENTH")
			list_of_name.extend ("HEIGHT")
			list_of_name.extend ("NINETH")
			list_of_name.extend ("TENTH")


			create dir.make (wizard_information.location)
			if dir.exists then
				dir.delete_content
			else
				dir.create_dir
			end
			create dir.make (wizard_information.location + "\pixmaps")
			dir.create_dir
			create dir.make (wizard_information.location + "\src")
			dir.create_dir
			create dir.make (wizard_information.location + "\resources")
			dir.create_dir

			create tuple1.make
			tuple1.put ("<FL_WIZARD_NAME>", 1)
			tuple1.put (wizard_information.wizard_name, 2)
			create tuple2.make
			tuple2.put ("<FL_WIZARD_PATH>", 1)
			tuple2.put (wizard_information.location, 2)
			create l.make
			l.extend (tuple1)
			l.extend (tuple2)
			from_template_to_project (wizard_resources_path, "Ace.ace", wizard_information.location, "Ace.ace", l)

			from
				i:= 1
				list_of_name.start
			until
				i > wizard_information.number_state
			loop
					if list_of_name.after then
						list_of_name.start
					end
					create tuple1.make
					tuple1.put ("<FL_WIZARD_CLASS_NAME>", 1)
					class_name:= "WIZARD_" + list_of_name.item + "_STATE"
					tuple1.put (class_name, 2)
					class_name.to_lower
					create l.make
					l.extend (tuple1)
					from_template_to_project (wizard_resources_path, "template_state.e", wizard_information.location + "/src", class_name + ".e", l)

					i:= i+1
					list_of_name.forth
			end

			create tuple1.make
			tuple1.put ("<FL_WIZARD_NAME>", 1)
			tuple1.put (wizard_information.wizard_name, 2)
			create l.make
			l.extend (tuple1)
			from_template_to_project (wizard_resources_path, "initial_template_state.e", wizard_information.location + "/src", "wizard_initial_state.e", l)

			copy_file ("wizard_final_state", "e", wizard_information.location + "/src")
			copy_file ("wizard_information", "e", wizard_information.location + "/src")
			copy_file ("project_wizard_shared", "e", wizard_information.location + "/src")
			copy_file ("eiffel_wizard_icon", "bmp", wizard_information.location + "/pixmaps")
			copy_file ("eiffel_wizard", "bmp", wizard_information.location + "/pixmaps")

			
		end


feature -- Access

	display_state_text is
		do
			title.set_text ("WIZARD GENERATION")
			message.set_text ("%N%NAll the states will be generated in the directory that you have%
								%%Nspecified.")
		end

	final_message: STRING is
		do
		end

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
		-- Icon for the Eiffel Store Wizard

end -- class WIZARD_FINAL_STATE
