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
			obj: ANY
		do
			obj := eif_id_object (a_object_id)
			if attached {EV_TOOL_BAR_RADIO_BUTTON_IMP} obj as a_radio_button_imp then
				if
					a_radio_button_imp.is_selected and then
					attached a_radio_button_imp.select_actions_internal as l_radio_button_select_actions
				then
					l_radio_button_select_actions.call (Void)
				end
			elseif attached {EV_TOOL_BAR_BUTTON_IMP} obj as a_toolbar_button_imp then
				a_toolbar_button_imp.call_select_actions
			end
		end

	pnd_deferred_parent_start_transport_filter_intermediary (a_c_object: POINTER; a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Start of pick and drop transport
		do
			if attached {EV_PND_DEFERRED_ITEM_PARENT} eif_object_from_c (a_c_object) as pnd_par then
				pnd_par.on_mouse_button_event (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
			else
				check is_pnd_par: False end
			end
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
		do
			if
				attached {EV_MULTI_COLUMN_LIST_IMP} eif_id_object (a_object_id) as a_mcl and then
				a_mcl.column_resized_actions_internal /= Void
			then
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
			a_text_iter, a_text_mark: POINTER
		do
			if
				attached {EV_RICH_TEXT_IMP} eif_id_object (a_object_id) as a_rich_text and then
				not a_rich_text.is_destroyed
			then
				a_text_iter := {GOBJECT}.g_value_pointer ({GOBJECT}.g_value_array_i_th (args, 1))
				a_text_mark := {GOBJECT}.g_value_pointer ({GOBJECT}.g_value_array_i_th (args, 2))
				a_rich_text.on_text_mark_changed (a_text_iter, a_text_mark )
			end
		end

	tree_row_expansion_change_intermediary (a_object_id: INTEGER; is_expanded: BOOLEAN; nargs: INTEGER; args: POINTER)
			-- Used for calling expansion actions for tree nodes
		local
			a_tree_node: detachable EV_TREE_NODE_IMP
			a_tree_path: POINTER
		do
			if
				attached {EV_TREE_IMP} eif_id_object (a_object_id) as a_tree_imp and then
				not a_tree_imp.is_destroyed
			then
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
			a_tree_path_str: POINTER
		do
			if
				attached {EV_GTK_TREE_VIEW} eif_id_object (a_object_id) as a_list_imp and then
				not a_list_imp.is_destroyed
			then
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
		do
			if
				attached {EV_COMBO_BOX_IMP} eif_id_object (a_object_id) as a_combo and then
			 	a_combo.parent_imp /= Void and then not a_combo.is_destroyed
			 then
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
			obj: ANY
		do
			obj := eif_id_object (a_object_id)
			if attached {EV_TOOL_BAR_RADIO_BUTTON_IMP} obj as a_radio_button_imp then
				if a_radio_button_imp.is_selected and then attached a_radio_button_imp.select_actions_internal as l_radio_button_select_actions then
					l_radio_button_select_actions.call (Void)
				end
			elseif
				attached {EV_TOOL_BAR_BUTTON_IMP} obj as a_toolbar_button_imp and then
				attached a_toolbar_button_imp.select_actions_internal as l_toolbar_button_select_actions
			then
				l_toolbar_button_select_actions.call (Void)
			end
		end

	gdk_event_dispatcher (a_object_id: INTEGER; n_args: INTEGER; args: POINTER)
			-- Intermediary agent for gdk events.
		do
			if attached {EV_ANY_IMP}  eif_id_object (a_object_id) as l_any_imp then
				l_any_imp.process_gdk_event (n_args, args)
			else
				check event_object_not_coupled: False end
			end
		end

feature {EV_ANY_I} -- Externals

	frozen eif_object_from_c, c_get_eif_reference_from_object_id (a_c_object: POINTER): detachable EV_ANY_IMP
			-- Get Eiffel object from `a_c_object'.
		local
			l_eif_oid: INTEGER
		do
			l_eif_oid := get_object_data_eif_oid (a_c_object)
			if
				l_eif_oid >= 0 and then
				attached {EV_ANY_IMP} eif_id_object (l_eif_oid) as res
			then
				Result := res
			end
		ensure
			is_class: class
		end

	frozen get_object_data_eif_oid (a_c_object: POINTER): INTEGER
		external
			"C inline use <ev_gtk.h>"
		alias
			"[
				(EIF_INTEGER) (rt_int_ptr) g_object_get_data (G_OBJECT($a_c_object), "eif_oid")
			]"
		ensure
			is_class: class
		end

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES
