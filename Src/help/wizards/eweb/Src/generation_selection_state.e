indexing
	description: "The user selects which generation he would like to see performed."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GENERATION_SELECTION_STATE

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

creation
	make

feature -- basic Operations

	build is 
			-- Build entries.
		local
			v1: EV_VERTICAL_BOX
		do 
				Create new_project_b.make_with_text (" Create a new EiffelWeb Project.")
				Create existing_project_b.make_with_text (" Add new forms to an existing project.")

				choice_box.extend(Create {EV_HORIZONTAL_BOX})
				choice_box.extend(new_project_b)
--				choice_box.extend(Create {EV_HORIZONTAL_BOX})
				choice_box.extend(existing_project_b)
				choice_box.extend(Create {EV_HORIZONTAL_BOX})
				set_updatable_entries(<<new_project_b.select_actions, existing_project_b.select_actions>>)
		end

	proceed_with_current_info is 
			-- Proceed, load the next state.
		do
			Precursor
			proceed_with_new_state(Create {DIRECTORY_SELECTION_STATE}.make(wizard_information))
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

	display_state_text is
		do
			message.set_text ("The wizard can either build a project from scratch or%N%
						%help you to add classes to an existing project. ")
			title.set_text ("Generation Type")
		end

end -- class GENERATION_SELECTION_STATE
