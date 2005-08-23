indexing
	description: "Builds an attribute editor for modification of objects of type EV_SPLIT_AREA."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_EV_SPLIT_AREA_EDITOR_CONSTRUCTOR

inherit
	GB_EV_EDITOR_CONSTRUCTOR
		undefine
			default_create
		end
	
	INTERNAL
		undefine
			default_create
		end

feature -- Access

	ev_type: EV_SPLIT_AREA
		-- Vision2 type represented by `Current'.
		
	type: STRING is "EV_SPLIT_AREA"
		-- String representation of object_type modifyable by `Current'.
		
	attribute_editor: GB_OBJECT_EDITOR_ITEM is
			-- A vision2 component to enable modification
			-- of items held in `objects'.
		do
			create Result
			initialize_attribute_editor (result)
			create first_expanded.make_with_text ("Is first expanded?")

			Result.extend (first_expanded)
			create second_expanded.make_with_text ("Is second expanded?")
			second_expanded.set_tooltip (gb_ev_split_area_is_item_expanded_tooltip)
			Result.extend (second_expanded)
			
				-- Connect events
			first_expanded.select_actions.extend (agent update_first_expanded)
			second_expanded.select_actions.extend (agent update_second_expanded)
			
			update_attribute_editor
		end
		
	update_attribute_editor is
			-- Update status of `attribute_editor' to reflect information
			-- from `objects.first'.
		local
			split_area: EV_SPLIT_AREA
		do
			split_area ?= object.object
			if not first.full then
				first_expanded.disable_sensitive
				second_expanded.disable_sensitive
			elseif split_area.is_item_expanded (split_area.first) then
				first_expanded.select_actions.block
				first_expanded.enable_select
				first_expanded.select_actions.resume
			elseif split_area.is_item_expanded (split_area.second) then
				second_expanded.select_actions.block
				second_expanded.enable_select
				second_expanded.select_actions.resume
			end
		end

feature {NONE} -- Implementation

	initialize_agents is
			-- Initialize `validate_agents' and `execution_agents' to
			-- contain all agents required for modification of `Current.
		do
		end
		
	update_first_expanded is
			-- Update expanded state of first item.
		do
			actual_update_first_expanded (object)
			for_all_instance_referers (object, agent actual_update_first_expanded (?))
			enable_project_modified
		end
		
	update_second_expanded is
			-- Update expanded state of second item.
		do
			actual_update_second_expanded (object)
			for_all_instance_referers (object, agent actual_update_second_expanded (?))
			enable_project_modified
		end
		
	actual_update_first_expanded (an_object: GB_OBJECT) is
			-- Update expanded state of first item for `an_object'.
		require
			an_object_not_void: an_object /= Void
		local
			split_area: EV_SPLIT_AREA
		do
			if first_expanded.is_selected then
				second_expanded.disable_select
				split_area ?= an_object.object
				split_area.disable_item_expand (split_area.second)
				split_area.enable_item_expand (split_area.first)
				split_area ?= an_object.real_display_object
				split_area.disable_item_expand (split_area.second)
				split_area.enable_item_expand (split_area.first)
			else
				split_area ?= an_object.object
				split_area.disable_item_expand (split_area.first)
				split_area ?= an_object.real_display_object
				split_area.disable_item_expand (split_area.first)
			end
		end
		
	actual_update_second_expanded (an_object: GB_OBJECT) is
			-- Update expanded state of second item for `an_object'.
		require
			an_object_not_void: an_object /= Void
		local
			split_area: EV_SPLIT_AREA
		do
			if second_expanded.is_selected then
				first_expanded.disable_select
				split_area ?= an_object.object
				split_area.disable_item_expand (split_area.first)
				split_area.enable_item_expand (split_area.second)
				split_area ?= an_object.real_display_object
				split_area.disable_item_expand (split_area.first)
				split_area.enable_item_expand (split_area.second)
			else
				split_area ?= an_object.object
				split_area.disable_item_expand (split_area.second)
				split_area ?= an_object.real_display_object
				split_area.disable_item_expand (split_area.second)
			end	
		end
	
	first_expanded: EV_CHECK_BUTTON
	second_expanded: EV_CHECK_BUTTON
	
	is_item_expanded_string: STRING is "Is_item_expanded"
	
		
end -- class GB_EV_SPLIT_AREA_EDITOR_CONSTRUCTOR
