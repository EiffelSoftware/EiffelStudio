indexing
	description: "Generation Type Page"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_GENERATION_TYPE

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
			Create generate_facade_b.make_with_text("Generate Facade")
			if state_information.generate_facade then
				generate_facade_b.enable_select
			else
				generate_facade_b.disable_select
			end
			generate_facade_b.press_actions.extend(~change_entries)
			Create new_project_b.make_with_text("Generate as a new Project")
			if state_information.new_project then
				new_project_b.enable_select
			else
				new_project_b.disable_select
			end
			new_project_b.press_actions.extend(~change_entries)
			main_box.extend(generate_facade_b)
			main_box.extend(new_project_b)
		end

	proceed_with_current_info is 
			-- Process user entries
		do 
			precursor
			proceed_with_new_state(Create {DB_GENERATION_LOCATION}.make(state_information))
		end

	update_state_information is
			-- Check user entries
		do
			state_information.set_generation_type(generate_facade_b.is_selected,
							new_project_b.is_selected)
			precursor
		end

feature -- Implementation

	generate_facade_b,new_project_b: EV_CHECK_BUTTON

end -- class DB_GENERATION_TYPE
