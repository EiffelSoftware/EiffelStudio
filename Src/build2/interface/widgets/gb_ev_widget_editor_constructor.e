indexing
	description: "Objects that provide a new attribute editor for EV_WIDGET properties."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_WIDGET_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
	
	GB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end
	
	GB_SHARED_OBJECT_HANDLER	
		export
			{NONE} all
		undefine
			default_create
		end

	
feature -- Access

	ev_type: EV_WIDGET
	
	type: STRING is
			-- String representation of object_type modifyable by `Current'.
		once
			Result := Ev_widget_string
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `first'.
		do
			minimum_width_entry.update_constant_display (first.minimum_width.out)
			if first.minimum_width_set_by_user then
				
				reset_width_button.enable_sensitive
			else
				reset_width_button.disable_sensitive
			end
			minimum_height_entry.update_constant_display (first.minimum_height.out)	
			if first.minimum_height_set_by_user then
				reset_height_button.enable_sensitive
			else
				reset_height_button.disable_sensitive
			end
		end

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			horizontal_box: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
			create Result
			initialize_attribute_editor (Result)
			
			create label.make_with_text (Gb_ev_widget_minimum_width)
			Result.extend (label)
			Result.disable_item_expand (label)
			create horizontal_box
			horizontal_box.set_padding_width (object_editor_padding_width)
			create minimum_width_entry.make_without_label (Current, horizontal_box, minimum_width_string, gb_ev_widget_minimum_width_tooltip,
				agent set_minimum_width (?), agent valid_minimum_dimension (?))
			create reset_width_button.make_with_text ("Reset")
			reset_width_button.select_actions.extend (agent reset_width)
			horizontal_box.extend (reset_width_button)
			horizontal_box.disable_item_expand (reset_width_button)
			Result.extend (horizontal_box)
			
			create label.make_with_text (Gb_ev_widget_minimum_height)
			Result.extend (label)
			Result.disable_item_expand (label)
			create horizontal_box
			horizontal_box.set_padding_width (object_editor_padding_width)
			create minimum_height_entry.make_without_label (Current, horizontal_box, minimum_height_string, gb_ev_widget_minimum_height_tooltip,
				agent set_minimum_height (?), agent valid_minimum_dimension (?))
			create reset_height_button.make_with_text ("Reset")
			reset_height_button.select_actions.extend (agent reset_height)
			horizontal_box.extend (reset_height_button)
			horizontal_box.disable_item_expand (reset_height_button)
			Result.extend (horizontal_box)
			
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			
			execution_agents.extend (agent set_minimum_height (?), Minimum_height_string)
			validate_agents.extend (agent valid_minimum_dimension (?), Minimum_height_string)
			execution_agents.extend (agent set_minimum_width (?), Minimum_width_string)
			validate_agents.extend (agent valid_minimum_dimension (?), Minimum_width_string)
		end

	reset_width is
			-- Reset minimum width of object referenced by `Current'.
		local
			original_id: INTEGER
		do
			reset_width_button.disable_sensitive
				-- Although the editor will be rebuilt, doing this gives the
				-- impression of instant feedback, even if there is a small delay
				-- before rebuilding.
			first.reset_minimum_width
				-- Reset the minimum width on `first'
			original_id := Object_handler.object_from_display_widget (first).id
				-- Store the original id so that we can restore the object afterwards.
			Object_handler.reset_object (object)
				-- Reset the object referenced by `Current'
			parent_editor.set_object (object_handler.object_from_id (original_id))
				-- Update `parent_editor' to reflect the change.
		end
		
	reset_height is
			-- Reset minimum width of object referenced by `Current'.
		local
			original_id: INTEGER
		do
			reset_height_button.disable_sensitive
				-- Although the editor will be rebuilt, doing this gives the
				-- impression of instant feedback, even if there is a small delay
				-- before rebuilding.
			first.reset_minimum_height
				-- Reset the minimum height on `first'
			original_id := Object_handler.object_from_display_widget (first).id
				-- Store the original id so that we can restore the object afterwards.
			Object_handler.reset_object (object)
				-- Reset the object referenced by `Current'
			parent_editor.set_object (object_handler.object_from_id (original_id))
				-- Update `parent_editor' to reflect the change.
		end

	minimum_width_entry, minimum_height_entry: GB_INTEGER_INPUT_FIELD
		-- Input widgets for `minimum_width' and `minimum_height'.
		
	set_minimum_width (integer: INTEGER) is
			-- Update property `minimum_width' on the first of `objects'.
		require
			first_not_void: first /= Void
		do
			for_first_object (agent {EV_WIDGET}.set_minimum_width (integer))
			update_editors
		end
		
	valid_minimum_dimension (value: INTEGER): BOOLEAN is
			-- Is `value' a valid minimum_width or minimum_height?
		do
			Result := value >= 0
		end
		
	set_minimum_height (integer: INTEGER) is
			-- Update property `minimum_height' on first of `objects'.
		require
			first_not_void: first /= Void
		do
			for_first_object (agent {EV_WIDGET}.set_minimum_height (integer))
			update_editors
		end

	Minimum_width_string: STRING is "Minimum_width"
	Minimum_height_string: STRING is "Minimum_height"

	reset_width_button, reset_height_button: EV_BUTTON
		-- Buttons that allow you to reset the minimum sizes on objects.
		
invariant
	--first.minimum_width_set_by_user implies not reset_width_button.is_sensitive else reset_button.is_sensitive
	--And other

end -- class GB_EV_WIDGET_EDITOR
