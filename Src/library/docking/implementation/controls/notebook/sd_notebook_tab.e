indexing
	description: "Tabs in SD_NOTEBOOK"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			create internal_drawing_area
			extend (internal_drawing_area)
			disable_item_expand (internal_drawing_area)

			set_minimum_height (internal_shared.title_bar_height)

			internal_drawing_area.expose_actions.force_extend (agent on_expose)

			create select_actions
			create drag_actions
			init_actions (a_notebook)
			internal_draw_pixmap := True
			internal_docking_manager := a_docking_manager
			internal_notebook := a_notebook

			init_drawing_style (a_top)
			set_enough_space
		ensure
			set: internal_notebook = a_notebook
			set: internal_docking_manager = a_docking_manager
		end

	init_drawing_style (a_top: BOOLEAN) is
			-- Init `internal_tab_style'
		do
			create internal_tab_style.make (internal_drawing_area, a_top)
			internal_tab_style.set_padding_width (internal_shared.padding_width)
		end

	init_actions (a_notebook: SD_NOTEBOOK) is
			-- Initialize actions
		do
			internal_drawing_area.pointer_button_press_actions.extend (agent on_pointer_press)
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

	set_width_not_enough_space (a_width: INTEGER) is
			-- Set current width.
		require
			a_width_valid: a_width >= 0
		do
			on_expose_with_width (a_width)

			set_minimum_width (a_width)
			internal_tab_style.set_enough_space (False)
		ensure
			set: enough_space = False
		end

	set_enough_space is
			-- Set current is enought space to show.
		do
			internal_tab_style.set_enough_space (True)
			update_minmum_size
		ensure
			set: enough_space = True
		end

	enough_space: BOOLEAN is
			-- If Current have enough space?
		do
			Result := internal_tab_style.is_enough_space
		end

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

	text: STRING is
			-- Text shown on Current.
		do
			Result := internal_tab_style.text
		end

	set_text (a_text: STRING) is
			-- Set `text'.
		require
			a_text_not_void: a_text /= Void
		do
			internal_tab_style.set_text (a_text)
			update_minmum_size
			on_expose
		ensure
			set: a_text = text
		end

	pixmap: EV_PIXMAP is
			-- Pixmap shown on Current.
		do
			Result := internal_tab_style.pixmap
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set `a_pixmap'.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_tab_style.set_pixmap (a_pixmap)
			internal_drawing_area.set_minimum_width (a_pixmap.width)
			update_minmum_size
			on_expose
		ensure
			set: pixmap = a_pixmap
		end

	is_selected: BOOLEAN is
			-- If Current tab selected?
		do
			Result := internal_tab_style.is_selected
		end

	set_selected (a_selected: BOOLEAN; a_focused: BOOLEAN) is
			-- Set `selected'.
		do
			internal_tab_style.set_selected (a_selected, a_focused)

			update_minmum_size
			on_expose
		ensure
			set: is_selected = a_selected
		end

	set_selection_color (a_focused: BOOLEAN) is
			-- Set color of selection color to focused selection color or non-focused color.
		require
			selected: is_selected
		do
			if a_focused then
				internal_drawing_area.set_background_color (internal_shared.focused_color)
			else
				internal_drawing_area.set_background_color (internal_shared.non_focused_title_color)
			end
			on_expose
		ensure
			set: a_focused implies internal_drawing_area.background_color.is_equal (internal_shared.focused_color)
			set: not a_focused implies internal_drawing_area.background_color.is_equal (internal_shared.non_focused_title_color)
		end

	set_selected_tab_after (a_selected_tab_after: BOOLEAN) is
			-- Set `is_selected_tab_after'.
		do
			is_selected_tab_after := a_selected_tab_after
		ensure
			set: is_selected_tab_after = a_selected_tab_after
		end

	is_selected_tab_after: BOOLEAN
			-- If after Current, there is a selected tab?

feature {NONE}  -- Implmentation for drag action

	on_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer press.
		local
			l_menu: SD_ZONE_MANAGEMENT_MENU
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
			when 3 then
				select_actions.call ([])
				create l_menu.make (internal_notebook)
				l_menu.show_at (Current, a_x, a_y)
--				l_menu.show_at_window (internal_docking_manager.main_window)
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

	on_expose is
			-- Handle expose actions.
		do
			on_expose_with_width (width)
		end

	on_expose_with_width (a_width: INTEGER) is
			-- Handle expose with a_width. a_width is total width current should be.
		require
			a_width_valid: a_width >= 0
		do
			internal_drawing_area.clear
			if pixmap /= Void then
				if is_selected then
					internal_tab_style.expose_selected (a_width)
				else
					internal_tab_style.expose_unselected (a_width, is_selected_tab_after)
				end
			end
		end

feature {NONE}  -- Implementation functions.

	update_minmum_size is
			-- Update munmum size of Current.
		local
			l_size: INTEGER
		do
			if enough_space then
				l_size := internal_tab_style.start_x_tail_internal
				if is_selected then
					l_size := l_size + internal_shared.highlight_tail_width
					l_size := l_size + internal_tab_style.padding_width
				end
				internal_drawing_area.set_minimum_width (l_size)
				set_minimum_width (l_size)
			end
		end

feature {NONE}  -- Implementation attributes

	internal_notebook: SD_NOTEBOOK
			-- Notebook Current belong to.

	internal_drawing_area: EV_DRAWING_AREA
			-- Drawing area for pixmap.

	internal_horizontal_box: EV_HORIZONTAL_BOX
			-- Horizontal box which contain `internal_pixmap_drawing

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

	internal_tab_style: SD_NOTEBOOK_TAB_STYLE_NORMAL
			-- Drawer of the internal_drawing_area.

invariant

	internal_docking_manager_not_void: internal_docking_manager /= Void
	internal_shared_not_void: internal_shared /= Void
	select_actions_not_void: select_actions /= Void
	drag_actions_not_void: drag_actions /= Void
	internal_drawing_area_not_void: internal_drawing_area /= Void
	not_void: internal_tab_style /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end
