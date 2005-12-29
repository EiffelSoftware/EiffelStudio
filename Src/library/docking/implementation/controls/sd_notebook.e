indexing
	description: "A EV_NOTEBOOK with it's own tabs, not use native Windows tab control."
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
			has as has_vertical_box
		redefine
			destroy
		end

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		local
			l_helper: SD_COLOR_HELPER
		do
			default_create
			create internal_shared
			internal_docking_manager := a_docking_manager

			create selection_actions
			create tab_double_click_actions
			create tab_drag_actions

			create internal_contents.make (1)
			create internal_tabs.make (1)

			create internal_tab_box.make (Current, internal_docking_manager)
			create l_helper

			internal_tab_box.set_background_color (l_helper.build_color_with_lightness (background_color, internal_shared.auto_hide_panel_lightness))
			extend_vertical_box (internal_tab_box)
			disable_item_expand (internal_tab_box)

			create {EV_HORIZONTAL_BOX} internal_border_box
			internal_border_box.set_border_width (internal_shared.focuse_border_width)
			extend_vertical_box (internal_border_box)

			create internal_cell
			internal_border_box.extend (internal_cell)

			pointer_motion_actions.extend (agent on_pointer_motion)
			pointer_button_release_actions.extend (agent on_pointer_release)
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Command

	set_focus_color (a_focus: BOOLEAN) is
			-- Set border focus color base on `a_focus'.
		do
			if a_focus then
				internal_border_box.set_background_color (internal_shared.focused_color)
			else
				internal_border_box.set_background_color (internal_shared.non_focused_color)
			end
		end

	set_item_text (a_content: SD_CONTENT; a_text: STRING) is
			-- Assign `a_text' to label of `an_item'.
		require
			has: has (a_content)
			a_content_not_void: a_content /= Void
		do
			internal_contents.start
			internal_contents.search (a_content)
			internal_tabs.go_i_th (internal_contents.index)
			internal_tabs.item.set_text (a_text)
		ensure
			set:
		end

	set_item_pixmap (a_content: SD_CONTENT; a_pixmap: EV_PIXMAP) is
			--
		require
			has: has (a_content)
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_contents.start
			internal_contents.search (a_content)
			internal_tabs.go_i_th (internal_contents.index)
			internal_tabs.item.set_pixmap (a_pixmap)
		ensure
			set:
		end

	select_item (a_content: SD_CONTENT) is
			-- Select `a_widget' and show it.
		require
			has: has (a_content)
		do
			if selected_item /= a_content then
				if a_content.user_widget.parent /= Void then
					a_content.user_widget.parent.prune (a_content.user_widget)
				end
				internal_cell.replace (a_content.user_widget)

			end
			notify_tab (tab_by_content (a_content))
			internal_tab_box.resize_tabs (internal_tab_box.width)
--			selection_actions.call ([])
		ensure
			selectd: selected_item = a_content
		end

	extend (a_content: SD_CONTENT) is
			-- Extend `a_content'.
		require
			a_content_not_void: a_content /= Void
			not_has: not has (a_content)
		local
			l_tab: SD_NOTEBOOK_TAB
		do
			internal_contents.extend (a_content)
			create l_tab.make
			internal_tabs.extend (l_tab)
			l_tab.set_drop_actions (a_content.drop_actions)
			l_tab.select_actions.extend (agent on_tab_selected (l_tab))
			l_tab.drag_actions.extend (agent on_tab_dragging (?, ?, ?, ?, ?, ?, ?, l_tab))
			internal_tab_box.extend (l_tab)
			internal_tab_box.disable_item_expand (l_tab)
			select_item (a_content)
		end

	prune (a_content: SD_CONTENT) is
			-- Prune `a_widget'.
		require
			has: has (a_content)
		do
			internal_contents.start
			internal_contents.search (a_content)
			internal_tabs.go_i_th (internal_contents.index)
			internal_tabs.item.destroy
			internal_tabs.remove

			internal_contents.start
			internal_contents.prune (a_content)

			if internal_contents.after then
				internal_contents.back
			end

			select_item (internal_contents.item)
			selection_actions.call ([])
		ensure
			pruned: not has (a_content)
		end

	set_tab_position (a_position: INTEGER) is
			-- Set tab position base on `a_position' which is one of top_top, top_bottom. See at bottom of class.
		require
			a_position_valid: a_position = tab_top or a_position = tab_bottom
		do
			start
			search (internal_tab_box)
			inspect
				a_position
			when tab_top then
				if index /= 1 then
					swap (1)
					disable_item_expand (internal_tab_box)
				end
			when tab_bottom then
				if index /= 2 then
					swap (2)
					disable_item_expand (internal_tab_box)
				end
			end
		end

	destroy is
			-- Redefine.
		do
			from
				internal_tabs.start
			until
				internal_tabs.after
			loop
				internal_tabs.item.destroy
				internal_tabs.forth
			end
			Precursor {EV_VERTICAL_BOX}
		end

	on_resize (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle resize actions.
		do
			internal_tab_box.on_resize (a_x, a_y, a_width, a_height)
		end

feature -- Query

	index_of (a_content: SD_CONTENT): INTEGER is
			-- Index of `a_widget'
		do
			Result := internal_contents.index_of (a_content, 1)
		end

	has (a_content: SD_CONTENT): BOOLEAN is
			-- If Current has `a_widget'?
		do
			Result := internal_contents.has (a_content)
		end

	has_tab (a_tab: SD_NOTEBOOK_TAB): BOOLEAN is
			-- If Current has `a_tab'.
		do
			Result := internal_tabs.has (a_tab)
		end

	selected_item_index: INTEGER is
			-- Index of `selected_item'.
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

	selected_item: SD_CONTENT is
			-- Selected item.
		local
			l_index: INTEGER
		do
			l_index := selected_item_index
			if internal_cell.readable and l_index /= 0 then
				Result := internal_contents.i_th (l_index)
			end
		end

	item_pixmap (a_content: SD_CONTENT): EV_PIXMAP is
			-- `a_content''s pixmap.
		require
			has: has (a_content)
		do
			internal_contents.start
			internal_contents.search (a_content)
			internal_tabs.go_i_th (internal_contents.index)
			Result := internal_tabs.item.pixmap
		end

	item_text (a_content: SD_CONTENT): STRING is
			-- `a_content''s pixmap.
		require
			has: has (a_content)
		do
			internal_contents.start
			internal_contents.search (a_content)
			internal_tabs.go_i_th (internal_contents.index)
			Result := internal_tabs.item.text
		end

	content_by_tab (a_tab: SD_NOTEBOOK_TAB): SD_CONTENT is
			-- Widget which associate with `a_tab'.
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
			-- Selection actions.

	tab_double_click_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Tab double click actions.

	tab_drag_actions: ACTION_SEQUENCE [ TUPLE [SD_CONTENT, INTEGER, INTEGER, INTEGER, INTEGER]]
			-- Tab drag actions. In tuple, 1st is dragged tab, 2nd is x, 3rd is y, 4th is screen_x, 5th is screen_y.

feature {NONE}  -- Implementation

	on_tab_dragging (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER; a_tab: SD_NOTEBOOK_TAB) is
			-- Handle tab dragging.

		do
			dragging_tab := a_tab
			enable_capture

			debug ("larry")
				print ("%NSD_NOTEBOOK on_tab_dragging enable capture")
			end
		end

	dragging_tab: SD_NOTEBOOK_TAB
			-- Tab which is dragging.

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release.
		do
			dragging_tab := Void
			disable_capture


			debug ("larry")
				print ("%NSD_NOTEBOOK on_pointer_release disable capture    dragging_tab := Void? " + (dragging_tab = Void).out)
			end
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer motion.
		local
			l_in_tabs: BOOLEAN
			l_target_tab: SD_NOTEBOOK_TAB
		do
			from
				internal_tabs.start
			until
				internal_tabs.after or l_in_tabs
			loop
				if internal_tabs.item /= dragging_tab then
					if tab_has_x_y (internal_tabs.item, a_screen_x, a_screen_y)  then
						l_in_tabs := True
						internal_tab_box.start
						internal_tab_box.search (internal_tabs.item)
						l_target_tab := internal_tabs.item
						internal_docking_manager.command.lock_update (Current, False)
						internal_tab_box.swap (internal_tab_box.index_of (dragging_tab, 1))
						internal_tab_box.disable_item_expand (dragging_tab)
						internal_tab_box.disable_item_expand (l_target_tab)
						on_resize (0, 0, width, height)
						internal_docking_manager.command.unlock_update
					end
				elseif tab_has_x_y (dragging_tab, a_screen_x, a_screen_y) then
					l_in_tabs := True
				end
				internal_tabs.forth
			end

			debug ("larry")
				print ("%NSD_NOTEBOOK on_pointer_motion l_in_tabs ? " + l_in_tabs.out)
			end

			if not l_in_tabs then
				disable_capture
				tab_drag_actions.call ([content_by_tab (dragging_tab), a_x, a_y, a_screen_x, a_screen_y])
			end
		end

	on_tab_selected (a_tab: SD_NOTEBOOK_TAB) is
			-- Handle notebook tab selected.
		do
			select_item (content_by_tab (a_tab))
			notify_tab (a_tab)
			selection_actions.call ([])
		end

	tab_by_content (a_content: SD_CONTENT): SD_NOTEBOOK_TAB is
			-- Tab which associate with `a_widget'.
		require
			has: has (a_content)
		do
			internal_contents.start
			internal_contents.search (a_content)
			Result := internal_tabs.i_th (internal_contents.index)
		ensure
			not_void: Result /= Void
		end

	notify_tab (a_except: SD_NOTEBOOK_TAB) is
			-- Disable all tabs selection except a_except. Select a_except.
		do
			from
				internal_tabs.start
			until
				internal_tabs.after
			loop
				if internal_tabs.item = a_except then
					internal_tabs.item.set_selected (True)
				else
					internal_tabs.item.set_selected (False)
				end

				internal_tabs.forth
			end
		end

	tab_has_x_y (a_tab: SD_NOTEBOOK_TAB; a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If `a_tab' has `a_screen_x', `a_screen_y'?
		local
			l_rect: EV_RECTANGLE
		do
			create l_rect.make (a_tab.screen_x, a_tab.screen_y, a_tab.width, a_tab.height)
			Result := l_rect.has_x_y (a_screen_x, a_screen_y)
		end

	internal_contents: ARRAYED_LIST [SD_CONTENT]
			-- All widgets in Current.

	internal_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- All tabs in Current.

	internal_tab_box: SD_NOTEBOOK_TAB_AREA
			-- Horizontal box which hold tabs and mini tool bar and close buttons..

	internal_cell: EV_CELL
			-- Cell which hold notebook selected content.

	internal_border_box: EV_BOX
			-- Box used for highlight border.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

feature -- Emumeration

	tab_top: INTEGER is 1
			-- Tab shown at top.
	tab_bottom: INTEGER is 2
			-- Tab shown at bottom.

invariant

	tab_drag_actions_not_void: tab_drag_actions /= Void
	internal_contents_not_void: internal_contents /= Void
	internal_tabs_no_void: internal_tabs /= Void
	internal_contents_internal_tabs_count_equal: internal_tabs.count = internal_contents.count

end
