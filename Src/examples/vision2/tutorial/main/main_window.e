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

	EV_COMMAND

creation
	make_top_level

feature --Access

	mbar: EV_STATIC_MENU_BAR
			-- A menu bar

	tree: EV_TREE
			-- Tree of the current window

	sbar: EV_STATUS_BAR
			-- A status bar

	case_class: CASE_CLASS
			-- A class to include all the classes in the system.

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
			sitem: EV_STATUS_BAR_ITEM
		do
			{EV_WINDOW} Precursor
			set_minimum_size (720, 420)
			set_title ("Tutorial of EiffelVision")
			!! split.make (Current)

			-- We set the menu
			!! mbar.make (Current)
			fill_menu

			-- We set the status bar
			!! sbar.make (Current)
			!! sitem.make_with_text (sbar, "Processing...")
			sitem.set_width (150)
			!! sitem.make_with_text (sbar, "Here is some information")
			sitem.set_width (-1)

			-- We set the tree
			!! vbox.make (split)
			split.set_position (200)
			!! label.make_with_text (vbox, "Vision hierarchy")
			label.set_expand (False)
			label.set_center_alignment
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
		end

feature -- Features needed for the status bar of the window.

	
feature -- Menu Features

	fill_menu is
		local
			menu: EV_MENU
			menu_item: EV_MENU_ITEM
			check_item: EV_CHECK_MENU_ITEM
		do
			!! menu.make_with_text (mbar, "Categories")
			!! menu_item.make_with_text (menu, "Widgets")
			!! menu_item.make_with_text (menu, "Events")
			!! menu_item.make_with_text (menu, "Properties")

			!! menu.make_with_text (mbar, "View")
			!! check_item.make_with_text (menu, "Demo")
			!! check_item.make_with_text (menu, "Documentation")
			!! check_item.make_with_text (menu, "Text")
			!! check_item.make_with_text (menu, "Control Window")
		end

feature -- Tree features

	fill_tree is
		local
			kernel, properties, items, figures, widgets: EV_TREE_ITEM
			primitive, container, dialog, uncommon: EV_TREE_ITEM
			demo: EV_TREE_ITEM
		do
			-- The main topics
			!! figures.make_with_text (tree, "figures")
			!! kernel.make_with_text (tree, "kernel")
			!! properties.make_with_text (tree, "properties")
			!! items.make_with_text (tree, "items")
			!! widgets.make_with_text (tree, "widgets")

			-- The sub topics
			!! container.make_with_text (widgets, "containers")
			!! primitive.make_with_text (widgets, "primitives")
			!! dialog.make_with_text (widgets, "common dialogs")
			!! uncommon.make_with_text (widgets, "uncommon widgets")

			-- The demos
			!ACCELERATOR_ITEM! demo.make (kernel)
			!CURSOR_ITEM! demo.make (kernel)
			!TIMEOUT_ITEM! demo.make (kernel)

			!PIXEL_ITEM! demo.make (figures)
			!SEGMENT_ITEM! demo.make (figures)
			!STRAIGHT_LINE_ITEM! demo.make (figures)
			!POLYLINE_ITEM! demo.make (figures)
			!ARC_ITEM! demo.make (figures)
			!ELLIPSE_ITEM! demo.make (figures)
			!CIRCLE_ITEM! demo.make (figures)
			!POLYGON_ITEM! demo.make (figures)
			!REGULAR_POLYGON_ITEM! demo.make (figures)
			!EQUILATERAL_TRIANGLE_ITEM! demo.make (figures)
			!SQUARE_ITEM! demo.make (figures)
			!RECTANGLE_ITEM! demo.make (figures)
			!SLICE_ITEM! demo.make (figures)
			!TEXT_FIGURE_ITEM! demo.make (figures)
-- Do not work
--			!PICTURE_ITEM! demo.make (figures)

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
			!TOOLBAR_ITEM! demo.make (primitive)
			!PROGRESS_ITEM! demo.make (primitive)

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
			!PIXMAP_ITEM! demo.make (uncommon)

			!ERROR_ITEM! demo.make (dialog)
			!QUESTION_ITEM! demo.make (dialog)
			!INFORMATION_ITEM! demo.make (dialog)
			!WARNING_ITEM! demo.make (dialog)
--	These examples do not work on gtk yet
			!OPEN_FILE_ITEM! demo.make (dialog)
			!SAVE_FILE_ITEM! demo.make (dialog)
			!DIRECTORY_ITEM! demo.make (dialog)
			!COLOR_SELECTION_ITEM! demo.make (dialog)
			!ACCELERATOR_SELECTION_ITEM! demo.make (dialog)
		end

feature -- Temp

	execute (arg: EV_ARGUMENT; ev_data: EV_EVENT_DATA) is
			-- Show and hide the window
		do
--			hide
--			show
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
