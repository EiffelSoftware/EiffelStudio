indexing
	description: "Objects that provide information about events in Vision2."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SUPPORTED_EVENTS
	
feature -- Access
	
	action_sequences_list: ARRAYED_LIST [STRING] is
			-- All action sequence classes in Vision2.
			-- All action sequences in interface are inherited through
			-- these classes.
		once
			create Result.make (0)
			Result.extend ("EV_APPLICATION_ACTION_SEQUENCES")
			Result.extend ("EV_CHECKABLE_LIST_ACTION_SEQUENCES")
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
			Result.extend ("EV_PIXMAP_ACTION_SEQUENCES")
			Result.extend ("EV_STANDARD_DIALOG_ACTION_SEQUENCES")
			Result.extend ("EV_TEXT_COMPONENT_ACTION_SEQUENCES")
			Result.extend ("EV_TEXT_FIELD_ACTION_SEQUENCES")
			Result.extend ("EV_TOOL_BAR_BUTTON_ACTION_SEQUENCES")
			Result.extend ("EV_TREE_ACTION_SEQUENCES")
			Result.extend ("EV_TREE_NODE_ACTION_SEQUENCES")
			Result.extend ("EV_WIDGET_ACTION_SEQUENCES")
			Result.extend ("EV_WINDOW_ACTION_SEQUENCES")
			Result.extend ("EV_TITLED_WINDOW_ACTION_SEQUENCES")
		ensure
			Result_ok: Result /= Void and Result.count = 23
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
			gb_ev_titled_window_action_sequences: GB_EV_TITLED_WINDOW_ACTION_SEQUENCES
			gb_ev_checkable_list_action_sequences: GB_EV_CHECKABLE_LIST_ACTION_SEQUENCES
			
			gb_ev_column_action_sequence: GB_EV_COLUMN_ACTION_SEQUENCE
			gb_ev_geometry_action_sequence: GB_EV_GEOMETRY_ACTION_SEQUENCE
			gb_ev_key_action_sequence: GB_EV_KEY_ACTION_SEQUENCE
			gb_ev_key_string_action_sequence: GB_EV_KEY_STRING_ACTION_SEQUENCE
			gb_ev_menu_item_select_action_sequence: GB_EV_MENU_ITEM_SELECT_ACTION_SEQUENCE
			gb_ev_pointer_button_action_sequence: GB_EV_POINTER_BUTTON_ACTION_SEQUENCE
			gb_ev_pointer_motion_action_sequence: GB_EV_POINTER_MOTION_ACTION_SEQUENCE
			gb_ev_new_item_action_sequence: GB_EV_NEW_ITEM_ACTION_SEQUENCE
			gb_ev_multi_column_list_row_select_action_sequence: GB_EV_MULTI_COLUMN_LIST_ROW_SELECT_ACTION_SEQUENCE
			gb_ev_notify_action_sequence: GB_EV_NOTIFY_ACTION_SEQUENCE
			gb_ev_value_change_action_sequence: GB_EV_VALUE_CHANGE_ACTION_SEQUENCE
			
		do		
		end
		

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class GB_SUPPORTED_EVENTS
