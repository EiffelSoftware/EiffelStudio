note
	description: "Summary description for {EV_RIBBON_RESOURCES}."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_RESOURCES

feature -- Query

	ribbon_list: ARRAYED_LIST [EV_RIBBON]
			-- Global list of ribbons
		once
			create Result.make (5)
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
				check l_list.count > 0 end
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

end
