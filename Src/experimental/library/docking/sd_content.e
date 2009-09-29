note
	description: "A content which has client prgrammer's widgets managed by docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CONTENT

inherit
	HASHABLE

	SD_ACCESS

	SD_DOCKING_MANAGER_HOLDER
		export
			{SD_ACCESS} all
			{ANY} is_docking_manager_attached
		redefine
			set_docking_manager
		end

create
	make_with_widget_title_pixmap,
	make_with_widget

feature {NONE} -- Initialization

	make_with_widget_title_pixmap (a_widget: EV_WIDGET; a_pixmap: EV_PIXMAP; a_unique_title: STRING_GENERAL)
			-- Creation method
		require
			a_widget_not_void: a_widget /= Void
			a_pixmap_not_void: a_pixmap /= Void
			a_unique_title_not_void: a_unique_title /= Void
		local
			l_state: SD_STATE_VOID
		do
			create internal_shared

			internal_user_widget := a_widget
			user_widget.set_minimum_size (0, 0)
			internal_unique_title := a_unique_title
			internal_pixmap := a_pixmap

			create l_state.make
			internal_state := l_state
			internal_type := {SD_ENUMERATION}.tool

			long_title := ""
			short_title := ""
			is_visible := False

			l_state.set_content (Current)
		ensure
			a_widget_set: a_widget = internal_user_widget
			a_title_set: internal_unique_title /= Void
			a_pixmap_set: a_pixmap = internal_pixmap
			state_not_void: is_state_set
			a_unique_title_set: a_unique_title.as_string_32.is_equal (internal_unique_title)
			long_title_not_void: long_title /= Void
			short_title_not_void: short_title /= Void
		end

	make_with_widget (a_widget: EV_WIDGET; a_unique_title: STRING_GENERAL)
			-- Creation method
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

	user_widget: attached like internal_user_widget
			-- Client programmer's widget
		require
			set: is_user_widget_set
		local
			l_result: detachable like user_widget
		do
			l_result := internal_user_widget
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
			result_valid: Result = internal_user_widget
		end

	unique_title: like internal_unique_title
			-- Client programmer's widget's unique_title
			-- Using for save/open docking layouts, normally it should not be changed after set
		do
			Result := internal_unique_title
		ensure
			result_valid: Result = internal_unique_title
		end

	long_title: STRING_32
			-- Client programmer's widget's long title
			-- The long title is used in all title bars where are enough space

	short_title: STRING_32
			-- Client programmer's widget's short title
			-- The short title is used in all tabs where are not enough space

	pixmap: like internal_pixmap
			-- Client programmer's widget's pixmap
			-- The icon showing on content notebook tab and auto hide tab if Gdi+ not available on Windows platform
		do
			Result := internal_pixmap
		ensure
			result_valid: Result = internal_pixmap
		end

	description: detachable STRING_32
			-- When show zone navigation dialog, we use this description if exist

	detail: detachable STRING_32
			-- When show zone navigation dialog, we use this detail if exist

	tab_tooltip: detachable STRING_32
			-- Tool tip displayed on notebook tab

	pixel_buffer: like internal_pixel_buffer
			-- Client programmer's widget's pixel buffer
		do
			Result := internal_pixel_buffer
		ensure
			result_valid: Result = internal_pixel_buffer
		end

	mini_toolbar: like internal_mini_toolbar
			-- Mini toolbar
		do
			Result := internal_mini_toolbar
		ensure
			result_valid: Result = internal_mini_toolbar
		end

	type: INTEGER
			-- Type of Current.
			-- One value from SD_SHARED type_editor or type_tool
		do
			Result := internal_type
		end

	is_visible: BOOLEAN
			-- If Current visible?

	is_floating: BOOLEAN
			-- If Current floating?
			-- Note: Maybe Current not visible but floating
		do
			if docking_manager /= Void then
				Result := docking_manager.query.is_floating (Current)
			end
		end

	has_focus: BOOLEAN
			-- If Current content has focus?
		do
			Result := docking_manager.focused_content = Current
		end

	is_title_unique_except_current (a_title: STRING_GENERAL): BOOLEAN
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

	hash_code: INTEGER
			-- Hash code
		do
			Result := unique_title.hash_code
		end

	floating_width: INTEGER
			-- If Current floating, the width of the floating window which contain Current
		do
			Result := state.last_floating_width
		end

	floating_height: INTEGER
			-- If Current floating, the height of the floating window which contain Current
		do
			Result := state.last_floating_height
		end

	state_value: INTEGER
			-- Current state.
			-- Note, it's possible result is {SD_ENUMERATION}.auto_hide, but `is_visible' return False. See bug#13339.
		local
			l_void: detachable SD_STATE_VOID
			l_docking: detachable SD_DOCKING_STATE
			l_tab: detachable SD_TAB_STATE
			l_auto_hide: detachable SD_AUTO_HIDE_STATE
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

	set_long_title (a_long_title: STRING_GENERAL)
			-- Set `long_title'
		require
			a_long_title_not_void: a_long_title /= Void
		do
			long_title := a_long_title
			state.change_long_title (a_long_title, Current)
		ensure
			set: a_long_title.as_string_32.is_equal (long_title)
		end

	set_short_title (a_short_title: STRING_GENERAL)
			-- Set `short_title'
		require
			a_short_title_not_void: a_short_title /= Void
			not_too_long: a_short_title.count < 1000
		do
			short_title := a_short_title
			state.change_short_title (a_short_title, Current)
		ensure
			set: a_short_title.as_string_32.is_equal (short_title)
		end

	set_unique_title (a_unique_title: STRING_GENERAL)
			-- Set `unique_title'
		require
			a_unique_title_not_void: a_unique_title /= Void
			title_valid: is_title_unique_except_current (a_unique_title)
		do
			internal_unique_title := a_unique_title
		ensure
			set: unique_title.is_equal (a_unique_title.as_string_32)
		end

	set_pixmap (a_pixmap: like internal_pixmap)
			-- Set the pixmap which shown on unique_title bar
		require
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_pixmap := a_pixmap
			state.change_pixmap (a_pixmap, Current)
		ensure
			a_pixmap_set: a_pixmap = internal_pixmap
		end

	set_description (a_description: like description)
			-- Set `a_description' to `description'
		require
			a_description_not_void: a_description /= Void
		do
			description := a_description
		ensure
			a_description_set: description = a_description
		end

	set_detail (a_detail: like detail)
			-- Set `a_detail' to `detail'
		require
			a_detail_not_void: a_detail /= Void
		do
			detail := a_detail
		ensure
			a_detail_set: detail = a_detail
		end

	set_tab_tooltip (a_text: like tab_tooltip)
			-- Set `a_text' to `tab_tooltip'
		do
			tab_tooltip := a_text
			state.change_tab_tooltip (a_text)
		ensure
			set: tab_tooltip = a_text
		end

	set_pixel_buffer (a_buffer: like internal_pixel_buffer)
			-- Set `internal_pixel_buffer'
		require
			a_buffer_not_void: a_buffer /= Void
		do
			internal_pixel_buffer := a_buffer
			-- FIXIT: should have something like this
--			state.change_pixmap (a_pixmap: EV_PIXMAP, a_content: SD_CONTENT)
		ensure
			a_buffer_set: a_buffer = internal_pixel_buffer
		end

	set_mini_toolbar (a_bar: like internal_mini_toolbar)
			-- Set mini toolbar
		require
			a_bar_not_void: a_bar /= Void
		do
			internal_mini_toolbar := a_bar
			state.set_mini_toolbar (a_bar)
		ensure
			a_bar_set: a_bar = internal_mini_toolbar
		end

	set_type (a_type: INTEGER)
			-- Set `internal_type'
		require
			a_type_valid: (create {SD_ENUMERATION}).is_type_valid (a_type)
		do
			internal_type := a_type
		end

	set_focus
			-- Set focus to `Current'
		require
			visible: is_visible
			not_destroyed: not is_destroyed
			docking_attached: is_docking_manager_attached
		do
			if docking_manager.property.last_focus_content /= Current and not docking_manager.property.is_opening_config then
				state.set_focus (Current)
				if attached internal_focus_in_actions as l_focus_in_actions then
					l_focus_in_actions.call (Void)
				end
			end
		end

	set_focus_no_maximized (a_zone: EV_WIDGET)
			-- Same as `set_focus', but only do things when no maximized zone in dock area which has `a_zone'
		require
			not_destroyed: not is_destroyed
			docking_manager_attached: is_docking_manager_attached
		do
			if docking_manager.property.last_focus_content /= Current and not docking_manager.property.is_opening_config then
				if docking_manager.query.maximized_inner_container (a_zone) = Void then
					if not is_visible then
						show
					end
					set_focus
				end
			end
		end

	set_user_widget (a_widget: EV_WIDGET)
			-- Set `user_widget' with `a_widget'
		require
			not_void: a_widget /= Void
		do
			internal_user_widget := a_widget
			state.set_user_widget (a_widget)
		end

	set_floating_width (a_width: INTEGER)
			-- Set `floating_width'
		require
			valid: a_width >= 0
		do
			state.set_last_floating_width (a_width)
		ensure
			set: floating_width = a_width
		end

	set_floating_height (a_height: INTEGER)
			-- Set `floating_height'
		require
			vaild: a_height >= 0
		do
			state.set_last_floating_height (a_height)
		ensure
			set: floating_height = a_height
		end

