indexing
	description: "Window which displays a state which is neither final nor initial."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	INTERMEDIARY_STATE_WINDOW

inherit
	WIZARD_STATE_WINDOW

feature {NONE} -- Basic Operations

	display is
			-- Display Current state.
		do 
			build_frame
			build
		end

	build_frame is
			-- Build widgets
		require
			main_box_empty: main_box.count=0
		local
			h1: EV_HORIZONTAL_BOX
			sep_h: EV_HORIZONTAL_SEPARATOR
			c: EV_CELL
			cont: EV_CONTAINER
		do
			create h1
			create title
			title.set_background_color (white_color)
			title.set_minimum_width (330)
			title.align_text_center
			title.align_text_vertical_center
			title.our_font.set_family (2)
			title.enable_bold
			create c
			h1.extend (c)
			c.set_background_color (white_color)
			h1.extend (title)
			create c
			h1.extend (c)
			c.set_background_color (white_color)
			cont := pixmap.parent
			if cont /= Void then
				cont.prune (pixmap)
			end
			h1.extend (pixmap)
			h1.set_border_width (5)
			h1.set_background_color (white_color)
			h1.set_minimum_height (58)
			h1.disable_item_expand (pixmap)
			pixmap.set_minimum_width (48)
			pixmap.set_minimum_height (48)

			main_box.extend(h1)
			main_box.disable_item_expand (h1)
			Create sep_h
			main_box.extend (sep_h)
			main_box.disable_item_expand (sep_h)

			create h1
			h1.extend (create {EV_CELL})
			create message
			message.align_text_left
			message.set_minimum_width (410)
			h1.extend (message)
			h1.disable_item_expand (message)
			h1.extend (create {EV_CELL})
			main_box.extend (h1)
--			main_box.disable_item_expand (h1)

			create c
			c.set_minimum_height (20)
			main_box.extend (c)
			main_box.disable_item_expand (c)


			create h1
			create c
			h1.extend (c)
			create choice_box
			h1.extend (choice_box)
			choice_box.set_minimum_width (360)
			create c
			h1.extend (c)

			display_state_text
			main_box.extend (h1)
--			main_box.disable_item_expand (h1)

			create c
			c.set_minimum_height (20)
			main_box.extend (c)
			main_box.disable_item_expand (c)
		ensure
			main_box_has_at_least_one_element: main_box.count > 0
		end

	pixmap_location: STRING is "eiffel_wizard_icon.bmp"
			-- Pixmap location

feature {INTERMEDIARY_STATE_WINDOW} -- Implementation

	choice_box: EV_VERTICAL_BOX

feature {NONE} -- Access

--	is_final_state: BOOLEAN is FALSE

end -- class INTERMEDIARY_STATE_WINDOW
