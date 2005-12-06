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
	author: "$Author$"
	id: "$Id$"
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
		do
			default_create
			create selection_actions

			create internal_widgets.make (1)
			create internal_tabs.make (1)

			create internal_horizontal_box
			extend_vertical_box (internal_horizontal_box)
			disable_item_expand (internal_horizontal_box)

			create internal_cell
			extend_vertical_box (internal_cell)
		end

feature -- Command

	set_item_text (a_widget: EV_WIDGET; a_text: STRING) is
			-- Assign `a_text' to label of `an_item'.
		do

		end

	set_item_pixmap (a_widget: EV_WIDGET; a_pixmap: EV_PIXMAP) is
			--
		do

		end

	select_item (a_widget: EV_WIDGET) is
			-- Select `a_widget' and show it.
		require
			has: has (a_widget)
		do
			internal_cell.replace (a_widget)
		end

	extend (a_widget: EV_WIDGET) is
			-- Extend `a_widget'.
		require
			a_widget_not_void: a_widget /= Void
			not_has: not has (a_widget)
		do
			internal_widgets.extend (a_widget)
			select_item (a_widget)
		end

	prune (a_widget: EV_WIDGET) is
			-- Prune `a_widget'.
		do
			internal_widgets.start
			internal_widgets.prune (a_widget)
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

	selected_item_index: INTEGER is
			-- Index of `selected_item'.
		do
			Result := internal_widgets.index_of (internal_cell.item, 1)
		end

	selected_item: EV_WIDGET is
			-- Selected item.
		do
			Result := internal_cell.item
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

feature {NONE}  -- Implementation

	internal_widgets: ARRAYED_LIST [EV_WIDGET]
			-- All widgets in Current.

	internal_tabs: ARRAYED_LIST [SD_NOTEBOOK_TAB]
			-- All tabs in Current.

	internal_horizontal_box: EV_HORIZONTAL_BOX
			-- Horizontal box which hold tabs and mini tool bar and close buttons..

	internal_cell: EV_CELL
			-- Cell which hold notebook selected content.

invariant

	internal_widgets_not_void: internal_widgets /= Void

end
