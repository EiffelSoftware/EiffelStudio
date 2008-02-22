indexing
	description: "A content which has client prgrammer's widgets managed by docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CONTENT

inherit
	HASHABLE

create
	make_with_widget_title_pixmap,
	make_with_widget

feature {NONE} -- Initialization

	make_with_widget_title_pixmap (a_widget: EV_WIDGET; a_pixmap: EV_PIXMAP; a_unique_title: STRING_GENERAL) is
			-- Creation method.
		require
			a_widget_not_void: a_widget /= Void
			a_pixmap_not_void: a_pixmap /= Void
			a_unique_title_not_void: a_unique_title /= Void
		local
			l_state: SD_STATE_VOID
		do
			create internal_shared
			create internal_drop_actions
			create internal_show_actions

			internal_user_widget := a_widget
			internal_user_widget.set_minimum_size (0, 0)
			internal_unique_title := a_unique_title
			internal_pixmap := a_pixmap

			create l_state.make (Current)
			internal_state := l_state
			internal_type := {SD_ENUMERATION}.tool

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

	make_with_widget (a_widget: EV_WIDGET; a_unique_title: STRING_GENERAL) is
			-- Creation method.
		require
			a_widget_not_void: a_widget /= Void
		local
			l_stock: EV_STOCK_PIXMAPS
		do
			create internal_shared
			create l_stock
			make_with_widget_title_pixmap (a_widget, l_stock.default_window_icon, a_unique_title)
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
			-- Using for save/open docking layouts, normally it should not be changed after set.
		do
			Result := internal_unique_title
		ensure
			result_valid: Result = internal_unique_title
		end

	long_title: STRING_GENERAL
			-- Client programmer's widget's long title. Which is shown at SD_TITLE_BAR.

	short_title: STRING_GENERAL
			-- Client programmer's widget's short title. Which is shown at SD_TAB_STUB.		

	pixmap: like internal_pixmap is
			-- Client programmer's widget's pixmap.
			-- The icon showing on content notebook tab and auto hide tab if Gdi+ not available on Windows platform.
		do
			Result := internal_pixmap
		ensure
			result_valid: Result = internal_pixmap
		end

	description: STRING_GENERAL
			-- When show zone navigation dialog, we use this description if exist.

	detail: STRING_GENERAL
			-- When show zone navigation dialog, we use this detail if exist.

	tab_tooltip: STRING_GENERAL
			-- Tool tip displayed on notebook tab.

	pixel_buffer: like internal_pixel_buffer is
			-- Client programmer's widget's pixel buffer
		do
			Result := internal_pixel_buffer
		ensure
			result_valid: Result = internal_pixel_buffer
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

	is_floating: BOOLEAN
			-- If Current floating?
			-- Note: Maybe Current not visible but floating.
		do
			if docking_manager /= Void then
				Result := docking_manager.query.is_floating (Current)
			end
		end

	has_focus: BOOLEAN is
			-- If Current content has focus?
		do
			Result := docking_manager.focused_content = Current
		end

	is_title_unique_except_current (a_title: STRING_GENERAL): BOOLEAN is
			-- If `a_title' unique?
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_title32: STRING_32
		do
			Result := True
			if docking_manager /= Void then
				l_contents := docking_manager.contents
				from
					l_title32 := a_title.as_string_32
					l_contents.start
				until
					l_contents.after or not Result
				loop
					if l_contents.item /= Current then
						if l_contents.item.unique_title.as_string_32.is_equal (l_title32) then
							Result := False
						end
					end
					l_contents.forth
				end
			end
		end

	hash_code: INTEGER is
			-- Hash code
		do
			Result := unique_title.hash_code
		end

	floating_width: INTEGER is
			-- If Current floating, the width of the floating window which contain Current.
		do
			Result := state.last_floating_width
		end

	floating_height: INTEGER is
			-- If Current floating, the height of the floating window which contain Current.
		do
			Result := state.last_floating_height
		end

	state_value: INTEGER is
			-- Current state.
			-- Note, it's possible result is {SD_ENUMERATION}.auto_hide, but `is_visible' return False. See bug#13339.
		local
			l_void: SD_STATE_VOID
			l_docking: SD_DOCKING_STATE
			l_tab: SD_TAB_STATE
			l_auto_hide: SD_AUTO_HIDE_STATE
		do
			l_void ?= state
			l_docking ?= state
			l_tab ?= state
			l_auto_hide ?= state
			if l_void /= Void then
				Result := {SD_ENUMERATION}.state_void
			elseif l_docking /= Void then
				Result := {SD_ENUMERATION}.docking
			elseif l_tab /= Void then
				Result := {SD_ENUMERATION}.tab
			elseif l_auto_hide /= Void then
				Result := {SD_ENUMERATION}.auto_hide
			end
		ensure
			vaild: (create {SD_ENUMERATION}).is_state_valid (Result)
		end

