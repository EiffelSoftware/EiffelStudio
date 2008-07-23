indexing
	description: "SD_ZONE that allow SD_CONTENTs tabbed."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_ZONE

inherit
	SD_MULTI_CONTENT_ZONE
		redefine
			extend,
			prune,
			on_focus_in,
			on_focus_out,
			on_normal_max_window,
			is_maximized,
			set_max,
			set_focus_color,
			set_non_focus_selection_color,
			save_content_title,
			update_mini_tool_bar_size
		end

	SD_TITLE_BAR_REMOVEABLE
		undefine
			copy,
			is_equal,
			default_create
		end

	EV_VERTICAL_BOX
		rename
			extend as extend_widget,
			prune as prune_widget,
			count as count_widget,
			has as has_widget,
			index_of as index_of_widget
		select
			implementation,
			count_widget,
			set_extend,
			put
		end

	SD_DOCKER_SOURCE
		undefine
			copy,
			is_equal,
			default_create
		end

create
	make

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT) is
			-- Creation method. When first time insert a SD_CONTENT.
			-- FIXIT: should add a_content and a_target_zone in this function?
		require
			a_content_not_void: a_content /= Void
			a_content_parent_void: a_content.user_widget.parent = Void
		do
			create internal_shared
			create internal_shared_not_used
			internal_docking_manager := a_content.docking_manager
			default_create
			create internal_notebook.make (internal_docking_manager)
			internal_notebook.set_minimum_size (0, 0)
			internal_notebook.set_tab_position ({SD_NOTEBOOK}.tab_bottom)

			internal_title_bar := internal_shared.widget_factory.title_bar (a_content.type, Current)
			internal_title_bar.set_stick (True)
			internal_title_bar.drag_actions.extend (agent on_drag_title_bar)
			internal_title_bar.stick_select_actions.extend (agent on_stick)
			internal_title_bar.normal_max_actions.extend (agent on_normal_max_window)
			internal_title_bar.close_request_actions.extend (agent on_close_request)

			update_mini_tool_bar (a_content)

			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_motion_actions.extend (agent on_pointer_motion)
			extend_widget (internal_title_bar)
			disable_item_expand (internal_title_bar)

			internal_notebook.selection_actions.extend (agent on_select_tab)
			internal_notebook.tab_drag_actions.extend (agent on_notebook_drag)
			extend_widget (internal_notebook)

			internal_notebook.drop_actions.extend (agent on_notebook_drop)

			resize_actions.extend (agent internal_notebook.on_resize)

			set_minimum_width (internal_shared.zone_minimum_width)
			set_minimum_height (internal_shared.zone_minimum_height)
		end

feature -- Query

	is_maximized: BOOLEAN is
			-- Redefine.
		do
			Result := internal_title_bar.is_max
		end

	is_drag_title_bar: BOOLEAN
			-- If user dragging title bar?
			-- If true, then we move all the contents, otherwise only move selected content.

	title_area: EV_RECTANGLE is
			-- Title bar area.
		do
			create Result.make (internal_title_bar.screen_x, internal_title_bar.screen_y, internal_title_bar.width, internal_title_bar.height)
		ensure
			not_void: Result /= Void
		end

