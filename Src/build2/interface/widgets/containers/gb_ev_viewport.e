indexing
	description: "Objects that manipulate objects of type EV_VIEWPORT"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_EV_VIEWPORT
	
	-- The following properties from EV_VIEWPORT are manipulated by `Current'.
	-- X_offset - Performed on the real object and the display_object.
	-- Y_offset - Performed on the real object and the display_object.
	-- Set_item_height and Set_item_width are both manipulated on both objects.

inherit
	
	GB_EV_ANY
		redefine
			attribute_editor,
			modify_from_xml_after_build,
			ev_type
		end
		
	GB_XML_UTILITIES
		undefine
			default_create
		end
		
	GB_SHARED_DEFERRED_BUILDER
		undefine
			default_create
		end

feature -- Access

	ev_type: EV_VIEWPORT
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_VIEWPORT"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			label: EV_LABEL
		do
			Result := Precursor {GB_EV_ANY}
			
			create x_offset_entry.make (Current, Result, "X_offset", agent set_x_offset (?), agent valid_position (?))
			create y_offset_entry.make (Current, Result, "Y_offset", agent set_y_offset (?), agent valid_position (?))
			create item_width_entry.make (Current, Result, "Item_width", agent set_item_width (?), agent valid_item_width (?))
			create item_height_entry.make (Current, Result, "Item_height", agent set_item_height (?), agent valid_item_height (?))
			
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
feature {GB_XML_STORE} -- Output

	
	generate_xml (element: XML_ELEMENT) is
			-- Generate an XML representation of `Current' in `element'.
		local
			gauge: EV_GAUGE
		do
			add_element_containing_integer (element, x_offset_string, objects.first.x_offset)
			add_element_containing_integer (element, y_offset_string, objects.first.y_offset)
				-- If we have no child, then we store -1, so we no not to perform any setting when
				-- loading.
			if objects.first.full then
				add_element_containing_integer (element, item_width_string, objects.first.item.width)
				add_element_containing_integer (element, item_height_string, objects.first.item.height)
			else
				add_element_containing_integer (element, item_width_string, -1)
				add_element_containing_integer (element, item_height_string, -1)
			end
		end
		
	modify_from_xml (element: XML_ELEMENT) is
			-- Update all items in `objects' based on information held in `element'.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			element_info2: ELEMENT_INFORMATION
			interval: INTEGER_INTERVAL
		do
				-- We set up some deferred building now.
			deferred_builder.defer_building (Current, element)
		end
		
	modify_from_xml_after_build (element: XML_ELEMENT) is
			-- Build from XML any information that was
			-- deferred during the load/build cycle.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info: ELEMENT_INFORMATION
			element_info2: ELEMENT_INFORMATION
			interval: INTEGER_INTERVAL
		do
			full_information := get_unique_full_info (element)
			element_info := full_information @ (X_offset_string)
			if element_info /= Void then
				set_x_offset (element_info.data.to_integer)
			end
			element_info := full_information @ (Y_offset_string)
			if element_info /= Void then
				set_y_offset (element_info.data.to_integer)
			end
			element_info := full_information @ (Item_width_string)
			if element_info /= Void then
				if element_info.data.to_integer >= 0 then
					set_item_width (element_info.data.to_integer)	
				end
			end
			element_info := full_information @ (Item_height_string)
			if element_info /= Void then
				if element_info.data.to_integer >= 0 then
					set_item_height (element_info.data.to_integer)	
				end
			end
			
		end
		
