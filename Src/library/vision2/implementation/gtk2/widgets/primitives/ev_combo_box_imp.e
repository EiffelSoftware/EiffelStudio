indexing

	description: 
		"EiffelVision combo box, gtk implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_COMBO_BOX_IMP
	
inherit
	EV_COMBO_BOX_I
		undefine
			wipe_out,
			call_pebble_function
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		undefine
			create_focus_in_actions,
			create_focus_out_actions,
			needs_event_box,
			pre_pick_steps,
			call_pebble_function,
			enable_transport
		redefine
			initialize,
			make,
			interface,
			needs_event_box
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
			set_focus
		redefine
			initialize,
			needs_event_box,
			make,
			interface,
			insert_i_th
		end

	EV_COMBO_BOX_ACTION_SEQUENCES_IMP

	EV_KEY_CONSTANTS

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is False

	make (an_interface: like interface) is
			-- Create a combo-box.
		local
			a_vbox: POINTER
		do
			base_make (an_interface)
			a_vbox := {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0)
			set_c_object (a_vbox)
			container_widget := {EV_GTK_EXTERNALS}.gtk_combo_box_entry_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (container_widget)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (a_vbox, container_widget, False, False, 0)
			entry_widget := {EV_GTK_EXTERNALS}.gtk_combo_box_get_entry (container_widget)
		end

	call_selection_action_sequences is
			-- Call the appropriate selection action sequences
		local
			a_selected_item: EV_LIST_ITEM
			a_selected_item_imp: EV_LIST_ITEM_IMP
		do
			a_selected_item := selected_item
			
			if a_selected_item /= Void then
				set_text (a_selected_item.text)
				a_selected_item_imp ?= a_selected_item.implementation
				if a_selected_item_imp.select_actions_internal /= Void then
					a_selected_item_imp.select_actions_internal.call (Void)
				end
				if select_actions_internal /= Void then
					select_actions_internal.call (Void)
				end
			end
			if previous_selected_item_imp /= Void then
					if previous_selected_item_imp.deselect_actions_internal /= Void then
						previous_selected_item_imp.deselect_actions_internal.call (Void)
					end
					if deselect_actions_internal /= Void then
						deselect_actions_internal.call (Void)
					end
			end
			previous_selected_item_imp := a_selected_item_imp
		end

	previous_selected_item_imp: EV_LIST_ITEM_IMP
		-- Item that was selected previously.
	
	initialize is
			-- Connect action sequences to signals.
		local
			a_cell_renderer: POINTER
			a_attribute: EV_GTK_C_STRING
		do
			Precursor {EV_LIST_ITEM_LIST_IMP}
			initialize_combo_box_style (container_widget)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_set_model (container_widget, list_store)

				-- The combo box is already initialized with a text cell renderer at position 0, that is why we reorder the pixbuf cell renderer to position 0 and set the text column to 1
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_entry_set_text_column (container_widget, 1)
			
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_clear (container_widget)
			
			a_cell_renderer := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_pixbuf_new
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_pack_start (container_widget, a_cell_renderer, True)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_reorder (container_widget, a_cell_renderer, 0)
			a_attribute := "pixbuf"
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_set_attribute (container_widget, a_cell_renderer, a_attribute.item, 0)

			a_cell_renderer := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_text_new
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_pack_start (container_widget, a_cell_renderer, True)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_reorder (container_widget, a_cell_renderer, 0)
			a_attribute := "text"
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_set_attribute (container_widget, a_cell_renderer, a_attribute.item, 1)

			real_signal_connect (container_widget, "changed", agent (app_implementation.gtk_marshal).on_pnd_deferred_item_parent_selection_change (internal_id), Void)
		end

	initialize_combo_box_style (a_combo_box: POINTER) is
			-- Remove the default shadow from the toolbar
		external
			"C inline use <gtk/gtk.h>"
		alias
			"[
				{
					gtk_widget_set_name ((GtkWidget*) $a_combo_box, "v2combobox");
					gtk_rc_parse_string ("style \"v2-combo-style\" {\n GtkComboBox::appears-as-list = 1\n }\n  widget \"*.v2combobox\" style : highest  \"v2-combo-style\" " );
				}
			]"
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP} (v, i)
			if count = 1 then
				v.enable_select
			end
		end
		
feature -- Status report

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected, for a multiple
			-- selection.
		local
			a_active: INTEGER
		do
			a_active := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_get_active (container_widget)
			if a_active >= 0 then
				Result := child_array @ (a_active + 1)
			end
		end

	selected_items: ARRAYED_LIST [EV_LIST_ITEM] is
			-- List of all the selected items. Used for list_item.is_selected implementation
		do
			create Result.make (0)
			Result.extend (selected_item)
		end

	select_item (an_index: INTEGER) is
			-- Select an item at the one-based `index' of the list.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_set_active (container_widget, an_index - 1)
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_set_active (container_widget, -1)
		end

	clear_selection is
			-- Clear the item selection of `Current'
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_set_active (container_widget, -1)
		end

feature -- Status setting

	set_maximum_text_length (len: INTEGER) is
			-- Set the length of the longest 
		do
			{EV_GTK_EXTERNALS}.gtk_entry_set_max_length (entry_widget, len)
		end

feature {EV_LIST_ITEM_IMP, EV_INTERMEDIARY_ROUTINES} -- Implementation
		
	container_widget: POINTER
			-- Gtk combo struct

feature {NONE} -- Implementation

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
			--| For now, do nothing.
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_COMBO_BOX

end -- class EV_COMBO_BOX_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

