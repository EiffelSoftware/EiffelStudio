note
	description: "A EV_NOTEBOOK with it's own tabs, not use native Windows tab control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK

inherit
	EV_VERTICAL_BOX
		rename
			extend as extend_vertical_box,
			prune_all as prune_all_vertical_box,
			prune as prune_vertical_box,
			index_of as index_of_vertical_box,
			has as has_vertical_box,
			replace as replace_box
		redefine
			destroy
		end

	SD_WIDGETS_LISTS
		undefine
			default_create,
			is_equal,
			copy
		end

	SD_ACCESS
		undefine
			default_create,
			is_equal,
			copy
		end

	SD_DOCKING_MANAGER_HOLDER
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER)
			-- Creation method
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		local
			l_helper: SD_COLOR_HELPER
		do

			create internal_shared
			set_docking_manager (a_docking_manager)

			create selection_actions
			create tab_double_click_actions
			create tab_drag_actions

			create internal_contents.make (1)
			create internal_tabs.make (1)

			create internal_tab_box.make (docking_manager)
			create l_helper

			create internal_border_for_tab_area.make
			create {EV_HORIZONTAL_BOX} internal_border_box
			create internal_cell
				-- Make sure tab bar shown when not enough height
				-- See bug#16786
			internal_cell.set_minimum_height (0)

			default_create

			internal_tab_box.right_side_double_click_actions.extend (agent on_tab_box_right_double_click)

			internal_border_for_tab_area.set_border_width (internal_shared.border_width)
			internal_border_for_tab_area.set_border_color (internal_shared.border_color)
			internal_border_for_tab_area.set_border_style ({SD_ENUMERATION}.top)
			extend_vertical_box (internal_border_for_tab_area)
			set_minimum_width ({SD_SHARED}.Notebook_minimum_width)

			update_size

			internal_border_for_tab_area.extend (internal_tab_box)
			internal_tab_box.set_gap (False)

			internal_border_box.set_border_width (internal_shared.focuse_border_width)
			extend_vertical_box (internal_border_box)

			internal_border_box.extend (internal_cell)

			pointer_motion_actions.extend (agent on_pointer_motion)
			pointer_button_release_actions.extend (agent on_pointer_release)

			add_notebook (Current)
			internal_tab_box.set_notebook (Current)
		ensure
			set: docking_manager = a_docking_manager
			set: internal_tab_box.notebook = Current
		end

