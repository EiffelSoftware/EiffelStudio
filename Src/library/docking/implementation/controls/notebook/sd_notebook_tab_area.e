note
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
		export
			{NONE} set_minimum_width
		end

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER)
			-- Creation method
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			create internal_shared

			internal_docking_manager := a_docking_manager

			create internal_tool_bar.make

			create internal_auto_hide_indicator.make

			create tab_box.make
			create internal_tabs_not_shown.make (30)

			default_create

			extend_horizontal_box (tab_box)
			disable_item_expand (tab_box)
			pointer_double_press_actions.extend
				(agent (a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32)
					do on_tab_box_right_side_double_click end)

			extend_horizontal_box (internal_tool_bar)
			internal_tool_bar.hide
			internal_tool_bar.extend (internal_auto_hide_indicator)
			internal_tool_bar.compute_minimum_size
			internal_auto_hide_indicator.select_actions.extend (agent on_tab_hide_indicator_selected)

			set_minimum_width (0)
			update_size

			if attached internal_docking_manager.tab_drop_actions as l_tab_drop_actions and then l_tab_drop_actions.count > 0 then
				drop_actions.extend (agent on_drop_actions)
				drop_actions.set_veto_pebble_function (agent on_veto_drop_action)
			end

			internal_auto_hide_indicator.set_tooltip (internal_shared.interface_names.tooltip_notebook_hidden_tab_indicator)
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature {SD_NOTEBOOK} -- Initlization

	set_notebook (a_notebook: SD_NOTEBOOK)
			-- Set `notebook' with `a_notebook'.
		require
			a_notebook_attached: attached a_notebook
		do
			notebook := a_notebook
		ensure
			notebook_set: notebook = a_notebook
		end

feature -- Redefine

	extend (a_widget: SD_NOTEBOOK_TAB)
			-- Extend a_widget
		require
			a_widget_not_void: a_widget /= Void
		do
			tab_box.extend (a_widget)
			resize_tabs (tab_box_predered_width)
		ensure
			extended: tab_box.has (a_widget)
		end

	extend_tabs (a_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB])
			-- Extend `a_tabs'
			-- This feature is faster than extend one by one
		require
			not_void: a_tabs /= Void
		do
			tab_box.extend_tabs (a_tabs)
			resize_tabs (tab_box_predered_width)
		end

feature -- Command

	update_size
			--Update minimum size
		do
			set_minimum_height (internal_shared.notebook_tab_height + 3)
		end

	set_gap (a_top: BOOLEAN)
			-- Set gap at top if a_top is True
		do
			is_gap_at_top := a_top
		ensure
			set: is_gap_at_top = a_top
		end

	resize_tabs (a_width: INTEGER)
			-- Hide/show tabs base on space
		local
			l_tabs, l_all_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			l_tab_item: SD_NOTEBOOK_TAB
			l_tab_before: detachable SD_NOTEBOOK_TAB
			l_tab_item_info, l_tab_before_info: SD_NOTEBOOK_TAB_INFO
		do
			if a_width >= 0 then
				ignore_resize := True
				l_all_tabs := all_tabs

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
					l_tab_item := l_all_tabs.item
					if not l_tabs.has (l_tab_item) then
						l_tab_item.show
						l_tab_item_info	:= l_tab_item.info
						if l_tab_before = Void then
							l_tab_item_info.set_tab_before (False)
							l_tab_item_info.set_tab_after (False)
						else
							l_tab_before_info	:= l_tab_before.info
							l_tab_before_info.set_tab_after (True)
							if l_tab_item.is_selected then
								l_tab_before_info.set_tab_after_selected (True)
							else
								l_tab_before_info.set_tab_after_selected (False)
							end
							l_tab_item_info.set_tab_before (True)
							if l_tab_before.is_selected then
								l_tab_item_info.set_tab_before_selected (True)
							else
								l_tab_item_info.set_tab_before_selected (False)
							end
							l_tab_item_info.set_tab_after (False)
						end
						l_tab_item_info.set_tab_after (False)
						l_tab_before := l_tab_item
						ignore_resize := True
					end
					l_all_tabs.forth
				end

				update_minimum_size
				ignore_resize := False
			end
		ensure
			enable_resize: a_width >= 0 implies not ignore_resize
		end

	update_minimum_size
			-- Update minimum size of Current
		local
			l_all_tabs: like all_tabs
			l_tabs_not_shown: like internal_tabs_not_shown
		do
			l_all_tabs := all_tabs
			l_tabs_not_shown := internal_tabs_not_shown.twin
			from
				l_tabs_not_shown.start
			until
				l_tabs_not_shown.after
			loop
				l_all_tabs.start
				l_all_tabs.prune (l_tabs_not_shown.item)
				l_tabs_not_shown.forth
			end
			if l_all_tabs.count > 0 and then attached l_all_tabs.last as l_last_tab then
				tab_box.set_minimum_width (l_last_tab.x + l_last_tab.width)
			end
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Handle resize actions
			-- `a_width' is tab areas' width, not include other EV_TOOL_BAR
		do
			if is_displayed then
				if not ignore_resize and a_width /= last_resize_width then
					debug ("docking")
						print ("%N SD_NOTEBOOK_TAB_AREA on_resize ("+ a_x.out +","+ a_y.out +","+ a_width.out +","+ a_height.out +")%N")
					end
					resize_tabs (a_width)
					last_resize_width := a_width
				end
			end
		ensure
			action_extended: True
		end

	swap (a_tab, a_tab_2: SD_NOTEBOOK_TAB)
			-- Swap position of tabs
		require
			has: has (a_tab) and has (a_tab_2)
		do
			tab_box.swap (a_tab, a_tab_2)
			resize_tabs (tab_box_predered_width)
		end

	set_tab_position (a_tab: SD_NOTEBOOK_TAB; a_index: INTEGER)
			-- Set tab position
		require
			has: has (a_tab)
			valid: a_index > 0 and a_index <= all_tabs.count
		do
			debug ("docking")
				print ("%NSD_NOTEBOOK_TAB_AREA set_tab_position index is: " + a_index.out)
			end
			tab_box.set_tab_position (a_tab, a_index)
			resize_tabs (tab_box_predered_width)
		ensure
			set: tab_box.i_th (a_index) = a_tab
			not_changed: old tab_box.count =  tab_box.count
		end

