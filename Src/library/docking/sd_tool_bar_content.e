indexing
	description: "Contents that have a tool bar items that client programmer want to managed by docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_CONTENT

inherit
	HASHABLE

	SD_ACCESS

create
	make_with_items,
	make_with_tool_bar

feature {NONE} -- Initlization

	make_with_items (a_unique_title: STRING_GENERAL; a_items: like items) is
			-- Creation method.
		require
			a_title_not_void: a_unique_title /= Void
			a_items_not_void: a_items /= Void
		do
			unique_title := a_unique_title
			-- We set display title same as unique title by default.
			title := a_unique_title
			items := a_items
		ensure
			set: unique_title = a_unique_title
			set: items = a_items
		end

	make_with_tool_bar (a_unique_title: STRING_GENERAL; a_tool_bar: EV_TOOL_BAR) is
			-- Creation method. A helper function, actually SD_TOOL_BAR_ZONE only appcept EV_TOOL_BAR_ITEMs.
			-- Warning: use this method will lose alpha data, which will show nothing when use AlphaBlend functions!
		require
			a_title_not_void: a_unique_title /= Void
			a_tool_bar_not_void: a_tool_bar /= Void
		local
			l_item: EV_TOOL_BAR_ITEM
			l_temp_items: like items
		do
			from
				a_tool_bar.start
				create l_temp_items.make (0)
			until
				a_tool_bar.after
			loop
				l_item := a_tool_bar.item
				if a_tool_bar.parent /= Void then
					a_tool_bar.item.parent.prune (a_tool_bar.item)
				end

				l_temp_items.extend (convert_to_sd_item (l_item, a_tool_bar.index.out))
				a_tool_bar.forth
			end
			make_with_items (a_unique_title, l_temp_items)
		ensure
			set: a_unique_title = unique_title
			set: a_tool_bar.count = items.count
		end

	convert_to_sd_item (a_ev_item: EV_TOOL_BAR_ITEM; a_name: STRING_GENERAL): SD_TOOL_BAR_ITEM is
			-- Convert a EV_TOOL_BAR_ITEM to SD_TOOL_BAR_ITEM.
			-- Warning: use this method to convert pixmap in `a_ev_item' will lose alpha data, which will show nothing when use AlphaBlend functions!
		require
			not_void: a_ev_item /= Void
		local
			l_tool_bar_toggle_button: EV_TOOL_BAR_TOGGLE_BUTTON
			l_tool_bar_button: EV_TOOL_BAR_BUTTON
			l_tool_bar_separator: EV_TOOL_BAR_SEPARATOR
			l_sd_button: SD_TOOL_BAR_BUTTON
			l_sd_separator: SD_TOOL_BAR_SEPARATOR
		do
			l_tool_bar_toggle_button ?= a_ev_item
			l_tool_bar_button ?= a_ev_item
			l_tool_bar_separator ?= a_ev_item
			if l_tool_bar_button /= Void then
				if l_tool_bar_toggle_button /= Void  then
					create {SD_TOOL_BAR_TOGGLE_BUTTON} l_sd_button.make
				else
					create l_sd_button.make
				end
				if l_tool_bar_button.text /= Void  then
					l_sd_button.set_text (l_tool_bar_button.text)
				end
				if l_tool_bar_button.pixmap /= Void then
					l_sd_button.set_pixmap (l_tool_bar_button.pixmap)
				end
				if l_tool_bar_button.select_actions /= Void then
					l_sd_button.select_actions.append (l_tool_bar_button.select_actions)
				end
				Result := l_sd_button
			else
				check must_be_separator: l_tool_bar_separator /= Void end
				create l_sd_separator.make
				Result := l_sd_separator
			end
			Result.set_name (a_name)
		ensure
			not_void: Result /= Void
		end

feature -- Command

	show is
			-- Show Current.
		require
			not_destroyed: not is_destroyed
		do
			if not is_visible then
				if zone /= Void then
					zone.show
					if zone.is_floating then
						zone.floating_tool_bar.show
					else
						if zone.assistant.last_state.is_docking_state_recorded then
							zone.assistant.dock_last_state_for_hide
						elseif manager /= Void then
							manager.set_top (Current, {SD_ENUMERATION}.top)
						end
					end
				end
				is_visible := True
			end
		end

	hide is
			-- Hide Current
		require
			not_destroyed: not is_destroyed
		local
			l_row: SD_TOOL_BAR_ROW
		do
			if is_visible then
				if zone /= Void then
					if zone.is_floating then
						zone.floating_tool_bar.hide
					else
						l_row := zone.row
						if l_row /= Void then
							zone.assistant.record_docking_state
							l_row.prune (zone)
							if l_row.count = 0 then
								l_row.destroy
							end
						end
					end
					zone.hide
				end
				is_visible := False
				manager.docking_manager.command.resize (True)
			end
		end

	close is
			-- Close Current
		require
			not_destroyed: not is_destroyed
		do
			destroy_container
			if manager /= Void then
				manager.contents.start
				manager.contents.prune (Current)
			end
		end

	set_title (a_display_title: STRING_GENERAL) is
			-- Set `title' with `a_display_title'
		require
			not_destroyed: not is_destroyed
			not_void: a_display_title /= Void
		do
			title := a_display_title
		ensure
			set: title = a_display_title
		end

	set_top (a_direction: INTEGER) is
			-- Set dock at `a_direction'
		require
			not_destroyed: not is_destroyed
			valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
			added: is_added
		do
			if zone /= Void then
				-- Use this function to set all SD_TOOL_BAR_ITEM wrap states.
				zone.change_direction (True)
			end
			destroy_container

			manager.set_top (Current, a_direction)

			is_visible := True
		ensure
			visible: is_visible = True
		end

	set_top_with (a_target_content: SD_TOOL_BAR_CONTENT) is
			-- Set Current dock at same row/column with `a_other_content'.
		require
			not_destroyed: not is_destroyed
			not_void: a_target_content /= Void
			added: is_added
			target_docking: a_target_content.is_docking
		do
			if zone /= Void then
				-- Use this function to set all SD_TOOL_BAR_ITEM wrap states.
				zone.change_direction (True)
			end
			destroy_container

			manager.set_top_with (Current, a_target_content)

			is_visible := True
		ensure
			visible: is_visible = True
		end

	refresh is
			-- Refresh tool bar if items visible changed.
		require
			not_destroyed: not is_destroyed
		do
			if zone /= Void then
				zone.assistant.refresh_items_visible
			end
		end

	destroy is
			-- When a SD_DOCKING_MANAGER destroy, all SD_CONTENTs in it will be destroyed.
			-- Clear all resources and all references.
		do
			if zone /= Void then
				zone.destroy
			end
			is_destroyed := True
		ensure
			destroyed: is_destroyed
		end