feature -- Set Position

	set_relative (a_relative: SD_CONTENT; a_direction: INTEGER)
			-- Set `Current' to dock at `a_direction' side of `a_relative'
		require
			a_relative_not_void: a_relative /= Void
			a_relative_zone_not_void: is_content_zone_set (a_relative)
			docking_manager_attached: is_docking_manager_attached
			manager_has_content: manager_has_content (Current)
			manager_has_content: manager_has_content (a_relative)
			a_direction_valid: four_direction (a_direction)
			not_auto_hide: a_relative.state_value /= {SD_ENUMERATION}.auto_hide
			not_destroyed: not is_destroyed
		local
			l_old_is_visible: BOOLEAN
		do
			l_old_is_visible := is_visible

			set_visible (True)
			if attached a_relative.state.zone as l_target_zone then
				state.change_zone_split_area (l_target_zone, a_direction)
			else
				check False end -- Implied by precondition `a_relative_zone_not_void'
			end

			if not l_old_is_visible then
				show_actions.call (Void)
			end

   			set_focus
   		end

	set_top (a_direction: INTEGER)
			-- Set `Current' dock at top level of a main docking area at `a_direction' side
		require
			docking_manager_attached: is_docking_manager_attached
			manager_has_content: manager_has_content (Current)
			a_direction_valid: four_direction (a_direction)
			not_destroyed: not is_destroyed
		local
			l_old_is_visible: BOOLEAN
		do
			l_old_is_visible := is_visible

			set_visible (True)
			state.set_direction (a_direction)
			state.dock_at_top_level (docking_manager.query.inner_container_main)

			if not l_old_is_visible then
				show_actions.call (Void)
			end

			set_focus
		end

	set_auto_hide (a_direction: INTEGER)
			-- Set `Current' dock at main container's `a_direction' auto hide bar
		require
			docking_manager_attached: is_docking_manager_attached
			manager_has_content: manager_has_content (Current)
			a_direction_valid: four_direction (a_direction)
			not_destroyed: not is_destroyed
		do
			set_visible (True)
			state.stick (a_direction)
			set_focus
		end

	set_floating (a_screen_x, a_screen_y: INTEGER)
			-- Set `Current' floating at position `a_screen_x', `a_screen_y'
		require
			docking_manager_attached: is_docking_manager_attached
			manager_has_content: manager_has_content (Current)
			not_destroyed: not is_destroyed
		local
			l_old_is_visible: BOOLEAN
		do
			l_old_is_visible := is_visible

			set_visible (True)
			state.float (a_screen_x, a_screen_y)

			if not l_old_is_visible then
				show_actions.call (Void)
			end

			set_focus
		end

	set_tab_with (a_content: SD_CONTENT; a_left: BOOLEAN)
			-- Set `Current' tab with `a_content'
			-- If `a_left' then put new tab at left, otherwise put new tab at right
		require
			docking_manager_attached: is_docking_manager_attached
			manager_has_current_content: manager_has_content (Current)
			manager_has_a_content: manager_has_content (a_content)
			target_content_zone_parent_exist: target_content_zone_parent_exist (a_content)
			not_destroyed: not is_destroyed
		local
			l_tab_zone: detachable SD_TAB_ZONE
			l_docking_zone: detachable SD_DOCKING_ZONE
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
				-- `a_content' is auto hide state, zone is void
				state.auto_hide_tab_with (a_content)
			end
			set_focus
		end

	set_default_editor_position
			-- Set editor to default editor position
		require
			docking_manager_attached: is_docking_manager_attached
			manager_has_content: manager_has_content (Current)
			editor_place_holder_in: manager_has_place_holder
			is_editor: type = {SD_ENUMERATION}.editor
			not_destroyed: not is_destroyed
		local
			l_old_is_visible: BOOLEAN
		do
			l_old_is_visible := is_visible

			set_visible (True)
			set_relative (docking_manager.zones.place_holder_content, {SD_ENUMERATION}.top)
			docking_manager.zones.place_holder_content.close

			if not l_old_is_visible then
				show_actions.call (Void)
			end

			set_focus
		ensure
			no_place_holder: not manager_has_place_holder
		end

	set_split_proportion (a_proportion: REAL)
			-- If current content is docking or tabbed, set parent splitter proportion to `a_proportion'
		require
			docking_manager_attached: is_docking_manager_attached
			valid: 0 <= a_proportion and a_proportion <= 1
			not_destroyed: not is_destroyed
		do
			state.set_split_proportion (a_proportion)
		end

feature -- Actions

	focus_in_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when keyboard focus is gained
		local
			l_actions: like internal_focus_in_actions
		do
			if not is_ignore_actions then
				l_actions := internal_focus_in_actions
				if l_actions = Void then
					create l_actions
					internal_focus_in_actions := l_actions
				end
				Result := l_actions
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

	focus_out_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to be performed when keyboard focus is lost
		local
			l_actions: like internal_focus_out_actions
		do
			if not is_ignore_actions then
				l_actions := internal_focus_out_actions
				if l_actions = Void then
					create l_actions
					internal_focus_out_actions := l_actions
				end
				Result := l_actions
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

	close_request_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to perfrom when close requested
		local
			l_actions: like internal_close_request_actions
		do
			if not is_ignore_actions then
				l_actions := internal_close_request_actions
				if l_actions = Void then
					create l_actions
					internal_close_request_actions := l_actions
				end
				Result := l_actions
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

	drop_actions: EV_PND_ACTION_SEQUENCE
			-- Drop actions to performed when user drop a pebble on notebook tab
		local
			l_actions: like internal_drop_actions
		do
			if not is_ignore_actions then
				l_actions := internal_drop_actions
				if l_actions = Void then
					create l_actions
					internal_drop_actions := l_actions
				end
				Result := l_actions
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

	show_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to perform when `user_widget' is shown
		local
			l_actions: like internal_show_actions
		do
			if not is_ignore_actions then
				l_actions := internal_show_actions
				if l_actions = Void then
					create l_actions
					internal_show_actions := l_actions
				end
				Result := l_actions
			else
				create Result
			end
		ensure
			not_void: Result /= Void
		end

