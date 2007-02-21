indexing
	description: "Tabs in SD_NOTEBOOK"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB

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

			text := ""
			create pixmap

			create info

			create select_actions
			create close_actions
			create drag_actions

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
			is_draw_top_tab := a_top
			internal_tab_drawer.set_padding_width (internal_shared.padding_width)
		end

feature -- Command

	set_drop_actions (a_actions: EV_PND_ACTION_SEQUENCE) is
			-- Set drop actions to Current.
		require
			a_actions_not_void: a_actions /= Void
		do
			drop_actions := a_actions
		ensure
			set: drop_actions = a_actions
		end

	set_width_not_enough_space (a_width: INTEGER) is
			-- Set current width.
		require
			a_width_valid: a_width >= 0
		do
			on_expose_with_width (a_width)
			is_enough_space := False
		ensure
			set: is_enough_space = False
		end

	set_enough_space is
			-- Set current is enought space to show.
		do
			is_enough_space := True
			update_minmum_size
		ensure
			set: is_enough_space = True
		end

	is_enough_space: BOOLEAN
			-- If Current have enough space?

	set_draw_pixmap is
			-- Set `internal_draw_pixmap'.
		do
			internal_draw_pixmap := True
		end

	hide is
			-- Hide
		do
			is_displayed := False
		end

	show is
			-- Show
		do
			is_displayed := True
		end

	destroy is
			-- Destory
		do
			if parent /= Void then
				parent.prune (Current)
				parent := Void
			end
		ensure
			cleared: parent = Void
		end

feature -- Query

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Drop actions.

	internal_draw_pixmap: BOOLEAN
			-- If draw `pixmap'?

	prefered_size: INTEGER is
			-- If current is displayed, size should take.
		do
			Result := internal_width
		end

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Select actions.

	close_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Close actions.

	drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Drag tab actions.

	is_hot: BOOLEAN
			-- If Current hot?

	is_pointer_in_close_area: BOOLEAN
			-- If pointer in close button area?

	is_pointer_pressed: BOOLEAN
			-- If pointer button pressed?

	x: INTEGER is
			-- X position relative to parent box.
		require
			not_void: parent /= Void
		do
			Result := parent.item_x (Current)
		end

	width: INTEGER is
			-- Width
		do
			if is_displayed then
				Result := internal_width
			end
		end

	height: INTEGER is
			-- Height
		do
			Result := parent.height
		end

	screen_x: INTEGER is
			-- Screen x position
		require
			parented: parent /= Void
		do
			Result := x + parent.screen_x
		end

	screen_y: INTEGER is
			-- Screen y position
		require
			parented: parent /= Void
		do
			Result := parent.screen_y
		end

	rectangle: EV_RECTANGLE is
			-- Current tab rectangle relative to `parent'.
		do
			-- When closing all editor tabs by right click menu, this feature called by on_pointer_press from SD_NOTEBOOK_TAB_BOX,
			-- parent maybe void sometimes. It's because pointer press actions delayed, the actions are executing after
			-- the SD_NOTEBOOK_TAB_BOX destroyed.
			if parent /= Void then
				create Result.make (x, 0, internal_width, height)
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

	is_displayed: BOOLEAN
			-- If current displayed?

	parent: SD_NOTEBOOK_TAB_BOX
			-- Parent tab box

feature -- Properties

	text: STRING_GENERAL
			-- Text shown on Current.

	set_text (a_text: STRING_GENERAL) is
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
			update_minmum_size
			on_expose
		ensure
			set: pixmap = a_pixmap
		end

	is_selected: BOOLEAN
			-- If Current tab selected?

	is_focused: BOOLEAN
			-- If Current focused?

	set_selected (a_selected: BOOLEAN; a_focused: BOOLEAN) is
			-- Set `selected'.
		do
			is_selected := a_selected
			is_focused := a_focused
			update_minmum_size
			if a_selected then
				show
			end
			on_expose
		ensure
			set: is_selected = a_selected
		end

	set_selection_color (a_focused: BOOLEAN) is
			-- Set color of selection color to focused selection color or non-focused color.
		require
			selected: is_selected
		do
			on_expose
		end

	info: SD_NOTEBOOK_TAB_INFO
			-- Information used for draw tabs.

	font: EV_FONT
			-- Font

	set_font (a_font: like font) is
			-- Set `font' with `a_font'
		require
			not_void: a_font /= Void
		do
			font := a_font
		ensure
			set: font = a_font
		end

