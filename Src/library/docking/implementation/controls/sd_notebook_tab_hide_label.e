indexing
	description: "On SD_NOTEBOOK_TAB_AREA when show auto hide zones."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_HIDE_LABEL

inherit
	EV_HORIZONTAL_BOX

create
	make

feature {NONE}  -- Initlization

	make is
			-- Creation method.
		do
			default_create
			create internal_shared
			create internal_pixmap_area
			extend (internal_pixmap_area)
			disable_item_expand (internal_pixmap_area)
			create internal_label
			extend (internal_label)

			internal_pixmap_area.expose_actions.extend (agent on_expose)
			set_minimum_height (internal_shared.title_bar_height)
		end

feature -- Command

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `pixmap'
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_pixmap_area.set_minimum_size (a_pixmap.minimum_width, a_pixmap.minimum_height)
			pixmap := a_pixmap

		ensure
			set: pixmap = a_pixmap
		end

	set_text (a_text: STRING) is
			-- Set `a_text'
		require
			a_text_not_void: a_text /= Void
		do
			internal_label.set_text (a_text)
			text := a_text
		ensure
			set: text = a_text
		end

	enable_focus_color is
			-- Enable focus color.
		do
			internal_label.set_background_color (internal_shared.focused_color)
			if internal_shared.focused_color.lightness > 0.5 then
				internal_label.set_foreground_color ((create {EV_STOCK_COLORS}).black)
			else
				internal_label.set_foreground_color ((create {EV_STOCK_COLORS}).white)
			end
		end

	disable_focus_color is
			-- Disable focus color.
		do
			internal_label.set_background_color (internal_shared.non_focused_color)
			if internal_shared.focused_color.lightness <= 0.5 then
				internal_label.set_foreground_color ((create {EV_STOCK_COLORS}).black)
			else
				internal_label.set_foreground_color ((create {EV_STOCK_COLORS}).white)
			end
		end

feature -- Query

	pixmap: EV_PIXMAP
			-- Pixmap

	text: STRING
			-- Text

feature -- Implementation

	on_expose (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle expose actions of `internal_pixmap_area'.
		do
			internal_pixmap_area.clear
			internal_pixmap_area.draw_pixmap (internal_shared.drawing_area_icons_start_x, internal_shared.drawing_area_icons_start_y, pixmap)
		end

	internal_label: EV_LABEL
			-- Label which hold `text'.

	internal_pixmap_area: EV_DRAWING_AREA
			-- Drawing area which draw `pixmap'.

	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_pixmap_area_not_void: internal_pixmap_area /= Void
	internal_label_not_void: internal_label /= Void

end
