indexing
	description: "Objects that generate XML output from a Vision2 system"
	date: "$Date$"
	revision: "$Revision$"

-- ************** Current Status *************
-- No action sequences are supported currently.
-- Supported widgets:
--	EV_WINDOW
--	EV_BOX, horizontal and vertical
--	EV_SCROLL_BAR, horizontal and vertical
--	EV_RANGE, horizontal and vertical
--	EV_BUTTON
--	EV_DRAWING_AREA
--	EV_LABEL
--	EV_TOGGLE_BUTTON
--	EV_RADIO_BUTTON
--	EV_CHECK_BUTTON
--	EV_LIST and EV_LIST_ITEM
--	EV_CELL
--	EV_SPLIT_AREA, horizontal and vertical
--	EV_FRAME
--	EV_MENU
--	EV_MENU_ITEM
--	EV_MENU_BAR
--	EV_NOTEBOOK
--	EV_VIEWPORT
--	EV_SCROLLABLE_AREA
-- 	EV_SEPARATOR, horizontal and vertical
--	EV_TREE EV_TREE_ITEM
--	EV_SPIN_BUTTON
-- *******************************************

class
	APPLICATION_STORE

inherit
	EV_APPLICATION
		redefine
			initialize
		end

	TOE_TREE_FACTORY
		undefine
			default_create
		end

feature -- Initialization

	initialize is
			-- Initialize application Storer.
		local
			control_window: EV_TITLED_WINDOW
			store_button: EV_BUTTON
		do	
			Precursor
			create control_window
			create store_button.make_with_text ("Generate XML")
			store_button.select_actions.extend (store_button~disable_sensitive)
			store_button.select_actions.extend (~store)
			store_button.select_actions.extend (store_button~enable_sensitive)
			control_window.extend (store_button)
			control_window.show
		end

feature --  Access

	filename: STRING is "C:\store_output_instance.xml"
		-- File in which XML ouput from `store' is saved

feature -- Basic operations

	store is
			-- Store Application in XML format.
		local
			application_element: XML_ELEMENT
			element: XML_ELEMENT
			toe_document: TOE_DOCUMENT
			window: EV_WINDOW
			titled_window: EV_TITLED_WINDOW
			formater: XML_FORMATER
			win: LINEAR [EV_WINDOW]
		do
			win := windows
				-- Create the application element.
			application_element := new_root_element ("application", "")
			add_attribute_to_element (application_element, "xsi", "xmlns", "http://www.w3.org/1999/XMLSchema-instance")
				
				-- Create the document.
			create toe_document.make
			create document.make_from_imp (toe_document)
				
				-- Go to start of `document'.
			document.start
				-- Add `application_element' as the root element of `document'.
			document.force_first (application_element)
			from
				win.start
			until
				win.off
			loop
				window := win.item
				titled_window ?= window
				if window /= Void then
					element := new_child_element (application_element, "window", "")
					if titled_window /= Void then
						add_attribute_to_element (element, "type", "xsi", "EV_TITLED_WINDOW")
						fill_window (titled_window, element)
					else
						add_attribute_to_element (element, "type", "xsi", "EV_WINDOW")
						fill_window (window, element)
					end
					application_element.force_last (element)
				end
				win.forth
			end

			
			create formater.make
			formater.process_document (document)
				-- Save our XML ouput to disk in `filename'.
			write_file_to_disk (filename, formater.last_string.to_utf8)
		end
	
	write_file_to_disk (a_filename, xml_text: STRING) is
			-- Create a file named `a_filename' with content `xml_text'.
		local
			file: RAW_FILE
		do
			create file.make_open_write (a_filename)
			file.start
			file.putstring (xml_format)
			file.put_string (xml_text)
			file.close
		end

feature {NONE} -- Implementation

	document: XML_DOCUMENT
		-- XML document generated from `Current'.

	xml_format: STRING is "<?xml version=%"1.0%" encoding=%"UTF-8%"?>"
		-- XML format type, included at start of `document'.


