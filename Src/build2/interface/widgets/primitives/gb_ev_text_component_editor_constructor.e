indexing
	description: "Builds an attribute editor for modification of objects of type EV_TEXT_COMPONENT."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_TEXT_COMPONENT_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_TEXT_COMPONENT
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TEXT_COMPONENT"
		-- String representation of object_type modifyable by `Current'.

	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result
			initialize_attribute_editor (Result)
			
			create editable_button.make_with_text (gb_ev_text_component_is_editable)
			editable_button.set_tooltip (gb_ev_text_component_is_editable)
			Result.extend (editable_button)
			editable_button.select_actions.extend (agent set_is_editable)
			editable_button.select_actions.extend (agent update_editors)

			update_attribute_editor

			disable_all_items (Result)
			align_labels_left (Result)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			editable_button.select_actions.block
			
			if first.is_editable then
				editable_button.enable_select
			else
				editable_button.disable_select
			end
			
			editable_button.select_actions.resume
		end
		
feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			-- Nothing to perform here.
		end
		
	set_is_editable is
			-- Update editable status for all objects to reflect `editable_button'.
		do
			if editable_button.is_selected then
				for_all_objects (agent {EV_TEXT_COMPONENT}.enable_edit)
			else
				for_all_objects (agent {EV_TEXT_COMPONENT}.disable_edit)
			end
		end
		
	editable_button: EV_CHECK_BUTTON
		-- Used to control is_editable state.
	
	Is_editable_string: STRING is "Is_editable"

end -- class GB_EV_TEXT_COMPONENT_EDITOR_CONSTRUCTOR
