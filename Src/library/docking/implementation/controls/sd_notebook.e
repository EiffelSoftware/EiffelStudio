indexing
	description:
		"[
			A EV_NOTEBOOK with a min tool bar area and a close button.
		]"
	appearance:
		"[
			  _______  _______  _______     _______________    _
			_/ tab_1 \/_tab_2_\/_tab_3_\___|_mini tool bar_|__|X|
			|                              						|
			|         selected_item          					|
			|                                					|
			----------------------------------------------------
		]"
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
		end

create
	make

feature {NONE}  -- Initlization

	make is
			-- Creation method.
		local
			l_helper: SD_COLOR_HELPER
		do
			default_create
			create internal_shared

			create selection_actions
			create tab_drag_actions

			create internal_widgets.make (1)
			create internal_tabs.make (1)

			create internal_tab_box
			create l_helper

			internal_tab_box.set_background_color (l_helper.build_color_with_lightness (background_color, internal_shared.auto_hide_panel_lightness))
			extend_vertical_box (internal_tab_box)
			disable_item_expand (internal_tab_box)

			create internal_cell
			extend_vertical_box (internal_cell)
		end

feature -- Command

	set_item_text (a_widget: EV_WIDGET; a_text: STRING) is
			-- Assign `a_text' to label of `an_item'.
		require
			has: has (a_widget)
			a_text_not_void: a_text /= Void
		do
			internal_widgets.search (a_widget)
			internal_tabs.go_i_th (internal_widgets.index)
			internal_tabs.item.set_text (a_text)
		ensure
			set:
		end

	set_item_pixmap (a_widget: EV_WIDGET; a_pixmap: EV_PIXMAP) is
			--
		require
			has: has (a_widget)
			a_pixmap_not_void: a_pixmap /= Void
		do
			internal_widgets.search (a_widget)
			internal_tabs.go_i_th (internal_widgets.index)
			internal_tabs.item.set_pixmap (a_pixmap)
		ensure
			set:
		end

	select_item (a_widget: EV_WIDGET) is
			-- Select `a_widget' and show it.
		require
			has: has (a_widget)
		do
			if selected_item /= a_widget then
				if a_widget.parent /= Void then
					a_widget.parent.prune (a_widget)
				end
				internal_cell.replace (a_widget)
			end
		ensure
			selectd: selected_item = a_widget
		end

	extend (a_widget: EV_WIDGET) is
			-- Extend `a_widget'.
		require
			a_widget_not_void: a_widget /= Void
			not_has: not has (a_widget)
		local
			l_tab: SD_NOTEBOOK_TAB
		do
			internal_widgets.extend (a_widget)
			create l_tab.make
			internal_tabs.extend (l_tab)
			l_tab.select_actions.extend (agent on_tab_selected (l_tab))
			l_tab.drag_actions.extend (agent on_tab_dragging (?, ?, ?, ?, ?, ?, ?, l_tab))
			internal_tab_box.extend (l_tab)
			internal_tab_box.disable_item_expand (l_tab)
			select_item (a_widget)
		end

	prune (a_widget: EV_WIDGET) is
			-- Prune `a_widget'.
		require
			has: has (a_widget)
		do
			internal_widgets.search (a_widget)
			internal_tabs.go_i_th (selected_item_index)
			internal_tabs.remove
			-- FIXTI: Should prune l_tab select and dragging actions here? Will it automatic collected?
			internal_widgets.start
			internal_widgets.prune (a_widget)
		ensure
			pruned: not has (a_widget)
		end
	
	set_tab_position (a_position: INTEGER) is
			-- Set tab position base on `a_position' which is one of top_top, top_bottom. See at bottom of class.
		require
			a_position_valid: a_position = tab_top or a_position = tab_bottom
		do
			inspect
				a_position
			when tab_top then
				search (internal_tab_box)
				if index /= 1 then
					swap (1)
					disable_item_expand (internal_tab_box)
				end
			when tab_bottom then
				search (internal_tab_box)
				if index /= 2 then
					swap (1)
					disable_item_expand (internal_tab_box)
				end
			end
		end
		