feature {NONE} -- Utility functions. Many may be useful in XML library.

	new_child_element (a_parent: XML_COMPOSITE; a_name, a_ns_prefix: STRING): XML_ELEMENT is
			-- `Result' is a new child element with name `a_name' and ns_prexif `a_ns_prefix'.
		local
			toe_element: TOE_ELEMENT
			internal_name, internal_ns_prefix: UCSTRING
		do
			create internal_name.make_from_string (a_name)
			create internal_ns_prefix.make_from_string (a_ns_prefix)
			create toe_element.make_child (a_parent, internal_name, internal_ns_prefix)
			create Result.make_from_imp (toe_element)	
		end

	new_root_element (a_name, a_ns_prefix: STRING): XML_ELEMENT is
			-- `Result' is a new root element with name `a_name' and ns_prexif `a_ns_prefix'.
		local
			toe_element: TOE_ELEMENT
			internal_name, internal_ns_prefix: UCSTRING
		do
			create internal_name.make_from_string (a_name)
			create internal_ns_prefix.make_from_string (a_ns_prefix)
			create toe_element.make_root (internal_name, internal_ns_prefix)
			create Result.make_from_imp (toe_element)	
		end

	add_attribute_to_element (element: XML_ELEMENT; a_name, a_prefix, a_value: STRING) is
			-- Add an atribute with name `a_name', prefix `a_prefix' and value `a_value' to `element'.
		local
			internal_name, internal_prefix, internal_value: UCSTRING
			toe_attribute: TOE_ATTRIBUTE
			attribute: XML_ATTRIBUTE
		do
			create internal_name.make_from_string (a_name)
			create internal_prefix.make_from_string (a_prefix)
			create internal_value.make_from_string (a_value)
			create toe_attribute.make (internal_name, internal_prefix, internal_value, element)
			create attribute.make_from_imp (toe_attribute)
			element.force_last (attribute)
		end
	
	add_element_containing_integer (element: XML_ELEMENT; element_name: STRING; value: INTEGER) is
			-- Add an element named `element' containing integer data `value' to `element'.
		local
			new_element: XML_ELEMENT
		do
			new_element := new_child_element (element, element_name, "")
			element.force_last (new_element)
			add_string_data (new_element, value.out)
		end

	add_element_containing_string (element: XML_ELEMENT; element_name, value: STRING) is
			-- Add an element named `element' containing string data `value' to `element'.
		local
			new_element: XML_ELEMENT
		do
			new_element := new_child_element (element, element_name, "")
			element.force_last (new_element)
			add_string_data (new_element, value)
		end

	add_element_containing_boolean (element: XML_ELEMENT; element_name: STRING; value: BOOLEAN) is
			-- Add an element named `element' containing boolean data `value' to `element'.
		local
			new_element: XML_ELEMENT
		do
			new_element := new_child_element (element, element_name, "")
			element.force_last (new_element)
			add_boolean_data (new_element, value)
		end

	add_boolean_data (element: XML_ELEMENT; content: BOOLEAN) is
			-- Add boolean character data with content `content' to `element'
		local	
			new_element: XML_CHARACTER_DATA
			toe_character_data: TOE_CHARACTER_DATA
			string: UCSTRING
		do
			if content then
				create string.make_from_string ("true")
			else
				create string.make_from_string ("false")
			end
			create toe_character_data.make (element, string)
			create new_element.make_from_imp (toe_character_data)
			element.force_last (new_element)
		end

	add_string_data (element: XML_ELEMENT; content: STRING) is
			-- Add string character data with content `content' to `element'
		local	
			new_element: XML_CHARACTER_DATA
			toe_character_data: TOE_CHARACTER_DATA
			string: UCSTRING
		do
			create string.make_from_string (content)
			create toe_character_data.make (element, string)
			create new_element.make_from_imp (toe_character_data)
			element.force_last (new_element)
		end

	create_widget_instance (element: XML_ELEMENT; widget_name: STRING): XML_ELEMENT is
		do
			Result := new_child_element (element, "item", "")
			add_attribute_to_element (Result, "type", "xsi", widget_name)
		end

