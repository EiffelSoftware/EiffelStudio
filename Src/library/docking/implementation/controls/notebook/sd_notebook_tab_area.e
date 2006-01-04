indexing
	description: "Objects that manage tabs on SD_NOTEBOOK. A decorator."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_AREA

inherit
	EV_HORIZONTAL_BOX
		rename
			extend as extend_horizontal_box,
			swap as swap_horizontal_box,
			has as has_horizontal_box
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
--			set_border_width (internal_shared.border_width)
--			set_background_color (internal_shared.border_color)
			set_background_color ((create {EV_STOCK_COLORS}).black)

			internal_notebook := a_notebook
			internal_docking_manager := a_docking_manager

			if internal_docking_manager.tab_drop_actions.count > 0 then
				drop_actions.extend (agent on_drop_actions)
			end

			create internal_tool_bar
			create internal_auto_hide_indicator


			create internal_gap_box
			extend_horizontal_box (internal_gap_box)

			create internal_tab_box
			internal_gap_box.extend (internal_tab_box)
			disable_item_expand (internal_gap_box)

			extend_horizontal_box (internal_tool_bar)
			disable_item_expand (internal_tool_bar)
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
			if internal_gap_box.has (internal_gap) then
				internal_gap_box.prune (internal_gap)
			end
			create internal_gap
			internal_gap.set_background_color (internal_shared.non_focused_color_lightness)
			internal_gap.set_minimum_height (internal_shared.auto_hide_panel_gap_size)
			if a_top then
				internal_gap_box.start
				internal_gap_box.put_left (internal_gap)
			else
				internal_gap_box.extend (internal_gap)
			end
		ensure
			set: internal_gap_box.has (internal_gap)
		end

	resize_tabs (a_width: INTEGER) is
			-- Hide/show tabs base on space.
		local
			l_tabs, l_all_tabs: ARRAYED_LIST [EV_WIDGET]
		do
			if a_width >= 0 then
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
				l_all_tabs := all_tabs.twin
				from
					l_all_tabs.start
				until
					l_all_tabs.after
				loop
					if not l_tabs.has (l_all_tabs.item) and l_all_tabs.item /= internal_tool_bar then
						l_all_tabs.item.show
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
		local
			l_app: EV_ENVIRONMENT
		do
			if is_displayed then
				if not ignore_resize then
					create l_app
					l_app.application.idle_actions.extend_kamikaze (agent resize_tabs (a_width))
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

feature -- Query

	has (a_tab: SD_NOTEBOOK_TAB):BOOLEAN is
			-- Has a_tab ?
		do
			Result := internal_tab_box.has (a_tab)
		end

	is_gap_at_top: BOOLEAN is
			-- If gap at top?
		require
			has_gap: gap_setted
		do
			Result := internal_gap_box.first = internal_gap
		end

	gap_setted: BOOLEAN is
			-- If gap area setted?
		do
			Result := internal_gap_box.has (internal_gap)
		end

feature {NONE}  -- Implementation functions

	on_tab_hide_indicator_selected is
			-- Handle tab hide indicator selection event.
		local
			l_dialog: SD_NOTEBOOK_HIDE_TAB_DIALOG
			l_tabs: like all_tabs
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
			set_dialog_position (l_dialog, internal_tool_bar.screen_x, internal_tool_bar.screen_y)
			l_dialog.show
		end

	set_dialog_position (a_dialog: EV_POSITIONABLE; a_prefer_x, a_prefer_y: INTEGER) is
			-- Set dialog position base on screen size.
		require
			a_dialog_not_void: a_dialog /= Void
		local
			l_screen: SD_SCREEN
			l_rect: EV_RECTANGLE
		do
			create l_screen
			create l_rect.make (l_screen.virtual_left, l_screen.virtual_top, l_screen.virtual_width, l_screen.virtual_height)
			if l_rect.has_x_y (a_dialog.width + a_prefer_x, a_dialog.height + a_prefer_y) then
				-- If enough space set position base on left top corner.
				a_dialog.set_position (a_prefer_x, a_prefer_y)
			elseif l_rect.has_x_y (a_prefer_x, a_prefer_y + a_dialog.height) then
				-- If enough space set position base on right top corner.
				a_dialog.set_position (a_prefer_x - a_dialog.width, a_prefer_y)
			elseif l_rect.has_x_y (a_prefer_x + a_dialog.width, a_prefer_y - a_dialog.height) then
				-- If enough space set position base on left bottom corner.
				a_dialog.set_position (a_prefer_x, a_prefer_y - a_dialog.height)
			elseif l_rect.has_x_y (a_prefer_x - a_dialog.width, a_prefer_y - a_dialog.height) then
				-- If enough space set positon base on right bottom corner.
				a_dialog.set_position (a_prefer_x - a_dialog.width, a_prefer_y - a_dialog.height)
			else
				check not_possible_in_this_case: False end
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
				internal_tab_box.start
			until
				internal_tab_box.after
			loop
				l_temp_tab ?= internal_tab_box.item
				check only_has_tab: l_temp_tab /= Void end
--				if l_temp_tab /= Void then
				Result.extend (l_temp_tab)
--				end
				internal_tab_box.forth
			end
		ensure
			not_void: Result /= Void
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
			end
			show_hide_indicator (a_width)
		ensure
			updated: internal_tabs_not_shown /= old internal_tabs_not_shown
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

	ignore_resize: BOOLEAN
			-- Ignore resize actions when executing `resize_tabs'?

	internal_tool_bar: EV_TOOL_BAR
			-- Tool bar which hold `internal_auto_hide_indicator'.

	internal_auto_hide_indicator: EV_TOOL_BAR_BUTTON
			-- Auto hide tabs indicator

	internal_tabs_not_shown: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- Tabs not shown which be not shown.

	internal_notebook: SD_NOTEBOOK
			-- Notebook which Current belong to.

	internal_gap: EV_CELL
			-- Gap in `internal_gap_box'.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

	internal_gap_box: EV_VERTICAL_BOX
			-- Gap box for `internal_tab_box'.

	internal_tab_box: EV_HORIZONTAL_BOX
			-- Box which contain all tabs.

	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_tab_box_not_void: internal_tab_box /= Void
	internal_gap_box_not_void: internal_gap_box /= Void
	internal_shared_not_void: internal_shared /= Void
	internal_docking_manager_not_void: internal_docking_manager /= Void
	internal_tool_bar_not_void: internal_tool_bar /= Void
	internal_auto_hide_indicator_not_void: internal_auto_hide_indicator /= Void

end
