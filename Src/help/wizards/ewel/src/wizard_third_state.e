indexing
	description	: "Page in which the user choose where he wants to generate the sources."
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_FOURTH_STATE

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
			create location.make (Current)
			location.set_label_string_and_size ("Project location", 10)
			location.set_textfield_string_and_capacity (wizard_information.project_location, 80)
			location.enable_directory_browse_button
			location.generate

			create to_compile_b.make_with_text ("Compile the generated project")
			if wizard_information.compile_project then
				to_compile_b.enable_select
			else
				to_compile_b.disable_select
			end

			choice_box.set_padding (Default_padding_size)
			choice_box.extend (location.widget)
			choice_box.disable_item_expand(location.widget)
			choice_box.extend (to_compile_b)
			choice_box.disable_item_expand (to_compile_b)
			choice_box.extend (create {EV_CELL})

			set_updatable_entries(<<location.browse_actions,
									location.change_actions,
									to_compile_b.select_actions>>)
		end

	proceed_with_current_info is 
		local
			dir: DIRECTORY
			dir_name: DIRECTORY_NAME
			next_window: WIZARD_STATE_WINDOW
			rescued: BOOLEAN
		do
			if not rescued then
				create dir_name.make_from_string (location.text)
				create dir.make (dir_name)
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
		do
			wizard_information.set_project_location (location.text)
			wizard_information.set_compile_project (to_compile_b.is_selected)
			Precursor
		end


feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("Project Location")
			subtitle.set_text ("Where should the Eiffel project be created?")
			message.set_text (
				"Choose the directory where you want to generate your new project.%N%
				%Uncheck the box if you don't want to compile the generated project")
		end

	location: WIZARD_SMART_TEXT_FIELD
			-- Label, Text field and browse button for the project location.

	to_compile_b: EV_CHECK_BUTTON
			-- Should compilation be launched?.

end -- class WIZARD_THIRD_STATE
