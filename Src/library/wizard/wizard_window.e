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
			v1,v2,v3: EV_VERTICAL_BOX
			h1,h2,h3: EV_HORIZONTAL_BOX
			sep: EV_VERTICAL_SEPARATOR
			sep2, h_sep1, h_sep2: EV_HORIZONTAL_SEPARATOR
			pix: EV_PIXMAP
		do
				default_create
				set_size(400,300)


				Create v1
				Create v2
				Create v3
				Create h_sep1

				extend(v1)
				v1.extend(v2)
				v1.extend (h_sep1)
				v1.disable_child_expand(h_sep1)
				v1.extend(v3)
				v1.disable_child_expand(v3)


				build_display_box(v2)			
				build_navigation_bar(v3)

--				Create v1
--				extend(v1)
--				Create h1
--				v1.extend(h1)
--				Create wizard_page
--				Create main_pixmap	
--				Create sep
--				Create v2
--				h1.extend(pixmap)
--				h1.extend(sep)
--				h1.disable_child_expand(sep)
--				h1.disable_child_expand(pixmap)
--				h1.extend(v2)
--				v2.extend(wizard_page)
--				Create sep2
--				v2.extend(sep2)
--				v2.disable_child_expand(sep2)
--				build_navigation_bar(v2)
				load_first_state
				Create wizard_information.make
		end

	build_navigation_bar(a_box: EV_BOX) is
			-- Build the navigation bar.
		local
			h1: EV_HORIZONTAL_BOX
			h2: EV_HORIZONTAL_BOX
		do	
			Create h1
			a_box.extend (h1)
			a_box.disable_child_expand (h1)

			Create previous_b.make_with_text_and_action ("Previous", ~previous_page)
			Create next_b.make_with_text_and_action ("Next", ~next_page)	
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

--			h1.extend (Create {EV_HORIZONTAL_BOX})
			h1.extend (cancel_b)
			h1.disable_child_expand (cancel_b)
			cancel_b.set_minimum_width (60)
			cancel_b.align_text_center

			h1.set_padding (20)
			h1.set_border_width (10)


		end

	build_display_box(a_box: EV_BOX) is
			-- Build the display box
			-- Box, above the Navigation bar
		do
--			if not common_state then
--				build_first_and_last_box(a_box)
--			else
				build_common_box(a_box)
--			end
		end

	build_first_and_last_box(a_box: EV_BOX) is
			-- Special display box for the first and the last state
		local
			text: EV_LABEL
			h1: EV_HORIZONTAL_BOX
			v1, v2: EV_VERTICAL_BOX
			sep_v: EV_VERTICAL_SEPARATOR
		do
			Create main_pixmap
--			Create text.make_with_text ("Test...")

			Create h1
			h1.set_minimum_height (300)

			Create v1
			v1.extend (pixmap)
--			v1.disable_child_expand (pixmap)
			v1.set_minimum_width (120)

			Create wizard_page

			Create v2
			v2.extend (wizard_page)

			Create sep_v

			h1.extend (v1)
			h1.disable_child_expand (v1)
			h1.extend (sep_v)
			h1.disable_child_expand (sep_v)
			h1.extend (v2)
			h1.disable_child_expand (v2)

			a_box.extend (h1)
			a_box.disable_child_expand (h1)
		end

	build_common_box(a_box: EV_BOX) is
			-- Common display box
		local
			v1, v2: EV_VERTICAL_BOX
			h1: EV_HORIZONTAL_BOX
			sep_h: EV_HORIZONTAL_SEPARATOR
			text: EV_LABEL
		do
			create wizard_info_page
			create text.make_with_text ("Test ... ")
			wizard_info_page.extend(text)

			create main_pixmap

			create h1
			h1.set_minimum_height(61)
			h1.set_background_color (create {EV_COLOR}.make_with_rgb (1.0, 1.0, 1.0))

			h1.extend (wizard_info_page)
--			h1.disable_child_expand(wizard_info_page)

			h1.extend (pixmap)
			h1.disable_child_expand(pixmap)

			create sep_h

			create v1
			v1.extend (h1)
			v1.disable_child_expand (h1)
			v1.extend (sep_h)
			v1.disable_child_expand (sep_h)

			create wizard_page

			create v2
			v2.extend (wizard_page)

			a_box.extend (v1)
			a_box.disable_child_expand (v1)
			a_box.extend (v2)

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

	main_pixmap: EV_PIXMAP

feature -- Basic Operations	

	set_final_state is
			-- Current state is final, hence a special
			-- process.
		do
			is_final_state := TRUE

				previous_b.parent.prune(previous_b)
				cancel_b.parent.prune(cancel_b)
				
				next_b.set_text("Exit")
				next_b.press_actions.wipe_out
				next_b.press_actions.extend(first_window~destroy)

--				next_b.parent.prune(next_b)
--				next_b.set_text("Exit")
--				next_b.press_actions.extend(~destroy)
--				cancel_b.set_text("Exit")
--				cancel_b.show
--				cancel_b.press_actions.extend(~destroy)



--			next_b.hide
--			cancel_b.set_text("Exit")
--			previous_b.parent.prune(previous_b)
--			next_b.parent.prune(next_b)
--			next_b.hide
--			next_b.set_text("Exit")
--			next_b.press_actions.extend(~destroy)
--			cancel_b.set_text("Exit")
--			cancel_b.parent.prune(cancel_b)
		end

	test is
		do
			first_window.destroy
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
				previous_b.hide
			else
				previous_b.show
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
