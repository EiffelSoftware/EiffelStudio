indexing
	description: "Objects that provide information about events in Vision2."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SUPPORTED_EVENTS
	
feature -- Access
	
	action_sequences: ARRAYED_LIST [STRING] is
			-- All action sequence classes in Vision2.
			-- All action sequences in interface are inherited through
			-- these classes.
		once
			create Result.make (0)
			Result.extend ("EV_APPLICATION_ACTION_SEQUENCES")
			Result.extend ("EV_BUTTON_ACTION_SEQUENCES")
			Result.extend ("EV_DRAWING_AREA_ACTION_SEQUENCES")
			Result.extend ("EV_GAUGE_ACTION_SEQUENCES")
			Result.extend ("EV_ITEM_ACTION_SEQUENCES")
			Result.extend ("EV_LIST_ITEM_ACTION_SEQUENCES")
			Result.extend ("EV_LIST_ITEM_LIST_ACTION_SEQUENCES")
			Result.extend ("EV_MENU_ITEM_ACTION_SEQUENCES")
			Result.extend ("EV_MENU_ITEM_LIST_ACTION_SEQUENCES")
			Result.extend ("EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES")
			Result.extend ("EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES")
			Result.extend ("EV_NOTEBOOK_ACTION_SEQUENCES")
			Result.extend ("EV_PICK_AND_DROPABLE_ACTION_SEQUENCES")
			Result.extend ("EV_PIXMAP_ACTION_SEQUENCES")
			Result.extend ("EV_STANDARD_DIALOG_ACTION_SEQUENCES")
			Result.extend ("EV_TEXT_COMPONENT_ACTION_SEQUENCES")
			Result.extend ("EV_TEXT_FIELD_ACTION_SEQUENCES")
			Result.extend ("EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES")
			Result.extend ("EV_TREE_ACTION_SEQUENCES")
			Result.extend ("EV_TREE_NODE_ACTION_SEQUENCES")
			Result.extend ("EV_WIDGET_ACTION_SEQUENCES")
			Result.extend ("EV_WINDOW_ACTION_SEQUENCES")
		ensure
			Result_ok: Result /= Void and Result.count = 22	
		end
		

feature {NONE} -- Implementation

	included_types is
			-- Need to incluide all types, so we can build
			-- them dynamically when encountered.
		local
			gb_ev_button_action_sequences: GB_EV_BUTTON_ACTION_SEQUENCES
			gb_ev_application_action_sequences: GB_EV_APPLICATION_ACTION_SEQUENCES
			gb_ev_gauge_action_sequences: GB_EV_GAUGE_ACTION_SEQUENCES
			gb_ev_pick_and_dropable_action_sequences: GB_EV_PICK_AND_DROPABLE_ACTION_SEQUENCES
			gb_ev_widget_action_sequences: GB_EV_WIDGET_ACTION_SEQUENCES
			gb_ev_container_action_sequences: GB_EV_CONTAINER_ACTION_SEQUENCES
			gb_ev_drawing_area_action_sequences: GB_EV_DRAWING_AREA_ACTION_SEQUENCES
			gb_ev_item_action_sequences: GB_EV_ITEM_ACTION_SEQUENCES
			gb_ev_list_item_action_sequences: GB_EV_LIST_ITEM_ACTION_SEQUENCES
			gb_ev_list_item_list_action_sequences: GB_EV_LIST_ITEM_LIST_ACTION_SEQUENCES
			gb_ev_menu_item_action_sequences: GB_EV_MENU_ITEM_ACTION_SEQUENCES
			gb_ev_menu_item_list_action_sequences: GB_EV_MENU_ITEM_LIST_ACTION_SEQUENCES
			gb_ev_multi_column_list_action_sequences: GB_EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES
			gb_ev_multi_column_list_row_action_sequences: GB_EV_MULTI_COLUMN_LIST_ACTION_SEQUENCES
			gb_ev_notebook_action_sequences: GB_EV_NOTEBOOK_ACTION_SEQUENCES
			gb_ev_pixmap_action_sequences: GB_EV_PIXMAP_ACTION_SEQUENCES
			gb_ev_standard_dialog_action_sequences: GB_EV_STANDARD_DIALOG_ACTION_SEQUENCES
			gb_ev_text_component_action_sequences: GB_EV_TEXT_COMPONENT_ACTION_SEQUENCES
			gb_ev_text_field_action_sequences: GB_EV_TEXT_FIELD_ACTION_SEQUENCES
			gb_ev_tool_bar_button_action_sequences: GB_EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES
			gb_ev_tree_action_sequences: GB_EV_TREE_ACTION_SEQUENCES
			gb_ev_tree_node_action_sequences: GB_EV_TREE_NODE_ACTION_SEQUENCES
			gb_ev_window_action_sequences: GB_EV_WINDOW_ACTION_SEQUENCES
		do		
		end
		

end -- class GB_SUPPORTED_EVENTS
