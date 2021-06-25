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
				-- Each time a new ribbon is added, we cleanup existing ones.
			cleanup_internal_ribbon_window_list
		end

	unregister_ribbon_window (a_ribbon_window: EV_RIBBON_TITLED_WINDOW)
			-- Register `a_ribbon_window'.
		local
			l_list: like internal_ribbon_window_list
		do
				-- We iterate the list to remove the window we are trying to unregister.
				-- Note that this routine and `cleanup_internal_ribbon_window_list' are
				-- the only one to remove items from the list.
			from
				l_list := internal_ribbon_window_list
				l_list.start
			until
				l_list.after
			loop
				if attached l_list.item.item as l_window then
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
		do
				-- List of ribbons belonging to windows that haven't been destroyed yet.
			create Result.make (internal_ribbon_window_list.count)
			across internal_ribbon_window_list as l_list loop
				if attached l_list.item as l_window and then not l_window.is_destroyed then
					if attached l_window.ribbon as l_ribbon then
						Result.extend (l_ribbon)
					end
				end
			end
		ensure
			not_void: Result /= Void
		end

	ribbon_window_list: ARRAYED_LIST [EV_RIBBON_TITLED_WINDOW]
			-- Global list of windows containing a ribbon.
		do
				-- List of windows that haven't been destroyed yet containing a ribbon.
			create Result.make (internal_ribbon_window_list.count)
			across internal_ribbon_window_list as l_list loop
				if attached l_list.item as l_window and then not l_window.is_destroyed then
					if attached l_window.ribbon then
						Result.extend (l_window)
					end
				end
			end
		end

	window_for_ribbon (a_ribbon: EV_RIBBON): detachable EV_RIBBON_TITLED_WINDOW
			-- Find window which contains `a_ribbon'
		do
				-- Go through the list of windows to find the window that has `a_ribbon'.
			across internal_ribbon_window_list as l_list until Result /= Void loop
				if attached l_list.item as l_window and then not l_window.is_destroyed then
					if l_window.ribbon = a_ribbon then
						Result := l_window
					end
				end
			end
		end

