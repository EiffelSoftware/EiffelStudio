indexing
	description: "SD_ZONE that allow SD_CONTENTs tabbed."
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
			close_window
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
			default_create
			create internal_contents.make (1)
			create internal_notebook
			internal_notebook.set_minimum_size (0, 0)
			internal_notebook.set_tab_position ({EV_NOTEBOOK}.tab_bottom)

			internal_title_bar := internal_shared.widget_factory.title_bar (a_content.type, Current)
			internal_title_bar.set_stick (True)
			internal_title_bar.drag_actions.extend (agent on_drag_title_bar)
			internal_title_bar.stick_select_actions.extend (agent on_stick)
			internal_title_bar.normal_max_actions.extend (agent on_normal_max_window)
			internal_title_bar.close_actions.extend (agent on_close)
			if a_content.mini_toolbar /= Void then
				internal_title_bar.custom_area.extend (a_content.mini_toolbar)
			end

			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_motion_actions.extend (agent on_pointer_motion)
			extend_widget (internal_title_bar)
			disable_item_expand (internal_title_bar)

			internal_notebook.selection_actions.extend (agent on_select_tab)
			extend_widget (internal_notebook)

			internal_notebook.pointer_button_press_actions.extend (agent on_notebook_pointer_press)
			internal_notebook.pointer_button_release_actions.extend (agent on_notebook_pointer_release)
			internal_notebook.pointer_motion_actions.extend (agent on_notebook_notebook_pointer_motion)
		end

feature -- Query

	is_maximized: BOOLEAN is
			-- Redefine.
		do
			Result := internal_title_bar.is_max
		end

feature -- Command

	extend (a_content: SD_CONTENT) is
			-- Redefine
		do
			if a_content.user_widget.parent /= Void then
				a_content.user_widget.parent.prune (a_content.user_widget)
			end
			Precursor {SD_MULTI_CONTENT_ZONE} (a_content)
			internal_title_bar.set_title (a_content.title)
			if a_content.mini_toolbar /= Void then
				internal_title_bar.custom_area.extend (a_content.mini_toolbar)
			else
				internal_title_bar.custom_area.wipe_out
			end
		end

	set_show_stick_min_max (a_show: BOOLEAN) is
			-- Redefine.
		do
			internal_title_bar.set_show_normal_max (a_show)
			internal_title_bar.set_show_stick (a_show)
		ensure then
			set: a_show = internal_title_bar.is_show_normal_max
			set: a_show = internal_title_bar.is_show_stick
		end

	set_title (a_title: STRING; a_content: SD_CONTENT) is
			-- Set title.
		require
			a_title_not_void: a_title /= Void
			a_content_not_void: a_content /= Void
			has_content: has (a_content)
		do
			internal_notebook.set_item_text (a_content.user_widget, a_title)
			if internal_notebook.selected_item_index = internal_notebook.index_of (a_content.user_widget, 1) then
				internal_title_bar.set_title (a_title)
			end
		ensure
			set: internal_notebook.item_text (a_content.user_widget) = a_title
			set_title_bar: internal_notebook.selected_item_index = internal_notebook.index_of (a_content.user_widget, 1)
				implies internal_title_bar.title = a_title
		end

	set_pixmap (a_pixmap: EV_PIXMAP; a_content: SD_CONTENT) is
			-- Set a_content's pixmap.
		require
			a_pixmap_not_void: a_pixmap /= Void
			a_content_not_void: a_content /= Void
			has_content: has (a_content)
		do
			internal_notebook.item_tab (a_content.user_widget).set_pixmap (a_pixmap)
		ensure
			set: internal_notebook.item_tab (a_content.user_widget).pixmap = a_pixmap
		end

	set_max (a_max: BOOLEAN) is
			-- Redefine.
		do
			internal_title_bar.set_max (a_max)
		end

feature {SD_TAB_STATE} -- Internal issues.

	contents: like internal_contents is
			-- `internal_contents'.
		do
			Result := internal_contents
		ensure
			not_void: Result /= Void
		end

	selected_item_index: INTEGER is
			-- Selected item index.
		do
			Result := internal_notebook.selected_item_index
		end

	select_item (a_content: SD_CONTENT) is
			-- Select `a_item' on the notebook.
		require
			a_content_not_void: a_content /= Void
			has (a_content)
		do
			internal_notebook.select_item (a_content.user_widget)
		ensure
			selected: internal_notebook.selected_item_index = internal_notebook.index_of (a_content.user_widget, 1)
		end


