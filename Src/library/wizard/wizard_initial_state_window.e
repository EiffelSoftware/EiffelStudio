indexing
	description: ""
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_INITIAL_STATE_WINDOW

inherit
	WIZARD_STATE_WINDOW
		export
			{NONE} all
		end

feature -- Basic Operations

	display is
			-- Display Current State
		do
			build
		end

	build is
			-- Special display box for the first and the last state
		local
			text: EV_LABEL
			h1: EV_HORIZONTAL_BOX
			v1, v2: EV_VERTICAL_BOX
			sep_v: EV_VERTICAL_SEPARATOR
			cont: EV_CONTAINER
		do
			create h1
			create message
			create title
			title.set_background_color (white_color)
			title.align_text_center
			message.set_background_color (white_color)
			message.align_text_left
			Create sep_v
			cont:= pixmap.parent
			if cont /= Void then
				cont.prune (pixmap)
			end
			pixmap.set_minimum_height (312)
			pixmap.set_minimum_width (165)
			h1.extend(pixmap)
			h1.extend(sep_v)

			Create v1
			v1.set_minimum_width (330)
			v1.extend (title)
			v1.disable_item_expand (title)
			v1.extend (message)
			h1.extend (v1)

			h1.disable_item_expand (sep_v)
			h1.disable_item_expand (v1)

			display_state_text
			main_box.extend (h1)			
		end

	pixmap_location: STRING is "Eiffel_wizard_new.bmp"


end -- class WIZARD_INITIAL_STATE_WINDOW