feature {GB_CODE_GENERATOR} -- Output

	generate_code (element: XML_ELEMENT; a_name, a_type: STRING; children_names: ARRAYED_LIST [STRING]): STRING is
			-- `Result' is string representation of
			-- settings held in `Current' which is
			-- in a compilable format.
		local
			full_information: HASH_TABLE [ELEMENT_INFORMATION, STRING]
			element_info, element_info2: ELEMENT_INFORMATION
			lower, upper: STRING
		do
			Result := ""
			full_information := get_unique_full_info (element)
			
			element_info := full_information @ X_offset_string
			if element_info /= Void and then element_info.data.to_integer /= 0 then
				Result := a_name + ".set_x_offset (" + element_info.data + ")"
			end
			
			element_info := full_information @ Y_offset_string
			if element_info /= Void and then element_info.data.to_integer /= 0 then
				Result := Result + indent + a_name + ".set_y_offset (" + element_info.data + ")"
			end
			
			element_info := full_information @ item_width_string
			if element_info /= Void and then element_info.data.to_integer >= 0 then
				Result := Result + indent + a_name + ".set_item_width (" + element_info.data + ")"
			end
			
			element_info := full_information @ item_height_string
			if element_info /= Void and then element_info.data.to_integer >= 0 then
				Result := Result + indent + a_name + ".set_item_height (" + element_info.data + ")"
			end
		end

feature {NONE} -- Implementation

	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
				-- We need to enable/disable all input fields
				-- depending on whether there is currently an item
				-- in the viewport. This is because these attributes
				-- are only applicable on the children.
			if first.is_empty then
				x_offset_entry.disable_sensitive
				y_offset_entry.disable_sensitive
				item_width_entry.disable_sensitive
				item_height_entry.disable_sensitive
			else
				x_offset_entry.enable_sensitive
				y_offset_entry.enable_sensitive
				item_width_entry.enable_sensitive
				item_height_entry.enable_sensitive
			end

			x_offset_entry.set_text (first.x_offset.out)
			y_offset_entry.set_text (first.y_offset.out)
			if first.full then
				item_width_entry.set_text (first.item.width.out)
				item_height_entry.set_text (first.item.height.out)
			else
				item_width_entry.set_text ("0")
				item_height_entry.set_text ("0")
			end
		end

	set_x_offset (integer: INTEGER) is
			-- Update property `x_offset' on all items in `objects'.
		do
			for_all_objects (agent {EV_VIEWPORT}.set_x_offset (integer))
		end
		
	set_y_offset (integer: INTEGER) is
			-- Update property `y_offset' on all items in `objects'.
		do
			for_all_objects (agent {EV_VIEWPORT}.set_y_offset (integer))
		end
		
	valid_position (integer: INTEGER): BOOLEAN is
			-- Is `integer' a valid coordinate in a viewport.
		do
			Result := True
		end
		
	set_item_width (integer: INTEGER) is
			-- Call `set_item_width' on all items in `objects'.
		do
				-- Note that we cannot use `for_all_objects' as we need to check the
				-- desired size against the allowable size for the second widget.
				-- This is because the minimum size of that widget is consrained by
				-- the additional parenting used in the builer display.
			first.set_item_width (integer)
			(objects @ 2).set_item_width (integer.max ((objects @ 2).item.width))
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			system_status.enable_project_modified
			command_handler.update
		end
		
	set_item_height (integer: INTEGER) is
			-- Call `set_item_height' on all items in `objects'.
		do
				-- Note that we cannot use `for_all_objects' as we need to check the
				-- desired size against the allowable size for the second widget.
				-- This is because the minimum size of that widget is consrained by
				-- the additional parenting used in the builer display.
			first.set_item_height (integer)
			(objects @ 2).set_item_height (integer.max ((objects @ 2).item.height))
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			system_status.enable_project_modified
			command_handler.update
		end
		
	valid_item_width (integer: INTEGER): BOOLEAN is
			--
		do
			if integer >= first.item.minimum_width then
				Result := True
			end
		end
		
	valid_item_height (integer: INTEGER): BOOLEAN is
			--
		do
			if integer >= first.item.minimum_height then
				Result := True
			end
		end

	x_offset_string: STRING is "X_offset"
	y_offset_string: STRING is "Y_offset"
	item_width_string: STRING is "Item_width"
	item_height_string: STRING is "Item_height"
	
	x_offset_entry, y_offset_entry, item_width_entry, item_height_entry: GB_INTEGER_INPUT_FIELD
		-- Input widgets for `x_offset', `y_offset', `set_item_width' and `set_item_height'.

end -- class GB_EV_WINDOW