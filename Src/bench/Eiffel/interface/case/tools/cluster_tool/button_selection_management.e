indexing
	description: "Class responsible for the selectable buttons management."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	BUTTON_SELECTION_MANAGEMENT

inherit
	ONCES

	CONSTANTS

feature -- Commands

	select_cli_creation (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			workarea.set_cli_sup_link_command
			inheritance_selected_b.set_selected(FALSE)
			aggregation_selected_b.set_selected(FALSE)
		end

	select_agg_creation (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			workarea.set_aggreg_link_command
			inheritance_selected_b.set_selected(FALSE)
			client_link_selected_b.set_selected(FALSE)
		end
 
	select_inh_creation (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			workarea.set_inherit_link_command
			client_link_selected_b.set_selected(FALSE)
			aggregation_selected_b.set_selected(FALSE)
		end

	select_client (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			System.set_is_client_hidden (false)
			System.set_is_modified
		end

	unselect_client (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			System.set_is_client_hidden (True)
			System.set_is_modified
		end

	select_aggreg (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			arg: EV_ARGUMENT1[SELECTABLE_BUTTON]
			but: SELECTABLE_BUTTON
		do
			System.set_is_aggreg_hidden (false)
			System.set_is_modified
		end

	unselect_aggreg (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			System.set_is_aggreg_hidden (true)
			System.set_is_modified
		end

	select_inherit (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			System.set_is_inheritance_hidden (false)
			System.set_is_modified
		end

	unselect_inherit (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			System.set_is_inheritance_hidden (true)
			System.set_is_modified
		end

	select_label (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			System.set_is_label_hidden (false)
			System.set_is_modified
		end

	unselect_label (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			System.set_is_label_hidden (true)
			System.set_is_modified
		end

	select_imp (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			System.set_is_client_hidden (false)
			System.set_is_modified
		end

	unselect_imp (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			System.set_is_client_hidden (true)
			System.set_is_modified
		end

	select_class (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			button_event_data: EV_BUTTON_EVENT_DATA
			new_class_stone: NEW_CLASS_STONE
		do
			cluster_selected_b.set_selected(FALSE)
		end

	select_cluster (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			class_selected_b.set_selected(FALSE)
		end

	drag_class (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			button_event_data: EV_BUTTON_EVENT_DATA
			new_class_stone: NEW_CLASS_STONE
		do 
			button_event_data ?= data
			!! new_class_stone
			class_hole_b.set_transported_data (new_class_stone)
			class_hole_b.set_data_type (stone_types.class_type_pnd)
		end

	drag_cluster (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			button_event_data: EV_BUTTON_EVENT_DATA
			new_cluster_stone: NEW_CLUSTER_STONE
		do 
			button_event_data ?= data
			!! new_cluster_stone
			cluster_hole_b.set_transported_data (new_cluster_stone)
			cluster_hole_b.set_data_type (stone_types.cluster_type_pnd)
		end

feature -- Implementation

	cluster_hole_b: EV_TOOL_BAR_BUTTON
		
	class_hole_b: EV_TOOL_BAR_BUTTON
		
	relation_hole_b: EV_TOOL_BAR_BUTTON
		
	deletion_hole_b: EV_TOOL_BAR_BUTTON

	cluster_selected_b: SELECTABLE_BUTTON

	class_selected_b: SELECTABLE_BUTTON

	client_link_selected_b: SELECTABLE_BUTTON

	aggregation_selected_b: SELECTABLE_BUTTON

	inheritance_selected_b: SELECTABLE_BUTTON

	client_link_visibility_b: SELECTABLE_BUTTON

	aggregation_visibility_b: SELECTABLE_BUTTON

	inheritance_visibility_b: SELECTABLE_BUTTON

	label_visibility_b: SELECTABLE_BUTTON

	all_visibility_b: SELECTABLE_BUTTON

	workarea: WORKAREA is deferred end

end -- class BUTTON_SELECTION_MANAGEMENT
