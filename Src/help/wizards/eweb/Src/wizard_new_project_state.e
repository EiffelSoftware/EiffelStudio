indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_NEW_PROJECT_STATE

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info
		end

create
	make

feature -- Basic Operation

	display is 
			-- Display user entries
		do
			build
		end

	build is 
			-- Build entries.
		local
			browse_b: EV_BUTTON
			h1: EV_HORIZONTAL_BOX
		do 
			Create h1
			Create location.make("Choose a Directory",
							 wizard_information.project_location, 10, 30, Current)
			Create browse_b.make_with_text("Browse...")
			browse_b.press_actions.extend(~Browse)

			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(h1)
			h1.extend (location)
--			h1.extend (Create {EV_VERTICAL_BOX})
			h1.extend (browse_b)
			main_box.extend(Create {EV_HORIZONTAL_BOX})	

			h1.disable_child_expand(browse_b)
			main_box.disable_child_expand(h1)

			set_updatable_entries(<<browse_b.press_actions, location.change_actions>>)
		end

	proceed_with_current_info is 
		local
			dir: DIRECTORY
		do
			Precursor
			if not wizard_information.project_location.is_equal("") then
				Create dir.make (wizard_information.project_location)
				if dir.exists then
--					proceed_with_new_state(Create {WIZARD_ADD_FORM_STATE}.make(wizard_information))
				else
--					proceed_with_new_state(Create {WIZARD_ERROR_LOCATION_STATE}.make(wizard_information))
				end
			else
--				proceed_with_new_state(Create {WIZARD_ERROR_LOCATION_STATE}.make(wizard_information))
			end			
		end

	update_state_information is
			-- Check User Entries
		do
			wizard_information.set_project_location (location.text)
			Precursor
		end

	browse is
			-- Launch a computer directory Browser.
		local
			dir_selector: EV_DIRECTORY_DIALOG	
		do
			Create dir_selector
			dir_selector.ok_actions.extend(~directory_selected(dir_selector))
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


feature {NONE} -- Implementation

	location: WIZARD_SMART_TEXT_FIELD

	pixmap_location: STRING is "small_essai.bmp"


end -- class WIZARD_NEW_PROJECT_STATE
