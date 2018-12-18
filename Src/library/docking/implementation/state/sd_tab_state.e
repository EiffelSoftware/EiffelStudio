note
	description: "SD_STATE which manage a SD_TAB_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_STATE

inherit
	SD_SHARED
	SD_STATE_WITH_CONTENT
		export
			{SD_TAB_STATE_ASSISTANT} internal_content, change_state, top_split_position
		redefine
			stick,
			change_zone_split_area,
			float,
			move_to_tab_zone,
			move_to_docking_zone,
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
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		local
			l_parent: detachable EV_CONTAINER
			l_target_zone_tab_state: SD_TAB_STATE
			l_old_split_position: INTEGER
			l_old_parent_split: BOOLEAN
		do
			init_common (a_content, a_direction)
			if a_target_zone.is_parent_split then
				l_old_split_position := a_target_zone.parent_split_position
				l_old_parent_split := True
			end
			l_parent := a_target_zone.parent
			docking_manager.zones.prune_zone (a_target_zone)
			tab_zone := widget_factory.tab_zone (a_content)
			docking_manager.zones.add_zone (tab_zone)

			-- Sometimes, `l_parent' maybe void, don't know the reason yet
			-- Maybe the calling of the actions have been delayed?
			if l_parent /= Void then
				l_parent.extend (tab_zone)
			end

			-- We should copy maximized informations from `a_target_zone'
			if a_target_zone.is_maximized then
				tab_zone.set_max (True)
				if
					attached a_target_zone.main_area_widget as l_main_area_widget and then
					attached a_target_zone.internal_parent as l_target_zone_parent and then
					attached a_target_zone.main_area as l_main_area
				then
					tab_zone.set_widget_main_area
						(l_main_area_widget, l_main_area, l_target_zone_parent, a_target_zone.internal_parent_split_position)
				end
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

			if l_old_parent_split then
				if attached {EV_SPLIT_AREA} tab_zone.parent as l_split_parent then
					if
						l_split_parent.full and then
						l_split_parent.minimum_split_position <= l_old_split_position and
						l_split_parent.maximum_split_position >= l_old_split_position
					then
						l_split_parent.set_split_position (l_old_split_position)
					end
				else
					check parent_of_tab_zone_is_split_area: False  end
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

	make_for_restore (a_contents: LIST [SD_CONTENT]; a_container: EV_CONTAINER; a_direction: INTEGER)
			-- Creation method for restoring
		require
			at_least_two: a_contents /= Void and then a_contents.count >= 2
			not_full: a_container /= Void and then not a_container.full
			direction_valid: (create {SD_ENUMERATION}).is_direction_valid (a_direction)
		local
			l_content: SD_CONTENT
		do
			init_common (a_contents.first, a_direction)

			tab_zone := widget_factory.tab_zone (a_contents.item)
			docking_manager.zones.add_zone (tab_zone)

			a_container.extend (tab_zone)
			tab_zone.extend_contents (a_contents)

			init_common_end

			from
				a_contents.start
			until
				a_contents.after
			loop
				l_content := a_contents.item
				if not a_contents.isfirst then
					;(create {SD_TAB_STATE}.make_for_restore_internal (l_content, tab_zone, a_direction)).do_nothing
				end
				l_content.change_state (Current)

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
			create assistant.make (docking_manager, Current)
		end

