indexing
	description: "Objects that represent a client's widget which docking issues are managed"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CONTENT

create
	make_with_widget_title_pixmap,
	make_with_widget

feature {NONE} -- Initialization

	make_with_widget_title_pixmap (a_widget: EV_WIDGET; a_title: STRING; a_pixmap: EV_PIXMAP) is
			-- Creation method.
		require
			a_widget_not_void: a_widget /= Void
			a_widget_valid: user_widget_valid (a_widget)
			a_title_not_void: a_title /= Void
			a_pixmap_not_void: a_pixmap /= Void
		local
			l_state: SD_STATE_VOID
		do
			create internal_shared
			internal_user_widget := a_widget
			internal_title := a_title
			internal_pixmap := a_pixmap

			-- By default, dock left.
			create l_state.make (Current)
--			l_state.dock_at_top_level (internal_shared.docking_manager.inner_container_main)
			internal_state := l_state
			internal_type := {SD_SHARED}.type_normal
		ensure
			a_widget_set: a_widget = internal_user_widget
			a_title_set: a_title = internal_title
			a_pixmap_set: a_pixmap = internal_pixmap
			state_not_void: internal_state /= Void
		end

	make_with_widget (a_widget: EV_WIDGET) is
			-- Creation method.
		require
			a_widget_not_void: a_widget /= Void
		local
			l_icon: EV_PIXMAP
		do
			create internal_shared
			l_icon := internal_shared.icons.default_icon.twin
			l_icon.set_minimum_size (20, 20)
			make_with_widget_title_pixmap (a_widget, "Untitled", l_icon)
		end

feature -- Access

	user_widget: like internal_user_widget is
			-- Client programmer's widget.
		do
			Result := internal_user_widget
		ensure
			result_valid: Result = internal_user_widget
		end

	title: like internal_title is
			-- Client programmer's widget's title.
		do
			Result := internal_title
		ensure
			result_valid: Result = internal_title
		end

	set_title (a_title: like internal_title) is
			-- Set the widget's title
		require
			a_title_not_void: a_title /= Void
		do
			internal_title := a_title
			internal_state.change_title (a_title, Current)
		ensure
			a_title_set: a_title = internal_title
		end

	pixmap: like internal_pixmap is
			-- Client programmer's widget's pixmap.
		do
			Result := internal_pixmap
		ensure
			result_valid: Result = internal_pixmap
		end

	set_pixmap (a_pixmap: like internal_pixmap) is
			-- Set the pixmap which shown on title bar.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_pixmap := a_pixmap
			internal_state.change_pixmap (a_pixmap, Current)
		ensure
			a_pixmap_set: a_pixmap = internal_pixmap
		end

	mini_toolbar: like internal_mini_toolbar is
			-- Mini toolbar.
		do
			Result := internal_mini_toolbar
		ensure
			result_valid: Result = internal_mini_toolbar
		end

	set_mini_toolbar (a_bar: like internal_mini_toolbar) is
			-- Set mini toolbar.
		require
			a_bar_not_void: a_bar /= Void
		do
			internal_mini_toolbar := a_bar
		ensure
			a_bar_set: a_bar = internal_mini_toolbar
		end

	type: INTEGER is
			--
		do
			Result := internal_type
		end

	set_type (a_type: INTEGER) is
			--
		require
			a_type_valid: a_type = {SD_SHARED}.type_normal or a_type = {SD_SHARED}.type_editor
		do
			internal_type := a_type
		end

feature -- Set Position

	set_relative (a_relative: SD_CONTENT; a_direction: INTEGER) is
			-- Set `Current' to dock at `a_direction' side of `a_relative'.
		require
			a_relative_not_void: a_relative /= Void
			manager_has_content: manager_has_content (Current)
			manager_has_content: manager_has_content (a_relative)
			a_direction_valid: four_direction (a_direction)
		do
   			state.change_zone_split_area (a_relative.state.zone, a_direction)
   		end

	set_top (a_direction: INTEGER) is
			-- Set `Current' dock at top level of a main docking area at `a_direction' side.
		require
			manager_has_content: manager_has_content (Current)
			a_direction_valid: four_direction (a_direction)
		do
