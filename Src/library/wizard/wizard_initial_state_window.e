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
		redefine
			display_pixmap
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
			h1: EV_HORIZONTAL_BOX
			v1: EV_VERTICAL_BOX
			sep_v: EV_VERTICAL_SEPARATOR
			cont: EV_CONTAINER
		do
			create h1
			create message
			message.set_background_color (white_color)
			message.align_text_left
			message.set_minimum_height (180)
			create title
			title.set_minimum_width (330) -- , 20)
			title.set_background_color (white_color)
			title.align_text_center
			title.align_text_middle
			title.set_font (title_font)

			create sep_v
			cont:= pixmap.parent
			if cont /= Void then
				cont.prune (pixmap)
			end
			pixmap.set_minimum_height (312)
			pixmap.set_minimum_width (165)
			pixmap.draw_pixmap (91, 9, pixmap_icon)
			h1.extend(pixmap)
			h1.extend(sep_v)

			create v1
			v1.set_minimum_width (330)
			v1.extend (title)
			v1.extend (message)
			h1.extend (v1)

			h1.disable_item_expand (sep_v)
			h1.disable_item_expand (v1)

			display_state_text
			main_box.extend (h1)			
		end

	pixmap_location: STRING is "eiffel_wizard.bmp"

	pixmap_icon_location: STRING is
			-- Path in which can be found the pixmap icon associated with
			-- the current state.
		deferred
		ensure
			exists: Result /= Void
		end

	display_pixmap is
			-- Draw pixmap
		local
			fi: FILE_NAME
		do
			Precursor {WIZARD_STATE_WINDOW}

			create fi.make_from_string (wizard_pixmaps_path)
			fi.extend (pixmap_icon_location)
			pixmap_icon.set_with_named_file (fi)

--			pixmap.set_minimum_width(pixmap.width)
--			pixmap.redraw
		end


end -- class WIZARD_INITIAL_STATE_WINDOW
