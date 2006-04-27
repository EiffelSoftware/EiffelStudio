indexing
	description: "Objects that manage tabs on SD_NOTEBOOK."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_AREA

inherit
	EV_HORIZONTAL_BOX
		rename
			extend as extend_horizontal_box,
			swap as swap_horizontal_box,
			has as has_horizontal_box,
			index_of as index_of_horizontal_box
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

			create internal_tool_bar.make
			create internal_auto_hide_indicator.make

			create internal_tab_box
			extend_horizontal_box (internal_tab_box)
			disable_item_expand (internal_tab_box)

			extend_horizontal_box (internal_tool_bar)
			disable_item_expand (internal_tool_bar)
			internal_tool_bar.hide
			internal_tool_bar.extend (internal_auto_hide_indicator)
			internal_auto_hide_indicator.set_pixmap (internal_shared.icons.hide_tab_indicator (0))
			internal_tool_bar.compute_minmum_size
			internal_auto_hide_indicator.select_actions.extend (agent on_tab_hide_indicator_selected)

			set_minimum_width (0)
			set_minimum_height (internal_shared.zone_minmum_height + 3)
		ensure
			set: internal_docking_manager = a_docking_manager
			set: internal_notebook = a_notebook
		end

feature -- Redefine

	extend (a_widget: EV_WIDGET) is
			-- Extend a_widget.
		require
			a_widget_not_void: a_widget /= Void
		do
			internal_tab_box.extend (a_widget)
			internal_tab_box.disable_item_expand (a_widget)
			resize_tabs (width)
		ensure
			extended: internal_tab_box.has (a_widget)
		end

feature -- Command

	set_gap (a_top: BOOLEAN) is
			-- Set gap at top if a_top is True.
		do
			is_gap_at_top := a_top
		ensure
			set: is_gap_at_top = a_top
		end

	resize_tabs (a_width: INTEGER) is
			-- Hide/show tabs base on space.
		local
			l_tabs, l_all_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			l_tab_before: SD_NOTEBOOK_TAB
		do
			if a_width >= 0 then
				ignore_resize := True
				l_all_tabs := all_tabs.twin

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
					l_all_tabs.start
				until
					l_all_tabs.after
				loop
					if not l_tabs.has (l_all_tabs.item) then
						l_all_tabs.item.show
						if l_tab_before = Void then
							l_all_tabs.item.info.set_tab_before (False)
							l_all_tabs.item.info.set_tab_after (False)
						else
							l_tab_before.info.set_tab_after (True)
							if l_all_tabs.item.is_selected then
								l_tab_before.info.set_tab_after_selected (True)
							else
								l_tab_before.info.set_tab_after_selected (False)
							end
							l_all_tabs.item.info.set_tab_before (True)
							if l_tab_before.is_selected then
								l_all_tabs.item.info.set_tab_before_selected (True)
							else
								l_all_tabs.item.info.set_tab_before_selected (False)
							end
							l_all_tabs.item.info.set_tab_after (False)
						end
						l_all_tabs.item.info.set_tab_after (False)
						l_tab_before := l_all_tabs.item
						ignore_resize := True
					end
					l_all_tabs.forth
				end
				ignore_resize := False
			end
		ensure
			enable_resize: a_width >= 0 implies ignore_resize = False
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle resize actions.
		do
			if is_displayed then
				if not ignore_resize then
					resize_tabs (a_width)
					debug ("docking")
						print ("%N SD_NOTEBOOK_TAB_AREA on_resize")
					end
				end
			end
		ensure
			action_extended: True
		end

	swap (a_tab, a_tab_2: SD_NOTEBOOK_TAB) is
			-- Swap position of tabs
		require
			has: has (a_tab) and has (a_tab_2)
		do
			internal_tab_box.go_i_th (internal_tab_box.index_of (a_tab, 1))
			internal_tab_box.swap (internal_tab_box.index_of (a_tab_2, 1))
			internal_tab_box.disable_item_expand (a_tab)
			internal_tab_box.disable_item_expand (a_tab_2)
		end

	set_tab_position (a_tab: SD_NOTEBOOK_TAB; a_index: INTEGER) is
			-- Set tab position.
		require
			has: has (a_tab)
			valid: a_index > 0 and a_index <= all_tabs.count
		do
			debug ("docking")
				print ("%NSD_NOTEBOOK_TAB_AREA set_tab_position index is: " + a_index.out)
			end
			internal_tab_box.prune (a_tab)
			internal_tab_box.go_i_th (a_index)
			internal_tab_box.put_left (a_tab)
		ensure
			set: internal_tab_box.i_th (a_index) = a_tab
			not_changed: old internal_tab_box.count =  internal_tab_box.count
		end