feature -- Query

	unique_title: STRING_GENERAL
			-- Unique tool bar title.
			-- It's used for store/open layout data, so it should not be changed.

	title: STRING_GENERAL
			-- Title for display.

	items: ARRAYED_SET [SD_TOOL_BAR_ITEM]
			-- All 	EV_TOOL_BAR_ITEM in `Current' including invisible items.

	items_visible: ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- All displayed items.
		do
			from
				create Result.make (1)
				items.start
			until
				items.after
			loop
				if items.item.is_displayed then
					Result.extend (items.item)
				end
				items.forth
			end
		ensure
			not_void: Result /= Void
		end

	items_except_sep (a_include_invisible: BOOLEAN): ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- `items' except SD_TOOL_BAR_SEPARATOR.
		local
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_snap_shot: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			if a_include_invisible then
				Result := items.twin
				l_snap_shot := items.twin
			else
				Result := items_visible
				l_snap_shot := items_visible
			end

			from
				l_snap_shot.start
			until
				l_snap_shot.after
			loop
				l_separator := Void
				l_separator ?= l_snap_shot.item
				if l_separator /= Void then
					Result.start
					Result.prune (l_separator)
				end
				l_snap_shot.forth
			end
		ensure
			not_void: Result /= Void
		end

	groups_count (a_include_invisible: BOOLEAN): INTEGER is
			-- Group count, group is buttons before one separater.
		local
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_last_is_separator: BOOLEAN -- Maybe two separator together.
			l_items: like items_visible
		do
			Result := 1
			from
				-- If first one is separator, we ignore it.
				l_last_is_separator := True
				if a_include_invisible then
					l_items := items
				else
					l_items := items_visible
				end
				l_items.start
			until
				l_items.after
			loop
				if l_items.item.is_displayed then
					l_separator ?= l_items.item
					if l_separator /= Void and not l_last_is_separator
						and l_items.index /= l_items.count then -- We ignore last separator
						Result := Result + 1
						l_last_is_separator := True
					elseif l_separator = Void then
						l_last_is_separator := False
					end
				end
				l_items.forth
			end
			if items.valid_index (l_items.count - 1) then
				l_separator ?= l_items.i_th (l_items.count - 1)
				if l_last_is_separator and l_separator /= Void then
					-- At least two sepators at the end.
					Result := Result - 1
				end
			elseif l_last_is_separator = True and l_items.count = 1 then
				-- Only one separator
				Result := 0
			elseif l_items.count = 0 then
				Result := 0
			end
		end

	group_items (a_group_index: INTEGER; a_include_invisible: BOOLEAN): ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- Group items.
		require
			valid: 0 < a_group_index and a_group_index <= groups_count (False)
		local
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_group_count: INTEGER
			l_stop: BOOLEAN
			l_items: like items_visible
			l_last_is_separator: BOOLEAN
		do
			from
				-- If first item is separator, we ingore it.
				l_last_is_separator := True
				if a_include_invisible then
					l_items := items
				else
					l_items := items_visible
				end
				create Result.make (1)
				l_group_count := 1
				l_items.start
			until
				l_items.after or l_stop
			loop
				l_separator ?= l_items.item

				if l_separator /= Void and not l_last_is_separator then
					l_group_count := l_group_count + 1
				elseif l_separator = Void and then l_group_count = a_group_index and l_items.item.is_displayed then
					Result.extend (l_items.item)
				end
				if l_separator /= Void then
					l_last_is_separator := True
				else
					l_last_is_separator := False
				end
				if l_group_count > a_group_index then
					l_stop := True
				end
				l_items.forth
			end
		ensure
			not_void: Result /= Void
			not_contain_separator:
		end

	show_request_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to perform when show requested
		do
			if internal_show_request_actions = Void then
				create internal_show_request_actions
			end
			Result := internal_show_request_actions
		end

	close_request_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to perfrom when close requested.
		do
			if internal_close_request_actions = Void then
				create internal_close_request_actions
			end
			Result := internal_close_request_actions
		end

	item_count_except_sep (a_include_invisible: BOOLEAN): INTEGER is
			-- Item count except SD_TOOL_BAR_SEPARATOR.
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_separator: SD_TOOL_BAR_SEPARATOR
		do
			from
				l_items := items
				l_items.start
			until
				l_items.after
			loop
				l_separator ?= l_items.item
				if l_separator = Void then
					if not a_include_invisible then
						if l_items.item.is_displayed then
							Result := Result + 1
						end
					else
						Result := Result + 1
					end
				end
				l_items.forth
			end
		end

	is_contain_widget_item: BOOLEAN is
			-- If Current contain normal widget items?
		local
			l_widget: SD_TOOL_BAR_WIDGET_ITEM
		do
			from
				items.start
			until
				items.after or Result
			loop
				l_widget ?= items.item
				Result := (l_widget /= Void)
				items.forth
			end
		end

	is_added: BOOLEAN is
			-- If Current added to a tool bar manager?
		do
			Result := manager /= Void
		end

	is_destroyed: BOOLEAN
			-- If Current destroyed?

	is_visible: BOOLEAN
			-- If Current visible?

	is_docking: BOOLEAN
			-- If current docking at four side of main container?
		do
			Result := zone /= Void and then zone.row /= Void
		end

	is_floating: BOOLEAN
			-- If current floating?
		do
			if zone /= Void then
				Result := zone.is_floating
			end
		end

	is_menu_bar: BOOLEAN is
			-- If Current is a menu bar which only contain SD_TOOL_BAR_MENU_ITEM.
		local
			l_menu_item: SD_TOOL_BAR_MENU_ITEM
		do
			if not items.is_empty then
				from
					items.start
					Result := True
				until
					items.after or not Result
				loop
					l_menu_item ?= items.item
					if l_menu_item = Void then
						Result := False
					end
					items.forth
				end
			end
		end

	hash_code: INTEGER is
			-- Hash code
		do
			Result := unique_title.hash_code
		end

