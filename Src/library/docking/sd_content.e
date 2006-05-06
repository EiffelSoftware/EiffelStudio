indexing
	description: "A content which has client prgrammer's widgets managed by docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CONTENT

create
	make_with_widget_title_pixmap,
	make_with_widget

feature {NONE} -- Initialization

	make_with_widget_title_pixmap (a_widget: EV_WIDGET; a_pixmap: EV_PIXMAP; a_unique_title: STRING) is
			-- Creation method.
		require
			a_widget_not_void: a_widget /= Void
			a_pixmap_not_void: a_pixmap /= Void
			a_unique_title_not_void: a_unique_title /= Void
		local
			l_state: SD_STATE_VOID
		do
			create internal_shared
			create drop_actions
			internal_user_widget := a_widget
			internal_unique_title := a_unique_title
			internal_pixmap := a_pixmap

			create l_state.make (Current)
			internal_state := l_state
			internal_type := {SD_SHARED}.type_tool

			long_title := ""
			short_title := ""
			is_visible := False
		ensure
			a_widget_set: a_widget = internal_user_widget
			a_title_set: internal_unique_title /= Void
			a_pixmap_set: a_pixmap = internal_pixmap
			state_not_void: internal_state /= Void
			a_unique_title_set: a_unique_title = internal_unique_title
			long_title_not_void: long_title /= Void
			short_title_not_void: short_title /= Void
		end

	make_with_widget (a_widget: EV_WIDGET; a_unique_title: STRING) is
			-- Creation method.
		require
			a_widget_not_void: a_widget /= Void
		local
			l_icon: EV_PIXMAP
		do
			create internal_shared
			l_icon := internal_shared.icons.default_icon.twin
			l_icon.set_minimum_size (20, 20)
			make_with_widget_title_pixmap (a_widget, l_icon, a_unique_title)
		end

feature -- Access

	user_widget: like internal_user_widget is
			-- Client programmer's widget.
		do
			Result := internal_user_widget
		ensure
			result_valid: Result = internal_user_widget
		end

	unique_title: like internal_unique_title is
			-- Client programmer's widget's unique_title.
		do
			Result := internal_unique_title
		ensure
			result_valid: Result = internal_unique_title
		end

	long_title: STRING
			-- Client programmer's widget's long title. Which is shown at SD_TITLE_BAR.

	short_title: STRING
			-- Client programmer's widget's short title. Which is shown at SD_TAB_STUB.		

	pixmap: like internal_pixmap is
			-- Client programmer's widget's pixmap.
		do
			Result := internal_pixmap
		ensure
			result_valid: Result = internal_pixmap
		end

	mini_toolbar: like internal_mini_toolbar is
			-- Mini toolbar.
		do
			Result := internal_mini_toolbar
		ensure
			result_valid: Result = internal_mini_toolbar
		end

	type: INTEGER is
			-- Type of Current.
			-- One value from SD_SHARED type_editor or type_tool
		do
			Result := internal_type
		end

	is_visible: BOOLEAN
			-- If Current visible?

feature -- Set

	set_long_title (a_long_title: STRING) is
			-- Set `long_title'.
		require
			a_long_title_not_void: a_long_title /= Void
		do
			long_title := a_long_title
			internal_state.change_title (a_long_title, Current)
		ensure
			set: a_long_title = long_title
		end

	set_short_title (a_short_title: STRING)	is
			-- Set `short_title'.
		require
			a_short_title_not_void: a_short_title /= Void
		do
			short_title := a_short_title
			internal_state.change_title (a_short_title, Current)
		ensure
			set: a_short_title = short_title
		end

	set_pixmap (a_pixmap: like internal_pixmap) is
			-- Set the pixmap which shown on unique_title bar.
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_pixmap := a_pixmap
			internal_state.change_pixmap (a_pixmap, Current)
		ensure
			a_pixmap_set: a_pixmap = internal_pixmap
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

	set_type (a_type: INTEGER) is
			-- Set `internal_type'.
		require
			a_type_valid: a_type = {SD_SHARED}.type_tool or a_type = {SD_SHARED}.type_editor
		do
			internal_type := a_type
		end

	set_focus is
			-- Set focus to `Current'.
		do
			if docking_manager.property.last_focus_content /= Current then
				if internal_focus_in_actions /= Void then
					internal_focus_in_actions.call ([])
				end
				state.set_focus (Current)
			end
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
   			set_focus
   		end

	set_top (a_direction: INTEGER) is
			-- Set `Current' dock at top level of a main docking area at `a_direction' side.
		require
			manager_has_content: manager_has_content (Current)
			a_direction_valid: four_direction (a_direction)
		do
			state.dock_at_top_level (docking_manager.query.inner_container_main)
			set_focus
		end

	set_auto_hide (a_direction: INTEGER) is
			-- Set `Current' dock at main container's `a_direction' auto hide bar.
		require
			manager_has_content: manager_has_content (Current)
			a_direction_valid: four_direction (a_direction)
		do
			state.stick (a_direction)
			set_focus
		end

	set_floating (a_screen_x, a_screen_y: INTEGER) is
			-- Set `Current' floating at position `a_screen_x', `a_screen_y'.
		require
			manager_has_content: manager_has_content (Current)
		do
			state.float (a_screen_x, a_screen_y)
			set_focus
		end

	set_tab_with (a_content: SD_CONTENT; a_first: BOOLEAN) is
			-- Set `Current' tab whit `a_content'.
		require
			manager_has_content: manager_has_content (Current)
			manager_has_content: manager_has_content (a_content)
			target_content_shown: target_content_shown (a_content)
		local
			l_tab_zone: SD_TAB_ZONE
			l_docking_zone: SD_DOCKING_ZONE
		do
			l_tab_zone ?= a_content.state.zone
			if l_tab_zone /= Void then
				if not a_first then
				 	state.move_to_tab_zone (l_tab_zone, l_tab_zone.count + 1)
				 else
				 	state.move_to_tab_zone (l_tab_zone, 1)
				end
			else
				l_docking_zone ?= a_content.state.zone
				check l_docking_zone /= Void end
				state.move_to_docking_zone (l_docking_zone, a_first)
			end
			set_focus
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

	close_request_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to perfrom when close requested.
		do
			if internal_close_request_actions = Void then
				create internal_close_request_actions
			end
			Result := internal_close_request_actions
		end

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Drop actions.

