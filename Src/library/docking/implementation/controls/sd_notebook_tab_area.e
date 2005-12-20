indexing
	description: "Objects that manage tabs on SD_NOTEBOOK. A decorator."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_AREA

inherit
	EV_HORIZONTAL_BOX

create
	make

feature {NONE}  -- Initlization

	make (a_notebook: SD_NOTEBOOK; a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_notebook_not_void: a_notebook /= Void
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			default_create
			internal_notebook := a_notebook
			internal_docking_manager := a_docking_manager

			if internal_docking_manager.tab_drop_actions.count > 0 then
				drop_actions.extend (agent on_drop_actions)
			end
			resize_actions.extend (agent on_resize)
		ensure
			set: internal_docking_manager = a_docking_manager
			set: internal_notebook = a_notebook
		end

feature {NONE}  -- Implementation

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle resize actions.
		local
			l_tabs: ARRAYED_LIST [EV_WIDGET]
		do
			updates_tabs_not_shown (a_width)
			l_tabs := internal_tabs_not_shown.twin
			from
				l_tabs.start
			until
				l_tabs.after
			loop
				l_tabs.item.hide
				l_tabs.forth	
	
			end
			from
				start
			until
				after
			loop
				if not l_tabs.has (item) then
					item.show
				end
				
				if not after then
					forth
				end
				
			end
		end

	on_drop_actions (a_any: ANY) is
			-- Handle drop actions.
		do
			internal_docking_manager.tab_drop_actions.call ([a_any, internal_notebook.selected_item])
		end

	all_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB] is
			-- All tabs in Current.
		local
			l_temp_tab: SD_NOTEBOOK_TAB
		do
			create Result.make (1)
			from
				start
			until
				after
			loop
				l_temp_tab ?= item
				check only_has_sd_tab: l_temp_tab /= Void end
				Result.extend (l_temp_tab)
				forth
			end

		end

	updates_tabs_not_shown (a_width: INTEGER) is
			--
		local
			l_total_width: INTEGER
			l_enough: BOOLEAN
			l_current: SD_NOTEBOOK_TAB
		do
			create internal_tabs_not_shown.make (1)
			if not is_empty then
				from
					start
				until
					after
				loop
					l_total_width := l_total_width + item.width
					forth
				end
				from
					finish
				until
					before or l_enough
				loop
					l_current ?= item
					check only_contain_tabs: l_current /= Void end
					if not l_current.is_selected then
						if l_total_width > a_width then
							internal_tabs_not_shown.extend (item)
							l_total_width := l_total_width - item.width
						else
							l_enough := True
						end
					end
					back
				end				
			end

		end

feature {NONE}  -- Implementation

	internal_tabs_not_shown: ARRAYED_LIST [EV_WIDGET]
			-- Tabs not shown which be not shown.

	internal_notebook: SD_NOTEBOOK
			-- Notebook which Current belong to.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.
end
