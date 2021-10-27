note
	description: "Tabs in SD_NOTEBOOK"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB

inherit
	HASHABLE

	SD_DOCKING_MANAGER_HOLDER

create
	make

feature {NONE}  -- Initlization

	make (a_notebook: SD_NOTEBOOK; a_top: BOOLEAN; a_docking_manager: SD_DOCKING_MANAGER)
			-- Creation method
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
			set_docking_manager (a_docking_manager)
			internal_notebook := a_notebook

			init_drawing_style (a_top)
			set_enough_space
		ensure
			set: internal_notebook = a_notebook
			set: docking_manager = a_docking_manager
		end

	init_drawing_style (a_top: BOOLEAN)
			-- Init `internal_tab_style'
		do
			is_draw_top_tab := a_top
			internal_tab_drawer.set_padding_width (internal_shared.padding_width)
		end

feature -- Command

	set_drop_actions (a_actions: SD_CONTENT_PND_ACTION_SEQUENCE)
			-- Set drop actions to Current
		require
			not_destroyed: not is_destroyed
			a_actions_not_void: a_actions /= Void
		do
			drop_actions := a_actions
		ensure
			set: drop_actions = a_actions
		end

	set_width_not_enough_space (a_width: INTEGER)
			-- Set current width
		require
			not_destroyed: not is_destroyed
			a_width_valid: a_width >= 0
		do
			on_expose_with_width (a_width)
			is_enough_space := False
		ensure
			set: not is_enough_space
		end

	set_enough_space
			-- Set current is enought space to show
		require
			not_destroyed: not is_destroyed
		do
			is_enough_space := True
			update_minmum_size
		ensure
			set: is_enough_space
		end

	is_enough_space: BOOLEAN
			-- If Current have enough space?

	set_draw_pixmap
			-- Set `internal_draw_pixmap'.
		require
			not_destroyed: not is_destroyed
		do
			internal_draw_pixmap := True
		end

	set_tool_tip (a_text: detachable READABLE_STRING_GENERAL)
			-- Set `tool_tip' with `a_text'
		require
			not_destroyed: not is_destroyed
		do
			if a_text /= Void then
				tool_tip := a_text.as_string_32
			else
				tool_tip := Void
			end
		ensure
			set: a_text /= Void implies (attached tool_tip as l_tooltip and then l_tooltip.same_string_general (a_text))
		end

	clear_pressed_flag
			-- Set `is_pointer_pressed' to False
			-- Clear `first_press_position' data
		require
			not_destroyed: not is_destroyed
		do
			first_press_position := Void
		end

	hide
			-- Hide
		require
			not_destroyed: not is_destroyed
		do
			is_displayed := False
		end

	show
			-- Show
		require
			not_destroyed: not is_destroyed
		do
			is_displayed := True
		end

	destroy
			-- Destory
		do
			if attached parent as l_parent then
				l_parent.prune (Current)
				parent := Void
			end
			clear_docking_manager
			is_destroyed := True
		ensure
			cleared: parent = Void
			destroyed: is_destroyed
		end

feature -- Query

	drop_actions: detachable SD_CONTENT_PND_ACTION_SEQUENCE
			-- Drop actions

	internal_draw_pixmap: BOOLEAN
			-- If draw `pixmap'?

	preferred_size: INTEGER
			-- If current is displayed, size should take
		require
			not_destroyed: not is_destroyed
		do
			Result := internal_width
		end

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Select actions

	close_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Close actions

	drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Drag tab actions

	is_hot: BOOLEAN
			-- If Current hot?

	is_pointer_in_close_area: BOOLEAN
			-- If pointer in close button area?

	is_pointer_pressed: BOOLEAN
			-- Is pointer button pressed?
		do
			Result := attached first_press_position
		end

	x: INTEGER
			-- X position relative to parent box.
		require
			not_destroyed: not is_destroyed
			not_void: parent /= Void
		do
			if attached parent as l_parent then
				Result := l_parent.item_x (Current)
			end
		end

	width: INTEGER
			-- Width.
		require
			not_destroyed: not is_destroyed
		do
			if is_displayed then
				Result := internal_width
			end
		end

	height: INTEGER
			-- Height.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
		do
			if attached parent as l_parent then
				Result := l_parent.height
			end
		end

	tool_tip: detachable STRING_32
			-- Tool tip

	screen_x: INTEGER
			-- Screen x position.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
		do
			if attached parent as l_parent then
				Result := x + l_parent.screen_x
			end
		end

	screen_y: INTEGER
			-- Screen y position.
		require
			not_destroyed: not is_destroyed
			parented: parent /= Void
		do
			if attached parent as l_parent then
				Result := l_parent.screen_y
			end
		end

	rectangle: EV_RECTANGLE
			-- Current tab rectangle relative to `parent'
		require
			not_destroyed: not is_destroyed
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
			-- If Current displayed?

	is_destroyed: BOOLEAN
			-- If Current destroyed?

	parent: detachable SD_NOTEBOOK_TAB_BOX
			-- Parent tab box

	hash_code: INTEGER
			-- Hash code
		do
			Result := text.hash_code
		end

