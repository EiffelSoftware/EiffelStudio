indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_INITIAL_STATE
inherit
	WIZARD_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info
		end

creation
	make

feature -- basic Operations

	display is 
			-- Display user entries
		do
			build
		end

	build is 
			-- Build entries.
		local
			v1: EV_VERTICAL_BOX
		do 
				Create new_project_b.make_with_text (" Create a new EiffelWeb Project.")
				Create existing_project_b.make_with_text (" Add new forms to an existing project.")

				main_box.extend(Create {EV_HORIZONTAL_BOX})
				main_box.extend(new_project_b)
				main_box.extend(Create {EV_HORIZONTAL_BOX})
				main_box.extend(existing_project_b)
				main_box.extend(Create {EV_HORIZONTAL_BOX})



				set_updatable_entries(<<new_project_b.press_actions, existing_project_b.press_actions>>)
		end

	proceed_with_current_info is 
		do
			Precursor
			if wizard_information.is_new_project then
				proceed_with_new_state(Create {WIZARD_NEW_PROJECT_STATE}.make(wizard_information))
			else
--				proceed_with_new_state(Create {WIZARD_EXISTING_PROJECT_STATE}.make(wizard_information))
			end
		end

	update_state_information is
			-- Check User Entries
		do
			if new_project_b.is_selected then
				wizard_information.set_new_project
			end
			Precursor
		end

	feature -- Implementation

	new_project_b, existing_project_b: EV_RADIO_BUTTON

	pixmap_location: STRING is "small_essai.bmp"



end -- class WIZARD_INITIAL_STATE
