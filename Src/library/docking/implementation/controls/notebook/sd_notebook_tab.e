indexing
	description: "Tabs in SD_NOTEBOOK"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB

inherit
	EV_DRAWING_AREA
		export
			{SD_NOTEBOOK_TAB_DRAWER_I} implementation
		redefine
			destroy,
			create_implementation
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

			create info

			set_minimum_height (internal_shared.title_bar_height)

			expose_actions.force_extend (agent on_expose)
			pointer_enter_actions.extend (agent on_pointer_enter)
			pointer_leave_actions.extend (agent on_pointer_leave)

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
			create {SD_NOTEBOOK_TAB_DRAWER_IMP}internal_tab_style.make (Current, a_top)
			internal_tab_style.set_padding_width (internal_shared.padding_width)
		end

	init_actions (a_notebook: SD_NOTEBOOK) is
			-- Initialize actions
		do
			pointer_button_press_actions.extend (agent on_pointer_press)
			pointer_double_press_actions.extend (agent on_double_press)

			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_motion_actions.extend (agent on_pointer_motion)
		end

	create_implementation is
			-- Redefine
		do
			create {SD_DRAWING_AREA_IMP} implementation.make (Current)
		end

feature -- Command

	destroy is
			-- Redefine.
		do
			Precursor {EV_DRAWING_AREA}
		end

	set_drop_actions (a_actions: EV_PND_ACTION_SEQUENCE) is
			-- Set drop actions to Current.
		require
			a_actions_not_void: a_actions /= Void
		do
			drop_actions.wipe_out
			drop_actions.append (a_actions)
		ensure
			set: drop_actions.is_equal (a_actions)
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
			Result := minimum_width
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
			set_minimum_width (a_pixmap.width)
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
				set_background_color (internal_shared.focused_color)
			else
				set_background_color (internal_shared.non_focused_title_color)
			end
			on_expose
		ensure
			set: a_focused implies background_color.is_equal (internal_shared.focused_color)
			set: not a_focused implies background_color.is_equal (internal_shared.non_focused_title_color)
		end

	info: SD_NOTEBOOK_TAB_INFO
			-- Information used for draw tabs.

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

	on_pointer_enter is
			-- Handle pointer enter actions.
		do
			is_hot := True
			on_expose_with_width (width)
		ensure
			set: is_hot = True
		end

	on_pointer_leave is
			-- Handle pointer leave actions.
		do
			is_hot := False
			on_expose_with_width (width)
		ensure
			set: is_hot = False
		end

	on_expose_with_width (a_width: INTEGER) is
			-- Handle expose with a_width. a_width is total width current should be.
		require
			a_width_valid: a_width >= 0
		do
			clear
			if pixmap /= Void then
				if width > 0 and height >0 then
					if is_selected then
						internal_tab_style.expose_selected (a_width, info)
					else
						if is_hot then
							internal_tab_style.expose_hot (a_width, info)
						else
							internal_tab_style.expose_unselected (a_width, info)
						end
					end
				end
			end
		end

feature {NONE}  -- Implementation functions.

	update_minmum_size is
			-- Update minmum size of Current.
		local
			l_size: INTEGER
			l_orignal_font, l_font: EV_FONT
		do
			if enough_space then
				l_font := font
				l_orignal_font := l_font.twin
				l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
				set_font (l_font)

				l_size := internal_tab_style.start_x_tail_internal
				set_font (l_orignal_font)
--				if is_selected then
--					l_size := l_size + internal_shared.highlight_tail_width
--					l_size := l_size + internal_tab_style.padding_width
--				end
				if l_size /= minimum_width or l_size /= minimum_width then
					set_minimum_width (l_size)
					set_minimum_width (l_size)
				end
			end
		end

feature {NONE}  -- Implementation attributes

	internal_notebook: SD_NOTEBOOK
			-- Notebook Current belong to.

--	internal_drawing_area: EV_DRAWING_AREA
--			-- Drawing area for pixmap.

--	internal_horizontal_box: EV_HORIZONTAL_BOX
--			-- Horizontal box which contain `internal_pixmap_drawing

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

	internal_tab_style: SD_NOTEBOOK_TAB_DRAWER_I
			-- Drawer of Current

	is_hot: BOOLEAN
			-- If Current hot?

invariant

	internal_docking_manager_not_void: internal_docking_manager /= Void
	internal_shared_not_void: internal_shared /= Void
	select_actions_not_void: select_actions /= Void
	drag_actions_not_void: drag_actions /= Void
	not_void: internal_tab_style /= Void
	not_void: info /= Void

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
