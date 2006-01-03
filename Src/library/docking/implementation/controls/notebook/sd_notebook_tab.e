indexing
	description: "Tabs in SD_NOTEBOOK"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB

inherit
	EV_HORIZONTAL_BOX
		redefine
			destroy
		end

create
	make

feature {NONE}  -- Initlization

	make is
			-- Creation method.
		do
			default_create
			create internal_shared
			set_padding_width (internal_shared.padding_width)
			create internal_drawing_area
			extend (internal_drawing_area)
			disable_item_expand (internal_drawing_area)
			internal_drawing_area.pointer_button_press_actions.force_extend (agent on_selected)

			set_minimum_height (internal_shared.title_bar_height)

			internal_drawing_area.expose_actions.force_extend (agent on_expose)
			text := ""

			create pixmap
			create select_actions
			create drag_actions
			internal_text_color := internal_shared.non_focused_color
			init_actions
			resize_actions.extend (agent on_resize)
		end

	init_actions is
			-- Initialize actions.
		do
			internal_drawing_area.pointer_button_press_actions.force_extend (agent on_pointer_press)
			internal_drawing_area.pointer_double_press_actions.extend (agent on_double_press)

			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_motion_actions.extend (agent on_pointer_motion)
		end

feature -- Command

	destroy is
			-- Redefine.
		do
			Precursor {EV_HORIZONTAL_BOX}
		end

	set_drop_actions (a_actions: EV_PND_ACTION_SEQUENCE) is
			-- Set drop actions to Current.
		require
			a_actions_not_void: a_actions /= Void
		do
			internal_drawing_area.drop_actions.wipe_out
			internal_drawing_area.drop_actions.append (a_actions)
		ensure
			set: internal_drawing_area.drop_actions.is_equal (a_actions)
		end

	set_width (a_width: INTEGER) is
			-- Set current width.
		require
			a_width_valid: a_width >= 0
		do
			if a_width - internal_drawing_area.minimum_width >= 0 then
				on_expose_with_width (a_width - internal_drawing_area.minimum_width)
			end

		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle resize actions.
		do
			on_expose
		end

	set_has_tab_before (a_has_before: BOOLEAN) is
			-- Set if there is a tab before Current, so we can decide whether to show seperator.
		do
			internal_has_tab_before := a_has_before
		ensure
			set: internal_has_tab_before = a_has_before
		end

	set_has_tab_after (a_has_after: BOOLEAN) is
			-- Set if there is a tab after Current, so we can decide whether to show seperator.
		do
			internal_has_tab_after := a_has_after
		ensure
			set: internal_has_tab_after = a_has_after
		end