feature -- Set

	set_long_title (a_long_title: STRING_GENERAL) is
			-- Set `long_title'.
		require
			a_long_title_not_void: a_long_title /= Void
		do
			long_title := a_long_title
			internal_state.change_title (a_long_title, Current)
		ensure
			set: a_long_title = long_title
		end

	set_short_title (a_short_title: STRING_GENERAL)	is
			-- Set `short_title'.
		require
			a_short_title_not_void: a_short_title /= Void
		do
			short_title := a_short_title
			internal_state.change_title (a_short_title, Current)
		ensure
			set: a_short_title = short_title
		end

	set_unique_title (a_unique_title: STRING_GENERAL) is
			-- Set `unique_title'
		require
			a_unique_title_not_void: a_unique_title /= Void
			title_valid: is_title_unique_except_current (a_unique_title)
		do
			internal_unique_title := a_unique_title
		ensure
			set: unique_title = a_unique_title
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

	set_description (a_description: like description) is
			-- Set `a_description' to `description'
		require
			a_description_not_void: a_description /= Void
		do
			description := a_description
		ensure
			a_description_set: description = a_description
		end

	set_detail (a_detail: like detail) is
			-- Set `a_detail' to `detail'
		require
			a_detail_not_void: a_detail /= Void
		do
			detail := a_detail
		ensure
			a_detail_set: detail = a_detail
		end

	set_tab_tooltip (a_text: like tab_tooltip) is
			-- Set `a_text' to `tab_tooltip'
		do
			tab_tooltip := a_text
			state.change_tab_tooltip (a_text)
		ensure
			set: tab_tooltip = a_text
		end

	set_pixel_buffer (a_buffer: like internal_pixel_buffer) is
			-- Set `internal_pixel_buffer'
		require
			a_buffer_not_void: a_buffer /= Void
		do
			internal_pixel_buffer := a_buffer
			-- FIXIT: should have something like this.
--			internal_state.change_pixmap (a_pixmap: EV_PIXMAP, a_content: SD_CONTENT)
		ensure
			a_buffer_set: a_buffer = internal_pixel_buffer
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
			a_type_valid: (create {SD_ENUMERATION}).is_type_valid (a_type)
		do
			internal_type := a_type
		end

	set_focus is
			-- Set focus to `Current'.
		require
			visible: is_visible
			not_destroyed: not is_destroyed
			attached: is_docking_manager_attached
		do
			if docking_manager.property.last_focus_content /= Current and not docking_manager.property.is_opening_config then
				state.set_focus (Current)
				if internal_focus_in_actions /= Void then
					internal_focus_in_actions.call (Void)
				end
			end
		end

	set_focus_no_maximized (a_zone: EV_WIDGET) is
			-- Same as `set_focus', but only do things when no maximized zone in dock area which has `a_zone'
		require
			not_destroyed: not is_destroyed
			attached: is_docking_manager_attached
		do
			if docking_manager.property.last_focus_content /= Current and not docking_manager.property.is_opening_config then
				if docking_manager.query.maximized_inner_container (a_zone) = Void then
					set_focus
				end
			end
		end

	set_user_widget (a_widget: EV_WIDGET) is
			-- Set `user_widget' with `a_widget'.
		require
			not_void: a_widget /= Void
		do
			internal_user_widget := a_widget
			state.set_user_widget (a_widget)
		end

	set_floating_width (a_width: INTEGER) is
			-- Set `floating_width'
		require
			valid: a_width >= 0
		do
			state.set_last_floating_width (a_width)
		ensure
			set: floating_width = a_width
		end

	set_floating_height (a_height: INTEGER) is
			-- Set `floating_height'
		require
			vaild: a_height >= 0
		do
			state.set_last_floating_height (a_height)
		ensure
			set: floating_height = a_height
		end

