indexing
	description: "Objects that provide a new attribute editor for EV_WIDGET properties."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_WIDGET_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
	
	GB_CONSTANTS
	
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
			minimum_height_entry.set_text (first.minimum_height.out)
			minimum_width_entry.set_text (first.minimum_width.out)
		end

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result
			initialize_attribute_editor (Result)
			create minimum_width_entry.make (Current, Result, gb_ev_widget_minimum_width, gb_ev_widget_minimum_width_tooltip, agent set_minimum_width (?), agent valid_minimum_dimension (?))
			create minimum_height_entry.make (Current, Result, gb_ev_widget_minimum_height, gb_ev_widget_minimum_height_tooltip, agent set_minimum_height (?), agent valid_minimum_dimension (?))
			
			update_attribute_editor
			
			disable_all_items (Result)
			align_labels_left (Result)
		end

feature {NONE} -- Implementation

	minimum_width_entry, minimum_height_entry: GB_INTEGER_INPUT_FIELD
		-- Input widgets for `minimum_width' and `minimum_height'.
		
	set_minimum_width (integer: INTEGER) is
			-- Update property `minimum_width' on the first of `objects'.
		require
			first_not_void: first /= Void
		do
			for_first_object (agent {EV_WIDGET}.set_minimum_width (integer))
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
		end

	Minimum_width_string: STRING is "Minimum_width"
	Minimum_height_string: STRING is "Minimum_height"

end -- class GB_EV_WIDGET_EDITOR