feature -- Obsolete

	item_count_except_separator: INTEGER is
			-- Item count except SD_TOOL_BAR_SEPARATOR.
		obsolete
			"Use item_count_except_sep instead."
		do
			Result := item_count_except_sep (True)
		end

	group (a_group_index: INTEGER_32): ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- Group items except hidden items.
		obsolete
			"Use group_items instead."
		do
			Result := group_items (a_group_index, True)
		end

	group_count: INTEGER is
			-- Group count, group is buttons before one separater.
		obsolete
			"Use groups_count instead."
		do
			Result := groups_count (True)
		end

	items_except_separator: ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- `items' except SD_TOOL_BAR_SEPARATOR.
		obsolete
			"Use items_except_sep instead."
		do
			Result := items_except_sep (True)
		end

feature {SD_TOOL_BAR_ZONE, SD_FLOATING_TOOL_BAR_ZONE, SD_TOOL_BAR_ZONE_ASSISTANT,
		SD_FLOATING_TOOL_BAR_ZONE_ASSISTANT, SD_TOOL_BAR_MANAGER, SD_OPEN_CONFIG_MEDIATOR,
		SD_SAVE_CONFIG_MEDIATOR, SD_DOCKING_MANAGER_QUERY, SD_TOOL_BAR, SD_TOOL_BAR_MANAGER}  -- Internal issues.

	wipe_out is
			-- Remove all items.
		do
			items.wipe_out
		end

	clear is
			-- Clear widget items' parents and reset state flags.
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
			l_parent: EV_CONTAINER
		do
			l_items := items.twin
			from
				l_items.start
			until
				l_items.after
			loop
				l_widget_item ?= l_items.item
				if l_widget_item /= Void then
					l_parent := l_widget_item.widget.parent
					if l_parent /= Void then
						l_parent.prune (l_widget_item.widget)
					end
				end
				l_items.forth
			end

			if zone /= Void and then zone.customize_dialog /= Void then
				zone.customize_dialog.destroy
				zone.set_customize_dialog (Void)
			end
		end

	index_of (a_item: SD_TOOL_BAR_ITEM; a_include_invisible: BOOLEAN): INTEGER
			-- Index of `a_item'
		require
			has: items.has (a_item)
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			from
				if a_include_invisible then
					l_items := items
				else
					l_items := items_visible
				end
				l_items.start
			until
				l_items.after or Result /= 0
			loop
				if l_items.item = a_item then
					Result := l_items.index
				end
				l_items.forth
			end
		ensure
			valid: Result /= 0
		end

	separator_after_item (a_item: SD_TOOL_BAR_ITEM): SD_TOOL_BAR_SEPARATOR is
			-- Separator after `a_item' if exist, except invisible items.
		require
			has: items_visible.has (a_item)
		local
			l_items_visible: like items_visible
		do
			l_items_visible := items_visible
			l_items_visible.go_i_th (l_items_visible.index_of (a_item, 1))
			if not l_items_visible.after then
				l_items_visible.forth
				if not l_items_visible.after then
					Result ?= l_items_visible.item
				end
			end
		end

	separator_before_item (a_item: SD_TOOL_BAR_ITEM): SD_TOOL_BAR_SEPARATOR is
			-- Separator before `a_item' if exist, except invisible items.
		require
			has: items.has (a_item)
		local
			l_index: INTEGER
			l_items_visible: like items_visible
		do
			l_items_visible := items_visible
			l_index := l_items_visible.index_of (a_item, 1)
			debug ("docking")
				print ("%N SD_TOOL_BAR_CONTENT: separator_before_item: index_of `a_item' is: " + l_index.out)
			end

			l_items_visible.go_i_th (l_index)
			if not l_items_visible.before then
				l_items_visible.go_i_th (l_index - 1)
				if not l_items_visible.before then
					Result ?= l_items_visible.item
				end
			end
		end