feature -- Command

	close is
			-- Destroy `Current', only destroy zone. Prune Current from SD_DOCKING_MANAGER.
		do
			state.close
			docking_manager.contents.start
			docking_manager.contents.prune (Current)
		end

	hide is
			-- Hide zone which has `Current'.
		do
			state.hide
			is_visible := False
		end

	show is
			-- Show zone which has `Current'.
		do
			state.show
			is_visible := True
		end

feature -- States report

	manager_has_content (a_content: SD_CONTENT): BOOLEAN is
			-- If docking manager has `a_content'.
		require
			a_content_not_void: a_content /= Void
		do
			Result := docking_manager.has_content (a_content)
		end

	four_direction (a_direction: INTEGER): BOOLEAN is
			-- If `a_direction' is one of four direction?
		do
			Result := a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right or
				 a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
		end

	target_content_shown (a_target_content: SD_CONTENT): BOOLEAN is
			-- If `a_target_content' shown ?
		do
			Result := a_target_content.state.zone.parent /= Void
		end

feature {SD_STATE, SD_HOT_ZONE, SD_CONFIG_MEDIATOR, SD_ZONE, SD_DOCKING_MANAGER,
		 SD_CONTENT, SD_DOCKER_MEDIATOR, SD_TAB_STUB, SD_DOCKING_MANAGER_AGENTS,
		 SD_DOCKING_MANAGER_COMMAND, SD_ZONE_NAVIGATION_DIALOG,
		 SD_TAB_STATE_ASSISTANT} -- State

	state: like internal_state is
			-- Current state
		do
			Result := internal_state
		end

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

feature {SD_DOCKING_MANAGER_AGENTS}

	set_docking_manager (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Set docking manager
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		local
			l_state_void: SD_STATE_VOID
		do
			docking_manager := a_docking_manager
			l_state_void ?= state
			if l_state_void /= Void then
				l_state_void.set_docking_manager (docking_manager)
			end
		ensure
			set: docking_manager = a_docking_manager
		end

feature {SD_STATE} -- implementation

	notify_focus_in is
			-- Notify focus in actions.
		do
			if internal_focus_in_actions /= Void then
				internal_focus_in_actions.call ([])
			end
		end

	internal_state: SD_STATE
			-- SD_STATE instacne, which will changed base on different states.

feature {SD_STATE, SD_DOCKING_MANAGER, SD_TAB_STATE_ASSISTANT} -- Change the SD_STATE base on the states

	change_state (a_state: SD_STATE) is
			-- Called by SD_RESOTRE, change current state object.
		require
			a_state_not_void: a_state /= Void
		do
			debug ("docking")
				print ("%NXXXXXXXXXXXXXXXXXXXXXXXXXX SD_CONTENT change_state XXXXXXXXXXXXXXXXXXXXXXXXXX")
			end
			internal_state := a_state
		end

feature {SD_STATE, SD_CONFIG_MEDIATOR}

	set_visible (a_bool: BOOLEAN) is
			-- Set `is_visible'
		do
			is_visible := a_bool
		ensure
			set: is_visible = a_bool
		end

feature {NONE}  -- Implemention.

	internal_user_widget: EV_WIDGET
			-- Client programmer's widget.

	internal_unique_title: STRING
			-- The internal_user_widget's internal_unique_title.

	internal_pixmap: EV_PIXMAP
			-- The internal_pixmap at the head of internal_unique_title.

	internal_mini_toolbar: EV_WIDGET
			-- Mini toolbar at the titlt bar.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_type: INTEGER
			-- The type of `Current'. One value from SD_SHARED.	

	internal_focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Mouse focus out actions.

feature {SD_TAB_ZONE}  -- Actions for SD_TAB_ZONE

	internal_focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Mouse focus in actions.

feature {SD_STATE} -- Actions for SD_STATE

	internal_close_request_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to perfrom when close requested.

invariant

	the_user_widget_not_void: internal_user_widget /= Void
	internal_shared_not_void: internal_shared /= Void

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
