indexing
	description	: "Second state of the wizard wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_PROJECT_NAME_AND_LOCATION_STATE

inherit
	BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end
create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		do 
			create project_name.make (Current)
			project_name.set_label_string_and_size ("Project name", 10)
			project_name.set_textfield_string (wizard_information.project_name)
			project_name.generate

			create project_location.make (Current)
			project_location.set_label_string_and_size ("Project location", 10)
			project_location.set_textfield_string (wizard_information.project_location)
			project_location.enable_directory_browse_button
			project_location.generate

			create to_compile_b.make_with_text ("Compile the generated project")
			if wizard_information.compile_project then
				to_compile_b.enable_select
			else
				to_compile_b.disable_select
			end
			
			choice_box.set_padding (dialog_unit_to_pixels(10))
			choice_box.extend (project_name.widget)
			choice_box.disable_item_expand (project_name.widget)
			choice_box.extend (project_location.widget)
			choice_box.disable_item_expand (project_location.widget)
			choice_box.extend (to_compile_b)
			choice_box.disable_item_expand (to_compile_b)
			choice_box.extend (create {EV_CELL}) -- expandable item

			set_updatable_entries(<<
				project_name.change_actions,
				project_location.change_actions,
				to_compile_b.select_actions>>)
		end

	proceed_with_current_info is 
		local
			dir: DIRECTORY
			next_window: WIZARD_STATE_WINDOW
			rescued: BOOLEAN
			a_project_location: STRING
		do
			if not rescued then
				a_project_location := clone (project_location.text)
				remove_ending_slash_and_spaces (a_project_location)
			
				create dir.make (a_project_location)
				if not dir.exists then
					-- Try to create the directory
					dir.create_dir
				end

				Precursor
				if not dir.exists then
					create {WIZARD_ERROR_LOCATION} next_window.make (wizard_information)
				else
					create {WIZARD_SECOND_STATE} next_window.make (wizard_information)
				end
			else
				-- Something went wrong when checking that the selected directory exists
				-- or when trying to create the directory, go to error.
				create {WIZARD_ERROR_LOCATION} next_window.make (wizard_information)
			end

			Precursor
			proceed_with_new_state (next_window)
		rescue
			rescued := True
			retry
		end

	update_state_information is
			-- Check User Entries
		local
			a_project_location: STRING
		do
			a_project_location := clone (project_location.text)
			remove_ending_slash_and_spaces (a_project_location)
			
			wizard_information.set_project_location (a_project_location)
			wizard_information.set_project_name (project_name.text)
			wizard_information.set_compile_project (to_compile_b.is_selected)
			Precursor
		end

feature {NONE} -- Implementation

	remove_ending_slash_and_spaces (a_directory_name: STRING) is
			-- Remove the ending slash, backslash.
		local
			end_char: CHARACTER
			directory_name_count: INTEGER
		do
				-- Remove slash/backslash.
			directory_name_count := a_directory_name.count
			end_char := a_directory_name @ directory_name_count
			if end_char = '/' or end_char = '\' then			
				a_directory_name.head (directory_name_count - 1)
			end
		end

	display_state_text is
		do
			title.set_text ("Project Name and Project location")
			subtitle.set_text (
				"You can choose the name of the project and%N%
				%the directory where the project will be generated.")

			message.set_text (
				"Please fill in:%N%
				%%T The name of the project (without space).%N%
				%%T The directory where you want the eiffel classes to be generated into.")
		end

	project_location: WIZARD_SMART_TEXT_FIELD
			-- Text field to enter the location of the project

	project_name: WIZARD_SMART_TEXT_FIELD
			-- Text field to enter the name of the wizard

	to_compile_b: EV_CHECK_BUTTON
			-- Should compilation be launched?.

end -- class WIZARD_SECOND_STATE

