indexing
	description: "LISTVIEW class of the WEL example : List_view."
	status: "See notice at end of class."
	date: ""
	revision: ""

class
	LISTVIEW

inherit
	WEL_LIST_VIEW
		redefine
			make,
 			on_lvn_begindrag,
 			on_lvn_beginlabeledit,
 			on_lvn_beginrdrag,
			on_lvn_columnclick,
			on_lvn_deleteallitems,
 			on_lvn_deleteitem,
 			on_lvn_endlabeledit,
 			on_lvn_getdispinfo,
 			on_lvn_insertitem,
			on_lvn_itemchanged,
 			on_lvn_itemchanging,
			on_lvn_keydown,
 			on_lvn_setdispinfo
		end

	WEL_LVCF_CONSTANTS
		export
			{NONE} all
		end

	WEL_TVIF_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height,
				an_id: INTEGER) is
			-- Create the tree and some items in it.
		local
 			column: WEL_LIST_VIEW_COLUMN
 			litem, litem2: WEL_LIST_VIEW_ITEM
		do
 			{WEL_LIST_VIEW} Precursor (a_parent, a_x, a_y, a_width, a_height, an_id)

			-- We add the columns
			!! column.make
			column.set_cx (80)
			column.set_fmt (Lvcfmt_left)
			column.set_text ("Left")
			append_column (column)
			!! column.make
			column.set_cx (80)
			column.set_fmt (Lvcfmt_center)
			column.set_text ("Center")
			append_column (column)
			!! column.make
			column.set_cx (80)
			column.set_fmt (Lvcfmt_right)
			column.set_text ("Right")
			append_column (column)
			!! column.make
			column.set_cx (80)
			column.set_fmt (Lvcfmt_justifymask)
			column.set_text ("Justify")
			append_column (column)

			-- We add the items in the first row
			!! litem.make
			litem.set_text ("Item 1 : 0,0")
			insert_item (litem)
			set_cell_text (1, 0, "1,0")
			set_cell_text (2, 0, "2,0")
			set_cell_text (3, 0, "3,0")

			-- We add the items in the second row
			!! litem.make
			litem.set_text ("Item 2 : 0,1")
			litem.set_iitem (1)
			insert_item (litem)
			set_cell_text (1, 1, "1,1")
			set_cell_text (2, 1, "2,1")
			set_cell_text (3, 1, "3,1")

			-- We add the items in the third row
			!! litem.make
			litem.set_text ("Item 3 : 0,2")
			litem.set_iitem (2)
			insert_item (litem)
			set_cell_text (1, 2, "1,2")
			set_cell_text (2, 2, "2,2")
			set_cell_text (3, 2, "3,2")

			-- We add the items in the forth row
			!! litem.make
			litem.set_iitem (3)
			litem.set_text ("Item 4 : 0,3")
			insert_item (litem)
			set_cell_text (1, 3, "1,3")
			set_cell_text (2, 3, "2,3")
			set_cell_text (3, 3, "3,3")
		end

feature -- Access

	item_output: WEL_STATIC

	mess_output: WEL_SINGLE_SELECTION_LIST_BOX

feature -- Element change

	set_item_output (static: WEL_STATIC) is
			-- Make `static' the new output.
		do
			item_output := static
		end

	set_mess_output (list: WEL_SINGLE_SELECTION_LIST_BOX) is
			-- Make `static' the new output.
		do
			mess_output := list
		end

	add_mess_output (str: STRING) is
			-- Add a message to the output.
		do
			if mess_output /= Void then
				mess_output.add_string (str)
				mess_output.set_top_index (mess_output.count - 1)
			end
		end

feature -- Notifications

	on_lvn_begindrag (info: WEL_NM_LIST_VIEW) is
			-- A drag-and-drop operation involving the left mouse
			-- button is being initiated.
		do
			add_mess_output ("Begin dragging")
		end

	on_lvn_beginlabeledit (info: WEL_LIST_VIEW_ITEM) is
			-- A label editing for an item has started.
		do
			add_mess_output ("Begin editing label")
		end

	on_lvn_beginrdrag (info: WEL_NM_LIST_VIEW) is
			-- A drag-and-drop operation involving the right mouse
			-- button is being initiated.
		do
			add_mess_output ("Begin right dragging")
		end

	on_lvn_columnclick (info: WEL_NM_LIST_VIEW) is
			-- A column was tapped.
		do
			add_mess_output ("Column clicked")
		end

	on_lvn_deleteallitems (info: WEL_NM_LIST_VIEW) is
			-- All the items were deleted.
		do
			add_mess_output ("All items deleted")
		end

	on_lvn_deleteitem (info: WEL_NM_LIST_VIEW) is
			-- An item was deleted.
		do
			add_mess_output ("One item deleted")
		end

	on_lvn_endlabeledit (info: WEL_LIST_VIEW_ITEM) is
			-- A label editing for an item has ended.
		do
			add_mess_output ("End editing label")
		end

	on_lvn_getdispinfo (info: WEL_LIST_VIEW_ITEM) is
			-- It is a request for the parent window to
			-- provide information needed to display or
			-- sort a list view item.
		do
			add_mess_output ("Get disp info")
		end

	on_lvn_insertitem (info: WEL_NM_LIST_VIEW) is
			-- A new item was inserted.
		do
			add_mess_output ("Insert item")
		end

	on_lvn_itemchanged (info: WEL_NM_LIST_VIEW) is
			-- An item has changed.
		local
			lvitem: WEL_LIST_VIEW_ITEM
		do
			add_mess_output ("Item changed")
			if flag_set (info.unewstate, Lvis_selected) and 
					not flag_set (info.uoldstate, Lvis_selected) then
				lvitem := get_item (info.iitem, info.isubitem)
				item_output.set_text (lvitem.text)
			end
		end

	on_lvn_itemchanging (info: WEL_NM_LIST_VIEW) is
			-- An item is changing
		do
			add_mess_output ("Item changing")
		end

	on_lvn_keydown (virtual_key: INTEGER) is
			-- A key has been pressed.
		do
			add_mess_output ("Key pressed :")
			item_output.set_text (virtual_key.out)
		end

	on_lvn_setdispinfo (info: WEL_LIST_VIEW_ITEM) is
			-- The list must update the information it maintains
			-- for an item.
		do
			add_mess_output ("Set disp info")
		end

feature -- Changing the style

	current_type: INTEGER
			-- Current style of the list.

	change_style is
			-- Change the style of the listview.
		local
			value: INTEGER
		do
			value := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_border + Ws_clipchildren
				+ Lvs_showselalways
			inspect current_type
			when 0 then
				set_style (value + Lvs_list)
				current_type := current_type + 1
			when 1 then
				set_style (value + Lvs_icon)
				current_type := current_type + 1
			when 2 then
				set_style (value + Lvs_smallicon)
				current_type := current_type + 1
			when 3 then
				set_style (value + Lvs_report)
				current_type := 0
			end 
		end

end -- class LISTVIEW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1995-1997, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------