--	   		state.dock_at_top_level (internal_shared.docking_manager.inner_container (state.zone))
			state.dock_at_top_level (internal_shared.docking_manager.inner_container_main)
		end

	set_auto_hide (a_direction: INTEGER) is
			-- Set `Current' dock at main container's `a_direction' auto hide bar.
		require
			manager_has_content: manager_has_content (Current)
			a_direction_valid: four_direction (a_direction)
		do
			state.stick_window (a_direction)
		end

	set_floating (a_screen_x, a_screen_y: INTEGER) is
			-- Set `Current' floating at position `a_screen_x', `a_screen_y'.
		require
			manager_has_content: manager_has_content (Current)
		do
			state.float_window (a_screen_x, a_screen_y)
		end

	set_tab_with (a_content: SD_CONTENT) is
			-- Set `Current' tab whit `a_content'.
		require
			manager_has_content: manager_has_content (Current)
			manager_has_content: manager_has_content (a_content)
		local
			l_tab_zone: SD_TAB_ZONE
			l_docking_zone: SD_DOCKING_ZONE
		do
			l_tab_zone ?= a_content.state.zone
			if l_tab_zone /= Void then
				state.move_to_tab_zone (l_tab_zone)
			else
				l_docking_zone ?= a_content.state.zone
				check l_docking_zone /= Void end
				state.move_to_docking_zone (l_docking_zone)
			end
		end

feature -- Actions

	focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when keyboard focus is gained.
		do
			if internal_focus_in_actions = Void then
				create internal_focus_in_actions
			end
			Result := internal_focus_in_actions
		ensure
			not_void: Result /= Void
		end

	focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when keyboard focus is lost.
		do
			if internal_focus_out_actions = Void then
				create internal_focus_out_actions
			end
			Result := internal_focus_out_actions
		ensure
			not_void: Result /= Void
		end

	close_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions perfromed before close.
		do
			if internal_close_actions = Void then
				create internal_close_actions
			end
			Result := internal_close_actions
		end

feature --

	set_close_behavior (a_destroy: BOOLEAN) is
			-- set `default_destroy'.
		do
			default_destroy := a_destroy
		ensure
			a_destroy_set: default_destroy = a_destroy
		end

	close is
			-- Destroy `Current' from docking library if `default_destroy', otherwise hide.
		do
			if internal_close_actions /= Void then
				internal_close_actions.call ([])
			end
			state.close_window

		end

	set_focus is
			-- Set focus to `Current'.
		do
			state.zone.on_focus_in (Current)
		end

feature -- States report

	user_widget_valid (a_widget: EV_WIDGET): BOOLEAN is
			-- Dose a_widget alreay in docking library?
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_container: EV_CONTAINER
			l_found: BOOLEAN
		do
			l_contents := internal_shared.docking_manager.contents
			from
				l_contents.start
			until
				l_contents.after or l_found
			loop
				l_container ?= l_contents.item.user_widget
				if l_container /= Void then
					if l_container.has_recursive (a_widget) then
						l_found := True
					end
				else
					if a_widget = l_contents.item.user_widget then
						l_found := True
					end
				end
				l_contents.forth
			end
			Result := not l_found
		end

	default_destroy: BOOLEAN
			-- If user click 'X' button, close `Current' or hide `Current'?

	manager_has_content (a_content: SD_CONTENT): BOOLEAN is
			-- If docking manager has `a_content'.
		require
			a_content_not_void: a_content /= Void
		do
			Result := internal_shared.docking_manager.has_content (a_content)
		end

	four_direction (a_direction: INTEGER): BOOLEAN is
			-- If `a_direction' is one of four direction?
		do
			Result := a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right or
				 a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
		end


feature {SD_STATE, SD_HOT_ZONE, SD_CONFIG, SD_ZONE, SD_DOCKING_MANAGER, SD_CONTENT} -- Access

	state: like internal_state is
			-- Current state
		do
			Result := internal_state
		end

feature {SD_STATE} -- implementation
	notify_focus_in is
			--
		do
			if internal_focus_in_actions /= Void then
				internal_focus_in_actions.call ([])
			end
		end

	internal_state: SD_STATE
			-- The SD_STATE instacne, which will change itself base on different states. States pattern.

feature {SD_STATE, SD_DOCKING_MANAGER} -- Change the SD_STATE base on the states

	change_state (a_state: SD_STATE) is
			-- Called by SD_RESOTRE, change current state object.
		require
			a_state_not_void: a_state /= Void
		do
			internal_state := a_state
		end

feature {NONE}  -- Implemention

	internal_user_widget: EV_WIDGET
			-- Client programmer's widget.

	internal_title: STRING
			-- The internal_user_widget's internal_title.

	internal_pixmap: EV_PIXMAP
			-- The internal_pixmap at the head of internal_title.

	internal_mini_toolbar: EV_TOOL_BAR
			-- Mini toolbar at the titlt bar.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_type: INTEGER
			-- The type of `Current'. One value from SD_SHARED.	

	internal_focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Mouse focus out actions.

feature {SD_TAB_ZONE}

	internal_focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Mouse focus in actions.

feature {SD_STATE} -- Implementation

	internal_close_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions perfromed before close.

invariant
	the_user_widget_not_void: internal_user_widget /= Void
end
