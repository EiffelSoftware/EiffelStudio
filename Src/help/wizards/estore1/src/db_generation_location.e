indexing
	description: "Page which deals with the different location entries."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_GENERATION_LOCATION


inherit
	STATE_WINDOW
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
			-- Build user entries.
		do 
			Create location.make("Sources Location",state_information.location,10,30,Current)
			Create project_location.make("Project Location",state_information.project_location,10,30,Current)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(location)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
			main_box.extend(project_location)
			main_box.disable_child_expand(location)
			main_box.disable_child_expand(project_location)
			main_box.extend(Create {EV_HORIZONTAL_BOX})
		end

	proceed_with_current_info is 
			-- Process user entries
		local
			next_step: DB_FINISH
			message: EV_ERROR_DIALOG
		do 
			if location.text.count =0 then
				Create message.make_with_text("Please provide a location.")
				entries_checked := FALSE
				entries_changed := TRUE
				message.show_modal
			else
				precursor
				proceed_with_new_state(Create {DB_FINISH}.make(state_information))
			end
		end

	update_state_information is
			-- Check user entries
		do
			state_information.set_locations(location.text,project_location.text)
			precursor
		end

feature -- Implementation

	location,project_location: SMART_TEXT_FIELD

end -- class DB_GENERATION_LOCATION
