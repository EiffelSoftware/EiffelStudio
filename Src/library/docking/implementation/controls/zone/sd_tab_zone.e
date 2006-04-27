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
			on_focus_in,
			on_focus_out,
			on_normal_max_window,
			is_maximized,
			set_max,
			set_focus_color,
			set_non_focus_selection_color
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

	make (a_content: SD_CONTENT; a_target_zone: SD_DOCKING_ZONE) is
			-- Creation method. When first time insert a SD_CONTENT.
			-- FIXIT: should add a_content and a_target_zone in this function?
		require
			a_content_not_void: a_content /= Void
			a_target_zone_not_void: a_target_zone /= Void
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
			if a_content.mini_toolbar /= Void then
				if a_content.mini_toolbar.parent /= Void then
					a_content.mini_toolbar.parent.prune (a_content.mini_toolbar)
				end
				internal_title_bar.extend_custom_area (a_content.mini_toolbar)
			end

			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_motion_actions.extend (agent on_pointer_motion)
			extend_widget (internal_title_bar)
			disable_item_expand (internal_title_bar)

			internal_notebook.selection_actions.extend (agent on_select_tab)
			internal_notebook.tab_drag_actions.extend (agent on_notebook_drag)
			extend_widget (internal_notebook)

			internal_notebook.drop_actions.extend (agent on_notebook_drop)

			resize_actions.extend (agent internal_notebook.on_resize)

			set_minimum_width (internal_shared.zone_minmum_width)
			set_minimum_height (internal_shared.zone_minmum_height)
		end

feature -- Query

	is_maximized: BOOLEAN is
			-- Redefine.
		do
			Result := internal_title_bar.is_max
		end

	is_drag_title_bar: BOOLEAN
			-- If user dragging title bar?

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
			if a_content.user_widget.parent /= Void then
				a_content.user_widget.parent.prune (a_content.user_widget)
			end
			Precursor {SD_MULTI_CONTENT_ZONE} (a_content)
			internal_title_bar.set_title (a_content.long_title)
			internal_notebook.set_focus_color (True)
			if a_content.mini_toolbar /= Void then
				if a_content.mini_toolbar.parent /= Void then
					a_content.mini_toolbar.parent.prune (a_content.mini_toolbar)
				end
				internal_title_bar.extend_custom_area (a_content.mini_toolbar)
			else
				internal_title_bar.wipe_out_custom_area
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

	set_title (a_title: STRING; a_content: SD_CONTENT) is
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
			set: internal_notebook.item_text (a_content) = a_title
			set_title_bar: internal_notebook.selected_item_index = internal_notebook.index_of (a_content)
				implies internal_title_bar.title = a_title
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
			valid: a_index > 0
		do
			if a_index >= contents.count then
				internal_notebook.set_content_position (a_content, contents.count)
			else
				internal_notebook.set_content_position (a_content, a_index)
			end
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
			has (a_content)
		do
			internal_notebook.select_item (a_content, a_focus)
		ensure
			selected: internal_notebook.selected_item_index = internal_notebook.index_of (a_content)
		end

feature {NONE} -- Agents for user

	on_focus_in (a_content: SD_CONTENT) is
			-- Redefine.
		do
			Precursor {SD_MULTI_CONTENT_ZONE} (a_content)
			internal_docking_manager.command.remove_auto_hide_zones (True)
			internal_title_bar.enable_focus_color
			internal_notebook.set_focus_color (True)

			if a_content /= Void then
				internal_notebook.select_item (a_content, True)
			end
		ensure then
			title_bar_focus: internal_title_bar.is_focus_color_enable
			content_set: a_content /= Void implies internal_notebook.selected_item_index = internal_notebook.index_of (a_content)
		end

	on_focus_out is
			-- Redefine.
		do
			Precursor {SD_MULTI_CONTENT_ZONE}
			internal_title_bar.disable_focus_color
			internal_notebook.set_focus_color (False)
		ensure then
			title_bar_not_focus: not internal_title_bar.is_focus_color_enable
		end

	on_stick is
			-- Handle user click button.
		do
			content.state.stick ({SD_DOCKING_MANAGER}.dock_left)
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
			if l_content.mini_toolbar /= Void then
				if l_content.mini_toolbar.parent /= Void then
					l_content.mini_toolbar.parent.prune (l_content.mini_toolbar)
				end
				internal_title_bar.extend_custom_area (l_content.mini_toolbar)
			else
				internal_title_bar.wipe_out_custom_area
			end
			if l_content.internal_focus_in_actions /= Void and then internal_docking_manager.property.last_focus_content /= l_content then
				l_content.internal_focus_in_actions.call ([])
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
			is_drag_title_bar := True
			create internal_docker_mediator.make (Current, internal_docking_manager)
			internal_docker_mediator.cancel_actions.extend (agent on_cancel_dragging)
			internal_docker_mediator.start_tracing_pointer (a_screen_x - screen_x, a_screen_y - screen_y)
			enable_capture
			l_tab_state ?= content.state
			check l_tab_state /= Void end
		ensure
			internal_docker_mediator_not_void: internal_docker_mediator /= Void
			internal_docker_mediator_tracing_pointer: internal_docker_mediator.is_tracing_pointer
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
			create internal_docker_mediator.make (Current, internal_docking_manager)
			internal_docker_mediator.cancel_actions.extend (agent on_cancel_dragging)
			internal_docker_mediator.start_tracing_pointer (a_screen_x - screen_x, screen_y + height - a_screen_y)
			enable_capture
		end

	on_pointer_motion (a_x, a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer motion.
		do
			if internal_docker_mediator /= Void then
				internal_docker_mediator.on_pointer_motion (a_screen_x, a_screen_y)
			end
		ensure
			pointer_motion_forwarded: internal_docker_mediator /= Void implies internal_docker_mediator.screen_x = a_screen_x and internal_docker_mediator.screen_y = a_screen_y
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

	internal_title_bar: SD_TITLE_BAR
			-- Title bar.

	internal_docker_mediator: SD_DOCKER_MEDIATOR
			-- Docker mediator.

invariant

	internal_notebook_not_void: internal_notebook /= Void

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
