indexing
	description: "Generation Type Page"
	author: "David S"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_GENERATION_TYPE

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build,
			change_entries
		end

create
	make

feature -- basic Operations

	build is 
			-- Build user entries.
		do 
			Create generate_facade_b.make_with_text("Generate Facade")
			Create new_project_b.make_with_text("Generate as a new Project")
			Create example_b.make_with_text("Generate example")
			Create current_project_b.make_with_text("Integrate within existing Project")
--			if wizard_information.generate_facade then
				generate_facade_b.enable_select
--			else
--				generate_facade_b.disable_select
--			end
			if wizard_information.new_project then
				new_project_b.enable_select
			else
				current_project_b.enable_select
			end
			if wizard_information.example then
				example_b.enable_select
			else
				example_b.disable_select
			end		

			choice_box.extend(Create {EV_CELL})
			choice_box.extend(new_project_b)
			new_project_b.set_minimum_height (20)
			choice_box.disable_item_expand (new_project_b)
			choice_box.extend(current_project_b)
			current_project_b.set_minimum_height (20)
			choice_box.disable_item_expand (current_project_b)
--			choice_box.extend(Create {EV_CELL})
--			choice_box.extend(example_b)
--			example_b.set_minimum_height (20)
--			choice_box.disable_item_expand (example_b)
--			choice_box.extend(generate_facade_b)
--			generate_facade_b.set_minimum_height (20)
--			choice_box.disable_item_expand (generate_facade_b)
			choice_box.extend(Create {EV_CELL})

			set_updatable_entries(<<generate_facade_b.select_actions,
									new_project_b.select_actions,
									current_project_b.select_actions,
									example_b.select_actions>>)
		end

	proceed_with_current_info is 
			-- Process user entries
		do 
			precursor
			proceed_with_new_state(Create {DB_GENERATION_LOCATION}.make(wizard_information))
		end

	update_state_information is
			-- Check user entries
		do
			wizard_information.set_generation_type(generate_facade_b.is_selected,
							new_project_b.is_selected)
			precursor
		end

	change_entries is
			-- The user pressed a button.
		do
			precursor
			if current_project_b /= Void then
				if current_project_b.is_selected then
					example_b.disable_select
					example_b.disable_sensitive
				else
					example_b.enable_sensitive
				end
			end
		end

	display_state_text is
		do
			title.set_text ("STEP 3: TYPE OF GENERATION")
			message.set_text ("%NYou need to select if you want to use an existing project or not")
--								 %
--								%%N%Ntype of files you want to generate%
--								%%N%NIf you need to generate the interface between EiffelStore%
--								%%Nand your example choose generate facade.")
		end

feature -- Implementation

	example_b,generate_facade_b: EV_CHECK_BUTTON

	new_project_b,current_project_b: EV_RADIO_BUTTON

end -- class DB_GENERATION_TYPE
