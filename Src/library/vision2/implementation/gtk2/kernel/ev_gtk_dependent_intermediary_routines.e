indexing
	description: "Intermediary routines between gtk and eiffel."
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
	
feature {EV_GTK_CALLBACK_MARSHAL, EV_ANY_IMP} -- Tuple optimizations

	empty_tuple: TUPLE is
		once
			Result := []
		end

feature {EV_ANY_I} -- Implementation

	text_buffer_mark_set_intermediary (a_object_id: INTEGER; nargs: INTEGER; args: POINTER) is
			-- Used for caret positioning events
		local
			a_rich_text: EV_RICH_TEXT_IMP
			a_text_iter, a_text_mark: POINTER
		do
			a_rich_text ?= eif_id_object (a_object_id)
			if a_rich_text /= Void and then not a_rich_text.is_destroyed then
				a_text_iter := feature {EV_GTK_EXTERNALS}.gtk_value_pointer (feature {EV_GTK_DEPENDENT_EXTERNALS}.g_value_array_i_th (args, 1))
				a_text_mark := feature {EV_GTK_EXTERNALS}.gtk_value_pointer (feature {EV_GTK_DEPENDENT_EXTERNALS}.g_value_array_i_th (args, 2))
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
			gdk_event := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (args)
			window_flags := feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_event_window_state_struct_new_window_state (gdk_event)
			if titled_window_imp /= Void and then not titled_window_imp.is_destroyed then
				if window_flags & feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum = feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum then
					--print ("Window minimized%N")
					titled_window_imp.call_window_state_event (feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum)
				elseif window_flags & feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum = feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum then
					--print ("Window maximized%N")
					titled_window_imp.call_window_state_event (feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum)
				elseif window_flags & feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_above_enum = feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_above_enum then
					--print ("Window above%N")
				elseif window_flags & feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_below_enum = feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_below_enum then
					--print ("Window below%N")
				elseif window_flags & feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_sticky_enum = feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_sticky_enum then
					--print ("Window sticky%N")
				elseif window_flags & feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_fullscreen_enum = feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_fullscreen_enum then
					--print ("Window fullscreen%N")
				elseif window_flags & feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_withdrawn_enum = feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_withdrawn_enum then
					--print ("Window withdrawn%N")
				else
					--print ("Window restored%N")
					titled_window_imp.call_window_state_event (feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_iconified_enum | feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_window_state_maximized_enum)
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
				a_tree_path := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_args_array_i_th (args, 1))
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
			a_list_imp: EV_CHECKABLE_LIST_IMP
			a_tree_path_str: POINTER
		do
			a_list_imp ?= eif_id_object (a_object_id)
			if a_list_imp /= Void and then not a_list_imp.is_destroyed then
				a_tree_path_str := feature {EV_GTK_EXTERNALS}.gtk_value_pointer (feature {EV_GTK_EXTERNALS}.gtk_args_array_i_th (args, 0))
				a_list_imp.on_tree_path_toggle (a_tree_path_str)
			end
		end

	scroll_wheel_translate (n: INTEGER; args: POINTER): TUPLE is
			-- Transform scroll wheel event
		local
			scroll_event: POINTER
			button_number: INTEGER
		do
			scroll_event := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_pointer (args)
			if feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_event_scroll_struct_scroll_direction (scroll_event) = feature {EV_GTK_DEPENDENT_EXTERNALS}.gdk_scroll_up_enum then
				button_number := 4
			else
				button_number := 5
			end
			Result := [feature {EV_GTK_EXTERNALS}.GDK_BUTTON_PRESS_ENUM, 0, 0, button_number, 0.5, 0.5, 0.5, 0, 0]
		end

	accel_activate_intermediary (a_object_id: INTEGER; n: INTEGER; p: POINTER) is
			-- Call accelerators for window `a_object_id'
		local
			arg: POINTER
			accel_key, accel_mods: INTEGER
			a_titled_window_imp: EV_TITLED_WINDOW_IMP
		do
			a_titled_window_imp ?= eif_id_object (a_object_id)
			arg := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_args_array_i_th (p, 1)
			accel_key := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_uint (arg)
			arg := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_args_array_i_th (p, 2)
			accel_mods := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_flags (arg)
			if a_titled_window_imp /= Void and then not a_titled_window_imp.is_destroyed then
				a_titled_window_imp.call_accelerators (key_code_from_gtk (accel_key), accel_mods)
			end
		end

	page_switch_translate (n: INTEGER; args: POINTER): TUPLE is
			-- Retrieve index of switched page.
		local
			gtkarg2: POINTER
		do
			gtkarg2 := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_args_array_i_th (args, 1)
			Result := [feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_uint (gtkarg2)]
		end

	on_pnd_deferred_item_parent_selection_change (a_object_id: INTEGER) is
			-- 
		local
			a_pnd_widget: EV_PND_DEFERRED_ITEM_PARENT
		do
			a_pnd_widget ?= eif_id_object (a_object_id)
			if a_pnd_widget /= Void then
				a_pnd_widget.call_selection_action_sequences
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
				if a_radio_button_imp.is_selected then
					a_toolbar_button_imp.select_actions_internal.call (Void)
				end
			elseif a_toolbar_button_imp /= Void then	
				a_toolbar_button_imp.select_actions_internal.call (Void)
			end
		end

feature {EV_ANY_I} -- Externals

	frozen c_get_eif_reference_from_object_id (a_c_object: POINTER): EV_ANY_IMP is
			-- Get Eiffel object from `a_c_object'.
		external
			"C (GtkWidget*): EIF_REFERENCE | %"ev_any_imp.h%""
		alias
			"c_ev_any_imp_get_eif_reference_from_object_id"
		end

end -- class EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

