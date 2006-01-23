indexing

	description: 
		"EiffelVision combo box, gtk implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_COMBO_BOX_IMP
	
inherit
	EV_COMBO_BOX_I
		undefine
			wipe_out
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		undefine
			create_focus_in_actions,
			create_focus_out_actions
		redefine
			initialize,
			make,
			interface,
			on_focus_changed
		end

	EV_LIST_ITEM_LIST_IMP
		undefine
			set_default_colors,
			visual_widget,
			set_composite_widget_pointer_style,
			destroy,
			on_key_event,
			default_key_processing_blocked,
			on_focus_changed,
			has_focus,
			set_focus,
			needs_event_box
		redefine
			select_callback,
			remove_i_th,
			gtk_reorder_child,
			initialize,
			make,
			add_to_container,
			interface,
			selected_item
		end

	EV_COMBO_BOX_ACTION_SEQUENCES_IMP

	EV_KEY_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a combo-box.
		local
			activate_id: INTEGER
			a_vbox: POINTER
		do
			base_make (an_interface)

			-- create of the gtk object.
			a_vbox := {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0)
			set_c_object (a_vbox)
			container_widget := {EV_GTK_EXTERNALS}.gtk_combo_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (container_widget)
			dropdown_window := {EV_GTK_EXTERNALS}.gtk_combo_struct_popwin (container_widget)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (a_vbox, container_widget, False, False, 0)

			-- Pointer to the text we see.
			entry_widget := {EV_GTK_EXTERNALS}.gtk_combo_struct_entry (container_widget)

			-- Pointer to the list of items.
			list_widget := {EV_GTK_EXTERNALS}.gtk_combo_struct_list (container_widget)
			{EV_GTK_EXTERNALS}.gtk_combo_set_use_arrows (container_widget, 0)
			{EV_GTK_EXTERNALS}.gtk_combo_set_case_sensitive (container_widget, 1)

			activate_id := {EV_GTK_EXTERNALS}.gtk_combo_struct_activate_id (container_widget)
			{EV_GTK_EXTERNALS}.signal_handler_block (entry_widget, activate_id)
			
			on_key_pressed_intermediary_agent := agent (App_implementation.gtk_marshal).on_list_item_list_key_pressed_intermediary (c_object, ?, ?, ?)
			on_item_clicked_intermediary_agent := agent (App_implementation.gtk_marshal).on_list_item_list_item_clicked_intermediary (c_object)
		end
		
	initialize is
			-- Connect action sequences to signals.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP}
				-- List item sets up all events

			{EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (
				list_widget,
				{EV_GTK_EXTERNALS}.gTK_SELECTION_BROWSE_ENUM
			)
			real_signal_connect (dropdown_window, "unmap-event", agent (App_implementation.gtk_marshal).on_combo_box_dropdown_unmapped (c_object), App_implementation.default_translate)
		end
		
feature -- Status report

	rows: INTEGER is
		 	-- Number of lines.
		do
			Result := {EV_GTK_EXTERNALS}.g_list_length (
				{EV_GTK_EXTERNALS}.gtk_list_struct_children (list_widget)
			)
		end

	selected_item: EV_LIST_ITEM is
			-- Currently selected item if any.
		local
			item_pointer: POINTER
			cur: EV_DYNAMIC_LIST_CURSOR [EV_ITEM]
		do
			item_pointer := {EV_GTK_EXTERNALS}.gtk_list_struct_selection (list_widget)
			if item_pointer /= NULL then
				item_pointer := {EV_GTK_EXTERNALS}.gslist_struct_data (item_pointer)
				if item_pointer /= NULL then
					Result ?= eif_object_from_c (item_pointer).interface
					check Result_not_void: Result /= Void end
				end
			elseif not is_editable then
					from
						cur := interface.cursor
						interface.start
					until
						index > count or else Result /= Void
					loop
						if item.text.is_equal (text) then
							Result := item
						end
						interface.forth
					end
					interface.go_to (cur)
			end		
		end

feature -- Status setting

	set_maximum_text_length (len: INTEGER) is
			-- Set the length of the longest 
		do
			{EV_GTK_EXTERNALS}.gtk_entry_set_max_length (entry_widget, len)
		end

feature {EV_LIST_ITEM_IMP, EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Implementation
		
	container_widget: POINTER
			-- Gtk combo struct
			
	launch_select_actions is
			-- 
		local
			sel_item: EV_LIST_ITEM
			sel_item_imp: EV_LIST_ITEM_IMP
		do
			sel_item ?= selected_item
			if sel_item /= Void then
				sel_item_imp ?= sel_item.implementation
				if sel_item_imp /= Void then
					call_select_actions (sel_item_imp)
				end				
			end
		end

feature {NONE} -- Implementation

	dropdown_window: POINTER
			-- Pointer to the GtkWindow that drops down on item selection.

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
			--| For now, do nothing.
		end
			
	on_key_pressed_intermediary_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE [EV_KEY, STRING, BOOLEAN]]
			-- Intermediary key agent that is reused for list items in `add_to_container'.
			
	on_item_clicked_intermediary_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE]
			-- Intermediary key agent that is reused for list items in `add_to_container'.

	add_to_container (v: like item; v_imp: EV_LIST_ITEM_IMP) is
			-- Add `v' to container.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := v_imp.text
			{EV_GTK_EXTERNALS}.gtk_combo_set_item_string (container_widget, v_imp.c_object, a_cs.item)
			{EV_GTK_EXTERNALS}.gtk_container_add (list_widget, v_imp.c_object)
			v_imp.set_item_parent_imp (Current)
			real_signal_connect (v_imp.c_object, "button-press-event", on_item_clicked_intermediary_agent, Void)
			real_signal_connect (v_imp.c_object, "key-press-event", on_key_pressed_intermediary_agent, key_event_translate_agent)

			-- Make sure the first item is always selected.
			{EV_GTK_EXTERNALS}.gtk_list_select_item (list_widget, 0)
		end

	remove_i_th (a_position: INTEGER) is
			-- Remove item at position `a_position'.
		local
			imp: EV_LIST_ITEM_IMP
		do
			imp ?= i_th (a_position).implementation
			Precursor (a_position)
			imp.set_item_parent_imp (Void)
			if count = 0 then
				set_text ("")
			end
		end

	gtk_reorder_child (a_container, a_child: POINTER; an_index: INTEGER) is
			-- Reorder `a_child' to `an_index' in `c_object'.
			-- `a_container' is ignored.
		do
			{EV_GTK_EXTERNALS}.gtk_box_reorder_child (container_widget, a_child, an_index - 1)
		end

	select_callback (n: INTEGER; an_item: POINTER) is
			-- Redefined to counter repeated select signal of combo box. 
		do	
			-- Do nothing, we handle selection via unmapping of popup window and explicit calling.
		end
		
	on_focus_changed (a_has_focus: BOOLEAN) is
			-- Focus for `Current' has changed'.
		do
			Precursor {EV_TEXT_FIELD_IMP} (a_has_focus)
			if a_has_focus and is_editable and not text.is_empty then
				select_all
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_COMBO_BOX;

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




end -- class EV_COMBO_BOX_IMP

