indexing
	description: "Builds an attribute editor for modification of objects of type EV_SENSITIVE."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_TOOL_BAR_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_TOOL_BAR
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_TOOL_BAR"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result
			initialize_attribute_editor (Result)
			create check_button.make_with_text (gb_ev_tool_bar_has_vertical_button_style)
			check_button.set_tooltip (gb_ev_tool_bar_has_vertical_button_style_tooltip)
			update_attribute_editor
			Result.extend (check_button)
			check_button.select_actions.extend (agent toggle_style)
			check_button.select_actions.extend (agent update_editors)
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
			check_button.select_actions.block
			if first.has_vertical_button_style then
				check_button.enable_select
			else
				check_button.disable_select
			end
			check_button.select_actions.resume
		end

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
			-- Nothing to perform here.
		end

	check_button: EV_CHECK_BUTTON
		-- Check button used for setting attribute.
	
	toggle_style is
			-- Update vertical style state.
		do
			if check_button.is_selected then
				for_all_objects (agent {EV_TOOL_BAR}.enable_vertical_button_style)
			else
				for_all_objects (agent {EV_TOOL_BAR}.disable_vertical_button_style)
			end
		end

		-- Constants for XML
	has_vertical_button_style_string: STRING is "Has_vertical_button_style"

end -- class GB_EV_TOOL_BAR_EDITOR_CONSTRUCTOR
