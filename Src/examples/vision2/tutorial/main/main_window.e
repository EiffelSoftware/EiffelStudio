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

	case_class: CASE_CLASS
			-- A class to include all the classes in the system.

feature -- Initialization

	make_top_level is
			-- Create the main window.
		local
			notebook: EV_NOTEBOOK
			split: EV_HORIZONTAL_SPLIT_AREA
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
			color: EV_COLOR
			bc: EV_BASIC_COLORS
			sitem: EV_STATUS_BAR_ITEM
			action_button: EV_BUTTON
			event_button: EV_BUTTON
			tooltip: EV_TOOLTIP
			cmd: EV_ROUTINE_COMMAND
			item: DEMO_ITEM [WINDOW_WINDOW]
			setp: EV_HORIZONTAL_SEPARATOR
		do
			{EV_WINDOW} Precursor
			set_minimum_size (500, 310)
			set_size (800, 600)
			set_title ("EiffelVision Tutorial")
			create split.make (Current)

			-- We set the menu
			create mbar.make (Current)
			fill_menu

			-- We set the status bar
			create sbar.make (Current)
			create sitem.make_with_text (sbar, "Processing...")
			sitem.set_width (200)
			create sitem.make_with_text (sbar, "Here is some information")
			sitem.set_width (-1)

			-- We set the tree
			create vbox.make (split)
			split.set_position (200)
			create label.make_with_text (vbox, "Please choose an item.")
			label.set_minimum_width (200)
			vbox.set_child_expandable (label, False)
			create tree.make (vbox)
			tree.set_minimum_size (195, 195)
			split.set_first_area_shrinkable (False)
			fill_tree

			-- We set the action button
			create item.make_with_title (Void, "", "")
			item.action_button.set_parent (vbox)
			vbox.set_child_expandable (item.action_button, False)
			item.action_button.set_insensitive (True)
			
			-- We set the event button
			create item.make_with_title (Void, "", "")
			item.event_button.set_parent (vbox)
			vbox.set_child_expandable (item.event_button, False)
			item.event_button.set_insensitive (True)

			-- We set the notebook
			create color.make_rgb (255, 255, 255)
			create notebook.make (split)
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
		end

feature -- Features needed for the status bar of the window.

feature -- Menu Features

	fill_menu is
		local
			menu: EV_MENU
			menu_item: EV_MENU_ITEM
			check_item: EV_CHECK_MENU_ITEM
			ri1, ri2, ri3: EV_RADIO_MENU_ITEM
			msep: EV_MENU_SEPARATOR
		do
			create menu.make_with_text (mbar, "Categories")
			create menu_item.make_with_text (menu, "Widgets")
			create menu_item.make_with_text (menu, "Events")
			create menu_item.make_with_text (menu, "Properties")

			create menu.make_with_text (mbar, "View")
			create ri1.make_with_text (menu, "Demo")
			create ri2.make_peer_with_text (menu, "Documentation", ri1)
			create ri3.make_peer_with_text (menu, "Text", ri1)
			--create cmd1.make (~show_Action_window)
			create check_item.make_with_text (menu, "Action Window")
			--check_item.add_select_command (cmd1, Void)
			create msep.make_with_index (menu, 4)
		end