feature -- Query

	has (a_tab: SD_NOTEBOOK_TAB):BOOLEAN is
			-- Has a_tab ?
		do
			Result := internal_tab_box.has (a_tab)
		end

	is_gap_at_top: BOOLEAN
			-- If gap at top?

	index_of (a_tab: SD_NOTEBOOK_TAB): INTEGER is
			-- Index of a_tab in all tabs.
		do
			Result := internal_tab_box.index_of (a_tab, 1)
		end

	all_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB] is
			-- All tabs in Current.
		local
			l_temp_tab: SD_NOTEBOOK_TAB
		do
			create Result.make (1)
			from
				internal_tab_box.start
			until
				internal_tab_box.after
			loop
				l_temp_tab ?= internal_tab_box.item
				check only_has_tab: l_temp_tab /= Void end
				Result.extend (l_temp_tab)
				internal_tab_box.forth
			end
		ensure
			not_void: Result /= Void
		end

feature {NONE}  -- Implementation functions

	on_tab_hide_indicator_selected is
			-- Handle tab hide indicator selection event.
		local
			l_dialog: SD_NOTEBOOK_HIDE_TAB_DIALOG
			l_tabs: like all_tabs
			l_helper: SD_POSITION_HELPER
		do
			create l_dialog.make (internal_notebook)

			from
				internal_tabs_not_shown.start
			until
				internal_tabs_not_shown.after
			loop
				l_dialog.extend_hide_tab (internal_tabs_not_shown.item)
				internal_tabs_not_shown.forth
			end

			from
				l_tabs := all_tabs
				l_tabs.start
			until
				l_tabs.after
			loop
				if l_tabs.item.is_displayed then
					l_dialog.extend_shown_tab (l_tabs.item)
				end

				l_tabs.forth
			end
			l_dialog.init
			create l_helper.make
			l_helper.set_dialog_position (l_dialog, internal_tool_bar.screen_x, internal_tool_bar.screen_y)
			l_dialog.show
		end

	on_drop_actions (a_any: ANY) is
			-- Handle drop actions.
		do
			internal_docking_manager.tab_drop_actions.call ([a_any, internal_notebook.selected_item])
		end

	updates_tabs_not_shown (a_width: INTEGER) is
			-- Calculate `internal_tabs_not_shown' base on a_width.
		require
			a_width_valid: a_width >= 0
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
				if l_enough then
					internal_one_not_enough_space := False
				else
					internal_one_not_enough_space := True
				end
			end
			show_hide_indicator (a_width)
		ensure
			updated: internal_tabs_not_shown /= old internal_tabs_not_shown
		end

	show_hide_indicator (a_width: INTEGER) is
			-- Show hide indicator base on `internal_tabs_not_shown''s count.
		local
			l_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
--			l_tabs: like all_tabs -- FIXIT: If uselike, then 'l_tabs.item.set_enough_space' will not clickable.
			l_only_tab: SD_NOTEBOOK_TAB
		do
			l_tabs := all_tabs
			if internal_tabs_not_shown.count > 0 then
				internal_auto_hide_indicator.set_pixmap (internal_shared.icons.hide_tab_indicator (internal_tabs_not_shown.count))
				internal_tool_bar.compute_minmum_size
				internal_tool_bar.show
				if l_tabs.count - 1 = internal_tabs_not_shown.count then
					-- Only show one tab now.
					l_only_tab := find_only_tab_shown
					if a_width - internal_tool_bar.width >= 0 and a_width - internal_tool_bar.width < l_only_tab.prefered_size then
						l_only_tab.set_width_not_enough_space (a_width - internal_tool_bar.width)
					end
				end
			end
			if l_tabs.count - 1 /= internal_tabs_not_shown.count then
				from
					l_tabs.start
				until
					l_tabs.after
				loop
					l_tabs.item.set_enough_space
					l_tabs.forth
				end
			end
			if internal_tabs_not_shown.count = 0 then
				internal_tool_bar.hide
			end
		ensure
			-- When there is not enough space to show `internal_tool_bar', follow contract broken.
--			setted: internal_tabs_not_shown.count > 0 implies internal_tool_bar.is_displayed
			setted: internal_tabs_not_shown.count = 0 implies not internal_tool_bar.is_displayed
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
		ensure
			valid: Result >= 0
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

feature {NONE}  -- Implementation attributes

	internal_one_not_enough_space: BOOLEAN
			-- If current space not enough to draw selected tab?

	ignore_resize: BOOLEAN
			-- Ignore resize actions when executing `resize_tabs'?

	internal_tool_bar: SD_TOOL_BAR
			-- Tool bar which hold `internal_auto_hide_indicator'.

	internal_auto_hide_indicator: SD_TOOL_BAR_BUTTON
			-- Auto hide tabs indicator

	internal_tabs_not_shown: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- Tabs not shown which be not shown.

	internal_notebook: SD_NOTEBOOK
			-- Notebook which Current belong to.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

	internal_tab_box: EV_HORIZONTAL_BOX
			-- Box which contain all tabs.

	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_tab_box_not_void: internal_tab_box /= Void
	internal_shared_not_void: internal_shared /= Void
	internal_docking_manager_not_void: internal_docking_manager /= Void
	internal_tool_bar_not_void: internal_tool_bar /= Void
	internal_auto_hide_indicator_not_void: internal_auto_hide_indicator /= Void

indexing
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