feature -- Properties

	text: STRING_32
			-- Text shown on Current

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Set `text'
		require
			not_destroyed: not is_destroyed
			a_text_not_void: a_text /= Void
		do
			text := a_text.as_string_32
			update_minmum_size
		ensure
			set: text.same_string_general (a_text)
		end

	pixmap: EV_PIXMAP
			-- Pixmap shown on Current

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Set `a_pixmap'
		require
			not_destroyed: not is_destroyed
			a_pixmap_not_void: a_pixmap /= Void
		do
			pixmap := a_pixmap
			update_minmum_size
		ensure
			set: pixmap = a_pixmap
		end

	is_selected: BOOLEAN
			-- If Current tab selected?

	is_focused: BOOLEAN
			-- If Current focused?

	set_selected (a_selected: BOOLEAN; a_focused: BOOLEAN)
			-- Set `selected'
		require
			not_destroyed: not is_destroyed
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

	set_selection_color (a_focused: BOOLEAN)
			-- Set color of selection color to focused selection color or non-focused color
		require
			not_destroyed: not is_destroyed
			selected: is_selected
		do
			on_expose
		end

	info: SD_NOTEBOOK_TAB_INFO
			-- Information used for draw tabs

	font: detachable EV_FONT
			-- Font

	set_font (a_font: like font)
			-- Set `font' with `a_font'
		require
			not_destroyed: not is_destroyed
			not_void: a_font /= Void
		do
			font := a_font
		ensure
			set: font = a_font
		end

	on_expose
			-- Handle expose actions
		require
			not_destroyed: not is_destroyed
		do
			on_expose_with_width (drawing_width)
		end