feature -- Command

	close
			-- Destroy `Current', only destroy zone. Prune Current from SD_DOCKING_MANAGER
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

	hide
			-- Hide zone which has `Current'
		require
			not_destroyed: not is_destroyed
			docking_manager_attached: is_docking_manager_attached
		do
			state.hide
			is_visible := False
			if docking_manager.property.last_focus_content = Current then
				docking_manager.property.set_last_focus_content (Void)
			end
		end

	show
			-- Show zone which has `Current'
		require
			not_destroyed: not is_destroyed
			docking_manager_attached: is_docking_manager_attached
		do
			state.show
			is_visible := True
		end

	minimize
			-- Minimize if possible
		require
			not_destroyed: not is_destroyed
			docking_manager_attached: is_docking_manager_attached
		do
			state.minimize
		end

	update_mini_tool_bar_size
			-- Update mini tool bar size
		require
			not_destroyed: not is_destroyed
			docking_manager_attached: is_docking_manager_attached
		local
			l_zone: detachable SD_ZONE
		do
			if state.is_zone_attached then
				l_zone := state.zone
				check l_zone /= Void end -- Implied by `is_zone_attached'
				l_zone.update_mini_tool_bar_size
			end
		end

	destroy
			-- When a SD_DOCKING_MANAGER destroy, all SD_CONTENTs in it will be destroyed
			-- Clear all resources and all references
		do
			if not is_destroyed then
				is_destroyed := True
				internal_state := Void
				-- We can create a SD_STATE_VOID here, otherwise it will reference to `docking_manager',
				-- and this is a memory leak.
				clear_docking_manager
				if attached internal_close_request_actions as l_close_actions then
					l_close_actions.wipe_out
					internal_close_request_actions := Void
				end
				if attached internal_focus_in_actions as l_focus_in_actions then
					l_focus_in_actions.wipe_out
					internal_focus_in_actions := Void
				end
				if attached internal_focus_out_actions as l_focus_out_actions then
					l_focus_out_actions.wipe_out
					internal_focus_out_actions := Void
				end
				if attached internal_drop_actions as l_drop_actions then
					l_drop_actions.wipe_out
					internal_drop_actions := Void
				end
				if attached internal_show_actions as l_show_actions then
					l_show_actions.wipe_out
					internal_show_actions := Void
				end

				internal_user_widget := Void
				internal_mini_toolbar := Void
			end
		ensure
			destroyed: is_destroyed
		end

feature -- States report

	manager_has_content (a_content: SD_CONTENT): BOOLEAN
			-- If docking manager has `a_content'
		require
			a_content_not_void: a_content /= Void
			docking_manager_attached: is_docking_manager_attached
		do
			Result := docking_manager.has_content (a_content)
		end

	manager_has_place_holder: BOOLEAN
			-- If docking manager has editor place holder?
		require
			docking_manager_attached: is_docking_manager_attached
		do
			Result := docking_manager.has_content (docking_manager.zones.place_holder_content)
		end

	four_direction (a_direction: INTEGER): BOOLEAN
			-- If `a_direction' is one of four direction?
		do
			Result := (create {SD_ENUMERATION}).is_direction_valid (a_direction)
		end

	target_content_shown (a_target_content: SD_CONTENT): BOOLEAN
			-- If `a_target_content' shown ?
		local
			l_zone: detachable SD_ZONE
		do
			if a_target_content.state.is_zone_attached then
				l_zone := a_target_content.state.zone
				check l_zone /= Void end -- Implied by `is_zone_attached'
				if attached {EV_WIDGET} l_zone as lt_widget then
					Result := lt_widget.parent /= Void
				else
					check not_possible: False end
				end
			end
		end

	target_content_zone_parent_exist (a_target_content: SD_CONTENT): BOOLEAN
			-- If `a_target_content''s zone parent not void if exists
		local
			l_zone: detachable SD_ZONE
		do
			if a_target_content.state.is_zone_attached then
				l_zone := a_target_content.state.zone
				check l_zone /= Void end -- Implied by `is_zone_attached
				if attached {EV_WIDGET} l_zone as lt_widget then
					Result := lt_widget.parent /= Void
				else
					check not_possible: False end
				end
			else
				Result := True
			end
		end

	is_destroyed: BOOLEAN
			-- If Current destroyed? Not useable anymore?

	is_user_widget_set: BOOLEAN
			-- If `internal_user_widget' has been set?
		do
			Result := attached internal_user_widget
		end

	is_state_set: BOOLEAN
			-- If `internal_state' has been set?
		do
			Result := attached internal_state
		end

	is_content_zone_set (a_content: SD_CONTENT): BOOLEAN
			-- If `a_content' has a relative {SD_ZONE} object?
		do
			Result := attached a_content.state.zone
		end

