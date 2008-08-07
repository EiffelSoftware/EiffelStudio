 indexing
	description: "A notebook show mini tool bar and tabs at top."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	appearance:
		"[
			  _______  _______  _______                        _
			_/ tab_1 \/_tab_2_\/_tab_3_\______________________|X|
			|                              						|
			|         selected_item          					|
			|                                					|
			----------------------------------------------------
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_UPPER

inherit
	SD_NOTEBOOK
		redefine
			make,
			set_tab_position,
			extend,
			on_resize,
			destroy
		end
create
	make

feature {NONE} -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		do
			create internal_tool_bar.make
			create internal_minimize_button.make
			create internal_normal_max_button.make
			create custom_area
			create internal_top_box

			create normal_max_actions
			create minimize_actions
			create drag_tab_area_actions
			
			Precursor {SD_NOTEBOOK}	(a_docking_manager)

			prune_vertical_box (internal_border_for_tab_area)
			start
			put_left (internal_border_for_tab_area)
			internal_border_for_tab_area.set_border_style ({SD_ENUMERATION}.bottom)
			internal_border_for_tab_area.wipe_out
			internal_border_for_tab_area.extend (internal_top_box)
			internal_top_box.extend (internal_tab_box)
			internal_tab_box.set_gap (True)

			internal_top_box.extend (custom_area)
			internal_top_box.disable_item_expand (custom_area)

			internal_minimize_button.set_pixmap (internal_shared.icons.minimize)
			if internal_shared.icons.minimize_buffer /= Void then
				internal_minimize_button.set_pixel_buffer (internal_shared.icons.minimize_buffer)
			end
			internal_minimize_button.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_minimize)

			internal_normal_max_button.set_pixmap (internal_shared.icons.maximize)
			if internal_shared.icons.maximize_buffer /= Void then
				internal_normal_max_button.set_pixel_buffer (internal_shared.icons.maximize_buffer)
			end
			internal_normal_max_button.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_maximize)

			internal_tool_bar.extend (internal_minimize_button)
			internal_tool_bar.extend (internal_normal_max_button)
			internal_tool_bar.compute_minimum_size

			internal_top_box.extend (internal_tool_bar)

			internal_top_box.disable_item_expand (internal_tool_bar)

			internal_tab_box.tab_box.pointer_double_press_actions.force_extend (agent on_normal_max_window)
			init_action
		end

	init_action is
			-- Initialize actions.
		do
			internal_normal_max_button.select_actions.extend (agent on_normal_max_window)
			internal_minimize_button.select_actions.extend (agent on_minimize)
			internal_tab_box.pointer_button_press_actions.extend (agent on_tab_area_pointer_press)
			internal_tab_box.pointer_button_release_actions.extend (agent on_tab_area_pointer_release)
			internal_tab_box.pointer_motion_actions.extend (agent on_tab_area_motion)
		end

feature -- Query

	custom_area: EV_CELL
			-- Custom area which allow client programmer extend.

	normal_max_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Normal\max actions.

	minimize_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Minimize actions.

	drag_tab_area_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Tab area drag actions.

	is_maximized: BOOLEAN
			-- If Current is maximized?

	is_in_close_area: BOOLEAN is
			-- If pointer position in tab close button area?
		do
			from
				internal_tabs.start
			until
				internal_tabs.after or Result
			loop
				Result := internal_tabs.item.is_pointer_in_close_area
				internal_tabs.forth
			end
		end

	in_normal_maximize_area: BOOLEAN is
			-- If pointer position in normal/maximize button area?
		do
			Result := internal_minimize_button.state = {SD_TOOL_BAR_ITEM_STATE}.hot
		end

