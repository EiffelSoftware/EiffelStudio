indexing
	description	: "Window on which is displayed the wizards"
	author		: "pascalf"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_WINDOW

inherit
	EV_TITLED_WINDOW 
		rename
			copy as copy_titled_window
		redefine
			destroy
		select
			copy_titled_window
		end

	WIZARD_STATE_MANAGER
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize Current window.
		local
			v1: EV_VERTICAL_BOX
		do
			default_create
			disable_user_resize
			set_minimum_size (dialog_unit_to_pixels(503), dialog_unit_to_pixels(385))
			create wizard_page
			create v1
			v1.extend (wizard_page)	
			build_navigation_bar (v1)
			extend (v1)

			load_first_state
		--	Create wizard_information.make
		end

	build_navigation_bar (a_box: EV_BOX) is
			-- Build the navigation bar.
		local
			h1: EV_HORIZONTAL_BOX
			h_sep: EV_HORIZONTAL_SEPARATOR
		do	
			create previous_b.make_with_text_and_action ("< Back ", agent previous_page)
			previous_b.align_text_center
			set_default_size_for_button (previous_b)

			create next_b.make_with_text_and_action ("Next >", agent next_page)	
			next_b.align_text_center
			set_default_size_for_button (next_b)

			create cancel_b.make_with_text_and_action ("Cancel", agent cancel_actions)
			cancel_b.align_text_center
			set_default_size_for_button (cancel_b)

			create help_b.make_with_text_and_action ("Help", agent show_help)
			help_b.align_text_center
			set_default_size_for_button (help_b)
			help_b.hide

			create h1
			h1.extend (previous_b)
			h1.disable_item_expand(previous_b)
			h1.extend (next_b)
			h1.disable_item_expand (next_b)

			create navigation_bar
			navigation_bar.set_padding (dialog_unit_to_pixels(11))
			navigation_bar.set_border_width (dialog_unit_to_pixels(11))
			navigation_bar.extend (help_b)
			navigation_bar.disable_item_expand (help_b)
			navigation_bar.extend (create {EV_CELL})
			navigation_bar.extend (h1)
			navigation_bar.disable_item_expand (h1)
			navigation_bar.extend (cancel_b)
			navigation_bar.disable_item_expand (cancel_b)
			
			create h_sep
			a_box.extend (h_sep)
			a_box.disable_item_expand (h_sep)
			a_box.extend (navigation_bar)
			a_box.disable_item_expand (navigation_bar)
		end
		
	load_first_state is
			-- Load first state.
		local
			wizard_initial_state: WIZARD_INITIAL_STATE
		do
			Create wizard_initial_state.make (create {WIZARD_INFORMATION}.make)
			proceed_with_new_state (wizard_initial_state)
			update_navigation
		end

feature -- Basic Operations

	add_help_button is
			-- Add help button to the navigation bar.
		do
			check
				non_void_help_button: help_b /= Void
			end
			help_b.show
		end
		
feature -- Command

	destroy is
			-- Destroy underlying native toolkit object.
			-- Render `Current' unusable.
		do
			Precursor;
			(create {EV_ENVIRONMENT}).application.destroy
		end

feature -- Access

	wizard_page: EV_VERTICAL_BOX
			-- Page on which is displayed the information
			-- needed to be completed by the user in order
			-- to be performed.

feature {NONE} -- Implementation

	previous_b, next_b, cancel_b, help_b: EV_BUTTON
			-- Button ensuring the navigation.

	navigation_bar: EV_HORIZONTAL_BOX
			-- Horizontal box containing navigation buttons

	wizard_info_page: EV_VERTICAL_BOX
			-- Page to be completed by the user
			-- to give the information about the current state

	is_final: BOOLEAN
			-- Is it the final state?

feature {WIZARD_STATE_WINDOW} -- Basic Operations	

	set_final_state (text: STRING) is
			-- Current state is final, hence a special process.
		do
			next_b.set_text(text)
			is_final := True
		end

	set_intermediary_state is
			-- Current state is intermediate.
		do
			is_final := False
		end

	disable_next_button is
			-- Disable the Next/Finish button
		do
			next_b.disable_sensitive
		end

	disable_back_button is
			-- Enable the Next/Finish button
		do
			previous_b.disable_sensitive
		end

feature -- Basic Operations

	previous_page is
			-- Go to the previous page.
		do
			if history.count > 1 then
				back
			end
			update_navigation
		end
	
	update_navigation is
			-- Update navigation buttons.
		do
			if history.count < 1 or else history.isfirst  then
				previous_b.disable_sensitive
			elseif is_final then
				previous_b.enable_sensitive
			else
				previous_b.enable_sensitive
				next_b.set_text("Next >")				
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