feature -- Helper

	ribbon_for_tab (a_tab: EV_RIBBON_TAB): detachable EV_RIBBON
			-- Find parent ribbon for `a_tab'
		local
			l_ribbon: EV_RIBBON
		do
			across ribbon_list as l_list until Result /= Void loop
					-- Search tabs in `l_ribbon'
				l_ribbon := l_list
				across l_ribbon.tabs as l_tabs until Result /= Void loop
					if l_tabs = a_tab then
						Result := l_ribbon
					end
				end
			end
		end

	ribbon_for_group (a_group: EV_RIBBON_GROUP): detachable EV_RIBBON
			-- Find parent ribbon for `a_group'
		local
			l_ribbon: EV_RIBBON
		do
			across ribbon_list as l_list until Result /= Void loop
					-- Search tabs in `l_ribbon'
				l_ribbon := l_list
				across l_ribbon.tabs as l_tabs until Result /= Void loop
					across l_tabs.groups as l_groups until Result /= Void loop
						if l_groups = a_group then
							Result := l_ribbon
						end
					end
				end
			end
		end

	ribbon_for_item (a_item: EV_RIBBON_ITEM): detachable EV_RIBBON
			-- Find parent ribbon for `a_item'
		require
			not_void: a_item /= Void
		do
			across ribbon_list as l_list until Result /= Void loop
				if attached find_item_in_tabs (a_item, l_list.tabs) then
					Result := l_list
				end
			end
		end

	find_item_in_tabs (a_item: EV_RIBBON_ITEM; a_tabs: ARRAYED_LIST [EV_RIBBON_TAB]): detachable EV_RIBBON_TAB
			-- Find `a_item' in `a_tabs'
		require
			not_void: a_item /= Void
			not_void: a_tabs /= Void
		local
			l_tab: EV_RIBBON_TAB
		do
				-- Search tabs in `l_ribbon'.
			across a_tabs as l_tabs until Result /= Void loop
				l_tab := l_tabs
					-- Search groups of `l_tabs.item'.
				across l_tab.groups as l_groups until Result /= Void loop
						-- Search buttons of `l_groups.item'.
					across l_groups.buttons as l_buttons until Result /= Void loop
						if l_buttons = a_item then
							Result := l_tab
						end
						if Result = Void then
							if attached {EV_RIBBON_SPLIT_BUTTON} l_buttons as l_split_button then
								across l_split_button.buttons as l_split_buttons until Result /= Void loop
									if l_split_buttons = a_item then
										Result := l_tab
									end
								end
							end
						end
					end
				end
			end
		end

	ribbon_for_contextual_tabs (a_item: EV_RIBBON_TAB_GROUP): detachable EV_RIBBON
			-- Find parent ribbon for contextual tabs
		do
			across internal_ribbon_window_list as l_list until Result /= Void loop
				if attached l_list.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if l_ribbon_window.contextual_tabs.has (a_item) then
						Result := l_ribbon_window.ribbon
					end
				end
			end
		end

	ribbon_for_menu_group (a_item: EV_RIBBON_APPLICATION_MENU_GROUP): detachable EV_RIBBON
			-- Find parent ribbon for menu groups
		do
			across internal_ribbon_window_list as l_list until Result /= Void loop
				if attached l_list.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if attached l_ribbon_window.application_menu as l_app_menu then
						if l_app_menu.groups.has (a_item) then
							Result := l_ribbon_window.ribbon
						end
					end
				end
			end
		end

	ribbon_for_contextual_tab_item (a_item: EV_RIBBON_ITEM): detachable EV_RIBBON
			-- Find parent ribbon for items in contexutal tabs
		require
			not_void: a_item /= Void
		do
			across internal_ribbon_window_list as l_list until Result /= Void loop
				if attached l_list.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					across l_ribbon_window.contextual_tabs as l_tabs until Result /= Void loop
						if attached find_item_in_tabs (a_item, l_tabs.tabs) then
							Result := l_ribbon_window.ribbon
						end
					end
				end
			end
		end

	ribbon_for_application_menu (a_item: EV_RIBBON_APPLICATION_MENU): detachable EV_RIBBON
			-- Find parent ribbon for application menu
		do
			across internal_ribbon_window_list as l_list until Result /= Void loop
				if attached l_list.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if attached l_ribbon_window.application_menu as l_menu then
						if l_menu = a_item then
							Result := l_ribbon_window.ribbon
						end
					end
				end
			end
		end

	ribbon_for_application_menu_recent_items (a_item: EV_RIBBON_APPLICATION_MENU_RECENT_ITEMS): detachable EV_RIBBON
			-- Find parent ribbon for application menu recent items
		do
			across internal_ribbon_window_list as l_list until Result /= Void loop
				if attached l_list.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if attached l_ribbon_window.application_menu as l_menu then
						if l_menu.recent_items = a_item then
							Result := l_ribbon_window.ribbon
						end
					end
				end
			end
		end

	ribbon_for_help_button (a_help_button: EV_RIBBON_HELP_BUTTON): detachable EV_RIBBON
			-- Find parent ribbon for help button
		do
			across internal_ribbon_window_list as l_list until Result /= Void loop
				if attached l_list.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if l_ribbon_window.help_button = a_help_button then
						Result := l_ribbon_window.ribbon
					end
				end
			end
		end

	ribbon_for_quick_access_toolbar (a_qat: EV_RIBBON_QUICK_ACCESS_TOOLBAR): detachable EV_RIBBON
			-- Find parent ribbon for quick access toolbar
		do
			across internal_ribbon_window_list as l_list until Result /= Void loop
				if attached l_list.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if l_ribbon_window.quick_access_toolbar = a_qat then
						Result := l_ribbon_window.ribbon
					end
				end
			end
		end

	ribbon_for_mini_toolbar (a_mini_toolbar: EV_RIBBON_MINI_TOOLBAR): detachable EV_RIBBON
			-- Find parent ribbon for mini toolbar
		do
			across internal_ribbon_window_list as l_list until Result /= Void loop
				if attached l_list.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if l_ribbon_window.mini_toolbars.has (a_mini_toolbar) then
						Result := l_ribbon_window.ribbon
					end
				end
			end
		end

	ribbon_for_context_menu (a_context_menu: EV_RIBBON_CONTEXT_MENU): detachable EV_RIBBON
			-- Find parent ribbon for context menu
		do
			across internal_ribbon_window_list as l_list until Result /= Void loop
				if attached l_list.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if l_ribbon_window.context_menus.has (a_context_menu) then
						Result := l_ribbon_window.ribbon
					end
				end
			end
		end

	ribbon_for_qat_item (a_item: EV_RIBBON_ITEM): detachable EV_RIBBON
			-- Find parent ribbon for quick access tool bar items
		do
			across internal_ribbon_window_list as l_list until Result /= Void loop
				if attached l_list.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if attached l_ribbon_window.quick_access_toolbar as l_qat then
						across l_qat.default_buttons as l_qats until Result /= Void loop
							if l_qats = a_item then
								Result := l_ribbon_window.ribbon
							end
						end
					end
				end
			end
		end

	ribbon_for_application_menu_item (a_item: EV_RIBBON_ITEM): detachable EV_RIBBON
			-- Find parent ribbon for application menu items
		do
			across internal_ribbon_window_list as l_list until Result /= Void loop
				if attached l_list.item as l_ribbon_window and then not l_ribbon_window.is_destroyed then
					if attached l_ribbon_window.application_menu as l_menu then
						across l_menu.groups as l_groups until Result /= Void loop
							across l_groups.buttons as l_buttons until Result /= Void loop
								if l_buttons = a_item then
									Result := l_ribbon_window.ribbon
								end

									-- Find Dropdown button and splitbutton child items
								if
									attached {EV_RIBBON_SPLIT_BUTTON} l_buttons or else
									attached {EV_RIBBON_DROP_DOWN_BUTTON} l_buttons
								then
									if find_in_split_or_drop_button_child_items (l_buttons, a_item) then
										Result := l_ribbon_window.ribbon
									end
								end
							end
						end
					end
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

			across l_children as l_child until Result loop
				if l_child = a_item_to_compare then
					Result := True
				end
			end
		end

feature {NONE} -- Implementation

	internal_ribbon_window_list: ARRAYED_LIST [WEAK_REFERENCE [EV_RIBBON_TITLED_WINDOW]]
			-- Global list of application menus
		once
			create Result.make (5)
		end

	is_cleaning: CELL [BOOLEAN]
			-- Variable to avoid recursive calls in `cleanup_internal_ribbon_window_list'.
		once
			create Result.put (False)
		end

	cleanup_internal_ribbon_window_list
			-- Look for dead ribbons, and if any update
		local
			l_new_list: like internal_ribbon_window_list
		do
				-- Only perform cleaning if none is already taking place.
			if not is_cleaning.item then
				is_cleaning.put (True)
					-- The code below looks complex and heavy since we recreate a list in place, but the
					-- reason is that we have a qualified call `l_window.is_destroyed' which could trigger
					-- some invariant checking which could trigger some traversal of `internal_ribbon_window_list'
					-- and this would invalidate a traditional traversal using `start'/`after'/`forth'.
				create l_new_list.make (internal_ribbon_window_list.count)
				across internal_ribbon_window_list as l_list loop
					if attached l_list.item as l_window and then not l_window.is_destroyed then
						if attached l_window.ribbon as l_ribbon then
							l_new_list.extend (l_list)
						end
					end
				end
					-- Update `internal_ribbon_window_list' with a cleaned version.
				internal_ribbon_window_list.copy (l_new_list)
				is_cleaning.put (False)
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
