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
			enable_transport,
			hide_border
		redefine
			initialize,
			make,
			interface,
			needs_event_box,
			has_focus,
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
			a_focus_list: POINTER
		do
			base_make (an_interface)
			a_vbox := {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0)
			set_c_object (a_vbox)
			container_widget := {EV_GTK_EXTERNALS}.gtk_combo_box_entry_new
			{EV_GTK_EXTERNALS}.gtk_widget_show (container_widget)
			{EV_GTK_EXTERNALS}.gtk_box_pack_start (a_vbox, container_widget, False, False, 0)
			entry_widget := {EV_GTK_EXTERNALS}.gtk_combo_box_get_entry (container_widget)
		

				-- Alter focus chain so that button cannot be selected via the keyboard.
			a_focus_list := {EV_GTK_EXTERNALS}.g_list_append (default_pointer, entry_widget)
			{EV_GTK_EXTERNALS}.gtk_container_set_focus_chain (container_widget, a_focus_list)
			{EV_GTK_EXTERNALS}.g_list_free (a_focus_list)


				-- This is a hack, remove when the toggle button can be retrieved via the API.
			real_signal_connect (container_widget, once "realize", agent (app_implementation.gtk_marshal).on_combo_box_toggle_button_event (internal_id, 1), Void)
			retrieve_toggle_button_signal_connection_id := last_signal_connection_id
		end

feature {NONE} -- Initialization

	call_selection_action_sequences is
			-- Call the appropriate selection action sequences
		local
			a_selected_item: EV_LIST_ITEM
			a_selected_item_imp: EV_LIST_ITEM_IMP
		do
			a_selected_item := selected_item
			if is_list_shown then
				{EV_GTK_EXTERNALS}.gtk_combo_box_popdown (container_widget)
			end
			if a_selected_item /= Void then
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
			a_cs: EV_GTK_C_STRING
		do
			Precursor {EV_LIST_ITEM_LIST_IMP}
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_set_model (container_widget, list_store)
			
				-- Set widget name so that the style can be used as set in EV_GTK_DEPENDENT_APPLICATION_IMP
			a_cs := once "v2combobox"
			{EV_GTK_EXTERNALS}.gtk_widget_set_name (container_widget, a_cs.item)

				-- The combo box is already initialized with a text cell renderer at position 0, that is why we reorder the pixbuf cell renderer to position 0 and set the text column to 1
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_entry_set_text_column (container_widget, 1)

			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_clear (container_widget)

			a_cell_renderer := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_text_new
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_pack_start (container_widget, a_cell_renderer, True)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_reorder (container_widget, a_cell_renderer, 0)
			a_attribute := once "text"
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_set_attribute (container_widget, a_cell_renderer, a_attribute.item, 1)

			a_cell_renderer := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_renderer_pixbuf_new
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_pack_start (container_widget, a_cell_renderer, False)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_reorder (container_widget, a_cell_renderer, 0)
			a_attribute := once "pixbuf"
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_cell_layout_set_attribute (container_widget, a_cell_renderer, a_attribute.item, 0)
			
			set_minimum_width_in_characters (4)

			real_signal_connect (container_widget, once "changed", agent (app_implementation.gtk_marshal).on_pnd_deferred_item_parent_selection_change (internal_id), Void)
		end

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP} (v, i)
			if count = 1 and then v.is_selectable then
				v.enable_select
			end
		end
		
feature -- Status report

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		local
			a_toggle: POINTER
		do
			Result := Precursor {EV_TEXT_FIELD_IMP}
				-- Check to see if the toggle button is depressed, if it is then the combo must have the focus
			return_combo_toggle (container_widget, $a_toggle)
			if not Result and a_toggle /= default_pointer then
				Result := {EV_GTK_EXTERNALS}.gtk_toggle_button_get_active (a_toggle)
			end
		end

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
			-- List of all the selected items. Used for list_item.is_selected implementation.
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
			-- Clear the item selection of `Current'.
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_combo_box_set_active (container_widget, -1)
		end

feature -- Status setting

	set_maximum_text_length (len: INTEGER) is
			-- Set the length of the longest text size in characters that `Current' can display.
		do
			{EV_GTK_EXTERNALS}.gtk_entry_set_max_length (entry_widget, len)
		end

feature {NONE} -- Implementation

	on_focus_changed (a_has_focus: BOOLEAN) is
			-- Focus for `Current' has changed'.
		local
			a_toggle: POINTER
		do
			if a_has_focus then
				if is_list_shown then
						-- `Current' is being popped down.
					is_list_shown := False
						-- Call list_hidden_actions.
					if list_hidden_actions_internal /= Void then
						list_hidden_actions_internal.call (Void)
					end
				else
					Precursor {EV_TEXT_FIELD_IMP} (a_has_focus)
				end
			else
				return_combo_toggle (container_widget, $a_toggle)
				if a_toggle /= default_pointer and then {EV_GTK_EXTERNALS}.gtk_toggle_button_get_active (a_toggle) then
						-- We have a "popup" action.
					is_list_shown := True
				else
					Precursor {EV_TEXT_FIELD_IMP} (a_has_focus)
				end
			end
		end

	is_list_shown: BOOLEAN
		-- Is combo list current shown?

	retrieve_toggle_button_signal_connection_id: INTEGER
		-- Signal connection id used when finding the toggle button of `Current'.

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Event handling

	retrieve_toggle_button is
			-- Retrieve the toggle button from the GtkComboBox structure.
		local
			a_toggle: POINTER
		do
			return_combo_toggle (container_widget, $a_toggle)
			check
				toggle_button_set: a_toggle /= default_pointer
			end
				-- Set the size of the toggle so that it isn't bigger than the entry size
			{EV_GTK_EXTERNALS}.gtk_widget_set_usize (a_toggle, -1, 1)
			{EV_GTK_EXTERNALS}.gtk_widget_unset_flags (a_toggle, {EV_GTK_EXTERNALS}.gtk_can_focus_enum)

			real_signal_connect (a_toggle, once "toggled", agent (app_implementation.gtk_marshal).on_combo_box_toggle_button_event (internal_id, 2), Void)
			{EV_GTK_DEPENDENT_EXTERNALS}.g_signal_handler_disconnect (container_widget, retrieve_toggle_button_signal_connection_id)
			retrieve_toggle_button_signal_connection_id := 0
		end

	toggle_button_toggled is
			-- The toggle button has been toggled.
		local
			a_toggle: POINTER
		do
			return_combo_toggle (container_widget, $a_toggle)
			if a_toggle /= default_pointer and then {EV_GTK_EXTERNALS}.gtk_toggle_button_get_active (a_toggle) then
				if drop_down_actions_internal /= Void then
					drop_down_actions_internal.call (Void)
				end
			end
		end

feature {NONE} -- Externals

	frozen return_combo_toggle (a_combo: POINTER; a_toggle_button: TYPED_POINTER [POINTER]) is
		external
			"C inline use %"ev_c_util.h%""
		alias
			"[
				{
				gtk_container_forall (GTK_CONTAINER ($a_combo), (GtkCallback) c_gtk_return_combo_toggle, (GtkWidget**) $a_toggle_button);
				}
			]"
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

