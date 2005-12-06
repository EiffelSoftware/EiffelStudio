indexing
	description: "Tabs in SD_NOTEBOOK"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB

inherit
	EV_HORIZONTAL_BOX

create
	make

feature {NONE}  -- Initlization

	make is
			-- Creation method.
		do
			default_create
			extend (internal_text_drawing_area)
			disable_item_expand (internal_text_drawing_area)
			extend (internal_tail_drawing_area)
			disable_item_expand (internal_tail_drawing_area)
			internal_tail_drawing_area.set_minimum_width (internal_shared.highlight_tail_width)

			set_minimum_height (internal_shared.title_bar_height)

			internal_tail_drawing_area.expose_actions.force_extend (agent on_expose)
			internal_text_drawing_area.expose_actions.force_extend (agent on_expose)
		end

feature -- Properties

	text: STRING
			-- Text shown on Current.

	set_text (a_text: STRING) is
			-- Set `text'.
		require
			a_text_not_void: a_text /= Void
		do
			text := a_text
		ensure
			set: a_text = text
		end

	pixmap: EV_PIXMAP
			-- Pixmap shown on Current.

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
		ensure
			set: pixmap = a_pixmap
		end

	selected: BOOLEAN
			-- If Current tab selected?

	set_selected (a_selected: BOOLEAN) is
			-- Set `selected'.
		local
			l_text_color: EV_COLOR
		do
			selected := a_selected
			if a_selected then
				internal_tail_drawing_area.set_background_color (internal_shared.focused_color)
				internal_text_drawing_area.set_background_color (internal_shared.focused_color)
				if internal_shared.focused_color.lightness > 0.5 then
					create l_text_color.make_with_rgb (0, 0, 0)
				else
					create l_text_color.make_with_rgb (1, 1, 1)
				end
				internal_text_drawing_area.set_foreground_color (l_text_color)
			else
				internal_tail_drawing_area.set_background_color (internal_shared.non_focused_color)
				internal_text_drawing_area.set_background_color (internal_shared.non_focused_color)
				if internal_shared.non_focused_color.lightness > 0.5 then
					create l_text_color.make_with_rgb (0, 0, 0)
				else
					create l_text_color.make_with_rgb (1, 1, 1)
				end
				internal_text_drawing_area.set_foreground_color (l_text_color)
			end
			on_expose
		ensure
			set: selected = a_selected
		end

feature {NONE}  -- Implementation

	on_expose is
			-- Handle expose actions.
		local
			l_helper: SD_COLOR_HELPER
		do
			internal_text_drawing_area.clear
			internal_tail_drawing_area.clear
			if selected then
				create l_helper
				l_helper.draw_color_change_gradually (internal_tail_drawing_area, internal_shared.focused_color)
			end
			internal_text_drawing_area.draw_ellipsed_text_top_left (0, 2, text, internal_text_drawing_area.width)
		end

	internal_text_drawing_area: EV_DRAWING_AREA
			-- Drawing area for text.

	internal_tail_drawing_area: EV_DRAWING_AREA
			-- Tail area which show color change gradually.

	internal_shared: SD_SHARED
			-- All singletons.

invariant
	internal_shared_not_void: internal_shared /= Void

end