feature -- Set Position

	set_relative (a_relative: SD_CONTENT; a_direction: INTEGER) is
			-- Set `Current' to dock at `a_direction' side of `a_relative'.
		require
			a_relative_not_void: a_relative /= Void
			attached: is_docking_manager_attached
			manager_has_content: manager_has_content (Current)
			manager_has_content: manager_has_content (a_relative)
			a_direction_valid: four_direction (a_direction)
			not_auto_hide: a_relative.state_value /= {SD_ENUMERATION}.auto_hide
			not_destroyed: not is_destroyed
		do
			set_visible (True)
   			state.change_zone_split_area (a_relative.state.zone, a_direction)
   			set_focus
   		end

	set_top (a_direction: INTEGER) is
			-- Set `Current' dock at top level of a main docking area at `a_direction' side.
		require
			attached: is_docking_manager_attached
			manager_has_content: manager_has_content (Current)
			a_direction_valid: four_direction (a_direction)
			not_destroyed: not is_destroyed
		do
			set_visible (True)
			state.set_direction (a_direction)
			state.dock_at_top_level (docking_manager.query.inner_container_main)
			set_focus
		end

	set_auto_hide (a_direction: INTEGER) is
			-- Set `Current' dock at main container's `a_direction' auto hide bar.
		require
			attached: is_docking_manager_attached
			manager_has_content: manager_has_content (Current)
			a_direction_valid: four_direction (a_direction)
			not_destroyed: not is_destroyed
		do
			set_visible (True)
			state.stick (a_direction)
			set_focus
		end

	set_floating (a_screen_x, a_screen_y: INTEGER) is
			-- Set `Current' floating at position `a_screen_x', `a_screen_y'.
		require
			attached: is_docking_manager_attached
			manager_has_content: manager_has_content (Current)
			not_destroyed: not is_destroyed
		do
			set_visible (True)
			state.float (a_screen_x, a_screen_y)
			set_focus
		end

	set_tab_with (a_content: SD_CONTENT; a_left: BOOLEAN) is
			-- Set `Current' tab with `a_content'.
			-- If `a_left' then put new tab at left, otherwise put new tab at right
		require
			attached: is_docking_manager_attached
			manager_has_current_content: manager_has_content (Current)
			manager_has_a_content: manager_has_content (a_content)
			target_content_zone_parent_exist: target_content_zone_parent_exist (a_content)
			not_destroyed: not is_destroyed
		local
			l_tab_zone: SD_TAB_ZONE
			l_docking_zone: SD_DOCKING_ZONE
		do
			set_visible (True)
			l_tab_zone ?= a_content.state.zone
			l_docking_zone ?= a_content.state.zone
			if l_tab_zone /= Void then
				if not a_left then
				 	state.move_to_tab_zone (l_tab_zone, l_tab_zone.count + 1)
				 else
				 	state.move_to_tab_zone (l_tab_zone, 1)
				end
			elseif l_docking_zone /= Void then
				state.move_to_docking_zone (l_docking_zone, a_left)
			else
				-- `a_content' is auto hide state, zone is void.
				state.auto_hide_tab_with (a_content)
			end
			set_focus
		end

	set_default_editor_position is
			-- Set editor to default editor position.
		require
			attached: is_docking_manager_attached
			manager_has_content: manager_has_content (Current)
			editor_place_holder_in: manager_has_place_holder
			is_editor: type = {SD_ENUMERATION}.editor
			not_destroyed: not is_destroyed
		do
			set_visible (True)
			set_relative (docking_manager.zones.place_holder_content, {SD_ENUMERATION}.top)
			docking_manager.zones.place_holder_content.close
			set_focus
		ensure
			no_place_holder: not manager_has_place_holder
		end

	set_split_proportion (a_proportion: REAL) is
			-- If current content is docking or tabbed, set parent splitter proportion to `a_proportion'.
		require
			attached: is_docking_manager_attached
			valid: 0 <= a_proportion and a_proportion <= 1
			not_destroyed: not is_destroyed
		do
			state.set_split_proportion (a_proportion)
		end

feature -- Actions

	focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when keyboard focus is gained.
		do
			if not is_ignore_actions then
				if internal_focus_in_actions = Void then
					create internal_focus_in_actions
				end
				Result := internal_focus_in_actions
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

	focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when keyboard focus is lost.
		do
			if not is_ignore_actions then
				if internal_focus_out_actions = Void then
					create internal_focus_out_actions
				end
				Result := internal_focus_out_actions
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

	close_request_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to perfrom when close requested.
		do
			if not is_ignore_actions then
				if internal_close_request_actions = Void then
					create internal_close_request_actions
				end
				Result := internal_close_request_actions
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Drop actions to performed when user drop a pebble on notebook tab.
		do
			if not is_ignore_actions then
				if internal_drop_actions = Void then
					create internal_drop_actions
				end
				Result := internal_drop_actions
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

	show_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to perform when `user_widget' is shown.
		do
			if not is_ignore_actions then
				if internal_show_actions = Void then
					create internal_show_actions
				end
				Result := internal_show_actions
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

