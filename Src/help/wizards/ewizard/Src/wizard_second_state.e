indexing
	description	: "Second state of the wizard wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_SECOND_STATE

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
			create wizard_name.make (Current)
			wizard_name.set_label_string_and_size ("Name of the wizard", 10)
			wizard_name.set_textfield_string_and_capacity (wizard_information.wizard_name, 30)
			wizard_name.generate

			create location.make (Current)
			location.set_label_string_and_size ("Project location", 10)
			location.set_textfield_string_and_capacity (wizard_information.location, 30)
			location.enable_directory_browse_button
			location.generate

			create to_compile_b.make_with_text ("Compile the generated project")
			if wizard_information.compile_project then
				to_compile_b.enable_select
			else
				to_compile_b.disable_select
			end
			
			choice_box.set_padding (dialog_unit_to_pixels(10))
			choice_box.extend (wizard_name.widget)
			choice_box.disable_item_expand (wizard_name.widget)
			choice_box.extend (location.widget)
			choice_box.disable_item_expand(location.widget)
			choice_box.extend (to_compile_b)
			choice_box.disable_item_expand (to_compile_b)
			choice_box.extend (create {EV_CELL}) -- expandable item

			set_updatable_entries(<<
				wizard_name.change_actions,
				location.change_actions,
				to_compile_b.select_actions>>)
		end

	proceed_with_current_info is 
		local
			dir: DIRECTORY
			next_window: WIZARD_STATE_WINDOW
			rescued: BOOLEAN
		do
			if not rescued then
				create dir.make (wizard_information.location)
				if not dir.exists then
					-- Try to create the directory
					dir.create_dir
				end

				Precursor
				if not dir.exists then
					create {WIZARD_ERROR_LOCATION} next_window.make (wizard_information)
				else
					create {WIZARD_FINAL_STATE} next_window.make (wizard_information)
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
			s: STRING
		do
			s := clone (location.text)
			s.replace_substring_all (" ", "")
			if (s @ s.count = '\') or (s @ s.count = '/') then
				s.head (s.count - 1)
			end
			wizard_information.set_location (s)
			wizard_information.set_wizard_name (wizard_name.text)
			wizard_information.set_compile_project (to_compile_b.is_selected)
			Precursor
		end

feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("Wizard Name and Project location")
			subtitle.set_text (
				"You can choose the name of the wizard and%N%
				%the directory where the project will be generated.")

			message.set_text (
				"Choose:%N%
				%%T The name of the wizard (without space).%N%
				%%T The directory where you want to generate the eiffel classes.")
		end

	location: WIZARD_SMART_TEXT_FIELD
			-- Text field to enter the location of the project

	wizard_name: WIZARD_SMART_TEXT_FIELD
			-- Text field to enter the name of the wizard

	to_compile_b: EV_CHECK_BUTTON
			-- Should compilation be launched?.

end -- class WIZARD_SECOND_STATE

