indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_NUMBER_STATE

inherit
	INTERMEDIARY_STATE_WINDOW
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
		local
			browse_b: EV_BUTTON
			h1: EV_HORIZONTAL_BOX
		do 
			create h1
			create wizard_name.make("Name of the wizard",
							 wizard_information.wizard_name, 10, 30, Current, False)
			h1.extend (wizard_name)
			main_box.extend (h1)
			main_box.disable_item_expand (h1)
			main_box.extend (create {EV_HORIZONTAL_BOX})

			create h1
			create location.make("Choose a Directory",
							 wizard_information.location, 10, 30, Current, False)		
			create browse_b.make_with_text("Browse...")
			browse_b.select_actions.extend(~Browse)
			h1.extend (location)
			h1.extend (browse_b)
			h1.disable_item_expand (browse_b)
			main_box.extend (h1)
			main_box.disable_item_expand(h1)
			main_box.extend (create {EV_HORIZONTAL_BOX})

			create h1
			create number_state.make("Number of state in the wizard",
							 wizard_information.number_state.out, 10, 30, Current, False)
			h1.extend (number_state)
			main_box.extend(h1)
			main_box.disable_item_expand(h1)
			main_box.extend (create {EV_HORIZONTAL_BOX})

			set_updatable_entries(<<wizard_name.change_actions, location.change_actions,
									number_state.change_actions>>)
		end

	proceed_with_current_info is 
		local
			dir: DIRECTORY
		do
			Precursor
			if number_state.text.is_integer then
				proceed_with_new_state(Create {WIZARD_FINAL_STATE}.make(wizard_information))
			else
				proceed_with_new_state(create {WIZARD_FINAL_STATE}.make(wizard_information))
			end
		end

	update_state_information is
			-- Check User Entries
		local
			num: INTEGER
			s: STRING
		do
			num:= number_state.text.to_integer
			wizard_information.set_number_state (num)
			s:= location.text
			s.replace_substring_all (" ", "")
			wizard_information.set_location (s)
			wizard_information.set_wizard_name (wizard_name.text)
			Precursor
		end

feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("WIZARD SPECIFICATION")
			message.set_text ("Choose:%N%T+ The name of the wizard.(No space !)%
								%%N%T+ The location where you want to generate the eiffel classes%
								%%N%T+ The number of state (10 Max.)")
		end

	number_state, location, wizard_name: WIZARD_SMART_TEXT_FIELD



feature -- Process

	browse is
			-- Launch a computer directory Browser.
		local
			dir_selector: EV_DIRECTORY_DIALOG	
		do
			create dir_selector
			dir_selector.ok_actions.extend (~directory_selected (dir_selector))
			dir_selector.show_modal
		end

	directory_selected (dir_selector: EV_DIRECTORY_DIALOG) is
			-- The user selected a directory from the browser. 
			-- It updates the text fields accordingly.
		require
			selector_exists: dir_selector /= Void
		do
			location.set_text(dir_selector.directory)
		end

end -- class WIZARD_NUMBER_STATE