feature {SD_ACCESS} -- State

	state: attached like internal_state
			-- Current state
		require
			set: is_state_set
		local
			l_result: like internal_state
		do
			l_result := internal_state
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

feature {SD_DOCKING_MANAGER_AGENTS, SD_DOCKING_MANAGER_ZONES}

	set_docking_manager (a_docking_manager: SD_DOCKING_MANAGER)
			-- <Precursor>
			-- If {SD_DOCKING_MANAGER}.contents has Current, `internl_docking_manager' will be set
		local
			l_state_void: detachable SD_STATE_VOID
		do
			if a_docking_manager = Void and is_docking_manager_attached then
				internal_clear_docking_manager_property
			end
			precursor {SD_DOCKING_MANAGER_HOLDER} (a_docking_manager)
			l_state_void ?= state
			if l_state_void /= Void then
				l_state_void.set_docking_manager (docking_manager)
			end
		end

feature {SD_STATE} -- implementation

	notify_focus_in
			-- Notify focus in actions
		do
			if attached internal_focus_in_actions as l_actions then
				l_actions.call (Void)
			end
		end

	internal_state: detachable SD_STATE
			-- SD_STATE instacne, which will be changed base on different states

feature {SD_STATE, SD_DOCKING_MANAGER, SD_TAB_STATE_ASSISTANT, SD_OPEN_CONFIG_MEDIATOR} -- Change the SD_STATE base on the states

	change_state (a_state: SD_STATE)
			-- Called by SD_RESOTRE, change current state object
		require
			a_state_not_void: a_state /= Void
		do
			debug ("docking")
				print ("%NXXXXXXXXXXXXXXXXXXXXXXXXXX SD_CONTENT change_state XXXXXXXXXXXXXXXXXXXXXXXXXX")
			end
			internal_state := a_state
		end

feature {SD_STATE, SD_OPEN_CONFIG_MEDIATOR}

	set_visible (a_bool: BOOLEAN)
			-- Set `is_visible'
		do
			is_visible := a_bool
			if is_user_widget_set and then not user_widget.is_displayed then
				user_widget.show
			end
			if state.is_zone_attached then
				if attached {EV_WIDGET} state.zone as lt_widget then
					if not lt_widget.is_destroyed and then not lt_widget.is_displayed then
						lt_widget.show
					end
				else
					check not_possible: False end
				end
			end
		ensure
			set: is_visible = a_bool
		end

