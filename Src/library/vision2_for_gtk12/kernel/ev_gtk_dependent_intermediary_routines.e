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
		
	ANY

feature {EV_ANY_IMP} -- Gtk Dependent intermediary routines

	scroll_wheel_translate (n: INTEGER; args: POINTER): TUPLE is
		do
			-- Not used.
		end

	page_switch_translate (n: INTEGER; args: POINTER): TUPLE is
			-- Retrieve index of switched page.
		local
			gtkarg2: POINTER
		do
			gtkarg2 := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_args_array_i_th (args, 1)
			Result := [{EV_GTK_DEPENDENT_EXTERNALS}.gtk_value_uint (gtkarg2)]
		end

	mcl_event_intermediary (a_c_object: POINTER; a_event_number: INTEGER; a_int: INTEGER) is
			-- Multi-column list event
		local
			a_mcl_imp: EV_MULTI_COLUMN_LIST_IMP
		do
			a_mcl_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			inspect
				a_event_number
			when 1 then		
				a_mcl_imp.select_callback (a_int)
			when 2 then
				a_mcl_imp.deselect_callback (a_int)
			when 3 then
				a_mcl_imp.column_click_callback (a_int)
			when 4 then
				a_mcl_imp.column_resize_callback (a_int)
			end
		end

feature {EV_ANY_IMP} -- Toolbar intermediary agent routines

	on_tool_bar_radio_button_activate (a_c_object: POINTER) is
			-- Toolbar button activated
		local
			a_tool_bar_radio_button_imp: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			a_tool_bar_radio_button_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_tool_bar_radio_button_imp.on_activate
		end

	toolbar_button_select_actions_intermediary (a_c_object: POINTER) is
			-- Intermediary agent for toolbar button select action
		local
			a_toolbar_button_imp: EV_TOOL_BAR_BUTTON_IMP
		do
			a_toolbar_button_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_toolbar_button_imp.select_actions_internal.call (Void)
		end

feature {EV_ANY_IMP, EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- List and list item intermediary agent routines
		
	on_list_item_list_key_pressed_intermediary (a_c_object: POINTER; a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- List item selected
		local
			a_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			a_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			--a_list_item_list.on_key_pressed (a_key, a_key_string, a_key_press)
		end
		
	on_list_item_list_item_clicked_intermediary (a_c_object: POINTER) is
			-- List item clicked
		local
			a_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			a_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			--a_list_item_list.on_item_clicked
		end

	list_proximity_intermediary (a_c_object: POINTER; in_out_flag: BOOLEAN) is
			-- Pointer entered or left
		local
			a_list_imp: EV_LIST_IMP
		do
			a_list_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			--a_list_imp.set_is_out (in_out_flag)
		end

	on_list_focus_intermediary (a_c_object: POINTER; in_out_flag: BOOLEAN) is
			-- Focus gained or lost
		local
			a_list_imp: EV_LIST_IMP
		do
			a_list_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			if in_out_flag then
				a_list_imp.attain_focus
			else
				a_list_imp.lose_focus
			end
		end

	list_item_select_callback_intermediary (a_c_object: POINTER; n_args: INTEGER; args: POINTER) is
			-- Item select callback
		local
			l_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			l_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			l_list_item_list.select_callback (n_args, args)
		end
		
	list_item_check_intermediary (a_c_object: POINTER) is
			-- List item check button callback
		local
			l_list_item_imp: EV_LIST_ITEM_IMP
		do
			l_list_item_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			l_list_item_imp.check_callback
		end

	list_item_deselect_callback_intermediary (a_c_object: POINTER; n_args: INTEGER; args: POINTER) is
			-- Item deselect callback
		local
			l_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			l_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			if not l_list_item_list.is_destroyed then
				l_list_item_list.deselect_callback (n_args, args)
			end
		end
		
	list_clicked_intermediary (a_c_object: POINTER) is
			-- List clicked
		local
			l_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			l_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			l_list_item_list.on_list_clicked
		end
		
	list_key_pressed_intermediary (a_c_object: POINTER; ev_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
			-- Key pressed in list
		local
			l_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			l_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			l_list_item_list.on_key_pressed (ev_key, a_key_string, a_key_press)
		end
		
	list_item_clicked_intermediary (a_c_object: POINTER) is
			-- List item clicked
		local
			l_list_item_list: EV_LIST_ITEM_LIST_IMP
		do
			l_list_item_list ?= c_get_eif_reference_from_object_id (a_c_object)
			l_list_item_list.on_item_clicked ()
		end

feature {EV_ANY_IMP} -- Combo box intermediary agent routines

	on_combo_box_dropdown_unmapped (a_c_object: POINTER) is
			-- Button released
		local
			a_combo_box_imp: EV_COMBO_BOX_IMP
		do
			a_combo_box_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_combo_box_imp.launch_select_actions
		end


feature {EV_ANY_IMP} -- Tree intermediary agent routines	
	
	on_tree_event_intermediary (a_c_object: POINTER; a_event_number: INTEGER; a_tree_item: POINTER) is
			-- Tree event
		local
			a_tree_imp: EV_TREE_IMP
		do
			a_tree_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			inspect
				a_event_number
			when 1 then		
				a_tree_imp.select_callback (a_tree_item)
			when 2 then
				a_tree_imp.deselect_callback (a_tree_item)
			when 3 then
				a_tree_imp.expand_callback (a_tree_item)
			when 4 then
				a_tree_imp.collapse_callback (a_tree_item)
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