feature {SD_NOTEBOOK_TAB_BOX} -- Command

	set_parent (a_parent: like parent)
			-- Set `parent' with `a_parent'
		require
			not_destroyed: not is_destroyed
		do
			parent := a_parent
		ensure
			set: parent = a_parent
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Hanlde pointer motion
		require
			not_destroyed: not is_destroyed
		local
			l_drawer: like internal_tab_drawer
			l_in_close_button: BOOLEAN
			l_offset: INTEGER
		do
			if attached first_press_position as l_position then
				-- Don't start drag in close button area
				if is_draw_top_tab and then internal_tab_drawer.close_rectangle_parent_box.has_x_y (a_x, a_y) then
					l_in_close_button := True
				end
				if not l_in_close_button then
						-- We must check if really have vision2 capture, because capture maybe interrupted by some operations like creating a EV_DIALOG.
					if attached parent as p and then p.has_capture then
						l_offset := internal_shared.drag_offset
						-- Only after user pointer moved `l_offset' pixels, then start calling `drag_actions'.
						-- Otherwise, it's too sensitive. See bug#13038
						if (a_screen_x < l_position.x - l_offset or a_screen_x > l_position.x + l_offset) or
							(a_screen_y < l_position.y - l_offset or a_screen_y > l_position.y + l_offset) then
							p.disable_capture (Current)
							drag_actions.call ([a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
							first_press_position := Void
						end
					end
				end
			else
				-- If user close other tab, Current tab will moved without pointer enter actiosn called.
				-- So we set is_hot here. Otherwise tab drawing state for close button will not correct.
				is_hot := True
				l_drawer := internal_tab_drawer
				if
					l_drawer.is_top_side_tab
					and then l_drawer.close_rectangle_parent_box.has_x_y (a_x, a_y)
				then
					if not is_pointer_in_close_area and internal_width > 0 then
						is_pointer_in_close_area := True
						if is_selected then
							l_drawer.expose_selected (drawing_width, info)
						else
							l_drawer.expose_hot (drawing_width, info)
						end
					end
				else
					if is_pointer_in_close_area and internal_width > 0 then
						is_pointer_in_close_area := False
						if is_selected then
							l_drawer.expose_selected (drawing_width, info)
						else
							l_drawer.expose_hot (drawing_width, info)
						end
					end
				end
			end
		end

	on_pointer_motion_for_tooltip (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer motion actions for setting tooltips
		require
			not_destroyed: not is_destroyed
		do
			if rectangle.has_x_y (a_x, a_y) and then attached parent as p then
				if attached tool_tip as l_tool_tip and then not p.tooltip.same_string (l_tool_tip) then
					p.set_tooltip (l_tool_tip)
				elseif tool_tip = Void then
					p.remove_tooltip
				end
			end
		end

	on_pointer_press (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer press
		require
			not_destroyed: not is_destroyed
		local
			l_drawer: like internal_tab_drawer
		do
			inspect
				a_button
			when {EV_POINTER_CONSTANTS}.left then
				create first_press_position.make_with_position (a_screen_x, a_screen_y)

				l_drawer := internal_tab_drawer
				if
					l_drawer.is_top_side_tab
					and internal_width > 0
					and then l_drawer.close_rectangle_parent_box.has_x_y (a_x, a_y)
				then
					-- For close actions, we don't call select actions
					if is_selected then
						redraw_selected
					else
						l_drawer.expose_hot (internal_width, info)
					end
					is_close_button_pressed := True
				else
					is_close_button_pressed := False
					select_actions.call (Void)
				end

					-- We enable capture after calling `select_actions', this will make debugger working in client programmers `select_actions'.
				if attached parent as p then
					p.enable_capture (Current)
				end
			when {EV_POINTER_CONSTANTS}.right then
				select_actions.call (Void)
				show_right_click_menu (False, a_x, a_y)
			when {EV_POINTER_CONSTANTS}.middle then
				close_actions.call (Void)
			else

			end
		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer release
		require
			not_destroyed: not is_destroyed
		local
			l_drawer: like internal_tab_drawer
		do
			first_press_position := Void
			if attached parent as p then
				p.disable_capture (Current)
			end
			l_drawer := internal_tab_drawer
			if a_button = {EV_POINTER_CONSTANTS}.right then
				show_right_click_menu (True, a_x, a_y)
			elseif
				l_drawer.is_top_side_tab
				and internal_width > 0
				and then l_drawer.close_rectangle_parent_box.has_x_y (a_x, a_y)
			then
				if is_close_button_pressed then
					if is_selected then
						redraw_selected
					else
						l_drawer.expose_hot (internal_width, info)
					end
					close_actions.call (Void)
				end
			end
		end

	on_pointer_enter
			-- Handle pointer enter actions
		require
			not_destroyed: not is_destroyed
		do
			is_hot := True
			is_close_button_pressed := False
			on_expose
		ensure
			set: is_hot
		end

	on_pointer_leave
			-- Handle pointer leave actions
		require
			not_destroyed: not is_destroyed
		do
			is_hot := False
			is_pointer_in_close_area := False
			on_expose
		ensure
			set: not is_hot
		end

feature {SD_NOTEBOOK_TAB_DRAWER_IMP, SD_NOTEBOOK_TAB_BOX} -- Internal command

	redraw_selected
			-- Redraw selected
		require
			not_destroyed: not is_destroyed
		local
			l_drawer: like internal_tab_drawer
		do
			l_drawer := internal_tab_drawer
			if l_drawer /= Void then
				internal_tab_drawer.expose_selected (internal_width, info)
			end
		end

	draw_focus_rect
			-- Draw focus rectangle
		require
			not_destroyed: not is_destroyed
		local
			l_rect: EV_RECTANGLE
		do
			l_rect := rectangle
			l_rect.set_left (l_rect.left + focus_rect_padding)
			l_rect.set_top (l_rect.top + focus_rect_padding)
			l_rect.set_right (l_rect.right - focus_rect_padding)
			l_rect.set_bottom (l_rect.bottom - focus_rect_padding)
			internal_tab_drawer.draw_focus_rect (l_rect)
		end

feature {NONE}  -- Implementation agents

	on_expose_with_width (a_width: INTEGER)
			-- Handle expose with `a_width'. `a_width' is total width current should be
		require
			not_destroyed: not is_destroyed
			a_width_valid: a_width >= 0
		local
			l_drawer: like internal_tab_drawer
		do
			if pixmap /= Void then
				if width > 0 and height > 0 and a_width > 0 then
					l_drawer := internal_tab_drawer
					if is_selected then
						l_drawer.expose_selected (a_width, info)
					else
						if is_hot then
							l_drawer.expose_hot (a_width, info)
						else
							l_drawer.expose_unselected (a_width, info)
						end
					end
				end
			end
		end

feature {NONE}  -- Implementation functions

	update_minmum_size
			-- Update minmum size of Current
		require
			not_destroyed: not is_destroyed
		local
			l_size: INTEGER
			l_drawer: like internal_tab_drawer
		do
			if parent /= Void and is_enough_space then

				l_drawer := internal_tab_drawer
				-- We want to calculate a maximum space
				l_drawer.set_selected (True, True)
					-- Crop size if it exceeds the maximum tab size
				l_size := l_drawer.start_x_tail_internal.min (internal_shared.Notebook_tab_maximum_size)

				if l_size /= internal_width then
					internal_width := l_size
				end
			end
		end

	show_right_click_menu (a_pointer_release_action: BOOLEAN; a_relative_x, a_relative_y: INTEGER)
			-- Show right click menu
			-- We will use pointer release action to show the menu only in the future. Larry 2007-6-7
		require
			not_destroyed: not is_destroyed
		local
			l_menu: EV_MENU
			l_platform: PLATFORM
		do
			create l_platform
			if (l_platform.is_windows and not a_pointer_release_action) or (not l_platform.is_windows and a_pointer_release_action) then
				l_menu := internal_shared.widget_factory.editor_tab_area_menu (internal_notebook)
				if attached parent as p then
					l_menu.show_at (p, a_relative_x, a_relative_y)
				end
			end
		end

feature {NONE}  -- Implementation attributes

	first_press_position: detachable EV_COORDINATE
			-- Is pointer button pressed? If yes, the value means the screen position of first pointer press
			-- Otherwise, the value is void

	focus_rect_padding: INTEGER = 2
			-- Padding with of focus rectangle

	internal_width: INTEGER
			-- Width

	drawing_width: INTEGER
			-- Width displayed on the screen
		require
			not_destroyed: not is_destroyed
		local
			l_avail_width: INTEGER
		do
			if attached parent as l_parent and then attached l_parent.parent as l_box then
				l_avail_width := l_box.width
			end
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

	is_close_button_pressed: BOOLEAN
			-- If close button has been just pressed?

	internal_notebook: SD_NOTEBOOK
			-- Notebook Current belong to

	internal_shared: SD_SHARED
			-- All singletons

	internal_tab_drawer: SD_NOTEBOOK_TAB_DRAWER_I
			-- Drawer of Current
		require
			not_destroyed: not is_destroyed
		do
			Result := internal_shared.notebook_tab_drawer (Current)
			Result.set_drawing_area (Current)
			Result.set_is_draw_at_top (is_draw_top_tab)
			Result.set_selected (is_selected, is_focused)
			Result.set_text (text)
			Result.set_pixmap (pixmap)
			Result.set_enough_space (is_enough_space)
		end

invariant
	internal_shared_not_void: internal_shared /= Void
	select_actions_not_void: select_actions /= Void
	drag_actions_not_void: drag_actions /= Void
	internal_tab_drawer_not_void: internal_tab_drawer /= Void
	info_not_void: info /= Void
	close_actions_not_void: close_actions /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
