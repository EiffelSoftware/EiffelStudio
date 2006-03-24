indexing
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

feature {EV_ANY_I} -- Implementation

	new_toolbar_item_select_actions_intermediary (a_object_id: INTEGER) is
			-- Intermediary agent for toolbar button select action
			-- (from EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES)
			-- (export status {EV_ANY_I})
		local
			a_toolbar_button_imp: EV_TOOL_BAR_BUTTON_IMP
			a_radio_button_imp: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			a_toolbar_button_imp ?= eif_id_object (a_object_id)
			a_radio_button_imp ?= a_toolbar_button_imp
			if a_radio_button_imp /= Void then
				if a_radio_button_imp.is_selected and then a_toolbar_button_imp.select_actions_internal /= Void then
					a_toolbar_button_imp.select_actions_internal.call (Void)
				end
			elseif a_toolbar_button_imp /= Void then
				a_toolbar_button_imp.call_select_actions
			end
		end

	pnd_deferred_parent_start_transport_filter_intermediary (a_c_object: POINTER; a_type: INTEGER; a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Start of pick and drop transport
		local
			pnd_par: EV_PND_DEFERRED_ITEM_PARENT
		do
			pnd_par ?= c_get_eif_reference_from_object_id (a_c_object)
			pnd_par.start_transport_filter (a_type, a_x, a_y, a_button, a_x_tilt, a_y_tilt, a_pressure, a_screen_x, a_screen_y)
		end

	mcl_column_click_callback (a_object_id: INTEGER; int: INTEGER) is
		local
			a_mcl: EV_MULTI_COLUMN_LIST_IMP
		do
			a_mcl ?= eif_id_object (a_object_id)
			if a_mcl /= Void and then a_mcl.column_title_click_actions_internal /= Void then
				a_mcl.column_title_click_actions_internal.call ([int])
			end
		end

	mcl_column_resize_callback (a_object_id: INTEGER; a_column: INTEGER) is
		local
			a_column_ptr: POINTER
			temp_width: INTEGER
			a_mcl: EV_MULTI_COLUMN_LIST_IMP
		do
			a_mcl ?= eif_id_object (a_object_id)
			if a_mcl /= Void and then a_mcl.column_resized_actions_internal /= Void then
				if a_column > 0 then
					a_column_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_get_column (a_mcl.tree_view, a_column - 1)
					temp_width := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_tree_view_column_get_width (a_column_ptr)
					if (a_column) <= a_mcl.column_count and then a_mcl.column_widths /= Void and then a_mcl.column_width (a_column) /= temp_width then
						a_mcl.update_column_width (temp_width, a_column)
						if a_mcl.column_resized_actions_internal /= Void then
							a_mcl.column_resized_actions_internal.call ([a_column])
						end
					end
				end
			end
		end

	text_buffer_mark_set_intermediary (a_object_id: INTEGER; nargs: INTEGER; args: POINTER) is
			-- Used for caret positioning events
		local
			a_rich_text: EV_RICH_TEXT_IMP
			a_text_iter, a_text_mark: POINTER
		do
			a_rich_text ?= eif_id_object (a_object_id)
			if a_rich_text /= Void and then not a_rich_text.is_destroyed then
				a_text_iter := {EV_GTK_EXTERNALS}.gtk_value_pointer ({EV_GTK_DEPENDENT_EXTERNALS}.g_value_array_i_th (args, 1))
				a_text_mark := {EV_GTK_EXTERNALS}.gtk_value_pointer ({EV_GTK_DEPENDENT_EXTERNALS}.g_value_array_i_th (args, 2))
				a_rich_text.on_text_mark_changed (a_text_iter, a_text_mark )
			end
		end

	window_state_intermediary (a_object_id: INTEGER; n_args: INTEGER; args: POINTER) is
			-- The window state of the window `a_object_id' has changed
		local
			gdk_event: POINTER
			window_flags: INTEGER
			titled_window_imp: EV_TITLED_WINDOW_IMP
		do
			titled_window_imp ?= eif_id_object (a_object_id)
			gdk_event := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (args)
			window_flags := {EV_GTK_DEPENDENT_EXTERNALS}.gdk_event_window_state_struct_new_window_state (gdk_event)
			if titled_window_imp /= Void and then not titled_window_imp.is_destroyed then
				if window_flags & {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum then
					--print ("Window minimized%N")
					titled_window_imp.call_window_state_event ({EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum)
				elseif window_flags & {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum then
					--print ("Window maximized%N")
					titled_window_imp.call_window_state_event ({EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum)
				elseif window_flags & {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_above_enum = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_above_enum then
					--print ("Window above%N")
				elseif window_flags & {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_below_enum = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_below_enum then
					--print ("Window below%N")
				elseif window_flags & {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_sticky_enum = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_sticky_enum then
					--print ("Window sticky%N")
				elseif window_flags & {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_fullscreen_enum = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_fullscreen_enum then
					--print ("Window fullscreen%N")
				elseif window_flags & {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_withdrawn_enum = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_withdrawn_enum then
					--print ("Window withdrawn%N")
				else
					--print ("Window restored%N")
					titled_window_imp.call_window_state_event ({EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum | {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum)
				end
			end
		end

	tree_row_expansion_change_intermediary (a_object_id: INTEGER; is_expanded: BOOLEAN; nargs: INTEGER; args: POINTER) is
			-- Used for calling expansion actions for tree nodes
		local
			a_tree_imp: EV_TREE_IMP
			a_tree_node: EV_TREE_NODE_IMP
			a_tree_path: POINTER
		do
			a_tree_imp ?= eif_id_object (a_object_id)
			if a_tree_imp /= Void and then not a_tree_imp.is_destroyed then
				a_tree_path := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer ({EV_GTK_DEPENDENT_EXTERNALS}.gtk_args_array_i_th (args, 1))
				a_tree_node := a_tree_imp.node_from_tree_path (a_tree_path)
				if is_expanded then
					-- Call tree node expand actions
					if a_tree_node.expand_actions_internal /= Void then
						a_tree_node.expand_actions_internal.call (Void)
					end
				else
					-- Call tree node collapse actions
					if a_tree_node.collapse_actions_internal /= Void then
						a_tree_node.collapse_actions_internal.call (Void)
					end
				end
			end
		end

	boolean_cell_renderer_toggle_intermediary (a_object_id: INTEGER; nargs: INTEGER; args: POINTER) is
			-- Called when a cell renderer is toggled (EV_CHECKABLE_LIST)
		local
			a_list_imp: EV_GTK_TREE_VIEW
			a_tree_path_str: POINTER
		do
			a_list_imp ?= eif_id_object (a_object_id)
			if a_list_imp /= Void and then not a_list_imp.is_destroyed then
				a_tree_path_str := {EV_GTK_EXTERNALS}.gtk_value_pointer ({EV_GTK_EXTERNALS}.gtk_args_array_i_th (args, 0))
				a_list_imp.on_tree_path_toggle (a_tree_path_str)
			end
		end

	scroll_wheel_translate (n: INTEGER; args: POINTER): TUPLE is
			-- Transform scroll wheel event
		local
			scroll_event: POINTER
			button_number: INTEGER
		do
			scroll_event := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (args)
			if {EV_GTK_DEPENDENT_EXTERNALS}.gdk_event_scroll_struct_scroll_direction (scroll_event) = {EV_GTK_DEPENDENT_EXTERNALS}.gdk_scroll_up_enum then
				button_number := 4
			else
				button_number := 5
			end
			Result := [{EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_ENUM, 0, 0, button_number, 0.5, 0.5, 0.5, 0, 0]
		end

	accel_activate_intermediary (a_object_id: INTEGER; n: INTEGER; p: POINTER) is
			-- Call accelerators for window `a_object_id'
		local
			arg: POINTER
			accel_key: NATURAL_32
			accel_mods: INTEGER
			a_titled_window_imp: EV_TITLED_WINDOW_IMP
		do
			a_titled_window_imp ?= eif_id_object (a_object_id)
			arg := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_args_array_i_th (p, 1)
			accel_key := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_uint (arg)
			arg := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_args_array_i_th (p, 2)
			accel_mods := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_flags (arg)
			if a_titled_window_imp /= Void and then not a_titled_window_imp.is_destroyed then
				a_titled_window_imp.call_accelerators (key_code_from_gtk (accel_key), accel_mods)
			end
		end

	page_switch_translate (n: INTEGER; args: POINTER): TUPLE is
			-- Retrieve index of switched page.
		local
			gtkarg2: POINTER
		do
			gtkarg2 := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_args_array_i_th (args, 1)
			Result := [{EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_uint (gtkarg2)]
		end

	on_pnd_deferred_item_parent_selection_change (a_object_id: INTEGER) is
			-- A selection event has occurred on a PND deferred item parent.
		local
			a_pnd_widget: EV_PND_DEFERRED_ITEM_PARENT
		do
			a_pnd_widget ?= eif_id_object (a_object_id)
			if a_pnd_widget /= Void then
				a_pnd_widget.call_selection_action_sequences
			end
		end

	on_combo_box_toggle_button_event (a_object_id: INTEGER; a_event_id: INTEGER) is
			-- A combo box toggle button has been toggled.
		local
			a_combo: EV_COMBO_BOX_IMP
		do
			a_combo ?= eif_id_object (a_object_id)
			if a_combo /= Void and then not a_combo.is_destroyed then
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

	toolbar_item_select_actions_intermediary (a_object_id: INTEGER) is
			-- Intermediary agent for toolbar button select action
		local
			a_toolbar_button_imp: EV_TOOL_BAR_BUTTON_IMP
			a_radio_button_imp: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			a_toolbar_button_imp ?= eif_id_object (a_object_id)
			a_radio_button_imp ?= a_toolbar_button_imp
			if a_radio_button_imp /= Void then
				if a_radio_button_imp.is_selected and then a_toolbar_button_imp.select_actions_internal /= Void then
					a_toolbar_button_imp.select_actions_internal.call (Void)
				end
			elseif a_toolbar_button_imp /= Void and then a_toolbar_button_imp.select_actions_internal /= Void then
				a_toolbar_button_imp.select_actions_internal.call (Void)
			end
		end

	gdk_event_dispatcher (a_object_id: INTEGER; n_args: INTEGER; args: POINTER) is
			-- Intermediary agent for gdk events.
		local
			l_any_imp: EV_ANY_IMP
		do
			l_any_imp ?= eif_id_object (a_object_id)
			l_any_imp.process_gdk_event (n_args, args)
		end

feature {EV_ANY_I} -- Externals

	frozen c_get_eif_reference_from_object_id (a_c_object: POINTER): EV_ANY_IMP is
			-- Get Eiffel object from `a_c_object'.
		external
			"C (GtkWidget*): EIF_REFERENCE | %"ev_any_imp.h%""
		alias
			"c_ev_any_imp_get_eif_reference_from_object_id"
		end

indexing
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