feature  -- States report

	value: INTEGER
		do
			Result := {SD_ENUMERATION}.tab
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
			l_selected_index: INTEGER
		do
			direction := a_data.direction
			l_selected_index := a_data.selected_tab_index
			if attached a_data.titles as l_titles then
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
				end

				if l_contents.count = 1 then
					Precursor (a_data, a_container)
					create l_docking_state.make_for_tab_zone (l_contents.first, a_container, a_data.direction)
					l_contents.first.change_state (l_docking_state)
					l_docking_state.set_direction (a_data.direction)
				elseif l_contents.count > 1 then
					from
						l_contents.start
					until
						l_contents.after
					loop
						l_content := l_contents.item
						if l_tab_zone = Void then
							check l_contents.isfirst end
							create l_tab_state.make_for_restore (l_contents.twin, a_container, a_data.direction)
							l_tab_zone := l_tab_state.zone
						else
							create l_tab_state.make_for_restore_internal (l_content, l_tab_zone, a_data.direction)
						end
						l_content.change_state (l_tab_state)
						l_content.set_visible (True)

						l_contents.forth
					end
				end
					-- At least found one content?
				if not l_contents.is_empty then
					if
						attached {SD_TAB_ZONE} content.state.zone as l_state_tab_zone and then
						l_state_tab_zone.contents.count >= l_selected_index
					then
						l_state_tab_zone.select_item (l_state_tab_zone.contents.i_th (l_selected_index), False)
					else
						-- `content.state.zone' maybe void (zone is docking zone), because `l_content' can't be found					
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
			else
				check
					from_precondition_more_than_one_title: False
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
			l_contents: LIST [SD_CONTENT]
			l_auto_hide_panel: SD_AUTO_HIDE_PANEL
			l_width_height: INTEGER
		do
			docking_manager.command.lock_update (zone, False)
			Precursor (a_direction)
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
			l_parent: EV_CONTAINER
		do
			docking_manager.command.lock_update (zone, False)
			l_parent := tab_zone.parent
			-- If we are closing all contents, we should not give focus to next content, see bug#13796
			tab_zone.prune (content, not docking_manager.is_closing_all)
			-- When Eiffel Studio exiting and recycling, `l_parent' maybe void (Linux only, Windows implementation works fine)
			-- This is ok since Current whole tab zone will be destroyed.
			if l_parent /= Void then
				assistant.update_last_content_state (l_parent)
			end
			change_state (create {SD_STATE_VOID}.make (content, docking_manager))
			docking_manager.command.remove_empty_split_area
			docking_manager.command.unlock_update
		end

	change_zone_split_area (a_target_zone: SD_ZONE; a_direction: INTEGER)
			-- <Precursor>
		local
			l_docking_state: SD_DOCKING_STATE
			l_parent: detachable EV_CONTAINER
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
				if attached floating_zone as l_floating_zone then
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
			if
				l_orignal_multi_dock_area.has (zone) and
				attached l_orignal_multi_dock_area.parent_floating_zone as l_floating_zone and
				zone.is_drag_title_bar
			then
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
			l_content: SD_CONTENT
			l_contents: LIST [SD_CONTENT]
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
					l_content := l_contents.item
					if attached l_content.user_widget.parent as l_parent then
						l_parent.prune (l_content.user_widget)
					end
					create l_tab_state.make_with_tab_zone (l_content, a_target_zone, l_orignal_direction)
					a_target_zone.set_content_position (l_content, a_index)
					l_content.change_state (l_tab_state)
					l_contents.back
				end
				if attached l_tab_state then
					l_tab_state.select_tab (content, True)
				else
					check l_tab_state /= Void end -- Implied by `tab_zone.contents' must has contents, so `l_tab_state' must be created
				end
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
			create l_state.make (content, docking_manager)
				-- See comments in `close', it's possible the {SD_TAB_ZONE} doesn't have any content when closing all tools.
			if not zone.contents.is_empty then
				l_state.set_relative (zone.contents.last)
			end
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
				create l_state_void.make (content, docking_manager)
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

	change_short_title (a_title: READABLE_STRING_GENERAL; a_content: SD_CONTENT)
			-- <Precursor>
		do
			if tab_zone.has (a_content) then
				tab_zone.set_short_title (a_title, a_content)
			end
		end

	change_long_title (a_title: READABLE_STRING_GENERAL; a_content: SD_CONTENT)
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

	change_tab_tooltip (a_text: detachable READABLE_STRING_GENERAL)
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
		do
			if is_set_width_after_restore then
				-- We must query zone from `content' but not query zone directly, because when restore `change_state' called.
				if attached {SD_TAB_STATE} content.state as l_state then
					from
						l_contents := l_state.zone.contents
						l_contents.start
					until
						l_contents.after
					loop
						l_contents.item.state.set_last_floating_width (a_int)
						l_contents.forth
					end
				else
					-- Could be docking state, because some SD_CONTENT can't be found during `restore'				
				end
				is_set_width_after_restore := False
			end

			Precursor (a_int)
		ensure then
			flag_cleared: not is_set_width_after_restore
		end

	set_last_floating_height (a_int: INTEGER)
			-- <Precursor>
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			if is_set_height_after_restore then
				-- We must query zone from `content' but not query zone directly, because when restore `change_state' called.
				if attached {SD_TAB_STATE} content.state as l_state then
					from
						l_contents := l_state.zone.contents
						l_contents.start
					until
						l_contents.after
					loop
						l_contents.item.state.set_last_floating_height (a_int)
						l_contents.forth
					end
				else
					-- Could be docking state, because some SD_CONTENT can't be found during `restore'
				end
				is_set_height_after_restore := False
			end

			Precursor (a_int)
		ensure then
			flag_cleared: not is_set_height_after_restore
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
			check l_result /= Void then
				-- Implied by precondition
				Result := l_result
			end
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

	content_count_valid (a_titles: ARRAYED_LIST [READABLE_STRING_GENERAL]): BOOLEAN
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
		do
			if attached {EV_SPLIT_AREA} a_multi_dock_area.item as l_container then
				if zone.is_drag_title_bar then
					Result := l_container.has (zone)
				else
					if attached {SD_DOCKING_ZONE} l_container.first as l_first_docking_zone then
						Result := l_first_docking_zone.content = internal_content
					end
					if
						not Result and then
						attached {SD_DOCKING_ZONE} l_container.second as l_second_docking_zone
					then
						Result := l_second_docking_zone.content = internal_content
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
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