--	tool_bar_items_texts: ARRAYED_LIST [STRING_GENERAL];
--			-- All strings on `items'.

	item_start_index (a_group_index: INTEGER; a_inclue_invisible: BOOLEAN): INTEGER is
			-- Start index in `items' of a group. Start index not include SD_TOOL_BAR_SEPARATOR.
		require
			valid: a_group_index > 0 and a_group_index <= groups_count (False)
		local
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_group_count: INTEGER
			l_items: like items_visible
			l_last_is_separator: BOOLEAN
		do
			from
				l_last_is_separator := True
				if a_inclue_invisible then
					l_items := items
				else
					l_items := items_visible
				end

				Result := 1
				l_group_count := 1
				l_items.start
			until
				l_items.after or l_group_count = a_group_index
			loop
				l_separator ?= l_items.item
				if l_separator /= Void and not l_last_is_separator then
					l_group_count := l_group_count + 1
				end
				if l_separator /= Void then
					l_last_is_separator := True
				else
					l_last_is_separator := False
				end
				Result := Result + 1

				l_items.forth
			end
		ensure
			valid: Result > 0 and Result <= items.count
		end

	item_end_index (a_group_index: INTEGER): INTEGER is
			-- End index in `items' of a group. End index not include SD_TOOL_BAR_SEPARATOR.
		require
			valid: a_group_index > 0 and a_group_index <= groups_count (False)
		do
			if a_group_index /= groups_count (False) then
				Result := item_start_index (a_group_index + 1, False) - 2
			else
				Result := items.count
			end
		ensure
			valid: Result > 0 and Result <= items.count
		end

	zone: SD_TOOL_BAR_ZONE
			-- Tool bar zone which Current related. May be Void if not exists.

	set_zone (a_zone: SD_TOOL_BAR_ZONE) is
			-- Set `zone'.
		require
			not_void: a_zone /= Void
		do
			zone := a_zone
		ensure
			set: zone = a_zone
		end

	manager: SD_TOOL_BAR_MANAGER
			-- Manager which manage Current.

	set_manager (a_manager: SD_TOOL_BAR_MANAGER) is
			-- Set `manager'
		do
			manager := a_manager
		ensure
			set: manager = a_manager
		end

	set_visible (a_bool: BOOLEAN) is
			-- Set `is_visible'
		do
			is_visible := a_bool
		ensure
			set: is_visible = a_bool
		end

feature {NONE} -- Implementation

	destroy_container is
			-- Destroy related containers.
		do
			if zone /= Void then
				zone.destroy_parent_containers
				if zone.is_floating then
					zone.floating_tool_bar.destroy
					if manager /= Void then
						manager.floating_tool_bars.prune_all (zone.floating_tool_bar)
					end
				end
				zone.destroy
			end
		end

	internal_show_request_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions to perform when show requested.

	internal_close_request_actions: EV_NOTIFY_ACTION_SEQUENCE;
			-- Actions to perfrom when close requested.

invariant

	items_not_void: items /= Void

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
