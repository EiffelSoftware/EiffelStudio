indexing
	description: "Builds an attribute editor for modification of objects of type EV_PROGRESS_BAR."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_PROGRESS_BAR_EDITOR_CONSTRUCTOR
	
inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
		
feature -- Access

	ev_type: EV_PROGRESS_BAR
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_PROGRESS_BAR"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result
			initialize_attribute_editor (Result)
			create check_button.make_with_text (gb_ev_progress_bar_is_segmented)
			check_button.set_tooltip (gb_ev_progress_bar_is_segmented_tooltip)
			update_attribute_editor
			Result.extend (check_button)
			check_button.select_actions.extend (agent toggle_segmented)
			check_button.select_actions.extend (agent update_editors)
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		do
		--	check_button.select_actions.block
			if first.is_segmented then
				check_button.enable_select
			else
				check_button.disable_select
			end
		--	check_button.select_actions.resume
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
	
	toggle_segmented is
			-- Update segmented state.
		do
			if check_button.is_selected then
				for_first_object (agent {EV_PROGRESS_BAR}.enable_segmentation)
			else
				for_first_object (agent {EV_PROGRESS_BAR}.disable_segmentation)
			end
		end

	-- Constants for XML
	
	is_segmented_string: STRING is "Is_segmented"

end -- class GB_EV_PROGRESS_BAR_EDITOR_CONSTRUCTOR
