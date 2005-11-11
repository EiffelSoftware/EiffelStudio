indexing
	description: "This is the tab stub on the SD_AUTO_HIDE_PANEL."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_STUB

inherit
	SD_HOR_VER_BOX

create
	make

feature {NONE} -- Initlization

	make (a_title: STRING; a_pixmap: EV_PIXMAP; a_vertical: BOOLEAN) is
			-- Creation method. If a_vertical True then vertical style otherwise horizontal style.
		require
			a_title_not_void: a_title /= Void
			a_pixmap_not_void: a_pixmap /= Void
		do
			init (a_vertical)
--			create internal_contents.make (1)
			set_background_color ((create {EV_STOCK_COLORS}).grey)
			set_border_width (1)

			internal_pixmap := a_pixmap
--			internal_title := a_title

			create internal_drawing_area
			internal_drawing_area.expose_actions.extend (agent handle_redraw)
			internal_drawing_area.set_minimum_size (internal_pixmap.minimum_width, internal_pixmap.minimum_height)
			extend (internal_drawing_area)
			create internal_label.make_with_text (a_title)
			extend (internal_label)

--			create pointer_enter_actions

--			pointer_enter_actions.merge_right (internal_pixmap.pointer_enter_actions)
			internal_label.pointer_enter_actions.extend (agent handle_pointer_enter)
--			-- | FIXIT: Why enable agent below, there'll be behavior unexcepted?
			internal_drawing_area.pointer_enter_actions.extend (agent handle_pointer_enter)
		end

feature -- Properties

	add_tab (a_title: STRING; a_pixmap: EV_PIXMAP) is
			-- Add a tab to `Current'.
		do

		end

	title: STRING is
			--
		do
			Result := internal_label.text
		end

	set_title (a_title: STRING) is
			--
		do
			internal_label.set_text (a_title)
		end

feature -- Basic operation

	set_show_text (a_show: BOOLEAN) is
			--
		do
			if a_show then
				start
				if not has (internal_label) then
					extend (internal_label)
				end
			else
				start
				if has (internal_label) then
					prune_all (internal_label)
				end
			end
		end

feature {NONE} -- Implementation

	l_label: EV_LABEL

--	internal_title: STRING
			-- Title of SD_CONTENT.

	internal_pixmap: EV_PIXMAP

	internal_drawing_area: EV_DRAWING_AREA

	internal_label: EV_LABEL

feature {NONE} -- Implemention

	handle_pointer_enter is
			-- Handle pointer enter event.
		do
			pointer_enter_actions.call ([])
		end

	handle_redraw (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			--
		do
			internal_drawing_area.clear
			internal_drawing_area.draw_pixmap (0, 0, internal_pixmap)
		end

end