feature -- Command

	set_focus_color (a_focus: BOOLEAN)
			-- Set border focus color base on `a_focus'
		do
			if a_focus then
				internal_border_box.set_background_color (internal_shared.focused_color)
				if attached selected_item as l_item then
					notify_tab (tab_by_content (l_item), True)
				end
			else
				internal_border_box.set_background_color (internal_shared.border_color)
				if attached selected_item as l_item then
					notify_tab (tab_by_content (l_item), False)
				end
			end
		end

	set_tab_active_color (a_focus: BOOLEAN)
			-- Set tab active selection color to focus color or non-focus color
		do
			if attached selected_item as l_item then
				tab_by_content (l_item).set_selection_color (a_focus)
			end
		end

	set_item_text (a_content: SD_CONTENT; a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to label of `an_item'
		require
			has: has (a_content)
			a_content_not_void: a_content /= Void
		do
			internal_contents.start
			internal_contents.search (a_content)
			internal_tabs.go_i_th (internal_contents.index)
			internal_tabs.item.set_text (a_text)
			internal_tab_box.tab_box.redraw
			-- The text let tab size changed, so it need resize
			internal_tab_box.resize_tabs (internal_tab_box.tab_box_predered_width)
		ensure
			set: a_text /= Void implies item_text (a_content).is_equal (a_text.as_string_32)
		end

	set_item_pixmap (a_content: SD_CONTENT; a_pixmap: EV_PIXMAP)
			-- Set tab which represent `a_content''s pixmap to `a_pixmap'
		require
			has: has (a_content)
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_contents.start
			internal_contents.search (a_content)
			internal_tabs.go_i_th (internal_contents.index)
			internal_tabs.item.set_pixmap (a_pixmap)
			internal_tab_box.tab_box.redraw
		ensure
			set:
		end

	select_item (a_content: SD_CONTENT; a_focus: BOOLEAN)
			-- Select `a_widget' and show it
		require
			has: has (a_content)
		do
			if selected_item /= a_content then
				docking_manager.command.lock_update (Current, False)
				if attached a_content.user_widget.parent as l_parent then
					l_parent.prune (a_content.user_widget)
				end
				internal_cell.replace (a_content.user_widget)
				docking_manager.command.unlock_update
			end
			notify_tab (tab_by_content (a_content), a_focus)
			internal_tab_box.resize_tabs (internal_tab_box.tab_box_predered_width)

			if not docking_manager.property.is_opening_config then
				a_content.show_actions.call (Void)
			end
		ensure
			selected: selected_item = a_content
		end

	extend (a_content: SD_CONTENT)
			-- Extend `a_content'
		require
			a_content_not_void: a_content /= Void
			not_has: not has (a_content)
		local
			l_tab: SD_NOTEBOOK_TAB
		do
			internal_contents.extend (a_content)
			l_tab := tab_factory_method (a_content)
			internal_tabs.extend (l_tab)

			internal_tab_box.extend (l_tab)

			select_item (a_content, True)
		end

	extend_contents (a_contents: LIST [SD_CONTENT])
			-- Extend `a_contents'
			-- This feature is faster than extend content one by one.
		require
			not_void: a_contents /= Void
		local
			l_tab: SD_NOTEBOOK_TAB
			l_new_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
		do
			from
				a_contents.start
				create l_new_tabs.make (a_contents.count)
			until
				a_contents.after
			loop
				if not has (a_contents.item) then
					internal_contents.extend (a_contents.item)
					l_tab := tab_factory_method (a_contents.item)
					internal_tabs.extend (l_tab)
					l_new_tabs.extend (l_tab)

					if a_contents.islast then
						internal_tab_box.extend_tabs (l_new_tabs)
						select_item (a_contents.item, True)
					end
				end
				a_contents.forth
			end
		end

	prune (a_content: SD_CONTENT; a_focus: BOOLEAN)
			-- Prune `a_widget'
		require
			has: has (a_content)
		local
			l_orignal_selected: detachable SD_CONTENT
			l_orignal_index: INTEGER
		do
			l_orignal_selected := selected_item
			l_orignal_index := selected_item_index
			internal_contents.start
			internal_contents.search (a_content)
			internal_tabs.go_i_th (internal_contents.index)
			if internal_tabs.item /= Void then
				internal_tabs.item.destroy
			end
			internal_tabs.remove

			internal_contents.start
			internal_contents.prune (a_content)

			if l_orignal_selected = a_content then
				-- We are closing a selected content, we should select the one at orignal index
				if not internal_contents.valid_index (l_orignal_index) then
					internal_contents.back
				else
					internal_contents.go_i_th (l_orignal_index)
				end

				select_item (internal_contents.item, a_focus)

				if a_focus then
					selection_actions.call (Void)
				end
			end
			internal_tab_box.resize_tabs (internal_tab_box.tab_box_predered_width)

		ensure
			pruned: not has (a_content)
		end

	replace (a_content: SD_CONTENT)
			-- Replace `a_content''s old `user_widget' with new one
		require
			has: has (a_content)
		do
			-- Because user changed `user_widget' so we can't find select_item
			-- This means if `selected_item_index' equal 0 then we should replace `internal_cell'.
			if selected_item_index = 0 then
				internal_cell.replace (a_content.user_widget)
			end
		end

	set_tab_position (a_position: INTEGER)
			-- Set tab position base on `a_position' which is one of top_top, top_bottom. See bottom of class
		require
			a_position_valid: a_position = tab_top or a_position = tab_bottom
		do
			start
			search (internal_border_for_tab_area)
			inspect
				a_position
			when tab_top then
				if index /= 1 then
					swap (1)
					disable_item_expand (internal_border_for_tab_area)
				end
			when tab_bottom then
				if index /= 2 then
					swap (2)
					disable_item_expand (internal_border_for_tab_area)
				end
			end
		end

	destroy
			-- <Precursor>
		do
			prune_notebook (Current)
			from
				internal_tabs.start
			until
				internal_tabs.after
			loop
				internal_tabs.item.destroy
				internal_tabs.forth
			end
			clear_docking_manager
			Precursor {EV_VERTICAL_BOX}
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Handle resize actions
		do
			internal_tab_box.on_resize (a_x, a_y, a_width, a_height)
		end

	set_content_position (a_content: SD_CONTENT; a_index: INTEGER)
			-- Position `a_content' at `a_index'
		require
			has: has (a_content)
			valid: a_index > 0 and a_index <= contents.count
		local
			l_tab: SD_NOTEBOOK_TAB
		do
			debug ("docking")
				print ({STRING_32} "%NSD_NOTEBOOK set_content_position a_content is: " + a_content.unique_title + " a_index is:" + a_index.out )
			end
			if contents.i_th (a_index) /= a_content then
				l_tab := tab_by_content (a_content)
				internal_tab_box.set_tab_position (l_tab, a_index)

				internal_contents.start
				internal_contents.prune (a_content)
				internal_contents.go_i_th (a_index)
				internal_contents.put_left (a_content)

				internal_tabs.start
				internal_tabs.prune (l_tab)
				internal_tabs.go_i_th (a_index)
				internal_tabs.put_left (l_tab)

			end
		ensure
			set: contents.i_th (a_index) = a_content
		end

	disable_widget_expand
			-- Disable client programmers' widget expand
		do
			disable_item_expand (internal_border_box)
		end

	enable_widget_expand
			-- Enable client programmers' widget expand
		do
			enable_item_expand (internal_border_box)
		end

	update_size
			-- Update minimum height base on font size
		do
			-- set_minimum_height is not needed on Windows.
			-- But on Linux, if we don't set it, docking (not tabbed) zone minimum height will be 1 when zone is minimized.
			set_minimum_height (internal_shared.notebook_tab_height + 3)
		end

	update_size_and_font
			-- Update tabs, tab box, tab area's size base on font size
		local
			l_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
		do
			from
				l_tabs := internal_tab_box.all_tabs
				l_tabs.start
			until
				l_tabs.after
			loop
				l_tabs.item.set_font (internal_shared.tool_bar_font)
				l_tabs.forth
			end

			internal_tab_box.tab_box.set_font (internal_shared.tool_bar_font)
			internal_tab_box.tab_box.update_size
			internal_tab_box.update_size

			internal_tab_box.resize_tabs (internal_tab_box.width)

			update_size
		end

