indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_FINAL_STATE

inherit
	BENCH_WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

creation
	make

feature -- Basic Operations

	proceed_with_current_info is
		do
			process_info
			Precursor
		end

feature -- Process

	process_info is
		local
			dir: DIRECTORY
			l: LINKED_LIST [TUPLE [STRING, STRING]]
			list_of_name: LINKED_LIST [STRING]
			tuple1, tuple2: TUPLE [STRING, STRING]
			class_name: STRING
			i: INTEGER
			next_state: STRING
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
				i := 1
				list_of_name.start
			until
				i > wizard_information.number_state
			loop
				if list_of_name.after then
					list_of_name.start
				end
				class_name := "WIZARD_" + list_of_name.item + "_STATE"
				class_name.to_lower

				create l.make
				create tuple1.make
				tuple1.put ("<FL_WIZARD_CLASS_NAME>", 1)
				tuple1.put (class_name, 2)

				create tuple1.make
				tuple1.put ("<FL_WIZARD_CLASS_NAME>", 1)
				tuple1.put (class_name, 2)
				l.extend (tuple1)

				create tuple1.make
				tuple1.put ("<FL_STATE_NUMBER>", 1)
				tuple1.put (i.out, 2)
				l.extend (tuple1)

					-- Prepare next step
				list_of_name.forth 
				i := i + 1

				if i > wizard_information.number_state then
					next_state := "WIZARD_FINAL_STATE"
				else
					next_state := "WIZARD_"+list_of_name.item+"_STATE"
				end

				create tuple1.make
				tuple1.put ("<FL_NEXT_STATE>", 1)
				tuple1.put (next_state, 2)
				l.extend (tuple1)

				from_template_to_project (wizard_resources_path, "template_wizard_state.e", wizard_information.location + "/src", class_name + ".e", l)
			end

			create tuple1.make
			tuple1.put ("<FL_WIZARD_NAME>", 1)
			tuple1.put (wizard_information.wizard_name, 2)
			create l.make
			l.extend (tuple1)
			from_template_to_project (wizard_resources_path, "template_wizard_initial_state.e", wizard_information.location + "/src", "wizard_initial_state.e", l)
			from_template_to_project (wizard_resources_path, "template_wizard_final_state.e", wizard_information.location + "/src", "wizard_final_state.e", l)

			copy_file ("wizard_information", "e", wizard_information.location + "/src")
			copy_file ("project_wizard_shared", "e", wizard_information.location + "/src")
			copy_file ("eiffel_wizard_icon", "bmp", wizard_information.location + "/pixmaps")
			copy_file ("eiffel_wizard", "bmp", wizard_information.location + "/pixmaps")
		end

	write_bench_notification_ok is
			-- Write onto the file given as argument the project ace file, directory, ...
		local
			file: PLAIN_TEXT_FILE
			rescued: BOOLEAN
			ace_location: FILE_NAME
		do
			if not rescued then
				if callback_content /= Void then
					create ace_location.make_from_string (wizard_information.location)
					ace_location.set_file_name ("ace")
					ace_location.add_extension ("ace")

						-- Modify the fields
					callback_content.replace_substring_all ("<SUCCESS>", "yes")
					callback_content.replace_substring_all ("<ACE>", ace_location)
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

feature -- Access

	display_state_text is
		local
			word: STRING
		do
			title.set_text ("Completing the New Wizard %NApplication Wizard")
			if wizard_information.compile_project then
				word :=" and compile "
			else
				word := " "
			end
			message.set_text (
				"You have specified the following settings:%N%
				%%N%
				%Wizard name: %T" + wizard_information.wizard_name + "%N%
				%Location:     %T" + wizard_information.location + "%N%
				%%N%
				%%N%
				%Click Finish to generate" + word + "this project")
		end

	final_message: STRING is
		do
		end

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
		-- Icon for the Eiffel Store Wizard

end -- class WIZARD_FINAL_STATE