feature -- Query

	has (a_tab: SD_NOTEBOOK_TAB):BOOLEAN
			-- Has a_tab?
		do
			Result := tab_box.has (a_tab)
		end

	is_gap_at_top: BOOLEAN
			-- If gap at top?

	index_of (a_tab: SD_NOTEBOOK_TAB): INTEGER
			-- Index of a_tab in all tabs
		do
			Result := tab_box.index_of (a_tab)
		end

	all_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- All tabs in Current
		do
			Result := tab_box.tabs
		ensure
			not_void: Result /= Void
		end

	tab_box: SD_NOTEBOOK_TAB_BOX
			-- Box which contain all tabs

	tab_box_predered_width: INTEGER
			-- tool bar preferred width
		do
			Result := width - internal_tool_bar.minimum_width
			if Result < 0 then
				Result := 0
			end
		ensure
			non_negative: Result >= 0
		end

	right_side_double_click_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Double click actions on Current right side blank area
		do
			Result := internal_right_side_double_click_actions
			if not attached Result then
				create Result
				internal_right_side_double_click_actions := Result
			end
		end

feature {NONE}  -- Implementation functions

	on_tab_hide_indicator_selected
			-- Handle tab hide indicator selection event
		local
			l_dialog: SD_NOTEBOOK_HIDE_TAB_DIALOG
			l_tabs: like all_tabs
			l_helper: SD_POSITION_HELPER
			l_tabs_invisible: like internal_tabs_not_shown
		do
			if attached notebook as n then
				create l_dialog.make (n)
				check
					internal_tabs_not_shown_not_void: internal_tabs_not_shown /= Void
				end
				from
					l_tabs_invisible := internal_tabs_not_shown
					l_tabs_invisible.finish
				until
					l_tabs_invisible.before
				loop
					l_dialog.extend_hide_tab (l_tabs_invisible.item)
					l_tabs_invisible.back
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
				l_helper.set_dialog_position (l_dialog, internal_tool_bar.screen_x, internal_tool_bar.screen_y, internal_tool_bar.height)
				l_dialog.show
			end
		end

	on_drop_actions (a_any: ANY)
			-- Handle drop actions.
		do
			if
				attached internal_docking_manager.tab_drop_actions as l_drop_actions and then
				attached notebook as n and then
				attached n.selected_item as l_content
			then
				l_drop_actions.call ([a_any, l_content])
			end
		end

	on_veto_drop_action (a_any: ANY): BOOLEAN
			-- Handle veto drop action.
		do
			if
				attached internal_docking_manager.tab_drop_actions as l_actions and then
				attached l_actions.veto_pebble_function as l_veto_function and then
				attached notebook as n and then
				attached n.selected_item as c
			then
				Result := l_veto_function (a_any, c)
			else
					-- If veto drop function not set.
				Result := True
			end
		end

	on_tab_box_right_side_double_click
			-- Handle right side double click actions from `tab_box'
		do
			if attached internal_right_side_double_click_actions then
				right_side_double_click_actions.call (void)
			end
		end

	updates_tabs_not_shown (a_width: INTEGER)
			-- Calculate `internal_tabs_not_shown' base on a_width
		require
			a_width_valid: a_width >= 0
		local
			l_total_width: INTEGER
			l_enough: BOOLEAN
			l_tabs: like all_tabs
			l_tab: SD_NOTEBOOK_TAB
			l_tabs_invisible: like internal_tabs_not_shown
			l_available_width: INTEGER
		do
			internal_tabs_not_shown.wipe_out
			l_tabs_invisible := internal_tabs_not_shown
			if not is_empty then
				l_total_width := total_preferred_width
				l_total_width := l_total_width
					-- Note: solution to be able to resize down (with gtk34).
					--| the minimum width of the full tab area need to take have a flexible part
					--| when the `internal_tool_bar` is hidden, the tabs box could use the full width
					--| and the implementatio set this width as the minimum width for the tabs box.
					--| So a flexible space (no minimum width) should be there to allow vision2 to resize down the notebook.
					--| The following line keeps at least  `internal_tool_bar.minimum_width + 2` for this purpose.
				l_available_width := a_width - internal_tool_bar.minimum_width - 2
				if l_total_width > l_available_width then
					l_tabs := all_tabs
					from
						l_tabs.finish
					until
						l_tabs.before or l_enough
					loop
						l_tab := l_tabs.item
						if not l_tab.is_selected then
							if l_total_width > l_available_width then
								l_tabs_invisible.extend (l_tab)
								l_total_width := l_total_width - l_tab.preferred_size
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
			internal_tabs_not_shown_updated: True
		end

	show_hide_indicator (a_width: INTEGER)
			-- Show hide indicator base on `internal_tabs_not_shown''s count
		local
			l_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
--			l_tabs: like all_tabs -- FIXIT: If uselike, then 'l_tabs.item.set_enough_space' will not clickable
			l_only_tab: SD_NOTEBOOK_TAB
			l_platform: PLATFORM
		do
			l_tabs := all_tabs
			if internal_tabs_not_shown.count > 0 then
				create l_platform
				if l_platform.is_windows then
					internal_auto_hide_indicator.set_pixel_buffer (internal_shared.icons.hide_tab_indicator_buffer (internal_tabs_not_shown.count))
				else
					-- We use EV_PIXMAP instead of EV_PIXEL_BUFFER on Linux, because draw_text is not available for Linux.
					internal_auto_hide_indicator.set_pixmap (internal_shared.icons.hide_tab_indicator (internal_tabs_not_shown.count))
					internal_auto_hide_indicator.update
				end

				internal_tool_bar.compute_minimum_size
				internal_tool_bar.show
				if l_tabs.count - 1 = internal_tabs_not_shown.count then
					-- Only show one tab now.
					l_only_tab := find_only_tab_shown
					if
						a_width - internal_tool_bar.width >= 0
						and a_width - internal_tool_bar.width < l_only_tab.preferred_size
					then
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

	total_preferred_width: INTEGER
			-- Calculate all tabs total preferred width
		local
			l_tabs: like all_tabs
		do
			l_tabs := all_tabs
			from
				l_tabs.start
			until
				l_tabs.after
			loop
				Result := Result + l_tabs.item.preferred_size
				l_tabs.forth
			end
		ensure
			valid: Result >= 0
		end

	find_only_tab_shown: SD_NOTEBOOK_TAB
			-- Find the only one tab which is shown
		require
			only_show_one_tab: all_tabs.count - 1 = internal_tabs_not_shown.count
		local
			l_tabs, l_result: like all_tabs
			l_tab: SD_NOTEBOOK_TAB
		do
			l_tabs := all_tabs
			l_result := all_tabs
			from
				l_tabs.start
			until
				l_tabs.after
			loop
				l_tab := l_tabs.item
				from
					internal_tabs_not_shown.start
				until
					internal_tabs_not_shown.after
				loop
					if internal_tabs_not_shown.item = l_tab then
						l_result.prune_all (l_tab)
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

feature {SD_NOTEBOOK_TAB_BOX, SD_NOTEBOOK} -- Internal attributes

	notebook: detachable SD_NOTEBOOK
			-- Notebook which Current belong to.

feature {NONE}  -- Implementation attributes

	last_resize_width: INTEGER
			-- We have to remember last width in `on_resize', otherwise there will be infinite loop
			-- See bug#13065.

	internal_one_not_enough_space: BOOLEAN
			-- If current space not enough to draw selected tab?

	ignore_resize: BOOLEAN
			-- Ignore resize actions when executing `resize_tabs'?

	internal_tool_bar: SD_TOOL_BAR
			-- Tool bar which hold `internal_auto_hide_indicator'

	internal_auto_hide_indicator: SD_TOOL_BAR_BUTTON
			-- Auto hide tabs indicator

	internal_tabs_not_shown: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- Tabs not shown which be not shown

	internal_right_side_double_click_actions: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Double click actions on Current right side blank area

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to

	internal_shared: SD_SHARED
			-- All singletons

invariant

	internal_tab_box_not_void: tab_box /= Void
	internal_shared_not_void: internal_shared /= Void
	internal_docking_manager_not_void: internal_docking_manager /= Void
	internal_tool_bar_not_void: internal_tool_bar /= Void
	internal_auto_hide_indicator_not_void: internal_auto_hide_indicator /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