feature {NONE} -- Agents for user

	on_focus_in (a_content: SD_CONTENT) is
			-- Redefine.
		do
			Precursor {SD_MULTI_CONTENT_ZONE} (a_content)
			internal_shared.docking_manager.disable_all_zones_focus_color
			internal_shared.docking_manager.remove_auto_hide_zones
			internal_title_bar.enable_focus_color

			if a_content /= Void then
				internal_notebook.select_item (a_content.user_widget)
			end
		ensure then
			title_bar_focus: internal_title_bar.is_focus_color_enable
			content_set: a_content /= Void implies internal_notebook.selected_item_index = internal_notebook.index_of (a_content.user_widget, 1)
		end

	on_focus_out is
			-- Redefine.
		do
			Precursor {SD_MULTI_CONTENT_ZONE}
			internal_title_bar.disable_focus_color
		ensure then
			title_bar_not_focus: not internal_title_bar.is_focus_color_enable
		end

	on_stick is
			-- Handle user click button.
		do
			content.state.stick_window ({SD_DOCKING_MANAGER}.dock_left)
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

	on_close is
			-- Handle user click close button.
		do

			content.state.close_window
			close_window
		end

feature {NONE} -- Agents for docker

	on_select_tab is
			-- Handle user click a tab in `internal_notebook'.
		local
			l_content: SD_CONTENT
		do
			if not internal_diable_on_select_tab then
				l_content := internal_contents.i_th (internal_notebook.selected_item_index)
				internal_title_bar.set_title (l_content.title)
				if l_content.mini_toolbar /= Void then
					internal_title_bar.custom_area.extend (l_content.mini_toolbar)
				else
					internal_title_bar.custom_area.wipe_out
				end
				if l_content.internal_focus_in_actions /= Void then
					l_content.internal_focus_in_actions.call ([])
				end
			end
		ensure
			title_bar_content_right: not internal_diable_on_select_tab implies internal_title_bar.title.is_equal (internal_contents.i_th (internal_notebook.selected_item_index).title)
			mini_tool_bar_added: not internal_diable_on_select_tab implies (internal_contents.i_th (internal_notebook.selected_item_index).mini_toolbar /= Void implies
				internal_title_bar.custom_area.item = internal_contents.i_th (internal_notebook.selected_item_index).mini_toolbar)
		end

	on_drag_title_bar (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle user drag title bar.
		local
			l_tab_state: SD_TAB_STATE
		do
			create internal_docker_mediator.make (Current)
			internal_docker_mediator.start_tracing_pointer (screen_x - a_screen_x, screen_y - a_screen_y)
			enable_capture
			l_tab_state ?= content.state
			check l_tab_state /= Void end
			l_tab_state.set_drag_title_bar (True)
		ensure
			internal_docker_mediator_not_void: internal_docker_mediator /= Void
			internal_docker_mediator_tracing_pointer: internal_docker_mediator.is_tracing_pointer
		end

	on_pointer_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release.
		do
			if internal_docker_mediator /= Void then
				debug ("larry")
					io.put_string ("%N SD_TAB_ZONE Handle pointer release.")
				end
				internal_notebook_pressed := False
				disable_capture
				internal_docker_mediator.end_tracing_pointer (a_screen_x, a_screen_y)
				internal_docker_mediator := Void
			end
		ensure
			internal_docker_mediator_stop: old internal_docker_mediator /= Void implies internal_docker_mediator = Void
		end

	on_notebook_pointer_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle notebook pointer release.
		do
			internal_notebook_pressed := False
		ensure
			set: internal_notebook_pressed = False
		end

	on_notebook_pointer_press (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle notebook pointer press.
		do
			internal_notebook_pressed := True
		ensure
			set: internal_notebook_pressed = True
		end

	on_notebook_notebook_pointer_motion (a_x, a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--	Handle notebook pointer motion.
		local
			l_tab_state: SD_TAB_STATE
		do
			debug ("larry")
				io.put_string ("%N SD_TAB_ZONE internal_notebook_pressed: " + internal_notebook_pressed.out)
			end
			if internal_notebook_pressed then
				create internal_docker_mediator.make (Current)
				internal_docker_mediator.start_tracing_pointer (screen_x - a_screen_x, screen_y - a_screen_y)
				enable_capture
				l_tab_state ?= content.state
				check l_tab_state /= Void end
				l_tab_state.set_drag_title_bar (False)
			end
		ensure
			docker_mediator_created: internal_notebook_pressed implies internal_docker_mediator /= Void
			docker_mediator_start: internal_notebook_pressed implies internal_docker_mediator.is_tracing_pointer
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

feature {NONE} -- Implementation

	close_window is
			-- Redefine
		do

		end

	internal_title_bar: SD_TITLE_BAR
			-- Title bar.

	internal_docker_mediator: SD_DOCKER_MEDIATOR
			-- Docker mediator.

	internal_notebook_pressed: BOOLEAN
			-- If user clicked notebook? Used for detect whether clicked notebook tabs.

invariant

	internal_notebook_not_void: internal_notebook /= Void

end