feature -- Command

	close is
			-- Destroy `Current', only destroy zone. Prune Current from SD_DOCKING_MANAGER.
		require
			not_destroyed: not is_destroyed
		do
			state.close
			if is_docking_manager_attached then
				internal_clear_docking_manager_property

				docking_manager.contents.start
				docking_manager.contents.prune (Current)
			end
		ensure
			detached: not is_docking_manager_attached
		end

	hide is
			-- Hide zone which has `Current'.
		require
			not_destroyed: not is_destroyed
			attached: is_docking_manager_attached
		do
			state.hide
			is_visible := False
			if docking_manager.property.last_focus_content = Current then
				docking_manager.property.set_last_focus_content (Void)
			end
		end

	show is
			-- Show zone which has `Current'.
		require
			not_destroyed: not is_destroyed
			attached: is_docking_manager_attached
		do
			state.show
			is_visible := True
		end

	minimize is
			-- Minimize if possible
		require
			not_destroyed: not is_destroyed
			attached: is_docking_manager_attached
		do
			state.minimize
		end

	update_mini_tool_bar_size is
			-- Update mini tool bar size
		require
			not_destroyed: not is_destroyed
			attached: is_docking_manager_attached
		local
			l_zone: SD_ZONE
		do
			l_zone := state.zone
			if l_zone /= Void then
				l_zone.update_mini_tool_bar_size
			end
		end

	destroy is
			-- When a SD_DOCKING_MANAGER destroy, all SD_CONTENTs in it will be destroyed.
			-- Clear all resources and all references.
		do
			if not is_destroyed then
				is_destroyed := True
				internal_state := Void
				-- We can create a SD_STATE_VOID here, otherwise it will reference to `docking_manager',
				-- and this is a memory leak.
				docking_manager := Void
				if internal_close_request_actions /= Void then
					internal_close_request_actions.wipe_out
					internal_close_request_actions := Void
				end
				if internal_focus_in_actions /= Void then
					internal_focus_in_actions.wipe_out
					internal_focus_in_actions := Void
				end
				if internal_focus_out_actions /= Void then
					internal_focus_out_actions.wipe_out
					internal_focus_out_actions := Void
				end
				if internal_drop_actions /= Void then
					internal_drop_actions.wipe_out
					internal_drop_actions := Void
				end
				if internal_show_actions /= Void then
					internal_show_actions.wipe_out
					internal_show_actions := Void
				end

				internal_user_widget := Void
				internal_mini_toolbar := Void
			end
		ensure
			destroyed: is_destroyed
		end