feature --

	show_action_window (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Show the action window if enabled.
		do
		end

feature -- Tree features

	fill_tree is
		local
			-- Sub tree item.
			kernel, properties: EV_TREE_ITEM
			items, figures, widgets: DEMO_ITEM [NO_DEMO_WINDOW]
			uncommon: EV_TREE_ITEM
			primitive, container, dialog: DEMO_ITEM [NO_DEMO_WINDOW]

			-- Kernel items
			acceleratord: DEMO_ITEM [ACCELERATOR_WINDOW]
			cursord: DEMO_ITEM [CURSOR_WINDOW]
			timeout: DEMO_ITEM [TIMEOUT_WINDOW]
			tooltip: DEMO_ITEM [TOOLTIP_WINDOW]

			-- Figures items
			figure: FIGURE_ITEM

			-- Items item
			simple, composed: DEMO_ITEM [NO_DEMO_WINDOW]
			mcitem: DEMO_ITEM [MC_ITEM_WINDOW]
			tb_button: DEMO_ITEM [TB_BUTTON_WINDOW]
			tb_toggle: DEMO_ITEM [TB_TOGGLE_WINDOW]
			tb_radio: DEMO_ITEM [TB_RADIO_WINDOW]
			listitem: DEMO_ITEM [LISTITEM_WINDOW]
			treeitem: DEMO_ITEM [TREEITEM_WINDOW]
			statusitem: DEMO_ITEM [STATUSITEM_WINDOW]
			menuitem: DEMO_ITEM [MENUITEM_WINDOW]

			-- Primitives
			gauge:		DEMO_ITEM [GAUGE_WINDOW]
			range:		DEMO_ITEM [RANGE_WINDOW]
			spin:		DEMO_ITEM [SPIN_BUTTON_WINDOW]
			scroll:		DEMO_ITEM [SCROLL_BAR_WINDOW]
			buttons:	DEMO_ITEM [BUTTON_WINDOW]
			toggle:		DEMO_ITEM [TOGGLE_BUTTON_WINDOW]
			checkb:		DEMO_ITEM [CHECK_BUTTON_WINDOW]
			radio:		DEMO_ITEM [RADIO_BUTTON_WINDOW]
			option:		DEMO_ITEM [OPTION_WINDOW]
			mc:			DEMO_ITEM [MULTI_COLUMN_LIST_WINDOW]
			label:		DEMO_ITEM [LABEL_WINDOW]
			tf:			DEMO_ITEM [TEXT_FIELD_WINDOW]
			ta:			DEMO_ITEM [TEXT_AREA_WINDOW]
			list:		DEMO_ITEM [LIST_WINDOW]
			treed:		DEMO_ITEM [TREE_WINDOW]
			combo:		DEMO_ITEM [COMBO_WINDOW]
			drawing:	DEMO_ITEM [DRAWING_WINDOW]
			rich:		DEMO_ITEM [RICH_WINDOW]
			toolbar:	DEMO_ITEM [TOOLBAR_WINDOW]
			progress:	DEMO_ITEM [PROGRESS_WINDOW]

			-- Containers
			window:		DEMO_ITEM [WINDOW_WINDOW]
			dialogd:		DEMO_ITEM [DIALOG_WINDOW]
			fixed:		DEMO_ITEM [FIXED_WINDOW]   
			box:		DEMO_ITEM [BOX_WINDOW] 
			notebook:	DEMO_ITEM [NOTEBOOK_WINDOW] 
			split:		DEMO_ITEM [SPLIT_AREA_WINDOW] 
			scrollable:	DEMO_ITEM [SCROLLABLE_WINDOW] 
			frame:		DEMO_ITEM [FRAME_WINDOW] 
			table:		DEMO_ITEM [TABLE_WINDOW] 
			dyntable:	DEMO_ITEM [DYNTABLE_WINDOW] 

			-- Dialogs
			selection, message: DEMO_ITEM [NO_DEMO_WINDOW]
			error:		DEMO_ITEM [ERROR_WINDOW]
			question:	DEMO_ITEM [QUESTION_WINDOW] 
			information:DEMO_ITEM [INFORMATION_WINDOW] 
			warning:	DEMO_ITEM [WARNING_WINDOW] 
			open_file:	DEMO_ITEM [OPEN_FILE_WINDOW] 
			save_file:	DEMO_ITEM [SAVE_FILE_WINDOW] 
			directory:	DEMO_ITEM [DIRECTORY_WINDOW] 
			accelerator:DEMO_ITEM [ACCELERATOR_SELECTION_WINDOW]
			color:		DEMO_ITEM [COLOR_WINDOW] 
			font:		DEMO_ITEM [FONT_WINDOW]
			printd:		DEMO_ITEM [PRINT_WINDOW]

			-- Uncommon
			popup:		DEMO_ITEM [POPUP_WINDOW]
			pixmap:		DEMO_ITEM [PIXMAP_WINDOW]
		do
			-- The main topics
			create figures.make_with_title 		(tree, "ev_figure", "no_demo_window")
			create kernel.make_with_text		(tree, "kernel")
			create properties.make_with_text		(tree, "properties")
			create items.make_with_title		(tree, "ev_item", "no_demo_window")
			create widgets.make_with_title		(tree, "ev_widget", "no_demo_window")

			-- The sub topics for widget root node
			create container.make_with_title		(widgets, "ev_container", "no_demo_window")
			create primitive.make_with_title		(widgets, "ev_primitive", "no_demo_window")
			create dialog.make_with_title		(widgets, "ev_standard_dialog", "no_demo_window")
			create uncommon.make_with_text		(widgets, "uncommon widgets")

			-- The sub topics for item root node
			create simple.make_with_title (items, "ev_simple_item", "no_demo_window")
			create composed.make_with_title (items, "ev_composed_item", "no_demo_window")
			create mcitem.make_with_title (composed, "ev_multi_column_list_row", "mc_item_window")
			create tb_button.make_with_title (simple, "ev_tool_bar_button", "tb_button_window")
			create tb_toggle.make_with_title (tb_button, "ev_tool_bar_toggle_button", "tb_toggle_window")
			create tb_radio.make_with_title (tb_toggle, "ev_tool_bar_radio_button", "tb_radio_window")
			create listitem.make_with_title (simple, "ev_list_item", "listitem_window")
			create treeitem.make_with_title (simple, "ev_tree_item", "treeitem_window")
			create statusitem.make_with_title (simple, "ev_status_bar_item", "statusitem_window")
			create menuitem.make_with_title (simple, "ev_menu_item", "menuitem_window")

			-- The demos
			create acceleratord.make_with_title	(kernel, "ev_accelerator", "accelerator_window")
			create cursord.make_with_title		(kernel, "ev_cursor", "cursor_window")
			create timeout.make_with_title		(kernel, "ev_timeout", "timeout_window")
			create tooltip.make_with_title		(kernel, "ev_tooltip", "tooltip_window")

				-- Figures demos
			create {PIXEL_ITEM} figure.make_with_title (figures, "ev_pixel", "figure_window")
			create {SEGMENT_ITEM} figure.make_with_title (figures, "ev_segment", "figure_window")
			create {STRAIGHT_LINE_ITEM} figure.make_with_title (figures, "ev_straight_line", "figure_window")
			create {POLYLINE_ITEM} figure.make_with_title (figures, "ev_polyline", "figure_window")
			create {ARC_ITEM} figure.make_with_title (figures, "ev_arc", "figure_window")
			create {ELLIPSE_ITEM} figure.make_with_title (figures, "ev_ellipse", "figure_window")
			create {CIRCLE_ITEM} figure.make_with_title (figures, "ev_circle", "figure_window")
			create {POLYGON_ITEM} figure.make_with_title (figures, "ev_polygon", "figure_window")
			create {REGULAR_POLYGON_ITEM} figure.make_with_title (figures, "ev_regular_polygon", "figure_window")
			create {EQUILATERAL_TRIANGLE_ITEM} figure.make_with_title (figures, "ev_equilateral_triangle", "figure_window")
			create {SQUARE_ITEM} figure.make_with_title (figures, "ev_square", "figure_window")
			create {RECTANGLE_ITEM} figure.make_with_title (figures, "ev_rectangle", "figure_window")
			create {SLICE_ITEM} figure.make_with_title (figures, "ev_slice", "figure_window")
			create {TEXT_FIGURE_ITEM} figure.make_with_title (figures, "ev_text_figure", "figure_window")
-- Do not work
--			--create {PICTURE_ITEM} figure.make_with_title (figures)

				-- Primitive demos
			create gauge.make_with_title (primitive, "ev_gauge", "gauge_window")
			create range.make_with_title (gauge, "ev_range", "range_window")
			create spin.make_with_title (gauge, "ev_spin_button", "spin_button_window")
			create scroll.make_with_title (gauge, "ev_scroll_bar", "scroll_bar_window")
			create buttons.make_with_title (primitive, "ev_button", "button_window")
			create toggle.make_with_title (buttons, "ev_toggle_button", "toggle_button_window")
			create checkb.make_with_title (buttons, "ev_check_button", "check_button_window")
			create radio.make_with_title (buttons, "ev_radio_button", "radio_button_window")
			create option.make_with_title (primitive, "ev_option_button", "option_window")
			create mc.make_with_title (primitive, "ev_multi_column_list", "multi_column_list_window")
			create label.make_with_title (primitive, "ev_label", "label_window")
			create tf.make_with_title (primitive, "ev_text_field", "text_field_window")
			create ta.make_with_title (primitive, "ev_text", "text_area_window")
			create list.make_with_title (primitive, "ev_list", "list_window")
			create treed.make_with_title (primitive, "ev_tree", "tree_window")
			create combo.make_with_title (primitive, "ev_combo_box", "combo_window")
			create drawing.make_with_title (primitive, "ev_drawing_area", "drawing_window")
			create rich.make_with_title (primitive, "ev_rich_text", "rich_window")
			create toolbar.make_with_title (primitive, "ev_tool_bar", "toolbar_window")
			create progress.make_with_title (gauge, "ev_progress_bar", "progress_window")

				-- Containers demos
			create window.make_with_title (container, "ev_window", "window_window")
			create dialogd.make_with_title (window, "ev_dialog" , "dialog_window")
			create fixed.make_with_title (container, "ev_fixed", "fixed_window")
			create box.make_with_title (container, "ev_box", "box_window")
			create notebook.make_with_title (container, "ev_notebook", "notebook_window")
			create split.make_with_title (container, "ev_split_area", "split_area_window")
			create scrollable.make_with_title (container, "ev_scrollable_area", "scrollable_window")
			create frame.make_with_title (container, "ev_frame", "frame_window")
			create table.make_with_title (container, "ev_table", "table_window")
			create dyntable.make_with_title (table, "ev_dynamic_table", "dyntable_window")
			create popup.make_with_title (uncommon, "ev_popup_menu", "popup_window")
			create pixmap.make_with_title (uncommon, "ev_pixmap", "pixmap_window")

				-- Standard dialogs demos
			create message.make_with_title (dialog, "ev_message_dialog", "no_demo_window")
			create error.make_with_title (message, "ev_error_dialog", "error_window")
			create question.make_with_title (message, "ev_question_dialog", "question_window")
			create information.make_with_title (message, "ev_information_dialog", "information_window")
			create warning.make_with_title (message, "ev_warning_dialog", "warning_window")
			create selection.make_with_title (dialog, "ev_selection_dialog", "no_demo_window")
			create open_file.make_with_title (selection, "ev_file_open_dialog", "open_file_window")
			create save_file.make_with_title (selection, "ev_file_save_dialog", "save_file_window")
			create directory.make_with_title (selection, "ev_directory_dialog", "directory_window")
			create accelerator.make_with_title (selection, "ev_accelerator_dialog", "accelerator_selection_window")
			create color.make_with_title (selection, "ev_color_dialog", "color_window")
			create font.make_with_title (selection, "ev_font_dialog", "font_window")
			create printd.make_with_title (dialog, "ev_print_dialog", "print_window")
		end

end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

