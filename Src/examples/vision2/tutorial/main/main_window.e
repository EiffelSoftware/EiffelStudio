indexing
	description: 
	"MAIN_WINDOW, main window for the application. Belongs to EiffelVision example 'hello world'."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MAIN_WINDOW

inherit
	EV_WINDOW
		redefine
			make_top_level
		end

creation
	make_top_level

feature --Access

	mbar: EV_STATIC_MENU_BAR
			-- A menu bar

	tree: EV_TREE
			-- Tree of the current window

	sbar: EV_STATUS_BAR
			-- A status bar

feature -- Initialization
	
	make_top_level is
			-- Create the main window.
		local
			notebook: EV_NOTEBOOK
			split: EV_HORIZONTAL_SPLIT_AREA
			item: BUTTON_ITEM
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
			color: EV_COLOR
			bc: EV_BASIC_COLORS
		do
			{EV_WINDOW} Precursor
			set_title ("Tutorial of EiffelVision")
			set_minimum_width (300)
			!! split.make (Current)

			-- We set the menu
			!! mbar.make (Current)
			fill_menu

			-- We set the status bar
			!! sbar.make (Current)

			-- We set the tree
			!! vbox.make (split)
			!! label.make_with_text (vbox, "Vision hierarchy")
			label.set_expand (False)
			!! tree.make (vbox)
			tree.set_minimum_size (200, 250)
			fill_tree

			-- We set the notebook
			!! item.make (Void)
			!! notebook.make (split)
			item.demo_page.set_parent (notebook)
			notebook.append_page (item.demo_page, "Demo")
			item.text_page.set_parent (notebook)
			notebook.append_page (item.text_page, "Documentation")
			item.class_page.set_parent (notebook)
			notebook.append_page (item.class_page, "Class text")
			item.destroy
			notebook.set_minimum_size (250, 250)
			set_minimum_size (600, 400)
		end

feature -- Features needed for the status bar of the window.

	
feature -- Menu Features

	fill_menu is
		local
			menu: EV_MENU
			submenu: EV_MENU_ITEM
			menu_item: EV_MENU_ITEM
		do
			!! menu.make_with_text (mbar, "Categories")
			!! menu_item.make_with_text (menu, "Widgets")
			!! menu_item.make_with_text (menu, "Events")
			!! menu_item.make_with_text (menu, "Properties")

			!! menu.make_with_text (mbar, "menu 2")
			!! menu_item.make_with_text (menu, "item 1")
			!! menu_item.make_with_text (menu, "item 2")
			!! submenu.make_with_text (menu, "submenu")
			!! menu_item.make_with_text (submenu, "item 1")
			!! menu_item.make_with_text (submenu, "item 2")
		end

feature -- Tree features

	fill_tree is
		local
			kernel, properties, items, widgets: EV_TREE_ITEM
			primitive, container, dialog, uncommon: EV_TREE_ITEM
			demo: EV_TREE_ITEM	
		do
			-- The main topics
			!! kernel.make_with_text (tree, "kernel")
			!! properties.make_with_text (tree, "properties")
			!! items.make_with_text (tree, "items")
			!! widgets.make_with_text (tree, "widgets")

			-- The sub topics
			!! container.make_with_text (widgets, "containers")
			!! primitive.make_with_text (widgets, "primitives")
			!! dialog.make_with_text (widgets, "common dialogs")
			!! uncommon.make_with_text (widgets, "uncommon widgets")

			-- The demo
			!BUTTON_ITEM! demo.make (primitive)
			!OPTION_ITEM! demo.make (primitive)
			!MULTI_COLUMN_LIST_ITEM! demo.make (primitive)
			!LABEL_ITEM! demo.make (primitive)
			!TEXT_FIELD_ITEM! demo.make (primitive)
			!TEXT_AREA_ITEM! demo.make (primitive)
			!LIST_ITEM! demo.make (primitive)
			!TREE_ITEM! demo.make (primitive)
			!COMBO_ITEM! demo.make (primitive)
--	This example does not work on gtk yet
			!DRAWING_ITEM! demo.make (primitive)
			!RICH_ITEM! demo.make (primitive)

			!WINDOW_ITEM! demo.make (container)
			!DIALOG_ITEM! demo.make (container)
			!FIXED_ITEM! demo.make (container)
			!BOX_ITEM! demo.make (container)
			!NOTEBOOK_ITEM! demo.make (container)
			!SPLIT_AREA_ITEM! demo.make (container)
			!SCROLLABLE_ITEM! demo.make (container)
			!FRAME_ITEM! demo.make (container)
			!TABLE_ITEM! demo.make (container)
			!DYNTABLE_ITEM! demo.make (container)

--	This example does not work on gtk yet
			!POPUP_ITEM! demo.make (uncommon)

			!ERROR_ITEM! demo.make (dialog)
			!QUESTION_ITEM! demo.make (dialog)
			!INFORMATION_ITEM! demo.make (dialog)
			!WARNING_ITEM! demo.make (dialog)
--	This example does not work on gtk yet
			!OPEN_FILE_ITEM! demo.make (dialog)
			!SAVE_FILE_ITEM! demo.make (dialog)
		end

end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
