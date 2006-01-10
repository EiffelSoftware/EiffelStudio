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

	make (a_notebook: SD_NOTEBOOK; a_top: BOOLEAN; a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			not_void: a_notebook /= Void
			not_void: a_docking_manager /= Void
		do
			default_create
			create internal_shared
			internal_draw_border_at_top := a_top
			set_padding_width (internal_shared.padding_width)
			create internal_drawing_area
			extend (internal_drawing_area)
			disable_item_expand (internal_drawing_area)


			set_minimum_height (internal_shared.title_bar_height)

			internal_drawing_area.expose_actions.force_extend (agent on_expose)
			text := ""

			create pixmap
			create select_actions
			create drag_actions
			init_actions (a_notebook)
			resize_actions.extend (agent on_resize)
			internal_draw_pixmap := True
			internal_docking_manager := a_docking_manager
		ensure
			set: internal_docking_manager = a_docking_manager
			set: internal_draw_border_at_top = a_top
		end

	init_actions (a_notebook: SD_NOTEBOOK) is
			-- Initialize actions.
		local
			l_pixmap: EV_PIXMAP
			l_cursor: EV_CURSOR
		do
			internal_drawing_area.pointer_button_press_actions.extend (agent on_pointer_press)
			internal_drawing_area.pointer_double_press_actions.extend (agent on_double_press)

			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_motion_actions.extend (agent on_pointer_motion)

			internal_drawing_area.set_pebble_function (agent on_pebble (a_notebook))
			create l_pixmap.make_with_size (16, 16)
			l_pixmap.set_with_named_file ("E:\Documents and Settings\All Users\Documents\ok.png")
			create l_cursor.make_with_pixmap (l_pixmap, 8, 8)
			internal_drawing_area.set_accept_cursor (l_cursor)
		end

	on_pebble (a_notebook: SD_NOTEBOOK): SD_CONTENT is
			-- Test~~~ Dose User will like this style?
		local
			l_dialog: SD_ZONE_MANAGEMENT_DIALOG
		do
			select_actions.call ([])

			Result := a_notebook.selected_item
			create l_dialog.make_with_notebook (a_notebook)
			l_dialog.show_relative_to_window (internal_docking_manager.main_window)
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

	set_width_not_enough_space (a_width: INTEGER) is
			-- Set current width.
		require
			a_width_valid: a_width >= 0
		do
--			if a_width >= 0 then
--				on_expose_with_width (a_width)
--			end
--			if a_width < start_x_separator_after_internal  then
--				-- There is not enough space.
----				internal_draw_pixmap := False
--			else
----				internal_draw_pixmap := True
--			end
--			set_minimum_width (a_width)
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle resize actions.
		do
			on_expose
		end

--	resize_not_enough_space (a_width: INTEGER) is
--			-- Hide/show `pixmap' base on `a_width' when not enough space.
--		require
--			selected: is_selected
--		do

--		end

	set_draw_pixmap is
			-- Set `internal_draw_pixmap'.
		do
			internal_draw_pixmap := True
		end

feature -- Query

	internal_draw_pixmap: BOOLEAN
			-- If draw `pixmap'?

	prefered_size: INTEGER is
			-- If current is displayed, size should take.
		do
			Result := internal_drawing_area.minimum_width
		end

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Select actions.

	drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Drag tab actions.

feature -- Properties

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

	set_selected (a_selected: BOOLEAN; a_focused: BOOLEAN) is
			-- Set `selected'.
		local
			l_color_helper: SD_COLOR_HELPER
			l_font: EV_FONT
		do
			is_selected := a_selected
			create l_color_helper
			if a_selected then
				if a_focused then
					internal_drawing_area.set_background_color (internal_shared.focused_color)
				else
					internal_drawing_area.set_background_color (internal_shared.non_focused_color_lightness)
				end
				l_font := internal_drawing_area.font
				l_font.set_weight ({EV_FONT_CONSTANTS}.Weight_bold)
			else
				internal_drawing_area.set_background_color (internal_shared.non_focused_color)
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

	on_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer press.
		do
			debug ("docking")
				print ("%NSD_NOTEBOOK_TAB  on_pointer_press")
			end
			inspect
				a_button
			when 1 then
				internal_pointer_pressed := True
				enable_capture
				select_actions.call ([])
			else

			end

		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release.
		do
			internal_pointer_pressed := False
			disable_capture
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Hanlde pointer motion.
		do
			if internal_pointer_pressed then
				internal_pointer_pressed := False
				disable_capture
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

--	on_selected is
--			-- Handle select actions.
--		do
--			select_actions.call ([])
--		end

	on_expose is
			-- Handle expose actions.
		do
			on_expose_with_width (width)
		end

	on_expose_with_width (a_width: INTEGER) is
			-- Handle expose with a_width. a_width is total width current should be.
		require
			a_width_valid: a_width >= 0
		local
			l_helper: SD_COLOR_HELPER
		do
			internal_drawing_area.clear
			if internal_draw_pixmap then
				internal_drawing_area.draw_pixmap (start_x_pixmap_internal, 2, pixmap)
			end

			create l_helper
			internal_drawing_area.set_foreground_color (l_helper.text_color_by (internal_drawing_area.background_color))
			if a_width - start_x_text_internal >= 0 then
				internal_drawing_area.draw_ellipsed_text_top_left (start_x_text_internal, internal_start_y_position, text, a_width - start_x_text_internal)
			end

			if is_selected then
				l_helper.draw_color_change_gradually_from (internal_drawing_area, start_x_tail_internal, internal_drawing_area.background_color, internal_shared.non_focused_color)
			end
			internal_drawing_area.set_foreground_color (internal_shared.border_color)
			internal_drawing_area.draw_segment (start_x_separator_after_internal, 0, start_x_separator_after_internal, height)
			if internal_draw_border_at_top then
				internal_drawing_area.draw_segment (0, 0, internal_drawing_area.width - 1, 0)
			else
				internal_drawing_area.draw_segment (0, internal_drawing_area.height - 1, internal_drawing_area.width - 1, internal_drawing_area.height - 1)
			end
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
			Result := start_x_pixmap_internal
			if internal_draw_pixmap then
				Result := Result + pixmap.width + padding_width
			end
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

	internal_drawing_area: EV_DRAWING_AREA
			-- Drawing area for pixmap.

	internal_horizontal_box: EV_HORIZONTAL_BOX
			-- Horizontal box which contain `internal_pixmap_drawing

	internal_start_y_position: INTEGER is 2
			-- Start y position of drawing a pixmap.

	internal_has_tab_before, internal_has_tab_after: BOOLEAN
			-- If before/after Current, there is a tab?

	internal_draw_border_at_top: BOOLEAN
			-- If draw border at top?

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

invariant

	internal_docking_manager_not_void: internal_docking_manager /= Void
	internal_shared_not_void: internal_shared /= Void
	select_actions_not_void: select_actions /= Void
	drag_actions_not_void: drag_actions /= Void
	internal_drawing_area_not_void: internal_drawing_area /= Void

end
