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
			v1,v2: EV_VERTICAL_BOX
			h1: EV_HORIZONTAL_BOX
			sep: EV_VERTICAL_SEPARATOR
			sep2: EV_HORIZONTAL_SEPARATOR
			pix: EV_PIXMAP
		do
				default_create
				set_size(300,300)
				Create v1
				extend(v1)
				Create h1
				v1.extend(h1)
				Create wizard_page
				Create main_pixmap	
				Create sep
				Create v2
				h1.extend(pixmap)
				h1.extend(sep)
				h1.disable_child_expand(sep)
				h1.disable_child_expand(pixmap)
				h1.extend(v2)
				v2.extend(wizard_page)
				Create sep2
				v2.extend(sep2)
				v2.disable_child_expand(sep2)
				build_navigation_bar(v2)
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
			Create cancel_b.make_with_text_and_action("Cancel",~cancel_actions)
			h1.extend(previous_b)
			h1.extend(next_b)
			h1.extend(Create {EV_HORIZONTAL_BOX})
			h1.extend(cancel_b)	
		end

	load_first_state is
			-- Load first state.
		local
			wizard_initial_state: WIZARD_INITIAL_STATE
		do
			wizard_initial_state.make(Create {WIZARD_INFORMATION}.make)
			proceed_with_new_state(wizard_initial_state)
		end

feature -- Implementation

	previous_b,next_b,cancel_b: EV_BUTTON
		-- Button ensuring the navigation.

	wizard_page: EV_VERTICAL_BOX
		-- Page on which is displayed the information
		-- needed to be completed by the user in order
		-- to be performed.

	main_pixmap: EV_PIXMAP

feature -- Basic Operations	

	set_final_state is
			-- Current state is final, hence a special
			-- process.
		do
			previous_b.parent.prune(previous_b)
			next_b.set_text("Exit")
			next_b.press_actions.extend(~destroy)
			cancel_b.parent.prune(cancel_b)
		end

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
			if history.count<1 or else history.isfirst then
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
