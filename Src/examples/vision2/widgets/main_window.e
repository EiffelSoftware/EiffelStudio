indexing
	description: "The main window for the vision2 widget test."
	date: "$Date$"
	revision: "$Revision$"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize,
			is_in_default_state
		end
		
	INTERNAL
		undefine
			default_create,
			copy
		end

create
	default_create

feature {NONE} -- Initialization

	initialize is
			-- Initialize `Current' to set up tests.
		local
			environment: EV_ENVIRONMENT
		do
			Precursor {EV_TITLED_WINDOW}
			create horizontal_box
			create widget_tree
				-- Set up widget selction tree.
			initialize_widget_tree
			widget_tree.set_minimum_size (150, 250)
			horizontal_box.extend (widget_tree)
			create vertical_box
			horizontal_box.extend (vertical_box)
				-- Set up widget display area.
			create widget_area
			widget_area.set_minimum_size (200, 200)
			vertical_box.extend (widget_area)
				-- Set up output area.
			create output
			vertical_box.extend (output)
			
				-- Set up scrollable area
			create scrollable_area
			horizontal_box.extend (scrollable_area)
			horizontal_box.disable_item_expand (scrollable_area)
			scrollable_area.set_minimum_size (Scrollable_area_width, 250)
			
				-- Set up menus
			create file_menu.make_with_text ("File")
			create help_menu.make_with_text ("Help")
			create exit_menu_item.make_with_text ("Exit")
			file_menu.extend (exit_menu_item)
			create about_menu_item.make_with_text ("About")
			help_menu.extend (about_menu_item)
			create a_menu_bar
			a_menu_bar.extend (file_menu)
			a_menu_bar.extend (help_menu)
			set_menu_bar (a_menu_bar)
			create about_dialog.make
			about_menu_item.select_actions.extend (agent show_about_dialog)
			create environment
				-- Allow the window to be closeable through the cross, and also the
				-- exit menu.
			exit_menu_item.select_actions.extend (agent (environment.application).destroy)
			close_request_actions.extend (agent (environment.application).destroy)
			extend (horizontal_box)

				-- Show `Current'.
			show
		end
		
		show_about_dialog is
				-- Create and display the about dialog.
			do
				create about_dialog.make
				about_dialog.show_modal_to_window (Current)
			end
			
	initialize_widget_tree is
			-- Add widgets to `widget_tree'.
		local
			tree_item, tree_item1, tree_item2: EV_TREE_ITEM
			widget: EV_WIDGET
			primitives: ARRAY [STRING]
			containers: ARRAY [STRING]
			counter: INTEGER
			pixmap: EV_PIXMAP
			passed: BOOLEAN
		do
			create tree_item.make_with_text ("Widgets")
			widget_tree.extend (tree_item)
			create tree_item1.make_with_text ("Containers")
			tree_item.extend (tree_item1)
			
			create containers.make_from_array (<<"EV_CELL", "EV_FIXED", "EV_FRAME", "EV_HORIZONTAL_SPLIT_AREA",
				"EV_HORIZONTAL_BOX", "EV_NOTEBOOK", "EV_SCROLLABLE_AREA", "EV_TABLE", "EV_VERTICAL_BOX",
				"EV_VERTICAL_SPLIT_AREA", "EV_VIEWPORT">>)
			from
				counter := 1
			until
				counter = containers.count + 1
			loop
				create tree_item2.make_with_text (containers @ counter)
				tree_item1.extend (tree_item2)
				passed := feature {ISE_RUNTIME}.check_assert (False)
				widget ?= new_instance_of (dynamic_type_from_string (tree_item2.text))
				widget.default_create
				passed := feature {ISE_RUNTIME}.check_assert (True)
				tree_item2.select_actions.extend (agent test_widget (widget))
				counter := counter + 1
			end

			create tree_item1.make_with_text ("Primitives")
			tree_item.extend (tree_item1)
			
			create primitives.make_from_array (<<"EV_BUTTON", "EV_CHECK_BUTTON", "EV_COMBO_BOX",
				"EV_HORIZONTAL_PROGRESS_BAR", "EV_HORIZONTAL_RANGE",
				"EV_HORIZONTAL_SEPARATOR", "EV_LABEL", "EV_LIST", "EV_MULTI_COLUMN_LIST", "EV_OPTION_BUTTON",
				"EV_PASSWORD_FIELD", "EV_PIXMAP", "EV_RADIO_BUTTON", "EV_SPIN_BUTTON",
				"EV_TEXT", "EV_TEXT_FIELD", "EV_TOGGLE_BUTTON", "EV_TOOL_BAR", "EV_TREE", "EV_VERTICAL_PROGRESS_BAR",
				"EV_VERTICAL_RANGE", "EV_VERTICAL_SEPARATOR", "EV_DRAWING_AREA", "EV_VERTICAL_SCROLL_BAR",
				"EV_HORIZONTAL_SCROLL_BAR">>)
			from
				counter  := 1
			until
				counter = primitives.count + 1
			loop
				create tree_item.make_with_text (primitives @ counter)
				tree_item1.extend (tree_item)
				passed := feature {ISE_RUNTIME}.check_assert (False)
				widget ?= new_instance_of (dynamic_type_from_string (tree_item.text))
				widget.default_create
				passed := feature {ISE_RUNTIME}.check_assert (False)
					-- If we are a pixmap, then we must load and assign
					-- an image.
				pixmap ?= widget
				if pixmap /= Void then
					pixmap.set_with_named_file ("bm_About.png")
				end
				tree_item.select_actions.extend (agent test_widget (widget))
				counter := counter + 1
			end
		end
		
	test_widget (widget: EV_WIDGET) is
			-- Initialize tests for `widget'.
		do
				-- Remove previous testable widget
			widget_area.wipe_out
			widget_area.extend (widget)
			

				-- Reset `scrollable_area' and other required
				-- containers.
			horizontal_box.prune (scrollable_area)
			create scrollable_area
			scrollable_area.set_minimum_size (Scrollable_area_width, 250)
			create test_holder
			horizontal_box.extend (scrollable_area)
			horizontal_box.disable_item_expand (scrollable_area)
			scrollable_area.extend (test_holder)
			output.remove_text
			create widget_control.make (test_holder, widget, output)
			
				-- We must now check the types that `widget' conforms to,
				-- in order to set up the required controls.
				
			container ?= widget
			if container /= Void then
				create container_control.make (test_holder, container, output)
			end
			sensitive ?= widget
			if sensitive /= Void then
				create sensitive_control.make (test_holder, sensitive, output)
			end
			colorizable ?= widget
			if colorizable /= Void then
				create colorizable_control.make (test_holder, colorizable, output)
			end
			textable ?= widget
			if textable /= Void then
				create textable_control.make (test_holder, textable, output)
			end
			
			text_alignable ?= widget
			if text_alignable /= Void then
				create text_alignable_control.make (test_holder, text_alignable, output)
			end
			
			text_component ?= widget
			if text_component /= Void then
				create text_component_control.make (test_holder, text_component, output)
			end
			
			button ?= widget
			if button /= Void then
				button.select_actions.extend (agent output.append_text ("Button selected%N"))
			end
			
			drawable ?= widget
			if drawable /= Void then
				create drawable_control.make (test_holder, drawable, output)
			end
			
			pixmapable ?= widget
			if pixmapable /= Void then
				create pixmapable_control.make (test_holder, pixmapable, output)
			end
			
			selectable ?= widget
			deselectable ?= widget
			if deselectable /= Void then
				create deselectable_control.make (test_holder, deselectable, output)
			elseif selectable /= Void then
				create selectable_control.make (test_holder, selectable, output)
			end
			
			gauge ?= widget
			if gauge /= Void then
				create gauge_control.make (test_holder, gauge, output)
			end
			
			item_list ?= widget
			if item_list /= Void then
				create item_list_control.make (test_holder, item_list, output)
			end
		end
		
