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
		undefine
			copy, is_equal
		end

	EV_GTK_KEY_CONVERSION

feature -- Implementation

	new_toolbar_item_select_actions_intermediary (a_object_id: INTEGER)
			-- Intermediary agent for toolbar button select action
		local
			a_toolbar_button_imp: detachable EV_TOOL_BAR_BUTTON_IMP
			a_radio_button_imp: detachable EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			a_toolbar_button_imp ?= eif_id_object (a_object_id)
			a_radio_button_imp ?= a_toolbar_button_imp
			if a_radio_button_imp /= Void then
				if a_radio_button_imp.is_selected and then attached a_radio_button_imp.select_actions_internal as l_radio_button_select_actions then
					l_radio_button_select_actions.call (Void)
				end
			elseif a_toolbar_button_imp /= Void then
				a_toolbar_button_imp.call_select_actions
			end
		end

	pnd_deferred_parent_start_transport_filter_intermediary (a_c_object: POINTER; a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Start of pick and drop transport
		local
			pnd_par: detachable EV_PND_DEFERRED_ITEM_PARENT
		do
			pnd_par ?= c_get_eif_reference_from_object_id (a_c_object)
			check pnd_par /= Void then end
			pnd_par.on_mouse_button_event (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	mcl_column_click_callback (a_object_id: INTEGER; int: INTEGER)
		local
			a_mcl: detachable EV_MULTI_COLUMN_LIST_IMP
		do
			a_mcl ?= eif_id_object (a_object_id)
			if a_mcl /= Void and then attached a_mcl.column_title_click_actions_internal as l_mcl_column_title_click_actions then
				l_mcl_column_title_click_actions.call ([int])
			end
		end

	mcl_column_resize_callback (a_object_id: INTEGER; a_column: INTEGER)
		local
			a_column_ptr: POINTER
			temp_width: INTEGER
			a_mcl: detachable EV_MULTI_COLUMN_LIST_IMP
		do
			a_mcl ?= eif_id_object (a_object_id)
			if a_mcl /= Void and then a_mcl.column_resized_actions_internal /= Void then
				if a_column > 0 then
					a_column_ptr := {GTK2}.gtk_tree_view_get_column (a_mcl.tree_view, a_column - 1)
					temp_width := {GTK2}.gtk_tree_view_column_get_width (a_column_ptr)
					if (a_column) <= a_mcl.column_count and then a_mcl.column_widths /= Void and then a_mcl.column_width (a_column) /= temp_width then
						a_mcl.update_column_width (temp_width, a_column)
						if attached a_mcl.column_resized_actions_internal as l_mcl_column_resized_actions then
							l_mcl_column_resized_actions.call ([a_column])
						end
					end
				end
			end
		end

	text_buffer_mark_set_intermediary (a_object_id: INTEGER; nargs: INTEGER; args: POINTER)
			-- Used for caret positioning events
		local
			a_rich_text: detachable EV_RICH_TEXT_IMP
			a_text_iter, a_text_mark: POINTER
		do
			a_rich_text ?= eif_id_object (a_object_id)
			if a_rich_text /= Void and then not a_rich_text.is_destroyed then
				a_text_iter := {GOBJECT}.g_value_pointer ({GOBJECT}.g_value_array_i_th (args, 1))
				a_text_mark := {GOBJECT}.g_value_pointer ({GOBJECT}.g_value_array_i_th (args, 2))
				a_rich_text.on_text_mark_changed (a_text_iter, a_text_mark )
			end
		end

	tree_row_expansion_change_intermediary (a_object_id: INTEGER; is_expanded: BOOLEAN; nargs: INTEGER; args: POINTER)
			-- Used for calling expansion actions for tree nodes
		local
			a_tree_imp: detachable EV_TREE_IMP
			a_tree_node: detachable EV_TREE_NODE_IMP
			a_tree_path: POINTER
		do
			a_tree_imp ?= eif_id_object (a_object_id)
			if a_tree_imp /= Void and then not a_tree_imp.is_destroyed then
				a_tree_path := {GOBJECT}.g_value_pointer ({GTK2}.gtk_args_array_i_th (args, 1))
				a_tree_node := a_tree_imp.node_from_tree_path (a_tree_path)
				if is_expanded then
					-- Call tree node expand actions
					if a_tree_node.expand_actions_internal /= Void then
						a_tree_node.expand_actions.call (Void)
					end
				else
					-- Call tree node collapse actions
					if a_tree_node.collapse_actions_internal /= Void then
						a_tree_node.collapse_actions.call (Void)
					end
				end
			end
		end

	boolean_cell_renderer_toggle_intermediary (a_object_id: INTEGER; nargs: INTEGER; args: POINTER)
			-- Called when a cell renderer is toggled (EV_CHECKABLE_LIST)
		local
			a_list_imp: detachable EV_GTK_TREE_VIEW
			a_tree_path_str: POINTER
		do
			a_list_imp ?= eif_id_object (a_object_id)
			if a_list_imp /= Void and then not a_list_imp.is_destroyed then
				a_tree_path_str := {GOBJECT}.g_value_pointer ({GTK2}.gtk_args_array_i_th (args, 0))
				a_list_imp.on_tree_path_toggle (a_tree_path_str)
			end
		end

	page_switch_translate (n: INTEGER; args: POINTER): TUPLE
			-- Retrieve index of switched page.
		local
			gtkarg2: POINTER
		do
			gtkarg2 := {GTK2}.gtk_args_array_i_th (args, 1)
			Result := [{GOBJECT}.g_value_uint (gtkarg2)]
		end

	on_pnd_deferred_item_parent_selection_change (a_object_id: INTEGER)
			-- A selection event has occurred on a PND deferred item parent.
		do
			if attached {EV_PND_DEFERRED_ITEM_PARENT} eif_id_object (a_object_id) as a_pnd_widget then
				a_pnd_widget.call_selection_action_sequences
			end
		end

	on_combo_box_toggle_button_event (a_object_id: INTEGER; a_event_id: INTEGER)
			-- A combo box toggle button has been toggled.
		local
			a_combo: detachable EV_COMBO_BOX_IMP
		do
			a_combo ?= eif_id_object (a_object_id)
			if a_combo /= Void and then a_combo.parent_imp /= Void and then not a_combo.is_destroyed then
				inspect
					a_event_id
				when 1 then
						-- The toggle button has been realized
					a_combo.retrieve_toggle_button
				when 2 then
						-- The toggle button has been toggled.
					a_combo.toggle_button_toggled
				end
			end
		end

	toolbar_item_select_actions_intermediary (a_object_id: INTEGER)
			-- Intermediary agent for toolbar button select action
		local
			a_toolbar_button_imp: detachable EV_TOOL_BAR_BUTTON_IMP
			a_radio_button_imp: detachable EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			a_toolbar_button_imp ?= eif_id_object (a_object_id)
			a_radio_button_imp ?= a_toolbar_button_imp
			if a_radio_button_imp /= Void then
				if a_radio_button_imp.is_selected and then attached a_radio_button_imp.select_actions_internal as l_radio_button_select_actions then
					l_radio_button_select_actions.call (Void)
				end
			elseif a_toolbar_button_imp /= Void and then attached a_toolbar_button_imp.select_actions_internal as l_toolbar_button_select_actions then
				l_toolbar_button_select_actions.call (Void)
			end
		end

	gdk_event_dispatcher (a_object_id: INTEGER; n_args: INTEGER; args: POINTER)
			-- Intermediary agent for gdk events.
		local
			l_any_imp: detachable EV_ANY_IMP
		do
			l_any_imp ?= eif_id_object (a_object_id)
			if l_any_imp /= Void then
				l_any_imp.process_gdk_event (n_args, args)
			else
				check event_object_not_coupled: False end
			end
		end

feature {EV_ANY_I} -- Externals

	frozen c_get_eif_reference_from_object_id (a_c_object: POINTER): detachable EV_ANY_IMP
			-- Get Eiffel object from `a_c_object'.
		external
			"C (GtkWidget*): EIF_REFERENCE | %"ev_any_imp.h%""
		alias
			"c_ev_any_imp_get_eif_reference_from_object_id"
		ensure
			is_class: class
		end

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
