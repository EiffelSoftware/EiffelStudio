indexing
	description: "Builds an attribute editor for modification of objects of type EV_VIEWPORT."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_VIEWPORT_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
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
		do
			create Result
			initialize_attribute_editor (Result)
			
			create x_offset_entry.make (Current, Result, gb_ev_viewport_x_offset, gb_ev_viewport_x_offset_tooltip,
				agent set_x_offset (?), agent valid_position (?))
			create y_offset_entry.make (Current, Result, gb_ev_viewport_y_offset, gb_ev_viewport_y_offset_tooltip,
				agent set_y_offset (?), agent valid_position (?))
			create item_width_entry.make (Current, Result, gb_ev_viewport_item_width, gb_ev_viewport_item_width_tooltip,
				agent set_item_width (?), agent valid_item_width (?))
			create item_height_entry.make (Current, Result, gb_ev_viewport_item_height, gb_ev_viewport_item_height_tooltip,
				agent set_item_height (?), agent valid_item_height (?))
			
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
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
			if objects @ 2 /= Void then
				(objects @ 2).set_item_width (integer.max ((objects @ 2).item.width))
			end
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			enable_project_modified
		end
		
	set_item_height (integer: INTEGER) is
			-- Call `set_item_height' on all items in `objects'.
		do
				-- Note that we cannot use `for_all_objects' as we need to check the
				-- desired size against the allowable size for the second widget.
				-- This is because the minimum size of that widget is consrained by
				-- the additional parenting used in the builer display.
			first.set_item_height (integer)
			if objects @ 2 /= Void then
				(objects @ 2).set_item_height (integer.max ((objects @ 2).item.height))
			end
				-- We update the system settings to reflect
				-- the fact that a user modification has taken place.
				-- This enables us to do things such as enable the save
				-- options.
			enable_project_modified
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

end -- class GB_EV_VIEWPORT_EDITOR_CONSTRUCTOR