feature -- Query

	index_of (a_widget: EV_WIDGET): INTEGER is
			-- Index of `a_widget'
		do
			Result := internal_widgets.index_of (a_widget, 1)
		end

	has (a_widget: EV_WIDGET): BOOLEAN is
			-- If Current has `a_widget'?
		do
			Result := internal_widgets.has (a_widget)
		end

	has_tab (a_tab: SD_NOTEBOOK_TAB): BOOLEAN is
			-- If Current has `a_tab'.
		do
			Result := internal_tabs.has (a_tab)
		end

	selected_item_index: INTEGER is
			-- Index of `selected_item'.
		do
			if internal_cell.readable then
				Result := internal_widgets.index_of (internal_cell.item, 1)				
			end
		end

	selected_item: EV_WIDGET is
			-- Selected item.
		do
			if internal_cell.readable then
				Result := internal_cell.item
			end
		end

	item_pixmap (a_widget: EV_WIDGET): EV_PIXMAP is
			-- `a_widget''s pixmap.
		require
			has: has (a_widget)
		do

		end

	item_text (a_widget: EV_WIDGET): STRING is
			-- `a_widget''s pixmap.
		require
			has: has (a_widget)
		do

		end

	selection_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Selection actions.
	
	tab_drag_actions: ACTION_SEQUENCE [ TUPLE [EV_WIDGET, INTEGER, INTEGER, INTEGER, INTEGER]]
			-- Tab drag actions. In tuple, 1st is dragged tab, 2nd is x, 3rd is y, 4th is screen_x, 5th is screen_y.

feature {NONE}  -- Implementation
	
	on_tab_dragging (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER; a_tab: SD_NOTEBOOK_TAB) is
			-- Handle tab dragging.
		do
			tab_drag_actions.call ([widget_by_tab (a_tab), a_x, a_y, a_screen_x, a_screen_y])
		end
		
	on_tab_selected (a_tab: SD_NOTEBOOK_TAB) is
			-- Handle notebook tab selected.
		do
			select_item (widget_by_tab (a_tab))
			disable_all_tab_selection
			a_tab.set_selected (True)
			selection_actions.call ([])
		end

	widget_by_tab (a_tab: SD_NOTEBOOK_TAB): EV_WIDGET is
			-- Widget which represent `a_tab'.
		require
			has: has_tab (a_tab)
		do
			internal_tabs.start
			internal_tabs.search (a_tab)
			Result := internal_widgets.i_th (internal_tabs.index)
		ensure
			not_void: Result /= Void
		end

	disable_all_tab_selection is
			-- Disable all tabs selection.
		do
			from
				internal_tabs.start
			until
				internal_tabs.after
			loop
				internal_tabs.item.set_selected (False)
				internal_tabs.forth
			end
		end

	internal_widgets: ARRAYED_LIST [EV_WIDGET]
			-- All widgets in Current.

	internal_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- All tabs in Current.

	internal_tab_box: EV_HORIZONTAL_BOX
			-- Horizontal box which hold tabs and mini tool bar and close buttons..

	internal_cell: EV_CELL
			-- Cell which hold notebook selected content.

	internal_shared: SD_SHARED
			-- All singletons.

feature -- Emumeration
	
	tab_top: INTEGER is 1
			-- Tab shown at top.
	tab_bottom: INTEGER is 2
			-- Tab shown at bottom.
		
invariant

	tab_drag_actions_not_void: tab_drag_actions /= Void
	internal_widgets_not_void: internal_widgets /= Void
	internal_tabs_no_void: internal_tabs /= Void
	internal_widgets_internal_tabs_count_equal: internal_tabs.count = internal_widgets.count

end
