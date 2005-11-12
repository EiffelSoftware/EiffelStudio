indexing
	description: "Objects that represent the zone when user content tabbed."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_ZONE

inherit
	SD_MULTI_CONTENT_ZONE
		redefine
			extend,
			on_focus_in,
			on_zone_focus_out
		end

	SD_TITLE_BAR_REMOVEABLE
		undefine
			copy,
			is_equal,
			default_create
		end

	EV_VERTICAL_BOX
		rename
			extend as extend_vertical_box,
			prune as prune_vertical_box,
			count as count_vertical_box
		end

	SD_DOCKER_SOURCE
		undefine
			copy,
			is_equal,
			default_create
		end

	SD_TITLE_BAR_REMOVEABLE
		undefine
			copy, is_equal, default_create
		end
create
	make

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_target_zone: SD_DOCKING_ZONE) is
			-- Creation method. When first time insert a SD_CONTENT.
		require
			a_content_not_void: a_content /= Void
			a_target_zone_not_void: a_target_zone /= Void
			a_content_parent_void: a_content.user_widget.parent = Void
		do
			create internal_shared
			default_create
			create internal_contents.make (1)
			create internal_notebook
			internal_notebook.set_minimum_size (0, 0)
			internal_notebook.set_tab_position ({EV_NOTEBOOK}.tab_bottom)

			internal_title_bar := internal_shared.widget_factory.title_bar (a_content.type, Current)
			internal_title_bar.set_stick (True)
			internal_title_bar.drag_actions.extend (agent handle_drag_title_bar)
			internal_title_bar.stick_select_actions.extend (agent on_stick)

			pointer_button_release_actions.extend (agent on_pointer_release)
			pointer_motion_actions.extend (agent on_pointer_motion)
			extend_vertical_box (internal_title_bar)
			disable_item_expand (internal_title_bar)


			internal_notebook.selection_actions.extend (agent on_select_tab)

			extend_vertical_box (internal_notebook)

			internal_notebook.pointer_button_press_actions.extend (agent handle_notebook_pointer_press)
			internal_notebook.pointer_button_release_actions.extend (agent handle_notebook_pointer_release)
			internal_notebook.pointer_motion_actions.extend (agent handle_notebook_notebook_pointer_motion)

--			internal_notebook.set_


--			init_focus_in (Current)

		end

feature -- Access
	extend (a_content: SD_CONTENT) is
			--
		do
			if a_content.user_widget.parent /= Void then
				a_content.user_widget.parent.prune (a_content.user_widget)
			end
			Precursor {SD_MULTI_CONTENT_ZONE} (a_content)

			internal_title_bar.set_title (a_content.title)
		end

feature -- Basic operation

	set_title_bar (a_show: BOOLEAN) is
			--
		do
			if a_show and then not has (internal_title_bar) then
				start
				put_left (internal_title_bar)
				disable_item_expand (internal_title_bar)
			elseif has (internal_title_bar) then
				prune_all (internal_title_bar)
			end
		end

	set_title (a_title: STRING; a_content: SD_CONTENT) is
			--
		require
			has_content:
		do
			internal_notebook.set_item_text (a_content.user_widget, a_title)
			if internal_notebook.selected_item_index = internal_notebook.index_of (a_content.user_widget, 1) then
				internal_title_bar.set_title (a_title)
			end
		end

	set_pixmap (a_pixmap: EV_PIXMAP; a_content: SD_CONTENT) is
			--
		do
			internal_notebook.item_tab (a_content.user_widget).set_pixmap (a_pixmap)
		end

feature {SD_TAB_STATE} -- Internal issues.

	contents: like internal_contents is
			--
		do
			Result := internal_contents
		ensure
			not_void: Result /= Void
		end

	selected_item_index: INTEGER is
			--
		do
			Result := internal_notebook.selected_item_index
		end

	select_item (a_item: SD_CONTENT) is
			--
		do
			internal_notebook.select_item (a_item.user_widget)
		end


feature {NONE} -- Implementation

	on_select_tab is
			-- Handle user click a new tab in `internal_notebook'.
		local
			l_content: SD_CONTENT
		do

			if not internal_diable_on_select_tab then
				l_content := internal_contents.i_th (internal_notebook.selected_item_index)
				internal_title_bar.set_title (l_content.title)

				if l_content.internal_focus_in_actions /= Void then
					l_content.internal_focus_in_actions.call ([])
				end

				debug ("larry")
					io.put_string ("%N select tab index:" + internal_notebook.index.out)
				end
			end

		end

	internal_title_bar: SD_TITLE_BAR

	on_focus_in (a_content: SD_CONTENT) is
			--

		do
			Precursor {SD_MULTI_CONTENT_ZONE} (a_content)
			internal_shared.docking_manager.disable_all_zones_focus_color
			internal_shared.docking_manager.remove_auto_hide_zones
			internal_title_bar.enable_focus_color

			if a_content /= Void then
				internal_notebook.select_item (a_content.user_widget)
			end
		end

	on_zone_focus_out is
			--
		do
			Precursor {SD_MULTI_CONTENT_ZONE}
			internal_title_bar.disable_focus_color
		end

	internal_docker_mediator: SD_DOCKER_MEDIATOR

	handle_drag_title_bar (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		local
			l_tab_state: SD_TAB_STATE
		do
			create internal_docker_mediator.make (Current)
			internal_docker_mediator.start_tracing_pointer (screen_x - a_screen_x, screen_y - a_screen_y)
			enable_capture
			l_tab_state ?= content.state
			check l_tab_state /= Void end
			l_tab_state.set_drag_title_bar (True)
		end

	on_stick is
			--
		do
--			content.state.stick_window (content.state.direction)
			content.state.stick_window ({SD_DOCKING_MANAGER}.dock_left)
		end

	on_pointer_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
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
		end

	handle_notebook_pointer_release (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			internal_notebook_pressed := False
		end

	handle_notebook_pointer_press (a_x, a_y, a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			internal_notebook_pressed := True
		end

	internal_notebook_pressed: BOOLEAN

	handle_notebook_notebook_pointer_motion (a_x, a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
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
		end

	on_pointer_motion (a_x, a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			if internal_docker_mediator /= Void then
				internal_docker_mediator.on_pointer_motion (a_screen_x, a_screen_y)
			end
		end

end