feature -- Command

	set_mini_tool_bar (a_widget: EV_WIDGET) is
			-- Set `custom_area' widget.
		require
			a_widget_not_void: a_widget /= Void
		do
			custom_area.wipe_out
			custom_area.extend (a_widget)
		end

	set_tab_position (a_position: INTEGER) is
			-- Redefine
		do
			start
			search (internal_border_for_tab_area)
			inspect
				a_position
			when tab_top then
				if index /= 1 then
					swap (1)
				end
			when tab_bottom then
				if index /= 2 then
					swap (2)
				end
			end
			disable_item_expand (internal_border_for_tab_area)
		end

	set_show_maximized (a_maximized: BOOLEAN) is
			-- Set `internal_normal_max_button''s pixmap.
		do
			if a_maximized then
				internal_normal_max_button.set_pixmap (internal_shared.icons.normal)
				if internal_shared.icons.normal_buffer /= Void then
					internal_normal_max_button.set_pixel_buffer (internal_shared.icons.normal_buffer)
				end
				internal_normal_max_button.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_restore)
			else
				internal_normal_max_button.set_pixmap (internal_shared.icons.maximize)
				if internal_shared.icons.maximize_buffer /= Void then
					internal_normal_max_button.set_pixel_buffer (internal_shared.icons.maximize_buffer)
				end
				internal_normal_max_button.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_maximize)
			end
			is_maximized := a_maximized
		end

	set_show_minimized (a_minimized: BOOLEAN) is
			-- Set `internal_minimized_button''s pixmap
		do
			if not a_minimized then
				internal_minimize_button.set_pixmap (internal_shared.icons.minimize)
				if internal_shared.icons.minimize_buffer /= Void then
					internal_minimize_button.set_pixel_buffer (internal_shared.icons.minimize_buffer)
				end
				internal_minimize_button.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_minimize)
			else
				internal_minimize_button.set_pixmap (internal_shared.icons.normal)
				if internal_shared.icons.normal_buffer /= Void then
					internal_minimize_button.set_pixel_buffer (internal_shared.icons.normal_buffer)
				end
				internal_minimize_button.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_restore)
			end
		end

	extend (a_content: SD_CONTENT) is
			-- Redefine.
		do
			Precursor {SD_NOTEBOOK} (a_content)
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Redefine.
		do
			internal_tab_box.on_resize (a_x, a_y, a_width - internal_tool_bar.width, a_height)
		end

	destroy is
			-- Refefine
		do
			Precursor {SD_NOTEBOOK}
			-- If we don't call destory, there is 2 Gdi objects leak.
			internal_tool_bar.destroy
		end

feature {NONE}  -- Agents

	on_normal_max_window is
			-- Handle normal max window.
		do
			normal_max_actions.call (Void)
		end

	on_minimize is
			-- Handle minimize actions.
		do
			minimize_actions.call (Void)
		end

	on_tab_area_pointer_press (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32) is
			-- Handle tab area pointer press actions.
		do
			if a_button = 1 then
				setter.before_enable_capture
				internal_tab_box.enable_capture
				is_pointer_pressed := True
			end
		end

	on_tab_area_pointer_release (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32) is
			-- Handle tab area pointer release actions.
		do
			if a_button = 1 then
				internal_tab_box.disable_capture
				setter.after_disable_capture
				is_pointer_pressed := False
			end
		end

	on_tab_area_motion (a_x: INTEGER_32; a_y: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32) is
			-- Handle tab area motion actions.
		do
			if is_pointer_pressed then
				internal_tab_box.disable_capture
				setter.after_disable_capture
				is_pointer_pressed := False
				drag_tab_area_actions.call ([a_x, a_y, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y])
			end
		end

feature {NONE}  -- Implementation

	is_pointer_pressed: BOOLEAN
			-- If pointer pressed on `internal_tab_box'?

	setter: SD_SYSTEM_SETTER is
			-- System setter
		once
			create {SD_SYSTEM_SETTER_IMP} Result
		end

	internal_top_box: EV_HORIZONTAL_BOX
			-- Box which contain

	internal_button_box: EV_HORIZONTAL_BOX
			-- Box which contain `custom_area' and `internal_tool_bar'

	internal_tool_bar: SD_TOOL_BAR
			-- Tool bar has `internal_normal_max_button', `internal_close_button'.

	internal_minimize_button: SD_TOOL_BAR_BUTTON
			-- Minimize button.

	internal_normal_max_button: SD_TOOL_BAR_BUTTON
			-- Normal\max button

invariant

	internal_tool_bar_not_void: internal_tool_bar /= Void
	internal_normal_max_button_not_void: internal_normal_max_button /= Void
	internal_minimize_button_not_void: internal_minimize_button /= Void

	custom_area_not_void: custom_area /= Void
	internal_top_box_not_void: internal_top_box /= Void

	normal_max_actions_not_void: normal_max_actions /= Void
	minimize_actions_not_void: minimize_actions /= Void

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
