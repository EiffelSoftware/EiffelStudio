note
	description: "Summary description for {EV_RIBBON_RESOURCES}."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_RESOURCES

feature -- Query

	ribbon_list: ARRAYED_LIST [EV_RIBBON]
			-- Global list of ribbons
		local
			l_list: like ribbon_window_list
		do
			from
				l_list := ribbon_window_list
				l_list.start
				create Result.make (l_list.count)
			until
				l_list.after
			loop
				if attached l_list.item.ribbon as l_ribbon then
					Result.extend (l_ribbon)
				end
				l_list.forth
			end
		ensure
			not_void: Result /= Void
		end

	ribbon_window_list: ARRAYED_LIST [EV_RIBBON_TITLED_WINDOW]
			-- Global list of application menus
		once
			create Result.make (5)
		end

	window_for_ribbon (a_ribbon: EV_RIBBON): detachable EV_RIBBON_TITLED_WINDOW
			-- Find window which contains `a_ribbon'
		do
			from
				ribbon_window_list.start
			until
				ribbon_window_list.after or Result /= Void
			loop
				if ribbon_window_list.item.ribbon = a_ribbon then
					Result := ribbon_window_list.item
				end
				ribbon_window_list.forth
			end
		end

feature -- Helper

	ribbon_for_tab (a_tab: EV_RIBBON_TAB): detachable EV_RIBBON
			-- Find parent ribbon for `a_tab'
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON]
			l_ribbon: EV_RIBBON
			l_tab: EV_RIBBON_TAB
		do
			from
				create l_res
				l_list := l_res.ribbon_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				l_ribbon := l_list.item
				from
					-- Search tabs in `l_ribbon'
					l_ribbon.tabs.start
				until
					l_ribbon.tabs.after or Result /= Void
				loop
					l_tab := l_ribbon.tabs.item
					if l_tab = a_tab then
						Result := l_ribbon
					end
					l_ribbon.tabs.forth
				end
				l_list.forth
			end
		end

	ribbon_for_group (a_group: EV_RIBBON_GROUP): detachable EV_RIBBON
			-- Find parent ribbon for `a_group'
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON]
			l_ribbon: EV_RIBBON
			l_tab: EV_RIBBON_TAB
			l_group: EV_RIBBON_GROUP
		do
			from
				create l_res
				l_list := l_res.ribbon_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				l_ribbon := l_list.item
				from
					-- Search tabs in `l_ribbon'
					l_ribbon.tabs.start
				until
					l_ribbon.tabs.after or Result /= Void
				loop
					l_tab := l_ribbon.tabs.item
					from
						-- Search group in `l_tab'
						l_tab.groups.start
					until
						l_tab.groups.after or Result /= Void
					loop
						l_group := l_tab.groups.item
						if l_group = a_group then
							Result := l_ribbon
						end

						l_tab.groups.forth
					end
					l_ribbon.tabs.forth
				end
				l_list.forth
			end
		end

	ribbon_for_item (a_item: EV_RIBBON_ITEM): detachable EV_RIBBON
			-- Find parent ribbon for `a_item'
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON]
			l_ribbon: EV_RIBBON
			l_tab: EV_RIBBON_TAB
			l_group: EV_RIBBON_GROUP
		do
			from
				create l_res
				l_list := l_res.ribbon_list
				--check l_list.count > 0 end -- Ribbon list can be empty before {EV_RIBBON}.init_with_window executed
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				l_ribbon := l_list.item
				from
					-- Search tabs in `l_ribbon'
					l_ribbon.tabs.start
				until
					l_ribbon.tabs.after or Result /= Void
				loop
					l_tab := l_ribbon.tabs.item
					from
						-- Search group in `l_tab'
						l_tab.groups.start
					until
						l_tab.groups.after or Result /= Void
					loop
						l_group := l_tab.groups.item
						from
							-- Search items in `l_group'
							l_group.buttons.start
						until
							l_group.buttons.after or Result /= Void
						loop
							if l_group.buttons.item = a_item then
								Result := l_ribbon
							end
							if Result = Void then
								if
									attached {EV_RIBBON_SPLIT_BUTTON} l_group.buttons.item as l_split_button and then
									attached l_split_button.buttons as l_buttons
								then
									from
										l_buttons.start
									until
										l_buttons.after or Result /= Void
									loop
										if l_buttons.item = a_item then
											Result := l_ribbon
										end
										l_buttons.forth
									end
								end
							end
							l_group.buttons.forth
						end

						l_tab.groups.forth
					end
					l_ribbon.tabs.forth
				end
				l_list.forth
			end
		end

	ribbon_for_contextual_tabs (a_item: EV_RIBBON_TAB_GROUP): detachable EV_RIBBON
			-- Find parent ribbon for contextual tabs
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON_TITLED_WINDOW]
			l_ribbon_window: EV_RIBBON_TITLED_WINDOW
		do
			from
				create l_res
				l_list := l_res.ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				l_ribbon_window := l_list.item
				if attached l_ribbon_window.contextual_tabs.has (a_item) then
					Result := l_ribbon_window.ribbon
				end

				l_list.forth
			end
		end

	ribbon_for_application_menu (a_item: EV_RIBBON_APPLICATION_MENU): detachable EV_RIBBON
			-- Find parent ribbon for application menu
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON_TITLED_WINDOW]
			l_ribbon_window: EV_RIBBON_TITLED_WINDOW
		do
			from
				create l_res
				l_list := l_res.ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				l_ribbon_window := l_list.item
				if attached l_ribbon_window.application_menu as l_menu then
					if l_menu = a_item then
						Result := l_ribbon_window.ribbon
					end
				end
				l_list.forth
			end
		end

	ribbon_for_application_menu_recent_items (a_item: EV_RIBBON_APPLICATION_MENU_RECENT_ITEMS): detachable EV_RIBBON
			--
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON_TITLED_WINDOW]
			l_ribbon_window: EV_RIBBON_TITLED_WINDOW
		do
			from
				create l_res
				l_list := l_res.ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				l_ribbon_window := l_list.item
				if attached l_ribbon_window.application_menu as l_menu then
					if l_menu.recent_items = a_item then
						Result := l_ribbon_window.ribbon
					end
				end
				l_list.forth
			end
		end

	ribbon_for_help_button (a_help_button: EV_RIBBON_HELP_BUTTON): detachable EV_RIBBON
			--
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON_TITLED_WINDOW]
		do
			from
				create l_res
				l_list := l_res.ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if l_list.item.help_button = a_help_button then
					Result := l_list.item.ribbon
				end
				l_list.forth
			end
		end

	ribbon_for_quick_access_toolbar (a_qat: EV_RIBBON_QUICK_ACCESS_TOOLBAR): detachable EV_RIBBON
			--
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON_TITLED_WINDOW]
		do
			from
				create l_res
				l_list := l_res.ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if l_list.item.quick_access_toolbar = a_qat then
					Result := l_list.item.ribbon
				end
				l_list.forth
			end
		end

	ribbon_for_mini_toolbar (a_mini_toolbar: EV_RIBBON_MINI_TOOLBAR): detachable EV_RIBBON
			--
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON_TITLED_WINDOW]
		do
			from
				create l_res
				l_list := l_res.ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if l_list.item.mini_toolbars.has (a_mini_toolbar) then
					Result := l_list.item.ribbon
				end
				l_list.forth
			end
		end

	ribbon_for_context_menu (a_context_menu: EV_RIBBON_CONTEXT_MENU): detachable EV_RIBBON
			--
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON_TITLED_WINDOW]
		do
			from
				create l_res
				l_list := l_res.ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if l_list.item.context_menus.has (a_context_menu) then
					Result := l_list.item.ribbon
				end
				l_list.forth
			end
		end

	ribbon_for_qat_item (a_item: EV_RIBBON_ITEM): detachable EV_RIBBON
			--
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON_TITLED_WINDOW]
		do
			from
				create l_res
				l_list := l_res.ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.quick_access_toolbar as l_qat then
					from
						l_qat.default_buttons.start
					until
						l_qat.default_buttons.after or Result /= Void
					loop
						if l_qat.default_buttons.item = a_item then
							Result := l_list.item.ribbon
						end

						l_qat.default_buttons.forth
					end
				end
				l_list.forth
			end
		end

	ribbon_for_application_menu_item (a_item: EV_RIBBON_ITEM): detachable EV_RIBBON
			--
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON_TITLED_WINDOW]
			l_ribbon_window: EV_RIBBON_TITLED_WINDOW
			l_menu_group: EV_RIBBON_APPLICATION_MENU_GROUP
		do
			from
				create l_res
				l_list := l_res.ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				l_ribbon_window := l_list.item
				if attached l_ribbon_window.application_menu as l_menu then
					from
						l_menu.groups.start
					until
						l_menu.groups.after or Result /= Void
					loop
						l_menu_group := l_menu.groups.item
						from
							l_menu_group.buttons.start
						until
							l_menu_group.buttons.after or Result /= Void
						loop
							if l_menu_group.buttons.item = a_item then
								Result := l_ribbon_window.ribbon
							end

							-- Find Dropdown button and splitbutton child items
							if attached {EV_RIBBON_SPLIT_BUTTON} l_menu_group.buttons.item or else
								attached {EV_RIBBON_DROP_DOWN_BUTTON} l_menu_group.buttons.item then
								if find_in_split_or_drop_button_child_items (l_menu_group.buttons.item, a_item) then
									Result := l_ribbon_window.ribbon
								end
							end

							l_menu_group.buttons.forth
						end
						l_menu.groups.forth
					end
				end
				l_list.forth
			end
		end

	find_in_split_or_drop_button_child_items (a_split_or_drop_down_item: EV_RIBBON_ITEM; a_item_to_compare: EV_RIBBON_ITEM): BOOLEAN
			--
		require
			not_void: a_split_or_drop_down_item /= Void
			not_void: a_item_to_compare /= Void
		local
			l_children: ARRAYED_LIST [EV_RIBBON_ITEM]
		do
			if attached {EV_RIBBON_SPLIT_BUTTON} a_split_or_drop_down_item as l_split_button then
				l_children := l_split_button.buttons
			elseif attached {EV_RIBBON_DROP_DOWN_BUTTON} a_split_or_drop_down_item as l_drop_down_button then
				l_children := l_drop_down_button.buttons
			else
				check not_possible: False end
				create l_children.make (1)
			end

			from
				l_children.start
			until
				l_children.after or Result
			loop
				if l_children.item = a_item_to_compare then
					Result := True
				end
				l_children.forth
			end
		end
end
