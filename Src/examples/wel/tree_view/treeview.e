indexing
	description	: "TREEVIEW class of the WEL example : Tree_view."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	status		: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	TREEVIEW

inherit
	APPLICATION_IDS
	WEL_COLOR_CONSTANTS
	WEL_TREE_VIEW
		redefine
			make,
			on_tvn_begindrag,
			on_tvn_beginlabeledit,
			on_tvn_beginrdrag,
			on_tvn_deleteitem,
			on_tvn_endlabeledit,
			on_tvn_getdispinfo,
			on_tvn_itemexpanded,
			on_tvn_itemexpanding,
			on_tvn_keydown,
			on_tvn_selchanged,
			on_tvn_selchanging,
			on_tvn_setdispinfo
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_WINDOW; a_x, a_y, a_width, a_height, an_id: INTEGER) is
			-- Create the tree and some items in it.
		local
			tvis1, tvis2, tvis3			: WEL_TREE_VIEW_INSERT_STRUCT
			tv_item1, tv_item2, tv_item3: WEL_TREE_VIEW_ITEM
			handle						: POINTER
			root_h						: POINTER
			image_list					: WEL_IMAGE_LIST
			a_bitmap					: WEL_BITMAP
			an_icon						: WEL_ICON
			bitmap_folder_normal		: INTEGER
			bitmap_folder_selected		: INTEGER
			bitmap_document_normal		: INTEGER
			bitmap_document_selected	: INTEGER
			bitmap_icon_application		: INTEGER
			background_color			: WEL_COLOR_REF
		do
			{WEL_TREE_VIEW} Precursor (a_parent, a_x, a_y, a_width, a_height, an_id)

				-- create the image list
			create image_list.make(16, 16, Ilc_color32, False)

				-- First match the background color of the imagelist with
				-- the background color of the tree view.
			create background_color.make_system(Color_window)
			image_list.set_background_color(background_color)

				-- Add bitmaps to the image list.
			create a_bitmap.make_by_id(Idb_document_normal)
			image_list.add_bitmap(a_bitmap)
			bitmap_document_normal := image_list.last_position

			create a_bitmap.make_by_id(Idb_document_selected)
			image_list.add_bitmap(a_bitmap)
			bitmap_document_selected := image_list.last_position

			create a_bitmap.make_by_id(Idb_folder_normal)
			image_list.add_bitmap(a_bitmap)
			bitmap_folder_normal := image_list.last_position

			create a_bitmap.make_by_id(Idb_folder_selected)
			image_list.add_bitmap(a_bitmap)
			bitmap_folder_selected := image_list.last_position

			create an_icon.make_by_id(Id_ico_application)
			image_list.add_icon(an_icon)
			bitmap_icon_application := image_list.last_position

				-- set the image list
			set_image_list(image_list)

			-- We had some items
			create tvis1.make
			tvis1.set_root
			create tv_item1.make
			tv_item1.set_text ("Root 1")
			tv_item1.set_image (bitmap_folder_normal, bitmap_folder_selected)
			tvis1.set_tree_view_item (tv_item1)
			Current.insert_item (tvis1)
			root_h := last_item

			-- Buttons
			create tvis2.make
			tvis2.set_last
			tvis2.set_parent (last_item)
			create tv_item2.make
			tv_item2.set_text ("Subtree 1")
			tv_item2.set_image (bitmap_folder_normal, bitmap_folder_selected)
			tvis2.set_tree_view_item (tv_item2)
			Current.insert_item (tvis2)
			handle := last_item

			create tvis3.make
			tvis3.set_last
			tvis3.set_parent (handle)
			create tv_item3.make
			tv_item3.set_text ("Item 1")
			tv_item3.set_image (bitmap_document_normal, bitmap_document_selected)
			tvis3.set_tree_view_item (tv_item3)
			Current.insert_item (tvis3)

			create tvis3.make
			tvis3.set_last
			tvis3.set_parent (handle)
			create tv_item3.make
			tv_item3.set_text ("Item 2")
			tv_item3.set_image (bitmap_document_normal, bitmap_document_selected)
			tvis3.set_tree_view_item (tv_item3)
			Current.insert_item (tvis3)

			create tvis2.make
			tvis2.set_last
			tvis2.set_parent (root_h)
			create tv_item2.make
			tv_item2.set_text ("Subtree 2")
			tv_item2.set_image (bitmap_folder_normal, bitmap_folder_selected)
			tvis2.set_tree_view_item (tv_item2)
			Current.insert_item (tvis2)

			create tvis3.make
			tvis3.set_last
			tvis3.set_parent (last_item)
			create tv_item3.make
			tv_item3.set_text ("Item 3")
			tv_item3.set_image (bitmap_document_normal, bitmap_document_selected)
			tvis3.set_tree_view_item (tv_item3)
			Current.insert_item (tvis3)

			create tvis2.make
			tvis2.set_last
			tvis2.set_parent (root_h)
			create tv_item2.make
			tv_item2.set_text ("Item 4")
			tv_item2.set_image (bitmap_document_normal, bitmap_document_selected)
			tvis2.set_tree_view_item (tv_item2)
			Current.insert_item (tvis2)

			create tvis3.make
			tvis3.set_last
			tvis3.set_parent (root_h)
			create tv_item3.make
			tv_item3.set_text ("Item 5")
			tv_item3.set_image (bitmap_document_normal, bitmap_document_selected)
			tvis3.set_tree_view_item (tv_item3)
			Current.insert_item (tvis3)

			create tvis2.make
			tvis2.set_last
			create tv_item2.make
			tv_item2.set_text ("Root 2")
			tv_item2.set_image (bitmap_folder_normal, bitmap_folder_selected)
			tvis2.set_tree_view_item (tv_item2)
			Current.insert_item (tvis2)

			create tvis3.make
			tvis3.set_last
			tvis3.set_parent (last_item)
			create tv_item3.make
			tv_item3.set_text ("item 6")
			tv_item3.set_image (bitmap_icon_application, bitmap_icon_application)
			tvis3.set_tree_view_item (tv_item3)
			Current.insert_item (tvis3)
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
			mess_output.add_string (str)
			mess_output.set_top_index (mess_output.count - 1)
		end