feature {NONE} -- Widget specific's.

	fill_window (a_window: EV_WINDOW; element: XML_ELEMENT) is
			-- Update `element' from information in `a_window'.
		do
			setup_EV_WIDGET (a_window, Void, element)
			setup_EV_POSITIONABLE (a_window, element)
			--| FIXME window action sequences need implementing here.
			if a_window.item /= Void then
				add_widget_to_container (a_window.item, a_window, clone (element))
			end
			--| FIXME Lower bar needs to be implemented here.
			add_element_containing_boolean (element, "is_modal", a_window.is_modal)
			add_element_containing_integer (element, "maximum_height", a_window.maximum_height)
			add_element_containing_integer (element, "maximum_width", a_window.maximum_width)
			if a_window.menu_bar /= Void then
				add_menu_bar (a_window.menu_bar, a_window, clone (element))
			end
			if not a_window.title.empty then
				add_element_containing_string (element, "title", a_window.title)
			end
			--|FIXME Upper bar needs to be implemented here.
			add_element_containing_boolean (element, "user_can_resize", a_window.user_can_resize)
		end

	add_menu_bar (menu_bar: EV_MENU_BAR; parent: EV_WINDOW; element: XML_ELEMENT) is
		local
			new_element: XML_ELEMENT
		do
			new_element := new_child_element (element, "menu_bar", "")
			--add_attribute_to_element (Result, "", "xsi", widget_name)
			--new_element := create_widget_instance (element, "EV_MENU_BAR")
			if new_element /= Void then
				element.force_last (new_element)
				from
					menu_bar.start
				until
					menu_bar.off
				loop
					add_menu_to_menu_bar (menu_bar.item, menu_bar, new_element)
					menu_bar.forth
				end
			end
		end

	add_menu_to_menu_bar (menu_item: EV_MENU_ITEM; parent: EV_MENU_BAR; element: XML_ELEMENT) is
		local
			new_element: XML_ELEMENT
			menu: EV_MENU
		do
			new_element := create_widget_instance (element, "EV_MENU")
			element.force_last (new_element)
			setup_EV_MENU_ITEM (menu_item, Void, new_element)
			--FIXME need to implement EV_MENU_ITEM_ACTION_SEQUENCES here.
		end

	setup_EV_MENU_ITEM (menu_item: EV_MENU_ITEM; parent: EV_MENU_ITEM_LIST; element: XML_ELEMENT) is
		local
			menu: EV_MENU
			menu_list: EV_MENU_ITEM_LIST
		do
			menu ?= parent
			check
				menu_not_void: menu /= Void
			end
			setup_EV_ITEM (menu_item, menu, element)
			setup_EV_TEXTABLE (menu_item, element)
			setup_EV_SENSITIVE (menu_item, element)
			--|FIXME EV_MENU_ITEM_ACTION_SEQUENCES needs to be implemented here.
				menu_list ?= menu_item
				if menu_list /= Void then
				from
					menu_list.start
				until
					menu_list.off
				loop
					add_item_to_item_holder (menu_list.item, menu, element)
					menu_list.forth
				end
			end
		end

	add_widget_to_container (a_widget: EV_WIDGET; parent: EV_CONTAINER; element: XML_ELEMENT) is
		require
			widget_not_void: a_widget /= Void
			element_not_void: element /= Void
		local
			new_element: XML_ELEMENT
			button: EV_BUTTON
			label: EV_LABEL
			horizontal_box: EV_HORIZONTAL_BOX
			vertical_box: EV_VERTICAL_BOX
			drawing_area: EV_DRAWING_AREA
			horizontal_scroll_bar: EV_HORIZONTAL_SCROLL_BAR
			vertical_scroll_bar: EV_VERTICAL_SCROLL_BAR
			vertical_range: EV_VERTICAL_RANGE
			horizontal_range: EV_HORIZONTAL_RANGE
			toggle_button: EV_TOGGLE_BUTTON
			check_button: EV_CHECK_BUTTON
			radio_button: EV_RADIO_BUTTON
			list: EV_LIST
			cell: EV_CELL
			horizontal_split_area: EV_HORIZONTAL_SPLIT_AREA
			vertical_split_area: EV_VERTICAL_SPLIT_AREA
			frame: EV_FRAME
			notebook: EV_NOTEBOOK
			viewport: EV_VIEWPORT
			scrollable_area: EV_SCROLLABLE_AREA
			vertical_separator: EV_VERTICAL_SEPARATOR
			horizontal_separator: EV_HORIZONTAL_SEPARATOR
			tree: EV_TREE
			spin_button: EV_SPIN_BUTTON
		do
			button ?= a_widget
			if button /= Void then
				toggle_button ?= button
				if toggle_button /= Void then
					check_button ?= button
					if check_button /= Void then
						new_element := create_widget_instance (element, "EV_CHECK_BUTTON")
						if new_element /= Void then
							element.force_last (new_element)
							setup_EV_CHECK_BUTTON (check_button, parent, new_element)
						end
					else
						new_element := create_widget_instance (element, "EV_TOGGLE_BUTTON")
						if new_element /= Void then
							element.force_last (new_element)
							setup_EV_TOGGLE_BUTTON (toggle_button, parent, new_element)
						end
					end
				else
					radio_button ?= button
					if radio_button /= Void then
						new_element := create_widget_instance (element, "EV_RADIO_BUTTON")
						if new_element /= Void then
							element.force_last (new_element)
							setup_EV_RADIO_BUTTON (radio_button, parent, new_element)
						end
					else
						new_element := create_widget_instance (element, "EV_BUTTON")
						if new_element /= Void then
							element.force_last (new_element)
							setup_EV_BUTTON (button, parent, new_element)
						end
					end
				end	
			end
			label ?= a_widget
			if label /= Void then
				new_element := create_widget_instance (element, "EV_LABEL")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_LABEL (label, parent, new_element)
				end
			end
			horizontal_box ?= a_widget
			if horizontal_box /= Void then
				new_element := create_widget_instance (element, "EV_HORIZONTAL_BOX")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_BOX (horizontal_box, parent, new_element)
				end
			end
			vertical_box ?= a_widget
			if vertical_box /= Void then
				new_element := create_widget_instance (element, "EV_VERTICAL_BOX")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_BOX (vertical_box, parent, new_element)
				end
			end
			drawing_area ?= a_widget
			if drawing_area /= Void then
				new_element := create_widget_instance (element, "EV_DRAWING_AREA")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_DRAWING_AREA (drawing_area, parent, new_element)
				end
			end
			vertical_scroll_bar ?= a_widget
			if vertical_scroll_bar /= Void then
				new_element := create_widget_instance (element, "EV_VERTICAL_SCROLL_BAR")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_SCROLL_BAR (vertical_scroll_bar, parent, new_element)
				end
			end
			horizontal_scroll_bar ?= a_widget
			if horizontal_scroll_bar /= Void then
				new_element := create_widget_instance (element, "EV_HORIZONTAL_SCROLL_BAR")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_SCROLL_BAR (horizontal_scroll_bar, parent, new_element)
				end
			end
			vertical_range ?= a_widget
			if vertical_range /= Void then
				new_element := create_widget_instance (element, "EV_VERTICAL_RANGE")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_RANGE (vertical_range, parent, new_element)
				end
			end
			horizontal_range ?= a_widget
			if horizontal_range /= Void then
				new_element := create_widget_instance (element, "EV_HORIZONTAL_RANGE")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_RANGE (horizontal_range, parent, new_element)
				end
			end
			list ?= a_widget
			if list /= Void then
				new_element := create_widget_instance (element, "EV_LIST")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_LIST (list, parent, new_element)
				end
			end
			cell ?= a_widget
			if cell /= Void then
				frame ?= a_widget
				viewport ?= a_widget
				scrollable_area ?= a_widget
				if frame /= Void then
					new_element := create_widget_instance (element, "EV_FRAME")
					if new_element /= Void then
						element.force_last (new_element)
						setup_EV_FRAME (frame, parent, new_element)
					end
				elseif scrollable_area /= Void then
					new_element := create_widget_instance (element, "EV_SCROLLABLE_AREA")
					if new_element /= Void then
						element.force_last (new_element)
						setup_EV_SCROLLABLE_AREA (scrollable_area, parent, new_element)
					end
				elseif viewport /= Void then
					new_element := create_widget_instance (element, "EV_VIEWPORT")
					if new_element /= Void then
						element.force_last (new_element)
						setup_EV_VIEWPORT (viewport, parent, new_element)
					end
				else
					new_element := create_widget_instance (element, "EV_CELL")
					if new_element /= Void then
						element.force_last (new_element)
						setup_EV_CELL (cell, parent, new_element)
					end
				end
			end
			horizontal_split_area ?= a_widget
			if horizontal_split_area /= Void then
				new_element := create_widget_instance (element, "EV_HORIZONTAL_SPLIT_AREA")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_SPLIT_AREA (horizontal_split_area, parent, new_element)
				end
			end
			vertical_split_area ?= a_widget
			if vertical_split_area /= Void then
				new_element := create_widget_instance (element, "EV_VERTICAL_SPLIT_AREA")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_SPLIT_AREA (vertical_split_area, parent, new_element)
				end
			end
			notebook ?= a_widget
			if notebook /= Void then
				new_element := create_widget_instance (element, "EV_NOTEBOOK")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_NOTEBOOK (notebook, parent, new_element)
				end
			end
			horizontal_separator ?= a_widget
			if horizontal_separator /= Void then
				new_element := create_widget_instance (element, "EV_HORIZONTAL_SEPARATOR")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_SEPARATOR (horizontal_separator, parent, new_element)
				end
			end
			vertical_separator ?= a_widget
			if vertical_separator /= Void then
				new_element := create_widget_instance (element, "EV_VERTICAL_SEPARATOR")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_SEPARATOR (vertical_separator, parent, new_element)
				end
			end
			tree ?= a_widget
			if tree /= Void then
				new_element := create_widget_instance (element, "EV_TREE")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_TREE (tree, parent, new_element)
				end
			end
			spin_button ?= a_widget
			if spin_button /= Void then
				new_element := create_widget_instance (element, "EV_SPIN_BUTTON")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_SPIN_BUTTON (spin_button, parent, new_element)
				end
			end
		end

	setup_EV_LIST_ITEM_LIST (list_item_list: EV_LIST_ITEM_LIST; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_PRIMITIVE (list_item_list, parent, element)
			--| FIXME EV_LIST_ITEM_LIST_ACTION_SEQUENCES need's to be implemented here.
		end

	setup_EV_LIST (list: EV_LIST; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_LIST_ITEM_LIST (list, parent, element)
			from
				list.start
			until
				list.off
			loop
				if list.item /= Void then
					add_item_to_item_holder (list.item, list, element)
				end
				list.forth
			end
			add_element_containing_boolean (element, "multipled_selection_enabled", list.multiple_selection_enabled)
			add_element_containing_integer (element, "pixmaps_height", list.pixmaps_height)
			add_element_containing_integer (element, "pixmaps_width", list.pixmaps_width)
		end

	setup_EV_TREE (tree: EV_TREE; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_PRIMITIVE (tree, parent, element)
			--| FIXME EV_TREE_ACTION_SEQUENCES need's to be implemented here.
			from
				tree.start
			until
				tree.off
			loop
				if tree.item /= Void then
					add_item_to_item_holder (tree.item, tree, element)
				end
				tree.forth
			end
			add_element_containing_integer (element, "pixmaps_height", tree.pixmaps_height)
			add_element_containing_integer (element, "pixmaps_width", tree.pixmaps_width)
		end

	setup_ev_tree_item (tree_item: EV_TREE_ITEM; parent: EV_TREE_NODE_LIST; element: XML_ELEMENT) is
		do
			setup_ev_tree_node (tree_item, parent, element)
			from
				tree_item.start
			until
				tree_item.off
			loop
				if tree_item /= Void then
					add_item_to_item_holder (tree_item.item, tree_item, element)
				end
				tree_item.forth
			end
		end

	setup_ev_tree_node (tree_node: EV_TREE_NODE; parent: EV_TREE_NODE_LIST; element: XML_ELEMENT) is
		do
			setup_ev_item (tree_node, parent, element)
			setup_ev_textable (tree_node, element)
			setup_ev_selectable (tree_node, element)
			setup_ev_tooltipable (tree_node, element)
			--| FIXME EV_TREE_NODE_ACTION_SEQUENCES needs implementing here.
			add_element_containing_boolean (element, "is_expanded", tree_node.is_expanded)
		end

	
	add_item_to_item_holder (item: EV_ITEM; parent: EV_ITEM_LIST [EV_ITEM]; element: XML_ELEMENT) is
		local
			new_element: XML_ELEMENT
			list_item: EV_LIST_ITEM
			menu_item: EV_MENU_ITEM
			menu: EV_MENU
			menu_parent: EV_MENU_ITEM_LIST
			tree_item: EV_TREE_ITEM
			tree_parent: EV_TREE_NODE_LIST
		do
			list_item ?= item
			if list_item /= Void then
				new_element := create_widget_instance (element, "EV_LIST_ITEM")
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_LIST_ITEM (list_item, parent, new_element) 
				end
			end
			menu_item ?= item
			if menu_item /= Void then
				menu_parent ?= parent
				menu ?= item
				if menu /= Void then
					new_element := create_widget_instance (element, "EV_MENU")
				else
					new_element := create_widget_instance (element, "EV_MENU_ITEM")
				end
				if new_element /= Void then
					element.force_last (new_element)
					setup_EV_MENU_ITEM (menu_item, menu_parent, new_element)
				end
			end
			tree_item ?= item
			if tree_item /= Void then
				new_element := create_widget_instance (element, "EV_TREE_ITEM")
				if new_element /= Void then
					element.force_last (new_element)
					tree_parent ?= parent
					check
						tree_parent_not_void: tree_parent /= Void 
					end
					setup_EV_TREE_ITEM (tree_item, tree_parent, new_element)
				end
			end
		end

	setup_EV_ITEM (item: EV_ITEM; parent: EV_ITEM_LIST [EV_ITEM]; element: XML_ELEMENT) is
		do
			setup_EV_PICK_AND_DROPABLE (item, element)
			setup_EV_PIXMAPABLE (item, element)
			--| FIXME EV_ITEM_ACTION_SEQUENCES needs to be implemented here.
		end

	setup_EV_LIST_ITEM (list_item: EV_LIST_ITEM; parent: EV_ITEM_LIST [EV_ITEM]; element: XML_ELEMENT) is
		do
			setup_EV_ITEM (list_item, parent, element)
			setup_EV_TEXTABLE (list_item, element)
			setup_EV_SELECTABLE (list_item, element)
			setup_EV_TOOLTIPABLE (list_item, element)
			--| FIXME EV_LIST_ITEM_ACTION_SEQUENCES needs to be implemented here.
		end

	setup_EV_GAUGE (gauge: EV_GAUGE; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_PRIMITIVE (gauge, parent, element)
			--| FIXME EV_GAUGE_ACTION_SEQUENCES needs to be implemented here.
			setup_value_range (gauge.value_range, element)
			add_element_containing_integer (element, "leap", gauge.leap)
			add_element_containing_integer (element, "step", gauge.step)
			add_element_containing_integer (element, "value", gauge.value)
		end

	setup_EV_DRAWING_AREA (drawing_area: EV_DRAWING_AREA; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_PRIMITIVE (drawing_area, parent, element)
		end

	setup_EV_LABEL (label: EV_LABEL; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_PRIMITIVE (label, parent, element)
			setup_EV_TEXTABLE (label, element)
			setup_EV_FONTABLE (label, element)
		end

	setup_EV_BUTTON (button: EV_BUTTON; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_PRIMITIVE (button, parent, element)
			setup_EV_TEXTABLE (button, element)
			setup_EV_PIXMAPABLE (button, element)
			--| FIXME EV_BUTTON_ACTION_SEQUENCES needs to be implemented here.
			--| FIXME We cannot query `is_default_push_button'.
			--add_element_containing_boolean (element, "is_default_push_button", button.is_default_push_button)
		end

	setup_EV_TOGGLE_BUTTON (toggle_button: EV_TOGGLE_BUTTON; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_BUTTON (toggle_button, parent, element)
			setup_EV_SELECTABLE (toggle_button, element)
		end

	setup_EV_CHECK_BUTTON (check_button: EV_CHECK_BUTTON; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_TOGGLE_BUTTON (check_button, parent, element)
		end

	setup_EV_RADIO_BUTTON (radio_button: EV_RADIO_BUTTON; parent: EV_CONTAINER; element: XML_ELEMENT) is
			-- Does not call setup_EV_TOGGLE_BUTTON, as interface does not inherit from toggle button.
		do
			setup_EV_BUTTON (radio_button, parent, element)
			setup_EV_SELECTABLE (radio_button, element)
		end

	setup_EV_TEXTABLE (textable: EV_TEXTABLE; element: XML_ELEMENT) is
		local
			new_element: XML_ELEMENT
		do
			new_element := new_child_element (element, "EV_TEXTABLE", "")
			element.force_last (new_element)
			if textable.alignment.is_left_aligned then
				add_element_containing_string (new_element, "alignment", "left")
			elseif textable.alignment.is_center_aligned then
				add_element_containing_string (new_element, "alignment", "center")
			elseif textable.alignment.is_right_aligned then
				add_element_containing_string (new_element, "alignment", "right")
			end
			if textable.text/= Void then
				add_element_containing_string (new_element, "text", textable.text)
			end
		end

	setup_EV_PIXMAPABLE (pixmapable: EV_PIXMAPABLE; element: XML_ELEMENT) is
		do
			--| FIXME Implement this.
		end

	setup_EV_WIDGET (a_widget: EV_WIDGET; parent: EV_CONTAINER; element: XML_ELEMENT) is
		local
			box: EV_BOX
			split_area: EV_SPLIT_AREA
		do
			setup_EV_PICK_AND_DROPABLE (a_widget, element)
			setup_EV_SENSITIVE (a_widget, element)
			setup_EV_COLORIZABLE (a_widget, element)
			setup_EV_POSITIONED (a_widget, element)
			setup_EV_WIDGET_ACTION_SEQUENCES (a_widget, element)
			--| FIXME actual_drop_target_agent needs implementing here.
			add_element_containing_boolean (element, "is_show_requested", a_widget.is_show_requested)
			--| FIXME Pointer_style needs implementing here
			box ?= parent
			if box /= Void then
				add_element_containing_boolean (element, "expandable", box.is_item_expanded (a_widget))
			else
				split_area ?= parent
				if split_area /= Void then
					add_element_containing_boolean (element, "expandable", split_area.is_item_expanded (a_widget))
				else
					add_element_containing_boolean (element, "expandable", true)
				end
			end
			add_element_containing_boolean (element, "has_focus", a_widget.has_focus)
		end

	setup_EV_BOX (box: EV_BOX; parent: EV_CONTAINER; element: XML_ELEMENT) is
			-- Update `element' from information in `a_box'.
		do
			setup_EV_WIDGET (box, Void, element)
			--| FIXME EV_CONTAINER_ACTION_SEQUENCES needs to be implemented here.
			from
				box.start
			until
				box.off
			loop
				if box.item /= Void then
					add_widget_to_container (box.item, box, element)
				end
				box.forth
			end
			add_element_containing_integer (element, "border_width", box.border_width)
			add_element_containing_boolean (element, "is_homogeneoue", box.is_homogeneous)
			add_element_containing_integer (element, "padding", box.padding)
		end

	setup_EV_NOTEBOOK (notebook: EV_NOTEBOOK; parent: EV_CONTAINER; element: XML_ELEMENT) is
			-- Update `element' from information in `notebook'.
		do
			setup_EV_WIDGET (notebook, Void, element)
			--| FIXME EV_CONTAINER_ACTION_SEQUENCES needs to be implemented here.
			--| FIXME EV_NOTEBOOK_ACTION_SEQUENCES needs to be implemented here.
			from
				notebook.start
			until
				notebook.off
			loop
				if notebook.item /= Void then
					add_widget_to_container (notebook.item, notebook, element)
					add_element_containing_string (element, "item_text", notebook.item_text (notebook.item))
				end
				notebook.forth
			end
			add_element_containing_integer (element, "selected_item_index", notebook.selected_item_index)
			add_element_containing_integer (element, "tab_position", notebook.tab_position)
		end

	setup_EV_CELL (cell: EV_CELL; parent: EV_CONTAINER; element: XML_ELEMENT) is
			-- Update `element' from information in `cell'.
		do
			setup_EV_WIDGET (cell, Void, element)
			--| FIXME EV_CONTAINER_ACTION_SEQUENCES needs to be implemented here.
			if cell.item /= Void then
				add_widget_to_container (cell.item, cell, element)
			end
		end

	setup_EV_VIEWPORT (viewport: EV_VIEWPORT; parent: EV_CONTAINER; element: XML_ELEMENT) is
			-- Update `element' from information in `viewport'.
		do
			setup_EV_CELL (viewport, parent, element)
			add_element_containing_integer (element, "x_offset", viewport.x_offset)
			add_element_containing_integer (element, "y_offset", viewport.y_offset)
		end

	setup_EV_SCROLLABLE_AREA (scrollable_area: EV_SCROLLABLE_AREA; parent: EV_CONTAINER; element: XML_ELEMENT) is
			-- Update `element' from information in `scrollable_area'.
		do
			setup_EV_VIEWPORT (scrollable_area, parent, element)
			add_element_containing_integer (element, "horizontal_step", scrollable_area.horizontal_step)
			add_element_containing_boolean (element, "is_horizontal_scroll_bar_visible", scrollable_area.is_horizontal_scroll_bar_visible)
			add_element_containing_boolean (element, "is_vertical_scroll_bar_visible", scrollable_area.is_vertical_scroll_bar_visible)
			add_element_containing_integer (element, "vertical_step", scrollable_area.vertical_step)
		end

	

	setup_EV_SPLIT_AREA (split_area: EV_SPLIT_AREA; parent: EV_CONTAINER; element: XML_ELEMENT) is
			-- Update `element' from information in `split_area'.
		do
			setup_EV_WIDGET (split_area, Void, element)
			--| FIXME EV_CONTAINER_ACTION_SEQUENCES needs to be implemented here.
			if split_area.first /= Void then
				add_widget_to_container (split_area.first, split_area, element)
			end
			if split_area.second /= Void then
				add_widget_to_container (split_area.second, split_area, element)
			end
			add_element_containing_integer (element, "split_position", split_area.split_position)
		end

	setup_EV_FRAME (frame: EV_FRAME; parent: EV_CONTAINER; element: XML_ELEMENT) is
			-- Update `element' from information in `frame'.
		do
			setup_EV_WIDGET (frame, Void, element)
			--| FIXME EV_CONTAINER_ACTION_SEQUENCES needs to be implemented here.
			setup_EV_TEXTABLE (frame, element)
			if frame.item /= Void then
				add_widget_to_container (frame.item, frame, element)
			end
			add_element_containing_integer (element, "style", frame.style)
		end

	setup_EV_SPIN_BUTTON (spin_button: EV_SPIN_BUTTON; parent: EV_CONTAINER; element: XML_ELEMENT) is
			-- Update `element' from information in `frame'.
		do
			setup_ev_gauge (spin_button, parent, element)
			setup_ev_text_field_basic (spin_button, parent, element)	
		end

	setup_ev_text_field_basic (text_field: EV_TEXT_FIELD; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_ev_text_component_basic (text_field, parent, element)
			--| FIXME implement EV_TEXT_FIELD_ACTION_SEQUENCES here.
			add_element_containing_integer (element, "capacity", text_field.capacity)
		end

	setup_ev_text_component_basic (text_component: EV_TEXT_COMPONENT; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			--|FIXME implement EV_TEXT_COMPONENT_ACTION_SEQUENCES here.
			add_element_containing_integer (element, "caret_position", text_component.caret_position)
			add_element_containing_boolean (element, "is_editable", text_component.is_editable)
			add_element_containing_string (element, "text", text_component.text)
		end

	setup_EV_SCROLL_BAR (scroll_bar: EV_SCROLL_BAR; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_GAUGE (scroll_bar, parent, element)
		end

	setup_EV_RANGE (range: EV_RANGE; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_GAUGE (range, parent, element)
		end

	setup_EV_SEPARATOR (separator: EV_SEPARATOR; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_PRIMITIVE (separator, parent, element)
		end


	setup_EV_PICK_AND_DROPABLE (pick_and_dropable: EV_PICK_AND_DROPABLE; element: XML_ELEMENT) is
		do
			--| FIXME Implement this.
		end

	setup_EV_FONTABLE (fontable: EV_FONTABLE; element: XML_ELEMENT) is
		do
			--| FIXME Implement this.
		end

	setup_EV_PRIMITIVE (primitive: EV_PRIMITIVE; parent: EV_CONTAINER; element: XML_ELEMENT) is
		do
			setup_EV_WIDGET (primitive, parent, element)
			setup_EV_TOOLTIPABLE (primitive, element)
		end

	setup_EV_WIDGET_ACTION_SEQUENCES (a_widget: EV_WIDGET; element: XML_ELEMENT) is
		do
			--| FIXME
		end

	setup_EV_TOOLTIPABLE (tooltipable: EV_TOOLTIPABLE; element: XML_ELEMENT) is
		local
			new_element: XML_ELEMENT
		do
			new_element := new_child_element (element, "EV_TOOLTIPABLE", "")
			element.force_last (new_element)
			if tooltipable.tooltip /= Void then
				add_element_containing_string (new_element, "tooltip", tooltipable.tooltip)
			end
		end

	setup_EV_POSITIONED (positioned: EV_POSITIONED; element: XML_ELEMENT) is
		local
			new_element: XML_ELEMENT
		do
			new_element := new_child_element (element, "EV_POSITIONED", "")
			element.force_last (new_element)
				-- You can only set a minimum_width or height greater than 0.
			if positioned.minimum_height > 0 then
				add_element_containing_integer (new_element, "minimum_height", positioned.minimum_height)
			end
			if positioned.minimum_width > 0 then
				add_element_containing_integer (new_element, "minimum_width", positioned.minimum_width)
			end
		end

	setup_EV_POSITIONABLE (positionable: EV_POSITIONABLE; element: XML_ELEMENT) is
		local
			new_element: XML_ELEMENT 
		do
			new_element := new_child_element (element, "EV_POSITIONABLE", "")
			element.force_last (new_element)
			add_element_containing_integer (new_element, "x_position", positionable.x_position)
			add_element_containing_integer (new_element, "y_position", positionable.y_position)
			add_element_containing_integer (new_element, "width", positionable.width)
			add_element_containing_integer (new_element, "height", positionable.height)

		end

	setup_EV_SENSITIVE (sensitive: EV_SENSITIVE; element: XML_ELEMENT) is
		local
			new_element: XML_ELEMENT
		do
			new_element := new_child_element (element, "EV_SENSITIVE", "")
			element.force_last (new_element)
			add_element_containing_boolean (new_element, "is_sensitive", sensitive.is_sensitive)
		end

	setup_EV_COLORIZABLE (colorizable: EV_COLORIZABLE; element: XML_ELEMENT) is
		local
			new_element: XML_ELEMENT
			foreground: XML_ELEMENT
			background: XML_ELEMENT
			a_color: EV_COLOR
		do
			new_element := new_child_element (element, "EV_COLORIZABLE", "")
			element.force_last (new_element)

			background := new_child_element (new_element, "background_color", "")
			new_element.force_last (background)
			a_color := colorizable.background_color
			add_element_containing_integer (background, "red", a_color.red_8_bit)
			add_element_containing_integer (background, "green", a_color.green_8_bit)
			add_element_containing_integer (background, "blue", a_color.blue_8_bit)

			foreground := new_child_element (new_element, "foreground_color", "")
			new_element.force_last (foreground)
			a_color := colorizable.foreground_color
			add_element_containing_integer (foreground, "red", a_color.red_8_bit)
			add_element_containing_integer (foreground, "green", a_color.green_8_bit)
			add_element_containing_integer (foreground, "blue", a_color.blue_8_bit)
			
		end

	setup_value_range (value_range: INTEGER_INTERVAL; element: XML_ELEMENT) is
		local
			new_element: XML_ELEMENT
		do
			new_element := new_child_element (element, "value_range", "")			
			element.force_last (new_element)
			add_element_containing_integer (new_element, "upper", value_range.upper)
			add_element_containing_integer (new_element, "lower", value_range.lower)
		end

	setup_EV_SELECTABLE (selectable: EV_SELECTABLE; element: XML_ELEMENT) is
		local
			new_element: XML_ELEMENT
		do
			new_element := new_child_element (element, "EV_SELECTABLE", "")
			element.force_last (new_element)
			add_element_containing_boolean (new_element, "is_selected", selectable.is_selected)
		end

invariant
	invariant_clause: -- Your invariant here

end -- class APPLICATION_STORE


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

