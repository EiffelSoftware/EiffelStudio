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
			create internal_shared

			create internal_pixmap_drawing_area
			extend (internal_pixmap_drawing_area)
			disable_item_expand (internal_pixmap_drawing_area)
			internal_pixmap_drawing_area.pointer_button_press_actions.force_extend (agent on_selected)

			create internal_text_drawing_area
			extend (internal_text_drawing_area)
			disable_item_expand (internal_text_drawing_area)
			internal_text_drawing_area.pointer_button_press_actions.force_extend (agent on_selected)

			create internal_tail_drawing_area
			extend (internal_tail_drawing_area)
			disable_item_expand (internal_tail_drawing_area)
			internal_tail_drawing_area.set_minimum_width (internal_shared.highlight_tail_width)

			set_minimum_height (internal_shared.title_bar_height)

			internal_tail_drawing_area.expose_actions.force_extend (agent on_expose)
			internal_text_drawing_area.expose_actions.force_extend (agent on_expose)
			text := ""

			create select_actions
			create drag_actions

			init_actions
		end

	init_actions is
			-- Initialize actions.
		do
			internal_pixmap_drawing_area.pointer_button_press_actions.force_extend (agent on_pointer_press)
			internal_pixmap_drawing_area.pointer_button_release_actions.force_extend (agent on_pointer_release)
			internal_pixmap_drawing_area.pointer_motion_actions.extend (agent on_pointer_motion)

			internal_text_drawing_area.pointer_button_press_actions.force_extend (agent on_pointer_press)
			internal_text_drawing_area.pointer_button_release_actions.force_extend (agent on_pointer_release)
			internal_text_drawing_area.pointer_motion_actions.extend (agent on_pointer_motion)

			internal_tail_drawing_area.pointer_button_press_actions.force_extend (agent on_pointer_press)
			internal_tail_drawing_area.pointer_button_release_actions.force_extend (agent on_pointer_release)
			internal_tail_drawing_area.pointer_motion_actions.extend (agent on_pointer_motion)

		end

feature -- Properties

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Select actions.

	drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Drag tab actions.

	text: STRING
			-- Text shown on Current.

	set_text (a_text: STRING) is
			-- Set `text'.
		require
			a_text_not_void: a_text /= Void
		local
			l_width: INTEGER
		do
			text := a_text
			l_width := internal_text_drawing_area.font.string_width (text)
			internal_text_drawing_area.set_minimum_width (l_width)
			on_expose
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
			internal_pixmap_drawing_area.set_minimum_width (a_pixmap.width)
			on_expose
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
				internal_pixmap_drawing_area.set_background_color (internal_shared.focused_color)
				internal_text_drawing_area.set_background_color (internal_shared.focused_color)
				internal_tail_drawing_area.set_background_color (internal_shared.focused_color)

				if internal_shared.focused_color.lightness > 0.5 then
					create l_text_color.make_with_rgb (0, 0, 0)
				else
					create l_text_color.make_with_rgb (1, 1, 1)
				end
				internal_text_drawing_area.set_foreground_color (l_text_color)
			else
				internal_pixmap_drawing_area.set_background_color (internal_shared.non_focused_color)
				internal_text_drawing_area.set_background_color (internal_shared.non_focused_color)
				internal_tail_drawing_area.set_background_color (internal_shared.non_focused_color)
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

feature {NONE}  -- Implmentation for drag action

	on_pointer_press is
			-- Handle pointer press.
		do
			internal_pointer_pressed := True
		end

	on_pointer_release is
			-- Handle pointer release.
		do
			internal_pointer_pressed := False
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Hanlde pointer motion.
		do
			if internal_pointer_pressed then
				drag_actions.call ([a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

	internal_pointer_pressed: BOOLEAN
			-- If pointer button pressed?

feature {NONE}  -- Implementation

	on_selected is
			-- Handle select actions.
		do
			select_actions.call ([])
		end

	on_expose is
			-- Handle expose actions.
		local
			l_helper: SD_COLOR_HELPER
		do
			internal_pixmap_drawing_area.clear
			internal_text_drawing_area.clear
			internal_tail_drawing_area.clear
			if selected then
				create l_helper
				l_helper.draw_color_change_gradually (internal_tail_drawing_area, internal_shared.focused_color)
			end
			if pixmap /= Void then
				internal_pixmap_drawing_area.draw_pixmap (0, 2, pixmap)
			end
			internal_text_drawing_area.draw_ellipsed_text_top_left (0, 2, text, internal_text_drawing_area.width)
		end

	internal_pixmap_drawing_area: EV_DRAWING_AREA
			-- Drawing area for pixmap.

	internal_text_drawing_area: EV_DRAWING_AREA
			-- Drawing area for text.

	internal_tail_drawing_area: EV_DRAWING_AREA
			-- Tail area which show color change gradually.

	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_shared_not_void: internal_shared /= Void
	select_actions_not_void: select_actions /= Void
	drag_actions_not_void: drag_actions /= Void

	internal_pixmap_drawing_area_not_void: internal_pixmap_drawing_area /= Void
	internal_text_drawing_area_not_void: internal_text_drawing_area /= Void
	internal_tail_drawing_area_not_void: internal_tail_drawing_area /= Void

end