feature -- Query

	contents: ARRAYED_LIST [SD_CONTENT]
			-- All contents in Current
		do
			Result := internal_contents.twin
		ensure
			not_void: Result /= Void
		end

	index_of (a_content: SD_CONTENT): INTEGER
			-- Index of `a_widget'
		do
			Result := internal_contents.index_of (a_content, 1)
		end

	index_of_tab (a_tab: SD_NOTEBOOK_TAB): INTEGER
			-- Index of `a_tab'
		require
			has: has_tab (a_tab)
		do
			Result := internal_tab_box.index_of (a_tab)
		end

	tab_by_content (a_content: SD_CONTENT): SD_NOTEBOOK_TAB
			-- Tab which associate with `a_content'
		require
			has: has (a_content)
		do
			internal_contents.start
			internal_contents.search (a_content)
			Result := internal_tabs.i_th (internal_contents.index)
		ensure
			not_void: Result /= Void
		end

	has (a_content: SD_CONTENT): BOOLEAN
			-- If Current has `a_content'?
		do
			Result := internal_contents.has (a_content)
		end

	has_tab (a_tab: SD_NOTEBOOK_TAB): BOOLEAN
			-- If Current has `a_tab'?
		do
			Result := internal_tabs.has (a_tab)
		end

	selected_item_index: INTEGER
			-- Index of `selected_item'
		local
			l_found: BOOLEAN
		do
			if internal_cell.readable then
				from
					internal_contents.start
				until
					internal_contents.after or l_found
				loop
					if internal_contents.item.user_widget = internal_cell.item then
						l_found := True
					end
					Result := Result + 1
					internal_contents.forth
				end
			end
			if not l_found then
				Result := 0
			end
		end

	selected_item: detachable SD_CONTENT
			-- Selected item
		local
			l_index: INTEGER
		do
			l_index := selected_item_index
			if internal_cell.readable and l_index /= 0 then
				Result := internal_contents.i_th (l_index)
			end
		end

	is_content_selected (a_content: SD_CONTENT): BOOLEAN
			-- If `a_content''s widget selected in notebook?
		do
			if a_content /= Void and then internal_cell.readable then
				Result := internal_cell.item = a_content.user_widget
			end
		end

	item_pixmap (a_content: SD_CONTENT): EV_PIXMAP
			-- `a_content''s pixmap
		require
			has: has (a_content)
		do
			internal_contents.start
			internal_contents.search (a_content)
			internal_tabs.go_i_th (internal_contents.index)
			Result := internal_tabs.item.pixmap
		end

	item_text (a_content: SD_CONTENT): STRING_32
			-- `a_content''s pixmap
		require
			has: has (a_content)
		do
			internal_contents.start
			internal_contents.search (a_content)
			internal_tabs.go_i_th (internal_contents.index)
			Result := internal_tabs.item.text
		end

	content_by_tab (a_tab: SD_NOTEBOOK_TAB): SD_CONTENT
			-- Widget which associate with `a_tab'
		require
			has: has_tab (a_tab)
		do
			internal_tabs.start
			internal_tabs.search (a_tab)
			Result := internal_contents.i_th (internal_tabs.index)
		ensure
			not_void: Result /= Void
		end

	selection_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Selection actions

	tab_double_click_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Tab double click actions

	tab_bar_right_blank_area_double_click_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Double click action on tab bar right blank area
		local
			l_actions: like internal_tab_bar_right_blank_area_double_click_actions
		do
			l_actions := internal_tab_bar_right_blank_area_double_click_actions
			if not attached l_actions then
				create l_actions
				internal_tab_bar_right_blank_area_double_click_actions := l_actions
			end
			Result := l_actions
		end

	tab_drag_actions: ACTION_SEQUENCE [ TUPLE [SD_CONTENT, INTEGER, INTEGER, INTEGER, INTEGER]]
			-- Tab drag actions. In tuple, 1st parameter is dragged tab, 2nd is x, 3rd is y, 4th is screen_x, 5th is screen_y

	tabs_shown: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- Tabs which is currently shown
		local
			l_tabs: like internal_tabs
		do
			create Result.make (1)
			l_tabs := internal_tabs.twin
			from
				l_tabs.start
			until
				l_tabs.after
			loop
				if l_tabs.item.is_displayed then
					Result.extend (l_tabs.item)
				end
				l_tabs.forth
			end
		end

	tab_area: EV_RECTANGLE
			-- Tab area
		do
			create Result.make (internal_tab_box.screen_x, internal_tab_box.screen_y, internal_tab_box.width, internal_tab_box.height)
		ensure
			not_void: Result /= Void
		end