feature -- States report

	manager_has_content (a_content: SD_CONTENT): BOOLEAN is
			-- If docking manager has `a_content'.
		require
			a_content_not_void: a_content /= Void
			attached: is_docking_manager_attached
		do
			Result := docking_manager.has_content (a_content)
		end

	manager_has_place_holder: BOOLEAN is
			-- If docking manager has editor place holder?
		require
			attached: is_docking_manager_attached
		do
			Result := docking_manager.has_content (docking_manager.zones.place_holder_content)
		end

	four_direction (a_direction: INTEGER): BOOLEAN is
			-- If `a_direction' is one of four direction?
		do
			Result := (create {SD_ENUMERATION}).is_direction_valid (a_direction)
		end

	target_content_shown (a_target_content: SD_CONTENT): BOOLEAN is
			-- If `a_target_content' shown ?
		local
			l_zone: SD_ZONE
		do
			l_zone := a_target_content.state.zone
			Result := l_zone /= Void and then l_zone.parent /= Void
		end

	target_content_zone_parent_exist (a_target_content: SD_CONTENT): BOOLEAN is
			-- If `a_target_content''s zone parent not void if exists.
		local
			l_zone: SD_ZONE
		do
			l_zone := a_target_content.state.zone
			if l_zone /= Void then
				Result := l_zone.parent /= Void
			else
				Result := True
			end
		end

	is_destroyed: BOOLEAN
			-- If Current destroyed? Not useable anymore?

	is_docking_manager_attached: BOOLEAN
			-- If Current has related docking manager?
			-- If {SD_DOCKING_MANAGER}.contents has Current, Result is True. Otherwise, Result is False.
		do
			Result := docking_manager /= Void
		end

feature {SD_STATE, SD_HOT_ZONE, SD_OPEN_CONFIG_MEDIATOR, SD_SAVE_CONFIG_MEDIATOR, SD_ZONE,
		 SD_DOCKING_MANAGER, SD_CONTENT, SD_DOCKER_MEDIATOR, SD_TAB_STUB, SD_DOCKING_MANAGER_AGENTS,
		 SD_DOCKING_MANAGER_COMMAND, SD_ZONE_NAVIGATION_DIALOG, SD_TAB_STATE_ASSISTANT,
		  SD_DOCKING_MANAGER_QUERY} -- State

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
		local
			l_state_void: SD_STATE_VOID
		do
			if a_docking_manager = Void and is_docking_manager_attached then
				internal_clear_docking_manager_property
			end
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
				internal_focus_in_actions.call (Void)
			end
		end

	internal_state: SD_STATE
			-- SD_STATE instacne, which will changed base on different states.

feature {SD_STATE, SD_DOCKING_MANAGER, SD_TAB_STATE_ASSISTANT, SD_OPEN_CONFIG_MEDIATOR} -- Change the SD_STATE base on the states

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

feature {SD_STATE, SD_OPEN_CONFIG_MEDIATOR}

	set_visible (a_bool: BOOLEAN) is
			-- Set `is_visible'
		local
			l_zone: SD_ZONE
		do
			is_visible := a_bool
			if internal_user_widget /= Void and then not internal_user_widget.is_displayed then
				internal_user_widget.show
			end
			l_zone := state.zone
			if l_zone /= Void and then not l_zone.is_destroyed and then not l_zone.is_displayed then
				l_zone.show
			end
		ensure
			set: is_visible = a_bool
		end

feature {NONE}  -- Implemention.

	is_ignore_actions: BOOLEAN
			-- Ignore actions?
		do
			Result := docking_manager /= Void and then docking_manager.is_closing_all
		end

	internal_user_widget: EV_WIDGET
			-- Client programmer's widget.

	internal_unique_title: STRING_GENERAL
			-- The internal_user_widget's internal_unique_title.

	internal_pixmap: EV_PIXMAP
			-- The internal_pixmap at the head of internal_unique_title.

	internal_pixel_buffer: EV_PIXEL_BUFFER
			-- The pixel buffer at the head of `internal_unique_title'

	internal_mini_toolbar: EV_WIDGET
			-- Mini toolbar at the titlt bar.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_type: INTEGER
			-- The type of `Current'. One value from SD_SHARED.	

	internal_focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Mouse focus out actions.

	internal_drop_actions: EV_PND_ACTION_SEQUENCE
			-- Drop actions to performed when user drop a pebble on notebook tab.

	internal_show_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to perform when `user_widget' is shown.

	internal_focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Mouse focus in actions.

	internal_close_request_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to perfrom when close requested.	

	internal_clear_docking_manager_property is
			-- Clear stuffs related with Current in {SD_DOCKING_MANAGER_PROPERTY}.
		require
			attached: is_docking_manager_attached
		do
			docking_manager.property.remove_from_clicked_list (Current)
			if docking_manager.property.last_focus_content = Current then
				docking_manager.property.set_last_focus_content (Void)
			end
		end

invariant
	the_user_widget_not_void: internal_user_widget /= Void
	internal_shared_not_void: internal_shared /= Void

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
