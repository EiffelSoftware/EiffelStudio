indexing
	description: "Generation Type Page"
	author: "David S"
	date: "$Date$"
	revision: "$Revision$"

class
	DB_GENERATION_TYPE

inherit
	WIZARD_INTERMEDIARY_STATE_WINDOW
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
		local
			hbox : EV_HORIZONTAL_BOX
			vbox1 : EV_VERTICAL_BOX
			cell : EV_CELL
		do 
			create new_project_b.make_with_text ("Generate as a new Project")
			create current_project_b.make_with_text ("Integrate within existing Project")
			create vision_example_b.make_with_text ("Generate example using EiffelVision2 library")
			create simple_example_b.make_with_text ("Generate simple example")

			choice_box.extend (create {EV_CELL})
			create hbox
			create vbox1
			vbox1.set_minimum_width (183)
			vbox1.extend (new_project_b)
			new_project_b.set_minimum_height (20)
			vbox1.disable_item_expand (new_project_b)
			create cell
			cell.set_minimum_height (20)
			vbox1.extend (cell)
			vbox1.disable_item_expand (cell)
			vbox1.extend (current_project_b)
			current_project_b.set_minimum_height (20)
			vbox1.disable_item_expand (current_project_b)
			hbox.extend (vbox1)
			create vbox2
			vbox2.extend (vision_example_b)
			vision_example_b.set_minimum_height (20)
			vbox2.disable_item_expand (vision_example_b)
			vbox2.extend (simple_example_b)
			simple_example_b.set_minimum_height (20)
			vbox2.disable_item_expand (simple_example_b)
			hbox.extend (vbox2)
			choice_box.extend (hbox)
			choice_box.extend (create {EV_CELL})

				-- To deal with the back button (Retrieve the history)
			if wizard_information.new_project then
				new_project_b.enable_select
				if wizard_information.vision_example then
					vision_example_b.enable_select
				else
					simple_example_b.enable_select
				end
			else
				current_project_b.enable_select
				vbox2.disable_sensitive
			end

			set_updatable_entries (<<new_project_b.select_actions,
									current_project_b.select_actions,
									vision_example_b.select_actions,
									simple_example_b.select_actions>>)
		end

	proceed_with_current_info is 
			-- Process user entries
		do 
			precursor
			proceed_with_new_state(create {DB_GENERATION_LOCATION}.make(wizard_information))
		end

	update_state_information is
			-- Check user entries
		do
			wizard_information.set_generation_type (new_project_b.is_selected)
			wizard_information.set_vision_example (vision_example_b.is_selected)
			precursor
		end

	change_entries is
			-- The user pressed a button.
		do
			precursor
			if current_project_b /= Void then
				if current_project_b.is_selected then
					vbox2.disable_sensitive
				else
					vbox2.enable_sensitive
				end
			end
		end

	display_state_text is
		do
			title.set_text ("STEP 3: TYPE OF GENERATION")
			message.set_text ("%NYou need to select if you want to use an existing project or not.")
		end

feature -- Implementation

	generate_facade_b: EV_CHECK_BUTTON
	
	vbox2 : EV_VERTICAL_BOX
		-- Box to choose the example to generate (via radio buttons). 
	
	new_project_b, current_project_b: EV_RADIO_BUTTON
		-- Coupled radio buttons to choose to generate a new project or not.

	vision_example_b, simple_example_b: EV_RADIO_BUTTON
		-- Coupled radio buttons to choose which example to generate (when new project selected).

end -- class DB_GENERATION_TYPE
