indexing
	description: "Builds an attrribute editor for modification of objects of type EV_TOOLTIPABLE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_TOOLTIPABLE_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_TOOLTIPABLE
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TOOLTIPABLE"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		local
			label: EV_LABEL
		do
			create Result
			initialize_attribute_editor (Result)
			create label.make_with_text (gb_ev_tooltipable_tooltip)
			Result.extend (label)
			label.set_tooltip (gb_ev_tooltipable_tooltip_tooltip)
			create tooltip_entry
			tooltip_entry.set_tooltip (gb_ev_tooltipable_tooltip_tooltip)
			Result.extend (tooltip_entry)
			tooltip_entry.change_actions.extend (agent set_tooltip)
			tooltip_entry.change_actions.extend (agent update_editors)
			
			update_attribute_editor
			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			tooltip_entry.change_actions.block
			tooltip_entry.set_text (first.tooltip)
			tooltip_entry.change_actions.resume
		end
		
feature {NONE} -- Implementation
	
	tooltip_entry: EV_TEXT_FIELD
		-- Holds the text to be used for the tooltip.
		
	set_tooltip is
			-- Assign text of `tooltip_entry' to tooltip of all objects.
		do
			if not tooltip_entry.text.is_empty then
				for_all_objects (agent {EV_TOOLTIPABLE}.set_tooltip (tooltip_entry.text))
			else
				for_all_objects (agent {EV_TOOLTIPABLE}.remove_tooltip)
			end
		end
		
	Tooltip_string: STRING is "Tooltip"

end -- class GB_EV_TOOLTIPABLE_EDITOR_CONSTRUCTOR
