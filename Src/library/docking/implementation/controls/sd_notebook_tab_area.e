indexing
	description: "Objects that manage tabs on SD_NOTEBOOK. A decorator."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_AREA

inherit
	EV_HORIZONTAL_BOX
		rename
			extend as extend_horizontal_box
		end

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
			create internal_shared
			internal_notebook := a_notebook
			internal_docking_manager := a_docking_manager

			if internal_docking_manager.tab_drop_actions.count > 0 then
				drop_actions.extend (agent on_drop_actions)
			end

			create internal_tool_bar
			create internal_auto_hide_indicator

--			extend_horizontal_box (create {EV_CELL})  -- For test
			extend_horizontal_box (internal_tool_bar)
			internal_tool_bar.hide
			internal_tool_bar.extend (internal_auto_hide_indicator)
			internal_auto_hide_indicator.set_pixmap (internal_shared.icons.hide_tab_indicator (0))
			internal_auto_hide_indicator.select_actions.extend (agent on_tab_hide_indicator_selected)
		ensure
			set: internal_docking_manager = a_docking_manager
			set: internal_notebook = a_notebook
		end

feature -- Redefine

	extend (a_widget: EV_WIDGET) is
			-- Redefine
		do
			finish
			put_left (a_widget)
		end

feature -- Command

	hide_show_tabs (a_width: INTEGER) is
			-- Hide/show tabs base on space.
		local
			l_tabs: ARRAYED_LIST [EV_WIDGET]
		do
			ignore_resize := True
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
				if not l_tabs.has (item) and item /= internal_tool_bar then
					item.show
					ignore_resize := True
				end

				forth

			end
			ignore_resize := False
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle resize actions.
		local

			l_app: EV_ENVIRONMENT
		do
			if is_displayed then
				if not ignore_resize then
					create l_app
					l_app.application.idle_actions.extend_kamikaze (agent hide_show_tabs (a_width))
				end
			end
		end

feature {NONE}  -- Implementation

	on_tab_hide_indicator_selected is
			-- Handle tab hide indicator selection event.
		local
			l_dialog: SD_NOTEBOOK_HIDE_TAB_DIALOG
		do
			create l_dialog.make (internal_notebook)
			l_dialog.set_position (internal_tool_bar.screen_x, internal_tool_bar.screen_y)
			from
				internal_tabs_not_shown.start
			until
				internal_tabs_not_shown.after
			loop
				l_dialog.extend (internal_tabs_not_shown.item)

				internal_tabs_not_shown.forth
			end
			l_dialog.show
			l_dialog.enable_capture
		end

	ignore_resize: BOOLEAN

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
				if l_temp_tab /= Void then
					Result.extend (l_temp_tab)
				end
				forth
			end

		end

	updates_tabs_not_shown (a_width: INTEGER) is
			-- Calculate `internal_tabs_not_shown' base on a_width.
		local
			l_total_width: INTEGER
			l_enough: BOOLEAN
			l_tabs: like all_tabs

		do
			create internal_tabs_not_shown.make (1)
			if not is_empty then
				l_total_width := total_prefered_width

				if l_total_width > a_width then
					l_total_width := l_total_width + internal_tool_bar.minimum_width
					l_tabs := all_tabs
					from
						l_tabs.finish
					until
						l_tabs.before or l_enough
					loop

						if not l_tabs.item.is_selected then
							if l_total_width > a_width then
								internal_tabs_not_shown.extend (l_tabs.item)
								l_total_width := l_total_width - l_tabs.item.prefered_size
							else
								l_enough := True
							end
						end
						l_tabs.back
					end
				end
			end

			show_hide_indicator (a_width)

		end

	show_hide_indicator (a_width: INTEGER) is
			-- Show hide indicator base on `internal_tabs_not_shown''s count.
		local
			l_tabs: like all_tabs
		do
			l_tabs := all_tabs
			if internal_tabs_not_shown.count > 0 then
				internal_auto_hide_indicator.set_pixmap (internal_shared.icons.hide_tab_indicator (internal_tabs_not_shown.count))
				internal_tool_bar.show
				if l_tabs.count - 1 = internal_tabs_not_shown.count then
					-- Only show one tab now.
					if a_width - internal_tool_bar.width >= 0 then
						find_only_tab_shown.set_width (a_width - internal_tool_bar.width)
					end
				end
			else
				internal_tool_bar.hide
			end
		end

	total_prefered_width: INTEGER is
			-- Calculate all tabs total prefered width.
		local
			l_tabs: like all_tabs
		do
			l_tabs := all_tabs
			from
				l_tabs.start
			until
				l_tabs.after
			loop
				Result := Result + l_tabs.item.prefered_size
				l_tabs.forth
			end
--			Result := Result + internal_shared.highlight_tail_width
		end

	find_only_tab_shown: SD_NOTEBOOK_TAB is
			-- Find the only one tab which is shown.
		require
			only_show_one_tab: all_tabs.count - 1 = internal_tabs_not_shown.count
		local
			l_tabs, l_result: like all_tabs
		do
			l_tabs := all_tabs
			l_result := all_tabs
			from
				l_tabs.start
			until
				l_tabs.after
			loop
				from
					internal_tabs_not_shown.start
				until
					internal_tabs_not_shown.after
				loop
					if internal_tabs_not_shown.item = l_tabs.item then
						l_result.prune_all (l_tabs.item)
					end
					internal_tabs_not_shown.forth
				end
				l_tabs.forth
			end
			check found_only_one: l_result.count = 1 end
			Result := l_result.first
		ensure
			not_void: Result /= Void
		end

feature {NONE}  -- Implementation

	internal_tool_bar: EV_TOOL_BAR
			-- Tool bar which hold `internal_auto_hide_indicator'.

	internal_auto_hide_indicator: EV_TOOL_BAR_BUTTON
			-- Auto hide tabs indicator

	internal_tabs_not_shown: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- Tabs not shown which be not shown.

	internal_notebook: SD_NOTEBOOK
			-- Notebook which Current belong to.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_tool_bar_not_void: internal_tool_bar /= Void
	internal_auto_hide_indicator_not_void: internal_auto_hide_indicator /= Void

end