feature -- Notifications

	on_tvn_begindrag (info: WEL_NM_TREE_VIEW) is
			-- A drag-and-drop operation involving the left mouse
			-- button is being initiated.
		do
			add_mess_output ("Begin dragging")
		end

	on_tvn_beginlabeledit (info: WEL_TREE_VIEW_ITEM) is
			-- A label editing for an item has started.
		do
			add_mess_output ("Begin label editing")
		end

	on_tvn_beginrdrag (info: WEL_NM_TREE_VIEW) is
			-- A drag-and-drop operation involving the right mouse
			-- button is being initiated.
		do
			add_mess_output ("Begin right dragging")
		end

	on_tvn_deleteitem (info: WEL_NM_TREE_VIEW) is
			-- An item has been deleted.
		do
			add_mess_output ("Item has been deleting")
		end

	on_tvn_endlabeledit (info: WEL_TREE_VIEW_ITEM) is
			-- A label editing for an item has ended.
		do
			add_mess_output ("End label editing")
		end

	on_tvn_getdispinfo (info: WEL_TREE_VIEW_ITEM) is
			-- The parent window must provide information needed
			-- to display or sort an item.
		do
			add_mess_output ("Get dispinfo")
		end

	on_tvn_itemexpanded (info: WEL_NM_TREE_VIEW) is
			-- a parent item's list of child items has expanded
			-- or collapsed.
		do
			add_mess_output ("Item expanded")
		end

	on_tvn_itemexpanding (info: WEL_NM_TREE_VIEW) is
			-- a parent item's list of child items is about to
			-- expand or collapse.
		do
			add_mess_output ("Item expanding")
		end

	on_tvn_keydown (virtual_key: INTEGER) is
			-- The user pressed a key and the tree-view control 
			-- has the input focus.
		do
			add_mess_output ("Key pressed : ")
			item_output.set_text (virtual_key.out)
		end

	on_tvn_selchanged (info: WEL_NM_TREE_VIEW) is
			-- Selection has changed from one item to another.
		local
			tree_item: WEL_TREE_VIEW_ITEM
		do
			add_mess_output ("Selection changed")
			tree_item := info.new_item
			if tree_item.text_is_valid then
				item_output.set_text (tree_item.text)
			end
		end

	on_tvn_selchanging (info: WEL_NM_TREE_VIEW) is
			-- Selection is about to change from one item to
			-- another.
		do
			add_mess_output ("Selection changing")
		end

	on_tvn_setdispinfo (info: WEL_TREE_VIEW_ITEM) is
			-- The parent window must update the informations
			-- it maintains about an item.
		do
			add_mess_output ("Set dispinfo")
		end

end -- class TREEVIEW

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
