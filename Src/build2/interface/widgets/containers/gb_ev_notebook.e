indexing
	description: "Objects that manipulate objects of type EV_NOTEBOOK"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_NOTEBOOK

inherit
	
	GB_EV_ANY
		redefine
			attribute_editor,
			ev_type,
			modify_from_xml_after_build
		end
		
	GB_ACCESSIBLE_DEFERRED_BUILDER
		undefine
			default_create
		end
		
	GB_XML_UTILITIES
		undefine
			default_create
		end
		
		
feature -- Access

	ev_type: EV_NOTEBOOK
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_NOTEBOOK"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			label: EV_LABEL
			name_field: EV_TEXT_FIELD
		do
			Result := Precursor {GB_EV_ANY}
			create label.make_with_text ("Tab position")
			Result.extend (label)
			create combo_box
			Result.extend (combo_box)
			combo_box.disable_edit
			create top_item.make_with_text (Ev_tab_top_string)
			combo_box.extend (top_item)
			create bottom_item.make_with_text (Ev_tab_bottom_string)
			combo_box.extend (bottom_item)
			create right_item.make_with_text (Ev_tab_right_string)
			combo_box.extend (right_item)
			create left_item.make_with_text (Ev_tab_left_string)
			combo_box.extend (left_item)
			combo_box.select_actions.extend (agent selection_changed)
			combo_box.select_actions.extend (agent update_editors)
			
			create label.make_with_text ("Item text")
			Result.extend (label)
			from
				first.start
			until
				first.off
			loop
				create name_field.make_with_text (first.item_text (first.item))
				name_field.change_actions.extend (agent change_item_text (name_field, first.index))
				Result.extend (name_field)
				first.forth
			end

			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			combo_box.select_actions.block
			if first.tab_position = first.tab_top then
				top_item.enable_select
			elseif first.tab_position = first.tab_bottom then
				bottom_item.enable_select
			elseif first.tab_position = first.tab_right then
				right_item.enable_select
			elseif first.tab_position = first.tab_left then
				left_item.enable_select
			end
			combo_box.select_actions.resume
		end

feature {GB_XML_STORE} -- Output
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			notebook: EV_NOTEBOOK
			names_string: STRING
		do
			notebook ?= new_instance_of (dynamic_type_from_string (class_name (first)))
			notebook.default_create
			if first.tab_position /= notebook.tab_position then
				add_element_containing_integer (element, Tab_position_string, first.tab_position)
			end
			from
				first.start
				names_string := ""
			until
				first.off
			loop
				names_string.append_string (first.item_text (first.item))
				if first.index /= first.count then
					names_string.append_character (separator_char)
				end
				first.forth
			end
			if not names_string.is_empty then
				add_element_containing_string (element, Item_text_string, names_string)
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			current_element: XML_ELEMENT
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
		do
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ (Tab_position_string)
			if element_info /= Void then
				for_all_objects (agent {EV_NOTEBOOK}.set_tab_position (element_info.data.to_integer))
			end
				-- We set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
	modify_from_xml_after_build (element: XML_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			names: ARRAYED_LIST [STRING]
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (Item_text_string)
			if element_info /= Void then
				names := names_from_string (element_info.data)
				from
					names.start
				until
					names.off
				loop
					first.set_item_text (first.i_th (names.index), names.item)
					(objects @ 2).set_item_text ((objects @ 2).i_th (names.index), names.item)
					system_status.enable_project_modified
					command_handler.update

					names.forth
				end
			end
		end	
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; a_name: STRING; children_names: ARRAYED_LIST [STRING]): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			names: ARRAYED_LIST [STRING]
		do
			Result := ""
			full_information := get_unique_full_info (element)
			element_info := full_information @ (tab_position_string)
			if element_info /= Void then
				Result := a_name + ".set_tab_position (" + element_info.data + ")"
			end
			element_info := full_information @ (Item_text_string)
			if element_info /= Void then
				names := names_from_string (element_info.data)
				check
					consistent_counts: children_names.count = names.count
				end
				from
					names.start
				until
					names.off
				loop
						-- If the current name is empty, then we do not generate a setting.
					if not names.item.is_equal ("") then
						Result := Result + indent + a_name + ".set_item_text (" + (children_names @ (names.index)) + ", %"" + names.item + "%")"
					end
					names.forth
				end
			end
			Result := strip_leading_indent (Result)
		end

feature {NONE} -- Implementation

	selection_changed is
			-- Selection in `combo_box' changed.
		do
			for_all_objects (agent {EV_NOTEBOOK}.set_tab_position (position_from_text (combo_box.selected_item.text)))
		end
		
		
	change_item_text (text_field: EV_TEXT_FIELD; index: INTEGER) is
			-- Modify representations of EV_NOTEBOOK to reflect a text change
			-- on layout item `index'. We cannot use `for_all_objects' as
			-- we need to get access to the real widget in each representation
			-- so doing it this way is easier.
		do
			first.set_item_text (first.i_th (index), text_field.text)
			(objects @ 2).set_item_text ((objects @ 2).i_th (index), text_field.text)
			system_status.enable_project_modified
			command_handler.update			
		end
		
	names_from_string (a_string: STRING): ARRAYED_LIST [STRING] is
			-- `Result' is all tab names encoded in `a_string'.
			-- each is separated by `separator_char'.
		local
			pos, last_pos: INTEGER
			item_position: INTEGER
			looped_already: BOOLEAN
		do
			create Result.make (0)
			from
				pos := 1
				item_position := 1
			until
				pos = a_string.count + 1
			loop
				if looped_already then
					last_pos := pos + 1
				else
					last_pos := 1
				end
			
				pos := a_string.index_of (separator_char, last_pos)
					-- This handles the last case.
				if pos = 0  then
					pos := a_string.count + 1
				end
				Result.extend (a_string.substring (last_pos, pos - 1))
				item_position := item_position + 1
				looped_already := True
			end
		end

	position_from_text (text: STRING): INTEGER is
			-- `Result' is integer value corresponding
			-- to `text' tab style. i.e. "Ev_tab_left_string".
		do
			if text.is_equal (Ev_tab_top_string) then
				Result := first.Tab_top
			elseif text.is_equal (Ev_tab_bottom_string) then
				Result := first.Tab_bottom
			elseif text.is_equal (Ev_tab_right_string) then
				Result := first.Tab_right
			elseif text.is_equal (Ev_tab_left_string) then
				Result := first.Tab_left
			else
				check
					False
				end
			end
		end

	combo_box: EV_COMBO_BOX
		-- Holds possible tab positions.
		
	Ev_tab_left_string: STRING is "Left"
	Ev_tab_right_string: STRING is "Right"
	Ev_tab_top_string: STRING is "Top"
	Ev_tab_bottom_string: STRING is "Bottom"
		-- String constants used for different tab_positions
	
	Tab_position_string: STRING is "Tab_position"
		-- String used to represent the tab position in the XML.
	Item_text_string: STRING is "Item_text"
		-- String used to represent the texts of the tabs in the XML.
	
	separator_char: CHARACTER is '^'
	
	top_item, bottom_item, left_item, right_item: EV_LIST_ITEM
		-- Selctions for combo box.

end -- class GB_EV_NOTEBOOK