feature -- Query

	prefered_size: INTEGER is
			-- If current is displayed, size should take.
		do
			Result := internal_drawing_area.minimum_width
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
		do
			text := a_text
			update_minmum_size
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
			internal_drawing_area.set_minimum_width (a_pixmap.width)
			update_minmum_size
			on_expose
		ensure
			set: pixmap = a_pixmap
		end

	is_selected: BOOLEAN
			-- If Current tab selected?

	set_selected (a_selected: BOOLEAN) is
			-- Set `selected'.
		local
			l_color_helper: SD_COLOR_HELPER
			l_font: EV_FONT
		do
			is_selected := a_selected
			create l_color_helper
			if a_selected then
				internal_drawing_area.set_background_color (internal_shared.focused_color)
				internal_text_color := l_color_helper.text_color_by (internal_shared.focused_color)
				l_font := internal_drawing_area.font
				l_font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)

			else
				internal_drawing_area.set_background_color (internal_shared.non_focused_color)
				internal_text_color := l_color_helper.text_color_by (internal_shared.non_focused_color)
				l_font := internal_drawing_area.font
				l_font.set_weight ({EV_FONT_CONSTANTS}.Weight_regular)
			end
			internal_drawing_area.set_font (l_font)
			update_minmum_size
			on_expose
		ensure
			set: is_selected = a_selected
		end

feature {NONE}  -- Implmentation for drag action

	on_pointer_press is
			-- Handle pointer press.
		do
			internal_pointer_pressed := True
			enable_capture

		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release.
		do
			debug ("docking")
				io.put_string ("%N SD_NOTEBOOK_TAB on_pointer_release")
				print ("%N SD_NOTEBOOK_TAB on_pointer_release disable capture")
			end

			internal_pointer_pressed := False
			disable_capture

		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Hanlde pointer motion.
		do
			if internal_pointer_pressed then
				internal_pointer_pressed := False
				disable_capture
				debug ("docking")
					print ("%N SD_NOTEBOOK_TAB on_pointer motion, after disable capture")
				end
				drag_actions.call ([a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end

		end

	internal_pointer_pressed: BOOLEAN
			-- If pointer button pressed?

feature {NONE}  -- Implementation agents

	on_double_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer double clicked actions.
		do
			pointer_double_press_actions.call ([a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
		end

	on_selected is
			-- Handle select actions.
		do
			select_actions.call ([])
		end

	on_expose is
			-- Handle expose actions.
		do
			on_expose_with_width (internal_drawing_area.width)
		end

	on_expose_with_width (a_width: INTEGER) is
			-- Handle expose with a_width.
		require
			a_width_valid: a_width >= 0
		local
			l_helper: SD_COLOR_HELPER
		do
			internal_drawing_area.clear
--			if not internal_has_tab_before then
--				internal_drawing_area.set_foreground_color (internal_shared.border_color)
--				internal_drawing_area.draw_segment (start_x_separator_before_internal, 0, start_x_separator_before_internal, height)
--			end
			internal_drawing_area.draw_pixmap (start_x_pixmap_internal, 2, pixmap)

			internal_drawing_area.set_foreground_color (internal_text_color)
			internal_drawing_area.draw_ellipsed_text_top_left (start_x_text_internal, internal_start_y_position, text, a_width)
			if is_selected then
				create l_helper
				l_helper.draw_color_change_gradually_from (internal_drawing_area, start_x_tail_internal, internal_shared.focused_color, internal_shared.non_focused_color)
			end
			internal_drawing_area.set_foreground_color (internal_shared.border_color)
			internal_drawing_area.draw_segment (start_x_separator_after_internal, 0, start_x_separator_after_internal, height)
		end

feature {NONE}  -- Implementation functions.

	start_x_separator_before_internal: INTEGER is
			-- Start x position where should draw seperator before.
		do
			Result := 0
		end

	start_x_pixmap_internal: INTEGER is
			-- Start x position where should draw `pixmap'.
		do
			Result := start_x_separator_before_internal + padding_width
		end

	start_x_text_internal: INTEGER is
			-- Start x position where should draw `text'.
		do
			Result := start_x_pixmap_internal + pixmap.width + padding_width
		end

	start_x_tail_internal: INTEGER is
			-- Start x position where should draw tail area.
		local
			l_width: INTEGER
		do
			l_width := internal_drawing_area.font.string_width (text)
			Result := start_x_text_internal + l_width + padding_width
		end

	start_x_separator_after_internal: INTEGER is
			-- Start x position where should draw seperator after.
		do
			if is_selected then
				Result := start_x_tail_internal + internal_shared.highlight_tail_width + padding_width - 1
			else
				Result := start_x_text_internal + internal_drawing_area.font.string_width (text) + padding_width - 1
			end
		end

	update_minmum_size is
			-- Update munmum size of Current.
		local
			l_size: INTEGER
		do
			l_size := start_x_tail_internal
			if is_selected then
				l_size := l_size + internal_shared.highlight_tail_width
				l_size := l_size + padding_width
			end
			internal_drawing_area.set_minimum_width (l_size)
		end

feature {NONE}  -- Implementation attributes

	internal_text_color: EV_COLOR
			-- Color of `text'

	internal_drawing_area: EV_DRAWING_AREA
			-- Drawing area for pixmap.

	internal_horizontal_box: EV_HORIZONTAL_BOX
			-- Horizontal box which contain `internal_pixmap_drawing

	internal_start_y_position: INTEGER is 2
			-- Start y position of drawing a pixmap.

	internal_has_tab_before, internal_has_tab_after: BOOLEAN
			-- If before/after Current, there is a tab?

	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_text_color_not_void: internal_text_color /= Void
	internal_shared_not_void: internal_shared /= Void
	select_actions_not_void: select_actions /= Void
	drag_actions_not_void: drag_actions /= Void

	internal_drawing_area_not_void: internal_drawing_area /= Void

end
