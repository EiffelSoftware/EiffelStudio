indexing
	description: "Window on which is displayed the wizards"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WINDOW

inherit
	EV_TITLED_WINDOW

	STATE_MANAGER
		undefine
			default_create
		end

Creation
	make

feature -- Initialization

	make is
			-- Initialize Current window.
		local
			v1: EV_VERTICAL_BOX
			h1: EV_HORIZONTAL_BOX
		do
			default_create
			set_size(300,300)
			Create v1
			extend(v1)
			Create h1
			v1.extend(h1)
			Create wizard_page
			h1.extend(create {EV_VERTICAL_BOX})
			h1.extend(create {EV_VERTICAL_SEPARATOR})
			h1.extend(wizard_page)
			build_navigation_bar(v1)
			load_first_state
			Create state_information.make
		end

	build_navigation_bar(a_box: EV_BOX) is
			-- Build the navigation bar.
		local
			h1: EV_HORIZONTAL_BOX
		do	
			Create h1
			a_box.extend(h1)
			a_box.disable_child_expand(h1)
			Create previous_b.make_with_text_and_action("Previous",~previous_page)
			Create next_b.make_with_text_and_action("Next",~next_page)	
			h1.extend(previous_b)
			h1.extend(next_b)	
		end

	load_first_state is
			-- Load first state.
		local
			db_initialization: DB_INITIALIZATION
		do
			Create db_initialization.make(Create {WIZARD_INFORMATION}.make)
			proceed_with_new_state(db_initialization)
		end

feature -- Implementation

	previous_b,next_b: EV_BUTTON
		-- Button ensuring the navigation.

	wizard_page: EV_VERTICAL_BOX
		-- Page on which is displayed the information
		-- needed to be completed by the user in order
		-- to be performed.

feature -- Basic Operations	

	previous_page is
			-- Go to the previous page.
		local
			
		do
			if history.count>1 then
				back
			end
			update_navigation
		end
	
	update_navigation is
		do
			if history.count<1 then
				previous_b.disable_sensitive
			else
				previous_b.enable_sensitive
			end
		end

	next_page is
		do
			if not history.after then 
				next
			end
			update_navigation
		end
	
end -- class WIZARD_WINDOW
