note
	description: "Ribbon resources such as instances, window lists."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_RESOURCES

feature -- Update

	register_ribbon_window (a_ribbon_window: EV_RIBBON_TITLED_WINDOW)
			-- Register `a_ribbon_window'.
		do
			internal_ribbon_window_list.extend (create {WEAK_REFERENCE [EV_RIBBON_TITLED_WINDOW]}.put (a_ribbon_window))
		end

	unregister_ribbon_window (a_ribbon_window: EV_RIBBON_TITLED_WINDOW)
			-- Register `a_ribbon_window'.
		local
			l_list: like internal_ribbon_window_list
		do
				-- We iterate the list to remove all windows that do not exist anymore or that have been destroyed
				-- in addition of the window you are trying to unregister.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after
			loop
				if attached l_list.item.item as l_window and then not l_window.is_destroyed then
					if l_window = a_ribbon_window then
						l_list.remove
					else
						l_list.forth
					end
				else
					l_list.remove
				end
			end
		end

feature -- Query

	ribbon_list: ARRAYED_LIST [EV_RIBBON]
			-- Global list of ribbons
		local
			l_list: like internal_ribbon_window_list
		do
				-- We iterate the list to remove all windows that do not exist anymore or that have been destroyed
				-- while creating our list of ribbons.
			from
				l_list := internal_ribbon_window_list
				l_list.start
				create Result.make (l_list.count)
			until
				l_list.after
			loop
				if attached l_list.item.item as l_window and then not l_window.is_destroyed then
					if attached l_window.ribbon as l_ribbon then
						Result.extend (l_ribbon)
					end
					l_list.forth
				else
					l_list.remove
				end
			end
		ensure
			not_void: Result /= Void
		end

	ribbon_window_list: ARRAYED_LIST [EV_RIBBON_TITLED_WINDOW]
			-- Global list of windows containing a ribbon.
		local
			l_list: like internal_ribbon_window_list
		do
				-- We iterate the list to remove all windows that do not exist anymore or that have been destroyed
				-- while creating our list of ribbon windows.			
			from
				l_list := internal_ribbon_window_list
				l_list.start
				create Result.make (l_list.count)
			until
				l_list.after
			loop
				if attached l_list.item.item as l_window and then not l_window.is_destroyed then
					Result.extend (l_window)
					l_list.forth
				else
					l_list.remove
				end
			end
		end

	window_for_ribbon (a_ribbon: EV_RIBBON): detachable EV_RIBBON_TITLED_WINDOW
			-- Find window which contains `a_ribbon'
		local
			l_list: like internal_ribbon_window_list
		do
				-- We iterate the list to remove all windows that do not exist anymore or that have been destroyed
				-- while searching for our window that has `a_ribbon'.			
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.item as l_window and then not l_window.is_destroyed then
					if l_window.ribbon = a_ribbon then
						Result := l_window
					end
					l_list.forth
				else
					l_list.remove
				end
			end
		end