feature {SD_NOTEBOOK_TAB_BOX} -- Command

	set_parent (a_parent: like parent) is
			-- Set `parent' with `a_parent'
		do
			parent := a_parent
		ensure
			set: parent = a_parent
		end

	on_expose is
			-- Handle expose actions.
		do
			on_expose_with_width (drawing_width)
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Hanlde pointer motion.
		local
			l_has_capture: BOOLEAN
		do
			if is_pointer_pressed then
				is_pointer_pressed := False
				l_has_capture := parent.has_capture
				parent.disable_capture (Current)

				-- We must check if really have vision2 capture, because capture maybe interrupted by some operations like creating a EV_DIALOG.
				if l_has_capture then
					drag_actions.call ([a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
				end
			else
				-- If user close other tab, Current tab will moved without pointer enter actiosn called.
				-- So we set is_hot here. Otherwise tab drawing state for close button will not correct.
				is_hot := True
				if internal_tab_drawer.is_top_side_tab and then internal_tab_drawer.close_rectangle_parent_box.has_x_y (a_x, a_y) then
					if not is_pointer_in_close_area and internal_width > 0 then
						is_pointer_in_close_area := True
						if is_selected then
							internal_tab_drawer.expose_selected (drawing_width, info)
						else
							internal_tab_drawer.expose_hot (drawing_width, info)
						end
					end
				else
					if is_pointer_in_close_area and internal_width > 0 then
						is_pointer_in_close_area := False
						if is_selected then
							internal_tab_drawer.expose_selected (drawing_width, info)
						else
							internal_tab_drawer.expose_hot (drawing_width, info)
						end
					end
				end
			end
		end

	on_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer press.
		local
			l_menu: SD_ZONE_MANAGEMENT_MENU
		do
			inspect
				a_button
			when 1 then
				is_pointer_pressed := True
				parent.enable_capture (Current)

				if internal_tab_drawer.is_top_side_tab and internal_width > 0 and then internal_tab_drawer.close_rectangle_parent_box.has_x_y (a_x, a_y) then
					-- For select actions, we don't call select actions.
					if is_selected then
						internal_tab_drawer.expose_selected (internal_width, info)
					else
						internal_tab_drawer.expose_hot (internal_width, info)
					end
				else
					select_actions.call (Void)
				end

			when 3 then
				select_actions.call (Void)
				create l_menu.make (internal_notebook)
				l_menu.show_at (parent, a_x, a_y)
			else

			end
		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release.
		do
			is_pointer_pressed := False
			parent.disable_capture (Current)
			if internal_tab_drawer.is_top_side_tab and internal_width > 0 and then internal_tab_drawer.close_rectangle_parent_box.has_x_y (a_x, a_y) then

				if is_selected then
					internal_tab_drawer.expose_selected (internal_width, info)
				else
					internal_tab_drawer.expose_hot (internal_width, info)
				end
				close_actions.call (Void)
			end
		end

	on_pointer_enter is
			-- Handle pointer enter actions.
		do
			is_hot := True
			on_expose
		ensure
			set: is_hot = True
		end

	on_pointer_leave is
			-- Handle pointer leave actions.
		do
			is_hot := False
			is_pointer_in_close_area := False
			on_expose
		ensure
			set: is_hot = False
		end

feature {NONE}  -- Implementation agents

	on_expose_with_width (a_width: INTEGER) is
			-- Handle expose with a_width. a_width is total width current should be.
		require
			a_width_valid: a_width >= 0
		do
			if pixmap /= Void then
				if width > 0 and height > 0 then
					if is_selected then
						internal_tab_drawer.expose_selected (a_width, info)
					else
						if is_hot then
							internal_tab_drawer.expose_hot (a_width, info)
						else
							internal_tab_drawer.expose_unselected (a_width, info)
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
			l_drawer: SD_NOTEBOOK_TAB_DRAWER_I
		do
			if parent /= Void and is_enough_space then

				l_drawer := internal_tab_drawer
				-- We want to calculate a maximum space
				l_drawer.set_selected (True, True)
				l_size := l_drawer.start_x_tail_internal

				if l_size /= internal_width then
					internal_width := l_size
				end
			end
		end

feature {NONE}  -- Implementation attributes

	internal_width: INTEGER
			-- Width

	drawing_width: INTEGER is
			-- Width showig on the screen.
		local
			l_box: SD_NOTEBOOK_TAB_AREA
			l_avail_width: INTEGER
		do
			l_box ?= parent.parent
			check not_void: l_box /= Void end
			l_avail_width := l_box.width
			if l_avail_width > 0 then
				if l_avail_width >= internal_width then
					Result := internal_width
				else
					Result := l_avail_width
				end
			end
			if Result <= 0 then
				Result := 1
			end
		ensure
			positive: Result > 0
		end

	is_draw_top_tab: BOOLEAN
			-- If current draw tab at top?

	internal_notebook: SD_NOTEBOOK
			-- Notebook Current belong to.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

	internal_tab_drawer: SD_NOTEBOOK_TAB_DRAWER_I is
			-- Drawer of Current
		do
			Result := internal_shared.notebook_tab_drawer
			Result.set_drawing_area (Current)
			Result.set_is_draw_at_top (is_draw_top_tab)
			Result.set_selected (is_selected, is_focused)
			Result.set_text (text)
			Result.set_pixmap (pixmap)
			Result.set_enough_space (is_enough_space)
		end

invariant

	not_void: internal_docking_manager /= Void
	not_void: internal_shared /= Void
	not_void: select_actions /= Void
	not_void: drag_actions /= Void
	not_void: internal_tab_drawer /= Void
	not_void: info /= Void
	not_void: close_actions /= Void

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
