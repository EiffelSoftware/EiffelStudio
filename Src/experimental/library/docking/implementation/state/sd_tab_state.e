note
	description: "SD_STATE which manage a SD_TAB_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_STATE

inherit
	SD_STATE
		export
			{SD_TAB_STATE_ASSISTANT} internal_content, change_state, top_split_position
		redefine
			stick,
			change_zone_split_area,
			float,
			move_to_tab_zone,
			move_to_docking_zone,
			dock_at_top_level,
			content,
			change_short_title,
			change_long_title,
			change_pixmap,
			change_tab_tooltip,
			close,
			content_count_valid,
			is_dock_at_top,
			hide,
			show,
			has,
			set_last_floating_width,
			set_last_floating_height,
			restore
		end
create
	{ANY} make, make_with_tab_zone

create
	{SD_TAB_STATE} make_for_restore, make_for_restore_internal

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_target_zone: SD_DOCKING_ZONE; a_direction: INTEGER)
			-- Creation method
		require
			a_content_not_void: a_content /= Void
			a_content_parent_void: a_content.user_widget.parent = Void
			a_target_zone_not_void: a_target_zone /= Void
			a_target_zone_parent_not_void: a_target_zone.parent /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		local
			l_parent: detachable EV_CONTAINER
			l_target_zone_tab_state: SD_TAB_STATE
			l_old_split_position: INTEGER
			l_old_parent_split: BOOLEAN
			l_split_parent: detachable EV_SPLIT_AREA
			l_main_area_widget: detachable EV_WIDGET
			l_target_zone_parent: detachable EV_CONTAINER
			l_main_area: detachable SD_MULTI_DOCK_AREA
		do
			init_common (a_content, a_direction)
			if a_target_zone.is_parent_split then
				l_old_split_position := a_target_zone.parent_split_position
				l_old_parent_split := True
			end
			l_parent := a_target_zone.parent
			docking_manager.zones.prune_zone (a_target_zone)
			tab_zone := internal_shared.widget_factory.tab_zone (a_content)
			docking_manager.zones.add_zone (tab_zone)

			-- Sometimes, `l_parent' maybe void, don't know the reason yet
			-- Maybe the calling of the actions have been delayed?
			if l_parent /= Void then
				l_parent.extend (tab_zone)
			end

			-- We should copy maximized informations from `a_target_zone'
			if a_target_zone.is_maximized then
				tab_zone.set_max (True)
				l_main_area_widget := a_target_zone.main_area_widget
				check l_main_area_widget /= Void end -- Implied by `a_target_zone.is_maximized'
				l_target_zone_parent := a_target_zone.internal_parent
				check l_target_zone_parent /= Void end -- Implied by `a_target_zone.is_maximized'
				l_main_area := a_target_zone.main_area
				check l_main_area /= Void end -- Implied by `a_target_zone.is_maximized'
				tab_zone.set_widget_main_area (l_main_area_widget, l_main_area, l_target_zone_parent, a_target_zone.internal_parent_split_position)
			end

			create l_target_zone_tab_state.make_with_tab_zone (a_target_zone.content, tab_zone, direction)
			l_target_zone_tab_state.set_last_floating_height (a_target_zone.state.last_floating_height)
			l_target_zone_tab_state.set_last_floating_width (a_target_zone.state.last_floating_width)
			a_target_zone.content.change_state (l_target_zone_tab_state)

			internal_content := a_content

			init_common_end

			-- For bug#15565
			-- a_content's state can be {SD_STATE_VOID} if we don't update it now, so (in following `tab_zone.extend (a_content)') when executing in {SD_NOTEBOOK}.select_item,
			-- the content's `show_actions' will call {SD_STATE_VOID}.set_user_widget but not {SD_TAB_STATE}.set_user_widget
			change_state (Current)

			-- At the end, add `a_content', so `a_content' is selected on SD_TAB_ZONE
			tab_zone.extend (a_content)

			if l_old_parent_split  then
				l_split_parent ?= tab_zone.parent
				check l_split_parent /= Void end
				if l_split_parent.full and then l_split_parent.minimum_split_position <= l_old_split_position and l_split_parent.maximum_split_position >= l_old_split_position then
					l_split_parent.set_split_position (l_old_split_position)
				end
			end

			initialized := True
		ensure
			set: internal_content = a_content
		end

	make_with_tab_zone (a_content: SD_CONTENT; a_target_zone: SD_TAB_ZONE; a_direction: INTEGER)
			-- Creation method
		require
			a_content_not_void: a_content /= Void
			a_target_zone: a_target_zone /= Void
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		do
			init_common (a_content, a_direction)
			tab_zone := a_target_zone

			if attached content.user_widget.parent as l_parent then
				l_parent.prune (content.user_widget)
			end
			internal_content := a_content

			init_common_end
			-- For bug#15565
			-- a_content's state can be {SD_STATE_VOID} if we don't update it now, so (in following `tab_zone.extend (a_content)') when executing in {SD_NOTEBOOK}.select_item,
			-- the content's `show_actions' will call {SD_STATE_VOID}.set_user_widget but not {SD_TAB_STATE}.set_user_widget			
			change_state (Current)

			tab_zone.extend (content)
		ensure
			set: a_target_zone = tab_zone
			extended: tab_zone.has (content)
			set: internal_content = a_content
		end

	make_for_restore (a_contents: ARRAYED_LIST [SD_CONTENT]; a_container: EV_CONTAINER; a_direction: INTEGER)
			-- Creation method for restoring
		require
			at_least_two: a_contents /= Void and then a_contents.count >= 2
			not_full: a_container /= Void and then not a_container.full
			direction_valid: (create {SD_ENUMERATION}).is_direction_valid (a_direction)
		local
			l_tab_state: SD_TAB_STATE
		do
			init_common (a_contents.first, a_direction)

			tab_zone := internal_shared.widget_factory.tab_zone (a_contents.item)
			docking_manager.zones.add_zone (tab_zone)

			a_container.extend (tab_zone)
			tab_zone.extend_contents (a_contents)

			init_common_end

			from
				a_contents.start
			until
				a_contents.after
			loop
				if a_contents.isfirst then
					a_contents.item.change_state (Current)
				else
					create l_tab_state.make_for_restore_internal (a_contents.item, tab_zone, a_direction)
					a_contents.item.change_state (Current)
				end

				a_contents.forth
			end
		end

	make_for_restore_internal (a_content: SD_CONTENT; a_tab_zone: SD_TAB_ZONE; a_direction: INTEGER)
			-- Creation method, only called by `make_for_restore'
		require
			not_void: a_content /= Void
			not_void: a_tab_zone /= Void
			direction_valid: (create {SD_ENUMERATION}).is_direction_valid (a_direction)
		do
			init_common (a_content, a_direction)
			tab_zone := a_tab_zone
			init_common_end
		end

	init_common (a_content: SD_CONTENT; a_direction: INTEGER)
			-- Initlization of common parts
		require
			not_void: a_content /= Void
		do
			create internal_shared
			internal_content := a_content
			set_docking_manager (a_content.docking_manager)
			direction := a_direction

			last_floating_height := a_content.state.last_floating_height
			last_floating_width := a_content.state.last_floating_width
		ensure
			set: a_content = internal_content
			set: a_direction = direction
		end

	init_common_end
			-- Initlization of common parts when all others initialized
		do
			create assistant.make (docking_manager)
			assistant.init (Current)
		end

feature -- Redefine

	restore (a_data: SD_INNER_CONTAINER_DATA; a_container: EV_CONTAINER)
			-- <Precursor>
		local
			l_content: detachable SD_CONTENT
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_docking_state: SD_DOCKING_STATE
			l_tab_state: SD_TAB_STATE
			l_tab_zone: detachable SD_TAB_ZONE
			l_titles: detachable ARRAYED_LIST [STRING_GENERAL]
			l_selected_index: INTEGER
		do
			direction := a_data.direction
			l_titles := a_data.titles
			check l_titles /= Void end -- Implied by precondition `more_than_one_title'
			l_selected_index := a_data.selected_tab_index
			create internal_shared
			from
				l_titles.start
				create l_contents.make (l_titles.count)
			until
				l_titles.after
			loop
				l_content := docking_manager.query.content_by_title_for_restore (l_titles.item)
				if l_content /= Void then
					l_contents.extend (l_content)
				end
				l_titles.forth
			end

			if not l_contents.is_empty then
				internal_content := l_contents.first
			else
				internal_content := Void
			end

			if l_contents.count = 1 then
				Precursor {SD_STATE} (a_data, a_container)
				create l_docking_state.make_for_tab_zone (l_contents.first, a_container, a_data.direction)
				l_contents.first.change_state (l_docking_state)
				l_docking_state.set_direction (a_data.direction)
			elseif l_contents.count > 1 then
				from
					l_contents.start
				until
					l_contents.after
				loop
					if l_contents.isfirst then
						create l_tab_state.make_for_restore (l_contents.twin, a_container, a_data.direction)
						l_tab_zone := l_tab_state.zone
					else
						check l_tab_zone /= Void end -- Implied by first iteration of this loop
						create l_tab_state.make_for_restore_internal (l_contents.item, l_tab_zone, a_data.direction)
					end
					l_contents.item.change_state (l_tab_state)
					l_contents.item.set_visible (True)

					l_contents.forth
				end
			end

			-- At least found one content?
			if internal_content /= Void then
				l_tab_zone ?= content.state.zone
				-- `l_tab_zone' maybe void (zone is docking zone), because `l_content' can't be found
				if l_tab_zone /= Void then
					if l_tab_zone.contents.count >= l_selected_index then
						l_tab_zone.select_item (l_tab_zone.contents.i_th (l_selected_index), False)
					end
				end

				if a_data.is_minimized then
					restore_minimize
				end

				is_set_width_after_restore := True
				is_set_height_after_restore := True

				if attached content.state.zone as l_zone then
					update_floating_zone_visible (l_zone, a_data.is_visible)
				else
					check False end -- `zone' was set by previsous `make_for_restore'
				end
			end

			-- `initialized' can't set `True' here since this instance not really initialized,
			-- this feature ONLY initialized OTHER SD_STATE objects
		ensure then
			restored:
		end

	dock_at_top_level (a_multi_dock_area: SD_MULTI_DOCK_AREA)
			-- <Precursor>
		do
			docking_manager.command.lock_update (a_multi_dock_area, False)
			if zone.is_drag_title_bar then
				assistant.dock_whole_at_top_level (a_multi_dock_area)
			else
				assistant.dock_tab_at_top_level (a_multi_dock_area)
			end

			docking_manager.command.remove_empty_split_area
			docking_manager.command.update_title_bar
			docking_manager.query.inner_container_main.update_middle_container
			docking_manager.command.resize (True)
			docking_manager.command.unlock_update
		ensure then
			is_dock_at_top: old a_multi_dock_area.full implies is_dock_at_top (a_multi_dock_area)
		end

	stick (a_direction: INTEGER)
			-- <Precursor>
		local
			l_auto_hide_state: SD_AUTO_HIDE_STATE
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_auto_hide_panel: SD_AUTO_HIDE_PANEL
			l_width_height: INTEGER
		do
			docking_manager.command.lock_update (zone, False)
			Precursor {SD_STATE} (a_direction)
			-- We must do it before the widget off-screen on GTK
			l_width_height := width_height_by_direction
			docking_manager.zones.prune_zone (tab_zone)
			l_contents := tab_zone.contents
			from
				l_contents.start
			until
				l_contents.after
			loop
				create l_auto_hide_state.make (l_contents.item, direction)

				l_auto_hide_state.set_width_height (l_width_height)
				l_contents.item.change_state (l_auto_hide_state)
				l_contents.forth
			end
			l_auto_hide_panel:= docking_manager.query.auto_hide_panel (direction)
			l_auto_hide_panel.set_tab_group (l_contents)
			l_auto_hide_panel.select_tab_by_content (content)
			-- We have to clear last focus content. Otherwise, when user select it in ctrl + tab dialog, it will not appear
			-- See bug#13101
			docking_manager.property.set_last_focus_content (Void)
			docking_manager.command.unlock_update
		ensure then
			pruned: not docking_manager.zones.has_zone (tab_zone)
		end

	close
			-- <Precursor>
		local
			l_parent: detachable EV_CONTAINER
			l_state_void: SD_STATE_VOID
		do
			docking_manager.command.lock_update (zone, False)
			l_parent := tab_zone.parent
			-- If we are closing all contents, we should not give focus to next content, see bug#13796
			tab_zone.prune (content, not docking_manager.is_closing_all)
			-- When Eiffel Studio exiting and recycling, `l_parent' maybe void.
			-- This is ok since Current whole tab zone will be destroyed.
			if l_parent /= Void then
				assistant.update_last_content_state (l_parent)
			end
			create l_state_void.make
			l_state_void.set_content (content)
			change_state (l_state_void)
			docking_manager.command.remove_empty_split_area
			docking_manager.command.unlock_update
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER)
			-- <Precursor>
		local
			l_docking_state: SD_DOCKING_STATE
			l_parent: detachable EV_CONTAINER
			l_floating_zone: like floating_zone
		do
			docking_manager.command.lock_update (zone, False)
			if not zone.is_drag_title_bar then
				l_parent := tab_zone.parent
				tab_zone.prune (content, False)
				create l_docking_state.make (content, a_direction, tab_zone.width)
				l_docking_state.change_zone_split_area (a_target_zone, a_direction)
				change_state (l_docking_state)
				docking_manager.command.lock_update (zone, False)
				if l_parent /= Void then
					assistant.update_last_content_state (l_parent)
				end
				docking_manager.command.unlock_update
			else
				l_floating_zone := floating_zone
				if l_floating_zone /= Void then
					last_floating_height := l_floating_zone.height
					last_floating_width := l_floating_zone.width
				end

				assistant.change_zone_split_area_to_docking_zone (a_target_zone, a_direction)
				docking_manager.command.update_title_bar
			end

			-- We have to `remove_empty_split_area' here, see bug#12330
			docking_manager.command.remove_empty_split_area
			docking_manager.query.inner_container_main.update_middle_container
			docking_manager.command.unlock_update
		ensure then
			parent_changed:
		end

	float (a_x, a_y: INTEGER)
			-- <Precursor>
		local
			l_orignal_multi_dock_area: SD_MULTI_DOCK_AREA
		do
			l_orignal_multi_dock_area := docking_manager.query.inner_container (zone)
			if l_orignal_multi_dock_area.has (zone) and attached l_orignal_multi_dock_area.parent_floating_zone as l_floating_zone
				and zone.is_drag_title_bar then
				l_floating_zone.set_position (a_x, a_y)
			else
				assistant.float_internal (a_x, a_y)
			end
		ensure then
--			whole_floated:
		end

	move_to_tab_zone (a_target_zone: SD_TAB_ZONE; a_index: INTEGER)
			-- <Precursor>
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_tab_state: detachable SD_TAB_STATE
			l_orignal_direction: INTEGER
		do
			docking_manager.command.lock_update (zone, False)
			if zone.is_drag_title_bar then
				docking_manager.zones.prune_zone (tab_zone)
				l_orignal_direction := a_target_zone.state.direction
				l_contents := tab_zone.contents
				from
					l_contents.finish
				until
					l_contents.before
				loop
					if attached l_contents.item.user_widget.parent as l_parent then
						l_parent.prune (l_contents.item.user_widget)
					end
					create l_tab_state.make_with_tab_zone (l_contents.item, a_target_zone, l_orignal_direction)
					a_target_zone.set_content_position (l_contents.item, a_index)
					l_contents.item.change_state (l_tab_state)
					l_contents.back
				end
				check l_tab_state /= Void end -- Implied by `tab_zone.contents' must has contents, so `l_tab_state' must be created
				l_tab_state.select_tab (content, True)
			else
				assistant.move_tab_to_zone (a_target_zone, a_index)
			end
			docking_manager.command.update_title_bar
			docking_manager.command.unlock_update
		ensure then
			moved:
		end

	move_to_docking_zone (a_target_zone: SD_DOCKING_ZONE; a_first: BOOLEAN)
			-- <Precursor>
		do
			docking_manager.command.lock_update (zone, False)
			if zone.is_drag_title_bar then
				assistant.move_whole_to_docking_zone (a_target_zone)
			else
				if a_first then
					assistant.move_tab_to_zone (a_target_zone, 1)
				else
					assistant.move_tab_to_zone (a_target_zone, 2)
				end
			end
			docking_manager.command.remove_empty_split_area
			docking_manager.command.update_title_bar
			docking_manager.command.unlock_update
		ensure then
			moved:
		end

	hide
			-- <Precursor>
		local
			l_state: SD_STATE_VOID
		do
			close
			create l_state.make
			l_state.set_content (content)
			l_state.set_relative (zone.contents.last)
			change_state (l_state)
		end

	show
			-- <Precursor>
		local
			l_state_void: SD_STATE_VOID
		do
			if not content.is_visible then
				-- Current was SD_TAB_STATE before open_config (SD_CONFIG_MEDIATOR),
				-- after open_config, client programmers will call this fucntion sometimes.
				-- We use default void state behavior here.				
				create l_state_void.make
				l_state_void.set_content (content)
				change_state (l_state_void)
				l_state_void.show
			end
		end

	set_user_widget (a_widget: EV_WIDGET)
			-- <Precursor>
		do
			zone.replace_user_widget (content)
		end

	set_mini_toolbar (a_widget: EV_WIDGET)
			-- <Precursor>
		do
			zone.update_mini_tool_bar_when_selected (content)
		end

feature {SD_CONTENT} -- Redefine

	change_short_title (a_title: STRING_GENERAL; a_content: SD_CONTENT)
			-- <Precursor>
		do
			if tab_zone.has (a_content) then
				tab_zone.set_short_title (a_title, a_content)
			end
		end

	change_long_title (a_title: STRING_GENERAL; a_content: SD_CONTENT)
			-- <Precursor>
		do
			-- During zone transforming, `tab_zone' maybe not has `a_content'
			-- See bug#14623
			if tab_zone.has (a_content) then
				tab_zone.set_long_title (a_title, a_content)
			end
		end

	change_pixmap (a_pixmap: EV_PIXMAP; a_content: SD_CONTENT)
			-- <Precursor>
		do
			-- During zone transforming, `tab_zone' maybe not has `a_content'
			-- See bug#14623
			if tab_zone.has (a_content) then
				tab_zone.set_pixmap (a_pixmap, a_content)
			end
		end

	change_tab_tooltip (a_text: detachable STRING_GENERAL)
			-- <Precursor>
		do
			-- During zone transforming, `tab_zone' maybe not has `a_content'
			-- See bug#14623
			if zone.has (content) then
				zone.change_tab_tooltip (content, a_text)
			end
		end

feature {SD_OPEN_CONFIG_MEDIATOR, SD_STATE} -- Redefine

	set_last_floating_width (a_int: INTEGER)
			-- <Precursor>
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_state: detachable SD_TAB_STATE
		do
			if is_set_width_after_restore then
				-- We must query zone from `content' but not query zone directly, because when restore `change_state' called.
				l_state ?= content.state
				-- Maybe `l_state' is docking state, because some SD_CONTENT can't be found during `restore'				
				if l_state /= Void then
					from
						l_contents := l_state.zone.contents
						l_contents.start
					until
						l_contents.after
					loop
						l_contents.item.state.set_last_floating_width (a_int)
						l_contents.forth
					end
				end
				is_set_width_after_restore := False
			end

			Precursor {SD_STATE}(a_int)
		ensure then
			flag_cleared: is_set_width_after_restore = False
		end

	set_last_floating_height (a_int: INTEGER)
			-- <Precursor>
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_state: detachable SD_TAB_STATE
		do
			if is_set_height_after_restore then
				-- We must query zone from `content' but not query zone directly, because when restore `change_state' called.
				l_state ?= content.state
				-- Maybe `l_state' is docking state, because some SD_CONTENT can't be found during `restore'
				if l_state /= Void then
					from
						l_contents := l_state.zone.contents
						l_contents.start
					until
						l_contents.after
					loop
						l_contents.item.state.set_last_floating_height (a_int)
						l_contents.forth
					end
				end
				is_set_height_after_restore := False
			end

			Precursor {SD_STATE}(a_int)
		ensure then
			flag_cleared: is_set_height_after_restore = False
		end

	is_set_width_after_restore, is_set_height_after_restore: BOOLEAN
			-- Is set `last_floating_width' and `last_floating_height' after restore?

feature -- Properties redefine

	content: SD_CONTENT
			-- <Precursor>
		local
			l_result: like internal_content
		do
			l_result := internal_content
			check l_result /= Void end -- Implied by precondition
			Result := l_result
		ensure then
			not_void: not docking_manager.property.is_opening_config implies Result /= Void
		end

	zone: SD_TAB_ZONE
			-- <Precursor>
		do
			Result := tab_zone
		ensure then
			not_void: Result /= Void
		end

feature -- Query

	content_count_valid (a_titles: ARRAYED_LIST [STRING_GENERAL]): BOOLEAN
		do
			Result := a_titles.count > 1
		end

	has (a_content: SD_CONTENT): BOOLEAN
			-- <Precursor>
		do
			Result := tab_zone.has (a_content)
		end

	is_dock_at_top (a_multi_dock_area: SD_MULTI_DOCK_AREA): BOOLEAN
			-- <Precursor>
		local
			l_container: detachable EV_SPLIT_AREA
			l_widget: detachable EV_WIDGET
			l_docking_zone: detachable SD_DOCKING_ZONE
		do
			l_container ?= a_multi_dock_area.item
			if zone.is_drag_title_bar then
				l_widget ?= zone
				check
					all_zone_is_widget: l_widget /= Void
				end
				if l_container /= Void then
					Result := l_container.has (l_widget)
				end
			elseif l_container /= Void then
				l_docking_zone ?= l_container.first
				if l_docking_zone /= Void then
					Result := l_docking_zone.content = internal_content
				end
				if not Result then
					l_docking_zone ?= l_container.second
					if l_docking_zone /= Void then
						Result := l_docking_zone.content = internal_content
					end
				end
			end
		end

	is_selected: BOOLEAN
			-- If Current selected in notebook widget?
		do
			Result := tab_zone.is_content_selected (content)
		end

feature -- Command

	select_tab (a_content: SD_CONTENT; a_focus: BOOLEAN)
			-- Enable select one tab
		require
			has_content: has (a_content)
		do
			tab_zone.select_item (a_content, a_focus)
		ensure
			selected: tab_zone.selected_item_index = tab_zone.index_of (a_content)
		end

feature {SD_TAB_STATE_ASSISTANT} -- Internal attibutes

	tab_zone: SD_TAB_ZONE
			-- SD_TAB_ZONE managed by `Current'

	assistant: SD_TAB_STATE_ASSISTANT
			-- Assistant for Current

invariant
	tab_zone_not_void: initialized implies tab_zone /= Void
	assistant_not_void: initialized implies assistant /= Void

note
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