feature -- Helper

	ribbon_for_tab (a_tab: EV_RIBBON_TAB): detachable EV_RIBBON
			-- Find parent ribbon for `a_tab'
		local
			l_list: ARRAYED_LIST [EV_RIBBON]
			l_ribbon: EV_RIBBON
			l_tab: EV_RIBBON_TAB
		do
			from
				l_list := ribbon_list
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
			l_list: ARRAYED_LIST [EV_RIBBON]
			l_ribbon: EV_RIBBON
			l_tab: EV_RIBBON_TAB
			l_group: EV_RIBBON_GROUP
		do
			from
				l_list := ribbon_list
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
		require
			not_void: a_item /= Void
		local
			l_list: ARRAYED_LIST [EV_RIBBON]
			l_ribbon: EV_RIBBON
		do
			from
				l_list := ribbon_list
				--check l_list.count > 0 end -- Ribbon list can be empty before {EV_RIBBON}.init_with_window executed
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				l_ribbon := l_list.item
				if attached find_item_in_tabs (a_item, l_ribbon.tabs) then
					Result := l_ribbon
				end
				l_list.forth
			end
		end

	find_item_in_tabs (a_item: EV_RIBBON_ITEM; a_tabs: ARRAYED_LIST [EV_RIBBON_TAB]): detachable EV_RIBBON_TAB
			-- Find `a_item' in `a_tabs'
		require
			not_void: a_item /= Void
			not_void: a_tabs /= Void
		local
			l_tab: EV_RIBBON_TAB
			l_group: EV_RIBBON_GROUP
		do
			from
				-- Search tabs in `l_ribbon'
				a_tabs.start
			until
				a_tabs.after or Result /= Void
			loop
				l_tab := a_tabs.item
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
							Result := l_tab
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
										Result := l_tab
									end
									l_buttons.forth
								end
							end
						end
						l_group.buttons.forth
					end

					l_tab.groups.forth
				end
				a_tabs.forth
			end
		end

	ribbon_for_contextual_tabs (a_item: EV_RIBBON_TAB_GROUP): detachable EV_RIBBON
			-- Find parent ribbon for contextual tabs
		local
			l_list: like internal_ribbon_window_list
		do
				-- While iterating `internal_ribbon_window_list' we remove all
				-- windows that do not exist anymore or that have been destroyed.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if l_ribbon_window.contextual_tabs.has (a_item) then
						Result := l_ribbon_window.ribbon
					end
					l_list.forth
				else
					l_list.remove
				end
			end
		end

	ribbon_for_menu_group (a_item: EV_RIBBON_APPLICATION_MENU_GROUP): detachable EV_RIBBON
			-- Find parent ribbon for menu groups
		local
			l_list: like internal_ribbon_window_list
		do
				-- While iterating `internal_ribbon_window_list' we remove all
				-- windows that do not exist anymore or that have been destroyed.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if attached l_ribbon_window.application_menu as l_app_menu then
						if l_app_menu.groups.has (a_item) then
							Result := l_ribbon_window.ribbon
						end
					end
					l_list.forth
				else
					l_list.remove
				end
			end
		end

	ribbon_for_contextual_tab_item (a_item: EV_RIBBON_ITEM): detachable EV_RIBBON
			-- Find parent ribbon for items in contexutal tabs
		require
			not_void: a_item /= Void
		local
			l_list: like internal_ribbon_window_list
			l_tabs: ARRAYED_LIST [EV_RIBBON_TAB_GROUP]
		do
				-- While iterating `internal_ribbon_window_list' we remove all
				-- windows that do not exist anymore or that have been destroyed.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					from
						l_tabs := l_ribbon_window.contextual_tabs
						l_tabs.start
					until
						l_tabs.after or Result /= Void
					loop
						if attached find_item_in_tabs (a_item, l_tabs.item.tabs) then
							Result := l_ribbon_window.ribbon
						end
						l_tabs.forth
					end
					l_list.forth
				else
					l_list.remove
				end
			end
		end

	ribbon_for_application_menu (a_item: EV_RIBBON_APPLICATION_MENU): detachable EV_RIBBON
			-- Find parent ribbon for application menu
		local
			l_list: like internal_ribbon_window_list
		do
				-- While iterating `internal_ribbon_window_list' we remove all
				-- windows that do not exist anymore or that have been destroyed.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if attached l_ribbon_window.application_menu as l_menu then
						if l_menu = a_item then
							Result := l_ribbon_window.ribbon
						end
					end
					l_list.forth
				else
					l_list.remove
				end
			end
		end

	ribbon_for_application_menu_recent_items (a_item: EV_RIBBON_APPLICATION_MENU_RECENT_ITEMS): detachable EV_RIBBON
			-- Find parent ribbon for application menu recent items
		local
			l_list: like internal_ribbon_window_list
		do
				-- While iterating `internal_ribbon_window_list' we remove all
				-- windows that do not exist anymore or that have been destroyed.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if attached l_ribbon_window.application_menu as l_menu then
						if l_menu.recent_items = a_item then
							Result := l_ribbon_window.ribbon
						end
					end
					l_list.forth
				else
					l_list.remove
				end
			end
		end

	ribbon_for_help_button (a_help_button: EV_RIBBON_HELP_BUTTON): detachable EV_RIBBON
			-- Find parent ribbon for help button
		local
			l_list: like internal_ribbon_window_list
		do
				-- While iterating `internal_ribbon_window_list' we remove all
				-- windows that do not exist anymore or that have been destroyed.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if l_ribbon_window.help_button = a_help_button then
						Result := l_ribbon_window.ribbon
					end
					l_list.forth
				else
					l_list.remove
				end
			end
		end

	ribbon_for_quick_access_toolbar (a_qat: EV_RIBBON_QUICK_ACCESS_TOOLBAR): detachable EV_RIBBON
			-- Find parent ribbon for quick access toolbar
		local
			l_list: like internal_ribbon_window_list
		do
				-- While iterating `internal_ribbon_window_list' we remove all
				-- windows that do not exist anymore or that have been destroyed.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if l_ribbon_window.quick_access_toolbar = a_qat then
						Result := l_ribbon_window.ribbon
					end
					l_list.forth
				else
					l_list.remove
				end
			end
		end

	ribbon_for_mini_toolbar (a_mini_toolbar: EV_RIBBON_MINI_TOOLBAR): detachable EV_RIBBON
			-- Find parent ribbon for mini toolbar
		local
			l_list: like internal_ribbon_window_list
		do
				-- While iterating `internal_ribbon_window_list' we remove all
				-- windows that do not exist anymore or that have been destroyed.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if l_ribbon_window.mini_toolbars.has (a_mini_toolbar) then
						Result := l_ribbon_window.ribbon
					end
					l_list.forth
				else
					l_list.remove
				end
			end
		end

	ribbon_for_context_menu (a_context_menu: EV_RIBBON_CONTEXT_MENU): detachable EV_RIBBON
			-- Find parent ribbon for context menu
		local
			l_list: like internal_ribbon_window_list
		do
				-- While iterating `internal_ribbon_window_list' we remove all
				-- windows that do not exist anymore or that have been destroyed.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if l_ribbon_window.context_menus.has (a_context_menu) then
						Result := l_ribbon_window.ribbon
					end
					l_list.forth
				else
					l_list.remove
				end
			end
		end

	ribbon_for_qat_item (a_item: EV_RIBBON_ITEM): detachable EV_RIBBON
			-- Find parent ribbon for quick access tool bar items
		local
			l_list: like internal_ribbon_window_list
		do
				-- While iterating `internal_ribbon_window_list' we remove all
				-- windows that do not exist anymore or that have been destroyed.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if attached l_ribbon_window.quick_access_toolbar as l_qat then
						from
							l_qat.default_buttons.start
						until
							l_qat.default_buttons.after or Result /= Void
						loop
							if l_qat.default_buttons.item = a_item then
								Result := l_ribbon_window.ribbon
							end

							l_qat.default_buttons.forth
						end
					end
					l_list.forth
				else
					l_list.remove
				end
			end
		end

	ribbon_for_application_menu_item (a_item: EV_RIBBON_ITEM): detachable EV_RIBBON
			-- Find parent ribbon for application menu items
		local
			l_list: like internal_ribbon_window_list
			l_menu_group: EV_RIBBON_APPLICATION_MENU_GROUP
		do
				-- While iterating `internal_ribbon_window_list' we remove all
				-- windows that do not exist anymore or that have been destroyed.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after or Result /= Void
			loop
				if attached l_list.item.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
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
				else
					l_list.remove
				end
			end
		end

	find_in_split_or_drop_button_child_items (a_split_or_drop_down_item: EV_RIBBON_ITEM; a_item_to_compare: EV_RIBBON_ITEM): BOOLEAN
			-- Find parent ribbon for buttons in split button oro drop-down button
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

feature {NONE} -- Implementation

	internal_ribbon_window_list: ARRAYED_LIST [WEAK_REFERENCE [EV_RIBBON_TITLED_WINDOW]]
			-- Global list of application menus
		once
			create Result.make (5)
		end

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