feature {NONE} -- Implementation
		
	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
			-- Currently do not care about this check, so we
			-- are turning it off.
		do
			Result := True
		end

feature -- Access

	widget_tree: EV_TREE
		-- A tree holding all testable widgets.
	
	widget_area: EV_FRAME
		-- A cell to hold the currently selected and testable widget.
		
	test_detail_selection: EV_NOTEBOOK
		-- This holds different details of the test for each widget.
	
	output: EV_TEXT
		-- All event output occurs here.


		-- The following widgets are used to build the interface
		-- for the user.
	test_holder: EV_VERTICAL_BOX
	
	frame: EV_FRAME
	
	scrollable_area: EV_SCROLLABLE_AREA
		
	horizontal_box: EV_HORIZONTAL_BOX
		
	vertical_box, vertical_box1: EV_VERTICAL_BOX
	
	text_field: EV_TEXT_FIELD
	
	button, button1: EV_BUTTON
	
	file_menu, help_menu: EV_MENU
	
	exit_menu_item, about_menu_item: EV_MENU_ITEM
	
	a_menu_bar: EV_MENU_BAR
	
	about_dialog: ABOUT_DIALOG
					
feature {NONE} -- Implementation


	-- The following widgets need to be included, 
	-- we cannot create them dynamically if we do not reference them.
 include1: EV_CHECK_BUTTON
 include2: EV_COMBO_BOX
 include3: EV_HORIZONTAL_PROGRESS_BAR
 include4: EV_HORIZONTAL_RANGE
 include5: EV_HORIZONTAL_SEPARATOR
 include6: EV_LIST
 include7: EV_MULTI_COLUMN_LIST
 include8: EV_VERTICAL_PROGRESS_BAR
 include9: EV_VERTICAL_RANGE
 include10: EV_VERTICAL_SEPARATOR
 include11: EV_OPTION_BUTTON
 include12: EV_PASSWORD_FIELD
 include13: EV_TOOL_BAR
 include14: EV_HORIZONTAL_SPLIT_AREA
 include15: EV_VERTICAL_SPLIT_AREA
 include16: EV_FIXED
 include17: EV_TABLE
 include18: EV_DRAWING_AREA
 include19: EV_HORIZONTAL_SCROLL_BAR
 include20: EV_VERTICAL_SCROLL_BAR


		-- The different properties and types that
		-- we need to use.
	textable: EV_TEXTABLE
	
	text_component: EV_TEXT_COMPONENT
	
	sensitive: EV_SENSITIVE
	
	colorizable: EV_COLORIZABLE
	
	text_component_text_field: EV_TEXT_FIELD
	
	selectable: EV_SELECTABLE	
	
	deselectable: EV_DESELECTABLE
	
	drawable: EV_DRAWABLE
	
	pixmapable: EV_PIXMAPABLE
	
	gauge: EV_GAUGE
	
	container: EV_CONTAINER
	
	textable_text_field: EV_TEXT_FIELD
	
	text_alignable: EV_TEXT_ALIGNABLE
	
	item_list: EV_ITEM_LIST [EV_ITEM]
	
	bspinr, bsping, bspinb, fspinr, fsping, fspinb: EV_SPIN_BUTTON
	
		-- The different controls available for
		-- use in the test.
	textable_control: TEXTABLE_CONTROL
	text_component_control: TEXT_COMPONENT_CONTROL
	sensitive_control: SENSITIVE_CONTROL
	colorizable_control: COLORIZABLE_CONTROL
	deselectable_control: DESELECTABLE_CONTROL
	selectable_control: SELECTABLE_CONTROL
	widget_control: WIDGET_CONTROL
	drawable_control: DRAWABLE_CONTROL
	pixmapable_control: PIXMAPABLE_CONTROL
	gauge_control: GAUGE_CONTROL
	container_control: CONTAINER_CONTROL
	item_list_control: ITEM_LIST_CONTROL
	text_alignable_control: TEXT_ALIGNABLE_CONTROL

		-- Default width of the scrollable area.
	Scrollable_area_width: INTEGER is 220
	
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

