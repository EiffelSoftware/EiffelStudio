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
			action_button: EV_BUTTON
			cmd: EV_ROUTINE_COMMAND
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
			sitem.set_width (200)
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
			create action_button.make_with_text(vbox,"Actions")

			-- We set the notebook
			!! item.make (Void)
			!! notebook.make (split)
			item.demo_page.set_parent (notebook)
			notebook.append_page (item.demo_page, "Demo")
			item.text_page.set_parent (notebook)
			notebook.append_page (item.text_page, "Documentation")
			item.class_page.set_parent (notebook)
			notebook.append_page (item.class_page, "Class text")
			item.example_page.set_parent (notebook)
			notebook.append_page (item.example_page, "Example text")
			item.destroy
			notebook.set_minimum_size (250, 250)



			--create cmd.make(~execute1)
			--action_button.add_click_command (cmd, Void)
		end

feature -- Features needed for the status bar of the window.


feature -- Execute commands


	--execute1 (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
	--		--When the action button is pressed then
--			--display the window
--		local
--	do	
--		if act_window=Void then
--			create act_window.make(Current)
--		end
--		act_window.show
--	end
	
feature -- Menu Features

	fill_menu is
		local
			menu: EV_MENU
			menu_item: EV_MENU_ITEM
			
			check_item: EV_CHECK_MENU_ITEM
			radio_item: EV_RADIO_MENU_ITEM
		do
			!! menu.make_with_text (mbar, "Categories")
			!! menu_item.make_with_text (menu, "Widgets")
			!! menu_item.make_with_text (menu, "Events")
			!! menu_item.make_with_text (menu, "Properties")

			!! menu.make_with_text (mbar, "View")
			!! radio_item.make_with_text (menu, "Demo")
			!! radio_item.make_with_text (menu, "Documentation")
			!! radio_item.make_with_text (menu, "Text")
			!! check_item.make_with_text (menu, "Control Window")
		end

feature -- Tree features

	fill_tree is
		local
			-- Root tree items
			kernel, properties, items, figures, widgets: EV_TREE_ITEM

			-- Sub items for widgets node
			primitive, container, dialog, uncommon: EV_TREE_ITEM
			demo,gauges,table: EV_TREE_ITEM

			-- Sub items for items node
			-- simple, composed, separator: EV_TREE_ITEM
			
		do
			-- The main topics
			!! figures.make_with_text (tree, "figures")
			!! kernel.make_with_text (tree, "kernel")
			!! properties.make_with_text (tree, "properties")
			!! items.make_with_text (tree, "items")
			!! widgets.make_with_text (tree, "widgets")
		

			-- The sub topics for widget root node
			!! container.make_with_text (widgets, "containers")
			!! primitive.make_with_text (widgets, "primitives")
			!! dialog.make_with_text (widgets, "common dialogs")
			!! uncommon.make_with_text (widgets, "uncommon widgets")

			-- The sub topics for item root node
			--!! simple.make_with_text (items, "EV_SIMPLE_ITEM")
			--!! composed.make_with_text (items, "EV_COMPOSED_ITEM")
			--!! separator.make_with_text (items, "EV_SEPARATOR_ITEM")		

			-- The demos
			!ACCELERATOR_ITEM! demo.make (kernel)
			!CURSOR_ITEM! demo.make (kernel)
			!TIMEOUT_ITEM! demo.make (kernel)

		
		--	!NEW_ITEM! demo.make(figures)
			
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
--			--!PICTURE_ITEM! demo.make (figures)

			-- items for gauge tree
			!GAUGE_ITEM! gauges.make (primitive)
			!RANGE_ITEM! demo.make (gauges)
			!SPIN_BUTTON_ITEM! demo.make (gauges)
			!SCROLL_BAR_ITEM! demo.make (gauges)

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
			!TABLE_ITEM! table.make (container)
			!DYNTABLE_ITEM! demo.make (table)

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

--	Demos for item node
			--!MULTI_COLUMN_LIST_ROW_ITEM! items.make (composed,"MULTI_COLUMN_LIST_ROW_ITEM",test_wind)
			--!MULTI_COLUMN_LIST_ROW_ITEM! items.make (composed)
			--!TOOL_BAR_SEPARATOR! items.make (composed)
			--!MENU_SEPARATOR! items.make (composed)
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
