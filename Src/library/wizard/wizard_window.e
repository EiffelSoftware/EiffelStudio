indexing
	description: "Window on which is displayed the wizards"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WINDOW

inherit
	EV_TITLED_WINDOW 

	WIZARD_STATE_MANAGER
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
		do
				default_create
				set_size(400,300)
				Create wizard_page
				Create v1
				extend(v1)		
				v1.extend(wizard_page)	
				build_navigation_bar(v1)

				load_first_state
				Create wizard_information.make
		end

	build_navigation_bar(a_box: EV_BOX) is
			-- Build the navigation bar.
		local
			h1: EV_HORIZONTAL_BOX
			h2: EV_HORIZONTAL_BOX
			h_sep: EV_HORIZONTAL_SEPARATOR
		do	
			Create h_sep
			a_box.extend(h_sep)
			a_box.disable_child_expand(h_sep)
			Create h1
			a_box.extend (h1)
			a_box.disable_child_expand (h1)

			Create previous_b.make_with_text_and_action ("<< Previous ", ~previous_page)
			Create next_b.make_with_text_and_action ("Next >>", ~next_page)	
			Create cancel_b.make_with_text_and_action ("Cancel", ~cancel_actions)

			h1.extend (create {EV_CELL})

			create h2
			h1.extend (h2)
			h1.disable_child_expand (h2)

			h2.extend (previous_b)
			previous_b.set_minimum_width (60)
			previous_b.align_text_center
			h2.disable_child_expand (previous_b)

			h2.extend (next_b)
			next_b.set_minimum_width (60)
			next_b.align_text_center
			h2.disable_child_expand (next_b)

			h1.extend (cancel_b)
			h1.disable_child_expand (cancel_b)
			cancel_b.set_minimum_width (60)
			cancel_b.align_text_center

			h1.set_padding (20)
			h1.set_border_width (10)


		end

	load_first_state is
			-- Load first state.
		local
			wizard_initial_state: WIZARD_INITIAL_STATE
		do
			Create wizard_initial_state.make(Create {WIZARD_INFORMATION}.make)
			proceed_with_new_state(wizard_initial_state)
			update_navigation
		end

feature -- Implementation

	previous_b,next_b,cancel_b: EV_BUTTON
		-- Button ensuring the navigation.

	wizard_info_page: EV_VERTICAL_BOX
		-- Page to be completed by the user
		-- to give the information about the current state

	wizard_page: EV_VERTICAL_BOX
		-- Page on which is displayed the information
		-- needed to be completed by the user in order
		-- to be performed.

feature {WIZARD_FINAL_STATE_WINDOW} -- Basic Operations	

	set_final_state is
			-- Current state is final, hence a special
			-- process.
		do
				previous_b.disable_sensitive
				next_b.set_text("Finish")
		end

feature -- Basic Operations

	previous_page is
			-- Go to the previous page.
		do
			if history.count>1 then
				back
			end
			update_navigation
		end
	
	update_navigation is
			-- Update navigation buttons.
		do
			if history.count<1 or else history.isfirst or else 
				history.item.is_final_state then
				previous_b.disable_sensitive
			else
				previous_b.enable_sensitive
			end
		end

	next_page is
			-- Go to next page if possible.
		do
			if not history.after then
				next
			end
			update_navigation
		end

end -- class WIZARD_WINDOW