feature {NONE}  -- Implemention

	is_ignore_actions: BOOLEAN
			-- Ignore actions?
		do
			Result := is_docking_manager_attached and then docking_manager.is_closing_all
		end

	internal_user_widget: detachable EV_WIDGET
			-- Client programmer's widget

	internal_unique_title: STRING_32
			-- The internal_user_widget's internal_unique_title

	internal_pixmap: EV_PIXMAP
			-- The internal_pixmap at the head of internal_unique_title

	internal_pixel_buffer: detachable EV_PIXEL_BUFFER
			-- The pixel buffer at the head of `internal_unique_title'

	internal_mini_toolbar: detachable EV_WIDGET
			-- Mini toolbar at the titlt bar

	internal_shared: SD_SHARED
			-- All singletons

	internal_type: INTEGER
			-- The type of `Current'. One value from SD_SHARED

	internal_focus_out_actions: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Mouse focus out actions

	internal_drop_actions: detachable EV_PND_ACTION_SEQUENCE
			-- Drop actions to performed when user drop a pebble on notebook tab

	internal_show_actions: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to perform when `user_widget' is shown

	internal_focus_in_actions: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Mouse focus in actions

	internal_close_request_actions: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to perfrom when close requested

	internal_clear_docking_manager_property
			-- Clear stuffs related with Current in {SD_DOCKING_MANAGER_PROPERTY}
		require
			docking_manager_attached: is_docking_manager_attached
		do
			docking_manager.property.remove_from_clicked_list (Current)
			if docking_manager.property.last_focus_content = Current then
				docking_manager.property.set_last_focus_content (Void)
			end
		end

invariant
	internal_shared_not_void: internal_shared /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"






end