feature -- Command

	extend (a_content: SD_CONTENT) is
			-- Redefine
		do
			if not has (a_content) then
				if a_content.user_widget.parent /= Void then
					a_content.user_widget.parent.prune (a_content.user_widget)
				end
				Precursor {SD_MULTI_CONTENT_ZONE} (a_content)
				internal_title_bar.set_title (a_content.long_title)
				internal_notebook.set_focus_color (True)
				update_mini_tool_bar (a_content)
			end
		end

	prune (a_content: SD_CONTENT; a_focus: BOOLEAN) is
			-- Redefine
		local
			l_selected: SD_CONTENT
			l_index: INTEGER
		do
			Precursor {SD_MULTI_CONTENT_ZONE} (a_content, a_focus)
			l_index := selected_item_index
			if l_index = 0 then
				l_index := 1
			end
			l_selected := contents.i_th (l_index)
			-- `l_selected' should not be void in theroy.
			-- But in fact, it can be void sometimes, see bug#12807.
			if l_selected /= Void then
				internal_title_bar.set_title (l_selected.long_title)
				update_mini_tool_bar (l_selected)
			end
		end

	set_show_normal_max (a_show: BOOLEAN) is
			-- Redefine.
		do
			internal_title_bar.set_show_normal_max (a_show)
		ensure then
			set: a_show = internal_title_bar.is_show_normal_max
		end

	set_show_stick (a_show: BOOLEAN) is
			-- Redefine.
		do
			internal_title_bar.set_show_stick (a_show)
		ensure then
			set: a_show = internal_title_bar.is_show_stick
		end

	set_title (a_title: STRING_GENERAL; a_content: SD_CONTENT) is
			-- Set title.
		require
			a_title_not_void: a_title /= Void
			a_content_not_void: a_content /= Void
			has_content: has (a_content)
		do
			internal_notebook.set_item_text (a_content, a_title)
			if internal_notebook.selected_item_index = internal_notebook.index_of (a_content) then
				internal_title_bar.set_title (a_title)
			end
		ensure
			set: internal_notebook.item_text (a_content).is_equal (a_title.as_string_32)
			set_title_bar: internal_notebook.selected_item_index = internal_notebook.index_of (a_content)
				implies internal_title_bar.title.is_equal (a_title.as_string_32)
		end

	set_pixmap (a_pixmap: EV_PIXMAP; a_content: SD_CONTENT) is
			-- Set a_content's pixmap.
		require
			a_pixmap_not_void: a_pixmap /= Void
			a_content_not_void: a_content /= Void
			has_content: has (a_content)
		do
			internal_notebook.set_item_pixmap (a_content, a_pixmap)
		ensure
			set: internal_notebook.item_pixmap (a_content) = a_pixmap
		end

	set_max (a_max: BOOLEAN) is
			-- Redefine.
		do
			internal_title_bar.set_max (a_max)
		end

	set_focus_color (a_selection: BOOLEAN) is
			-- Redefine
		do
			if a_selection then
				internal_title_bar.enable_focus_color
				internal_notebook.set_active_color (True)
			else
				internal_title_bar.disable_focus_color
			end
		end

	set_non_focus_selection_color is
			-- Redefine
		do
			internal_title_bar.enable_non_focus_active_color
			internal_notebook.set_active_color (False)
		end

	set_content_position (a_content: SD_CONTENT; a_index: INTEGER) is
			-- Set a_content's position to a_index.
		require
			has: has (a_content)
		do
			if not contents.valid_index (a_index) then
				internal_notebook.set_content_position (a_content, contents.count)
			else
				internal_notebook.set_content_position (a_content, a_index)
			end
		end

	update_mini_tool_bar_size is
			-- Redefine
		do
			internal_title_bar.update_fixed_size
		end

feature {SD_OPEN_CONFIG_MEDIATOR} --

	save_content_title (a_config_data: SD_INNER_CONTAINER_DATA) is
			-- Redefine.
		do
			Precursor {SD_MULTI_CONTENT_ZONE}(a_config_data)
			a_config_data.set_selected_tab_index (selected_item_index)
		end

feature {SD_TAB_STATE} -- Internal issues.

	selected_item_index: INTEGER is
			-- Selected item index.
		do
			Result := internal_notebook.selected_item_index
		end

	select_item (a_content: SD_CONTENT; a_focus: BOOLEAN) is
			-- Select `a_item' on the notebook.
		require
			a_content_not_void: a_content /= Void
			has: has (a_content)
		do
			internal_notebook.select_item (a_content, a_focus)
			update_mini_tool_bar (a_content)
			on_select_tab
		ensure
			selected: internal_notebook.selected_item_index = internal_notebook.index_of (a_content)
		end

	is_content_selected (a_content: SD_CONTENT): BOOLEAN is
			-- If `a_content''s widget selected in notebook?
		do
			if a_content /= Void then
				Result := internal_notebook.is_content_selected (a_content)
			end
		end

feature {SD_FLOATING_STATE} -- Internal issues

	set_drag_title_bar (a_bool: BOOLEAN) is
			-- Set `is_drag_title_bar' with `a_bool'
		do
			is_drag_title_bar := a_bool
		ensure
			set: is_drag_title_bar = a_bool
		end

feature -- Agents for user

	on_focus_in (a_content: SD_CONTENT) is
			-- Redefine.
		do
			Precursor {SD_MULTI_CONTENT_ZONE} (a_content)
			internal_docking_manager.command.remove_auto_hide_zones (True)
			internal_title_bar.enable_focus_color
			internal_notebook.set_focus_color (True)
			if a_content /= Void then
				update_mini_tool_bar (a_content)
				internal_title_bar.set_title (a_content.long_title)
				internal_notebook.select_item (a_content, True)
			end
		ensure then
			content_set: a_content /= Void implies internal_notebook.selected_item_index = internal_notebook.index_of (a_content)
		end

	on_focus_out is
			-- Redefine.
		do
			Precursor {SD_MULTI_CONTENT_ZONE}
			internal_title_bar.disable_focus_color
			internal_notebook.set_focus_color (False)
		end

	on_stick is
			-- Handle user click button.
		do
			content.state.stick ({SD_ENUMERATION}.left)
		ensure
			state_changed:
		end

	on_normal_max_window is
			-- Handle user click min max button.
		do
			if internal_title_bar.is_show_normal_max then
				Precursor {SD_MULTI_CONTENT_ZONE}
			end
		end