feature {SD_NOTEBOOK_HIDE_TAB_DIALOG} -- Internal commands

	on_content_selected (a_content: SD_CONTENT)
			-- Handle hidden item list select actions
		require
			not_void: a_content /= Void
		local
			l_tab: SD_NOTEBOOK_TAB
		do
			l_tab := tab_by_content (a_content)

			on_tab_selected (l_tab)
		end

feature {NONE}  -- Implementation

	on_tab_dragging (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER; a_tab: SD_NOTEBOOK_TAB)
			-- Handle tab dragging

		do
			dragging_tab := a_tab
			enable_capture
			prepare_tabs_rects
			debug ("docking")
				print ("%NSD_NOTEBOOK on_tab_dragging enable capture")
			end
		end

	dragging_tab: detachable SD_NOTEBOOK_TAB
			-- Tab which is dragging

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer release
		do
			dragging_tab := Void
			disable_capture
			tabs_rects := Void

			debug ("docking")
				print ("%NSD_NOTEBOOK on_pointer_release disable capture    dragging_tab := Void? " + (dragging_tab = Void).out)
			end
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer motion
		local
			l_in_tabs: BOOLEAN
			l_index: INTEGER
		do
			-- FIXIT: This function should not be called on GTK.
			-- 		  So actually this if clause is should not needed.
			if attached dragging_tab as l_tab and attached tabs_rects as l_tab_rects then
				from
					l_tab_rects.start
				until
					l_tab_rects.after or l_in_tabs
				loop
					l_index := l_index + 1

					if l_tab_rects.item_for_iteration.has_x_y (a_screen_x, a_screen_y) then
						l_in_tabs := True

						-- Check if already swapped
						if l_index /= internal_tab_box.index_of (l_tab) then
							docking_manager.command.lock_update (Current, False)
							set_content_position (content_by_tab (l_tab), l_index)
							internal_tab_box.set_tab_position (l_tab, l_index)

							-- Is already done by on_resize
							internal_tab_box.resize_tabs (internal_tab_box.tab_box_predered_width)
							docking_manager.command.unlock_update
						end
					end

					l_tab_rects.forth
				end

				if not l_in_tabs then
					disable_capture
					tabs_rects := Void
					tab_drag_actions.call ([content_by_tab (l_tab), a_x, a_y, a_screen_x, a_screen_y])
				end
			end
		end

	on_tab_selected (a_tab: SD_NOTEBOOK_TAB)
			-- Handle notebook tab select actions
		require
			not_void: a_tab /= Void
			has: has_tab (a_tab)
		do
			select_item (content_by_tab (a_tab), True)
			notify_tab (a_tab, True)
			selection_actions.call (Void)
		end

	on_tab_box_right_double_click
			-- Handle `right_side_double_click_actions' of `internal_tab_box'
		do
			if attached internal_tab_bar_right_blank_area_double_click_actions then
				tab_bar_right_blank_area_double_click_actions.call (Void)
			end
		end

	notify_tab (a_except: SD_NOTEBOOK_TAB; a_focus: BOOLEAN)
			-- Disable all tabs selection except `a_except'. Select `a_except'
		local
			l_tab_item: SD_NOTEBOOK_TAB
		do
			from
				internal_tabs.start
			until
				internal_tabs.after
			loop
				l_tab_item := internal_tabs.item
				if l_tab_item = a_except then
					l_tab_item.set_selected (True, a_focus)
				else
					l_tab_item.set_selected (False, a_focus)
				end

				internal_tabs.forth
			end
		end

	swap_tabs_and_contents (a_tab_1, a_tab_2: SD_NOTEBOOK_TAB)
			-- Swap order of `a_tab_1' and `a_tab_2'
		require
			nor_equal: a_tab_1 /= a_tab_2
			has: internal_tabs.has (a_tab_1) and internal_tab_box.has (a_tab_1)
			has: internal_tabs.has (a_tab_2) and internal_tab_box.has (a_tab_2)
		local
			l_index_1, l_index_2: INTEGER
			l_index_1_valid, l_index_2_valid: BOOLEAN
		do
			l_index_1 := internal_tab_box.index_of (a_tab_1)
			l_index_2 := internal_tab_box.index_of (a_tab_2)
			l_index_1_valid := l_index_1 <= internal_tabs.count and l_index_1 /= 0
			l_index_1_valid := l_index_2 <= internal_tabs.count and l_index_2 /= 0
			if l_index_1_valid and l_index_2_valid then
				internal_tabs.go_i_th (l_index_1)
				internal_tabs.swap (l_index_2)

				internal_contents.go_i_th (l_index_1)
				internal_contents.swap (l_index_2)
			end
		ensure
			not_changed: old internal_contents.count = internal_contents.count
		end

	prepare_tabs_rects
			-- Create `tabs_rects' base on current tabs position
		local
			l_tabs_snapshot: like internal_tabs
			l_rect: EV_RECTANGLE
			l_tab: SD_NOTEBOOK_TAB
			l_tab_rects: like tabs_rects
		do
			if attached dragging_tab then
				from
					l_tabs_snapshot := internal_tabs.twin
					create l_tab_rects.make (l_tabs_snapshot.count)
					tabs_rects := l_tab_rects
					l_tabs_snapshot.start
				until
					l_tabs_snapshot.after
				loop
					l_tab := l_tabs_snapshot.item
					create l_rect.make (l_tab.screen_x, l_tab.screen_y, l_tab.width, l_tab.height)
					l_tab_rects.force (l_rect, l_tab)
					l_tabs_snapshot.forth
				end
			end
		end

	tab_factory_method (a_content: SD_CONTENT): SD_NOTEBOOK_TAB
			-- Factory method for SD_NOTEBOOK_TAB
		require
			not_void: a_content /= Void
		do
			create Result.make (Current, internal_tab_box.is_gap_at_top, docking_manager)
			Result.set_drop_actions (a_content.drop_actions)
			Result.select_actions.extend (agent on_tab_selected (Result))
			Result.close_actions.extend (agent (a_content.close_request_actions).call (Void))
			Result.drag_actions.extend (agent on_tab_dragging (?, ?, ?, ?, ?, ?, ?, Result))
			Result.set_tool_tip (a_content.tab_tooltip)

			Result.set_text (a_content.short_title)
			Result.set_pixmap (a_content.pixmap)
		ensure
			not_void: Result /= Void
		end

	tabs_rects: detachable HASH_TABLE [EV_RECTANGLE, SD_NOTEBOOK_TAB]
			-- We remember orignal tab position each time before start dragging, otherwise
			-- it will cause tab jumping if a tab is very narrow and a tab is very wide.

	internal_contents: ARRAYED_LIST [SD_CONTENT]
			-- All widgets in Current

	internal_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- All tabs in Current

	internal_tab_box: SD_NOTEBOOK_TAB_AREA
			-- Horizontal box which hold tabs and mini tool bar and close buttons

	internal_cell: EV_CELL
			-- Cell which hold notebook selected content

	internal_border_box: EV_BOX
			-- Box used for highlight border

	internal_shared: SD_SHARED
			-- All singletons

	internal_border_for_tab_area: SD_CELL_WITH_BORDER
			-- Border box

	internal_tab_bar_right_blank_area_double_click_actions: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Double click action on tab bar right blank area

feature -- Emumeration

	tab_top: INTEGER = 1
			-- Tab shown at top

	tab_bottom: INTEGER = 2
			-- Tab shown at bottom

invariant

	internal_border_for_tab_area_not_void: internal_border_for_tab_area /= Void
	tab_drag_actions_not_void: tab_drag_actions /= Void
	internal_contents_not_void: internal_contents /= Void
	internal_tabs_no_void: internal_tabs /= Void
	internal_contents_internal_tabs_count_equal: internal_tabs.count = internal_contents.count

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
