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
			wipe_out
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		undefine
			create_focus_in_actions,
			create_focus_out_actions,
			needs_event_box
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
			interface
		end

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
			a_vbox := feature {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0)
			set_c_object (a_vbox)
			container_widget := feature {EV_GTK_EXTERNALS}.gtk_combo_box_entry_new
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (container_widget)
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (a_vbox, container_widget, False, False, 0)
			entry_widget := feature {EV_GTK_EXTERNALS}.gtk_combo_box_get_entry (container_widget)
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
					a_selected_item_imp.select_actions_internal.call (app_implementation.empty_tuple)
				end
				if select_actions_internal /= Void then
					select_actions_internal.call (app_implementation.empty_tuple)
				end
			else
				set_text ("")
			end
			if previous_selected_item_imp /= Void then
					if previous_selected_item_imp.deselect_actions_internal /= Void then
						previous_selected_item_imp.deselect_actions_internal.call (app_implementation.empty_tuple)
					end
					if deselect_actions_internal /= Void then
						deselect_actions_internal.call (app_implementation.empty_tuple)
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
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_set_model (container_widget, tree_store)
			
		--	feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_clear (container_widget)
			
			a_cell_renderer := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_pixbuf_new
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_pack_start (container_widget, a_cell_renderer, True)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_reorder (container_widget, a_cell_renderer, 0)
			create a_attribute.make ("pixbuf")
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_set_attribute (container_widget, a_cell_renderer, a_attribute.item, 0)

			a_cell_renderer := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_text_new
			--feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_pack_start (container_widget, a_cell_renderer, True)
			--feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_reorder (container_widget, a_cell_renderer, 0)
			create a_attribute.make ("text")
			--feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_set_attribute (container_widget, a_cell_renderer, a_attribute.item, 1)

				-- The combo box is already initialized with a text cell renderer at position 0, that is why we reorder the pixbuf cell renderer to position 0 and set the text column to 1
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_entry_set_text_column (container_widget, 1)
			
			real_signal_connect (container_widget, "changed", agent (app_implementation.gtk_marshal).on_pnd_deferred_item_parent_selection_change (internal_id), Void)
		end
		
feature -- Status report

	selected_item: EV_LIST_ITEM is
			-- Item which is currently selected, for a multiple
			-- selection.
		local
			a_active: INTEGER
		do
			a_active := feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_get_active (container_widget)
			if a_active >= 0 then
				Result := child_array @ (a_active + 1)
			end
		end

	select_item (an_index: INTEGER) is
			-- Select an item at the one-based `index' of the list.
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_set_active (container_widget, an_index - 1)
		end

	deselect_item (an_index: INTEGER) is
			-- Unselect the item at the one-based `index'.
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_set_active (container_widget, -1)
		end

	clear_selection is
			-- Clear the item selection of `Current'
		do
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_set_active (container_widget, -1)
		end

feature -- Status setting

	set_maximum_text_length (len: INTEGER) is
			-- Set the length of the longest 
		do
			feature {EV_GTK_EXTERNALS}.gtk_entry_set_max_length (entry_widget, len)
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