feature {NONE} -- Agents for docker

	on_select_tab is
			-- Handle user click a tab in `internal_notebook'.
		local
			l_content: SD_CONTENT
		do
			l_content := contents.i_th (internal_notebook.selected_item_index)
			internal_title_bar.set_title (l_content.long_title)
			update_mini_tool_bar (l_content)
			if not l_content.focus_in_actions.is_empty and then internal_docking_manager.property.last_focus_content /= l_content then
				l_content.focus_in_actions.call (Void)
			end
			internal_docking_manager.property.set_last_focus_content (l_content)
		ensure
--			title_bar_content_right: not internal_diable_on_select_tab implies internal_title_bar.title.is_equal (contents.i_th (internal_notebook.selected_item_index).long_title)
--			mini_tool_bar_added: not internal_diable_on_select_tab implies (contents.i_th (internal_notebook.selected_item_index).mini_toolbar /= Void implies
--				internal_title_bar.custom_area.item = contents.i_th (internal_notebook.selected_item_index).mini_toolbar)
		end

	on_drag_title_bar (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle user drag title bar.
		local
			l_tab_state: SD_TAB_STATE
		do
			if not is_destroyed and then is_displayed then
				is_drag_title_bar := True
				internal_docker_mediator := internal_docking_manager.query.docker_mediator (Current, internal_docking_manager)
				internal_docker_mediator.cancel_actions.extend (agent on_cancel_dragging)

				enable_capture
				internal_docker_mediator.start_tracing_pointer (a_screen_x - screen_x, a_screen_y - screen_y)

				l_tab_state ?= content.state
				check l_tab_state /= Void end
			end
		ensure
			internal_docker_mediator_tracing_pointer: internal_docker_mediator /= Void implies internal_docker_mediator.is_tracing_pointer
		end

	on_pointer_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release.
		do
			if internal_docker_mediator /= Void then
				debug ("docking")
					io.put_string ("%N SD_TAB_ZONE Handle pointer release.")
				end
				disable_capture
				internal_docker_mediator.end_tracing_pointer (a_screen_x, a_screen_y)
				internal_docker_mediator := Void
				is_drag_title_bar := False
			end
		ensure
			internal_docker_mediator_stop: old internal_docker_mediator /= Void implies internal_docker_mediator = Void
		end

	on_notebook_drag (a_content: SD_CONTENT; a_x, a_y, a_screen_x, a_screen_y: INTEGER) is
			-- Handle notebook drag actions.
		do
			internal_docker_mediator := internal_docking_manager.query.docker_mediator (Current, internal_docking_manager)
			internal_docker_mediator.cancel_actions.extend (agent on_cancel_dragging)
			-- Enable captuer must called before start tracing pointer on GTK, otherwise, pointer realse actions may not be called on GTK.
			enable_capture
			internal_docker_mediator.start_tracing_pointer (a_screen_x - screen_x, screen_y + height - a_screen_y)
		end

	on_pointer_motion (a_x, a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer motion.
		do
			-- If `internal_docker_mediator' /= Void and `internal_docker_mediator'.is_tracing = False, it means, we just started enable capture in `on_notebook_drag', but not called `start_tracing_pointer' yet.
			if internal_docker_mediator /= Void and then internal_docker_mediator.is_tracing then
				internal_docker_mediator.on_pointer_motion (a_screen_x, a_screen_y)
			end
		ensure
			pointer_motion_forwarded: internal_docker_mediator /= Void and then internal_docker_mediator.is_tracing implies
				internal_docker_mediator.screen_x = a_screen_x and internal_docker_mediator.screen_y = a_screen_y
		end

	on_notebook_drop (a_any: ANY) is
			-- Handle pointer drop.
		do
		end

	on_cancel_dragging is
			-- Handle cancel dragging from SD_DOCKER_MEDIATOR.
		do
			disable_capture
			internal_docker_mediator := Void
			is_drag_title_bar := False
		end

feature {NONE} -- Implementation

	update_mini_tool_bar (a_content: SD_CONTENT) is
			-- Show mini tool bar if exist, otherwise clear mini tool bar area.
		require
			not_void: a_content /= Void
		do
			if a_content.mini_toolbar /= Void then
				if a_content.mini_toolbar.parent /= Void then
					a_content.mini_toolbar.parent.prune (a_content.mini_toolbar)
				end
				internal_title_bar.extend_custom_area (a_content.mini_toolbar)
			else
				internal_title_bar.clear_custom_widget
			end
		end

	internal_title_bar: SD_TITLE_BAR
			-- Title bar.

	internal_docker_mediator: SD_DOCKER_MEDIATOR
			-- Docker mediator.

invariant

	internal_notebook_not_void: internal_notebook /= Void

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
