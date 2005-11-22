indexing
	description: "Tab stubs on SD_AUTO_HIDE_PANEL."
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
			set_background_color ((create {EV_STOCK_COLORS}).grey)
			set_border_width (1)

			internal_pixmap := a_pixmap

			create internal_drawing_area
			internal_drawing_area.expose_actions.extend (agent on_redraw)
			internal_drawing_area.set_minimum_size (internal_pixmap.minimum_width, internal_pixmap.minimum_height)
			extend (internal_drawing_area)
			create internal_label.make_with_text (a_title)
			extend (internal_label)

			internal_label.pointer_enter_actions.extend (agent on_pointer_enter)
			internal_drawing_area.pointer_enter_actions.extend (agent on_pointer_enter)
		ensure
			set: internal_pixmap = a_pixmap
			set: internal_label.text.is_equal (a_title)
			actions_added: internal_label.pointer_enter_actions.count = 1 and internal_drawing_area.pointer_enter_actions.count = 1
			label_added: has (internal_label)
			drawing_area_added: has (internal_drawing_area)
		end

feature -- Query

	title: STRING is
			-- Title.
		do
			Result := internal_label.text
		end

feature -- Command

	set_show_text (a_show: BOOLEAN) is
			-- If `a_show' True, show title. Vice visa.
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

	set_title (a_title: STRING) is
			-- Set `title'.
		do
			internal_label.set_text (a_title)
		end

feature {NONE} -- Agents

	on_pointer_enter is
			-- Handle pointer enter.
		do
			pointer_enter_actions.call ([])
		end

	on_redraw (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle redraw.
		do
			internal_drawing_area.clear
			internal_drawing_area.draw_pixmap (0, 0, internal_pixmap)
		end

feature {NONE} -- Implementation

	internal_pixmap: EV_PIXMAP
		-- Pixmap on `Current'.

	internal_drawing_area: EV_DRAWING_AREA
		-- Drawing area draw `internal_pixmap'.

	internal_label: EV_LABEL
		-- Lable which has title.

invariant

	internal_drawing_area_not_void: internal_drawing_area /= Void
	internal_label_not_void: internal_label /= Void

end
