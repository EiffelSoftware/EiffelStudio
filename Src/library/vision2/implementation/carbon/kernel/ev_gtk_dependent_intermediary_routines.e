note
	description: "Intermediary routines between gtk and eiffel."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES

inherit
	IDENTIFIED

feature {EV_ANY_I} -- Implementation

	new_toolbar_item_select_actions_intermediary (a_object_id: INTEGER)
			-- Intermediary agent for toolbar button select action
			-- (from EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES)
			-- (export status {EV_ANY_I})
		local
			a_toolbar_button_imp: EV_TOOL_BAR_BUTTON_IMP
			a_radio_button_imp: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do

		end

	pnd_deferred_parent_start_transport_filter_intermediary (a_c_object: POINTER; a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Start of pick and drop transport
		local
			pnd_par: EV_PND_DEFERRED_ITEM_PARENT
		do

		end

	mcl_column_click_callback (a_object_id: INTEGER; int: INTEGER)
		local
			a_mcl: EV_MULTI_COLUMN_LIST_IMP
		do

		end

	mcl_column_resize_callback (a_object_id: INTEGER; a_column: INTEGER)
		local
			a_column_ptr: POINTER
			temp_width: INTEGER
			a_mcl: EV_MULTI_COLUMN_LIST_IMP
		do

		end

	text_buffer_mark_set_intermediary (a_object_id: INTEGER; nargs: INTEGER; args: POINTER)
			-- Used for caret positioning events
		local
			a_rich_text: EV_RICH_TEXT_IMP
			a_text_iter, a_text_mark: POINTER
		do

		end

	window_state_intermediary (a_object_id: INTEGER; n_args: INTEGER; args: POINTER)
			-- The window state of the window `a_object_id' has changed
		local
			gdk_event: POINTER
			window_flags: INTEGER
			titled_window_imp: EV_TITLED_WINDOW_IMP
		do

		end

	tree_row_expansion_change_intermediary (a_object_id: INTEGER; is_expanded: BOOLEAN; nargs: INTEGER; args: POINTER)
			-- Used for calling expansion actions for tree nodes
		local
			a_tree_imp: EV_TREE_IMP
			a_tree_node: EV_TREE_NODE_IMP
			a_tree_path: POINTER
		do

		end

	boolean_cell_renderer_toggle_intermediary (a_object_id: INTEGER; nargs: INTEGER; args: POINTER)
			-- Called when a cell renderer is toggled (EV_CHECKABLE_LIST)
		local
			a_tree_path_str: POINTER
		do

		end

	scroll_wheel_translate (n: INTEGER; args: POINTER): TUPLE
			-- Transform scroll wheel event
		local
			scroll_event: POINTER
			button_number: INTEGER
		do

		end

	accel_activate_intermediary (a_object_id: INTEGER; n: INTEGER; p: POINTER)
			-- Call accelerators for window `a_object_id'
		local
			arg: POINTER
			accel_key: NATURAL_32
			accel_mods: INTEGER
			a_titled_window_imp: EV_TITLED_WINDOW_IMP
		do

		end

	page_switch_translate (n: INTEGER; args: POINTER): TUPLE
			-- Retrieve index of switched page.
		local
			gtkarg2: POINTER
		do

		end

	on_pnd_deferred_item_parent_selection_change (a_object_id: INTEGER)
			-- A selection event has occurred on a PND deferred item parent.
		local
			a_pnd_widget: EV_PND_DEFERRED_ITEM_PARENT
		do

		end

	on_combo_box_toggle_button_event (a_object_id: INTEGER; a_event_id: INTEGER)
			-- A combo box toggle button has been toggled.
		local
			a_combo: EV_COMBO_BOX_IMP
		do

		end

	toolbar_item_select_actions_intermediary (a_object_id: INTEGER)
			-- Intermediary agent for toolbar button select action
		local
			a_toolbar_button_imp: EV_TOOL_BAR_BUTTON_IMP
			a_radio_button_imp: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do

		end

	gdk_event_dispatcher (a_object_id: INTEGER; n_args: INTEGER; args: POINTER)
			-- Intermediary agent for gdk events.
		local
			l_any_imp: EV_ANY_IMP
		do

		end


note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES

