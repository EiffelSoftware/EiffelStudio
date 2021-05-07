note

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
			call_pebble_function,
			reset_pebble_function,
			return_actions
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		undefine
			needs_event_box,
			pre_pick_steps,
			post_drop_steps,
			call_pebble_function,
			reset_pebble_function,
			enable_transport,
			hide_border,
			pebble_source,
			ready_for_pnd_menu,
			able_to_transport
		redefine
			make,
			old_make,
			interface,
			has_focus,
			on_focus_changed
		end

	EV_LIST_ITEM_LIST_IMP
		undefine
			set_default_colors,
			visual_widget,
			destroy,
			on_key_event,
			on_focus_changed,
			has_focus,
			set_focus,
			background_color_style_context,
			foreground_color_style_context
		redefine
			make,
			needs_event_box,
			interface,
			insert_i_th,
			call_selection_action_sequences
		end

	EV_KEY_CONSTANTS

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := True
		end

	old_make (an_interface: attached like interface)
			-- Create a combo-box.
		do
			assign_interface (an_interface)
		end

feature {NONE} -- Initialization

	call_selection_action_sequences
			-- Call the appropriate selection action sequences
		local
			l_selected_item: detachable EV_LIST_ITEM
			l_previous_selected_item_imp, l_selected_item_imp: detachable EV_LIST_ITEM_IMP
		do
			l_selected_item := selected_item
			l_previous_selected_item_imp := previous_selected_item_imp
			if is_list_shown then
					-- Make sure that the list is hidden from the screen before calling selection actions.
				{GTK2}.gtk_combo_box_popdown (container_widget)
			end
			if l_selected_item /= Void then
				l_selected_item_imp ?= l_selected_item.implementation
				check l_selected_item_imp /= Void then end
				if l_selected_item_imp.select_actions_internal /= Void then
					l_selected_item_imp.select_actions.call (Void)
				end
				if select_actions_internal /= Void then
					select_actions_internal.call (Void)
				end
			end
			if l_previous_selected_item_imp /= Void then
				if l_previous_selected_item_imp.deselect_actions_internal /= Void then
					l_previous_selected_item_imp.deselect_actions.call (Void)
				end
				if deselect_actions_internal /= Void then
					deselect_actions_internal.call (Void)
				end
			end
			previous_selected_item_imp := l_selected_item_imp
			if l_selected_item_imp /= Void then
				on_change_actions
			end
		end

	previous_selected_item_imp: detachable EV_LIST_ITEM_IMP
		-- Item that was selected previously.

	make
			-- Connect action sequences to signals.
		local
			a_cell_renderer: POINTER
			a_attribute: EV_GTK_C_STRING
			a_cs: EV_GTK_C_STRING
			a_vbox: POINTER
		do
			a_vbox := {GTK3}.gtk_box_new ({GTK_ORIENTATION}.gtk_orientation_vertical, 0)
			set_c_object (a_vbox)
			container_widget := {GTK2}.gtk_combo_box_new_with_entry
			{GTK}.gtk_widget_show (container_widget)
			{GTK}.gtk_box_pack_start (a_vbox, container_widget, False, False, 0)
			entry_widget := {GTK}.gtk_bin_get_child (container_widget)

				-- Alter focus chain so that button cannot be selected via the keyboard.
			--a_focus_list := {GTK}.g_list_append (default_pointer, entry_widget)
			--	-- TODO check how to replace this code.
			-- Check https://github.com/FreeRDP/Remmina/commit/0bdded543d8d425470858046f3bf7f43681d932e
			-- the code is not used anymore.
			--	-- https://gitlab.gnome.org/GNOME/gtk/-/issues/1430
			--{GTK2}.gtk_container_set_focus_chain (container_widget, a_focus_list)
			--{GTK}.g_list_free (a_focus_list)

				-- This is a hack, remove when the toggle button can be retrieved via the API.
			real_signal_connect (container_widget,
						{EV_GTK_EVENT_STRINGS}.realize_event_name,
			 			agent (app_implementation.gtk_marshal).on_combo_box_toggle_button_event (internal_id, 1),
			 			Void
			 		)
			retrieve_toggle_button_signal_connection_id := last_signal_connection_id

			Precursor {EV_LIST_ITEM_LIST_IMP}
			align_text_left
			{GTK2}.gtk_combo_box_set_model (container_widget, list_store)

				-- Set widget name so that the style can be used as set in EV_GTK_DEPENDENT_APPLICATION_IMP
			a_cs := once "v2combobox"
			{GTK}.gtk_widget_set_name (container_widget, a_cs.item)

				-- The combo box is already initialized with a text cell renderer at position 0, that is why we reorder the pixbuf cell renderer to position 0 and set the text column to 1
			{GTK2}.gtk_combo_box_set_entry_text_column (container_widget, 1)

			{GTK2}.gtk_cell_layout_clear (container_widget)

			a_cell_renderer := {GTK2}.gtk_cell_renderer_text_new
			{GTK2}.gtk_cell_layout_pack_start (container_widget, a_cell_renderer, True)
			{GTK2}.gtk_cell_layout_reorder (container_widget, a_cell_renderer, 0)
			a_attribute := once "text"
			{GTK2}.gtk_cell_layout_set_attribute (container_widget, a_cell_renderer, a_attribute.item, 1)

			a_cell_renderer := {GTK2}.gtk_cell_renderer_pixbuf_new
			{GTK2}.gtk_cell_layout_pack_start (container_widget, a_cell_renderer, False)
			{GTK2}.gtk_cell_layout_reorder (container_widget, a_cell_renderer, 0)
			a_attribute := once "pixbuf"
			{GTK2}.gtk_cell_layout_set_attribute (container_widget, a_cell_renderer, a_attribute.item, 0)

			set_minimum_width_in_characters (4)

			real_signal_connect (container_widget,
					{EV_GTK_EVENT_STRINGS}.changed_event_name,
					agent (app_implementation.gtk_marshal).on_pnd_deferred_item_parent_selection_change (internal_id),
					Void
				)
			initialize_tab_behavior
			initialize_hints
		end

	insert_i_th (v: attached like item; i: INTEGER)
			-- Insert `v' at position `i'.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP} (v, i)
			if count = 1 and then v.is_selectable then
				v.enable_select
			end
		end

feature -- Status report

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?

	selected_item: detachable EV_LIST_ITEM
			-- Item which is currently selected, for a multiple
			-- selection.
		local
			a_active: INTEGER
		do
			a_active := {GTK2}.gtk_combo_box_get_active (container_widget)
			if a_active >= 0 then
				Result := child_array @ (a_active + 1)
			end
		end

	selected_items: ARRAYED_LIST [EV_LIST_ITEM]
			-- List of all the selected items. Used for list_item.is_selected implementation.
		local
			l_selected_item: like selected_item
		do
			create Result.make (0)
			l_selected_item := selected_item
			if l_selected_item /= Void then
				Result.extend (l_selected_item)
			end
		end

	select_item (an_index: INTEGER)
			-- Select an item at the one-based `index' of the list.
		do
			{GTK2}.gtk_combo_box_set_active (container_widget, an_index - 1)
		end

	deselect_item (an_index: INTEGER)
			-- Unselect the item at the one-based `index'.
		do
			{GTK2}.gtk_combo_box_set_active (container_widget, -1)
		end

	clear_selection
			-- Clear the item selection of `Current'.
		do
			{GTK2}.gtk_combo_box_set_active (container_widget, -1)
		end

feature -- Status setting

	set_maximum_text_length (len: INTEGER)
			-- Set the length of the longest text size in characters that `Current' can display.
		do
			{GTK2}.gtk_entry_set_max_length (entry_widget, len)
		end

feature {NONE} -- Implementation

	on_focus_changed (a_has_focus: BOOLEAN)
			-- Focus for `Current' has changed'.
		local
			a_toggle: POINTER
			l_popup: detachable EV_POPUP_WINDOW_IMP
		do
			if a_has_focus then
				if is_list_shown then
						-- `Current' is being popped down.
					is_list_shown := False
						-- Call list_hidden_actions.
					if list_hidden_actions_internal /= Void then
						list_hidden_actions_internal.call (Void)
					end
						-- We need to give capture back to the popup window.
					l_popup ?= top_level_window_imp
					if l_popup /= Void and then l_popup.is_show_requested then
						l_popup.grab_keyboard_and_mouse
					end
				else
					has_focus := True
					Precursor {EV_TEXT_FIELD_IMP} (a_has_focus)
				end
			else
				return_combo_toggle (container_widget, $a_toggle)
				if a_toggle /= default_pointer and then {GTK}.gtk_toggle_button_get_active (a_toggle) then
						-- We have a "popup" action.
					is_list_shown := True
				else
					has_focus := False
					Precursor {EV_TEXT_FIELD_IMP} (a_has_focus)
				end
			end
		end

	is_list_shown: BOOLEAN
		-- Is combo list current shown?

	retrieve_toggle_button_signal_connection_id: INTEGER
		-- Signal connection id used when finding the toggle button of `Current'.

feature {EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES} -- Event handling

	retrieve_toggle_button
			-- Retrieve the toggle button from the GtkComboBox structure.
		local
			a_toggle: POINTER
		do
			return_combo_toggle (container_widget, $a_toggle)
			if a_toggle /= default_pointer then
				check
					toggle_button_set: a_toggle /= default_pointer
				end
					-- Set the size of the toggle so that it isn't bigger than the entry size
				{GTK}.gtk_widget_set_size_request (a_toggle, -1, 1)
				{GTK}.gtk_widget_set_can_focus (a_toggle, False)

				real_signal_connect (a_toggle,
						{EV_GTK_EVENT_STRINGS}.toggled_event_name,
						agent (app_implementation.gtk_marshal).on_combo_box_toggle_button_event (internal_id, 2),
						Void
					)
				{GTK2}.signal_disconnect (container_widget, retrieve_toggle_button_signal_connection_id)
				retrieve_toggle_button_signal_connection_id := 0
			end
		end

	toggle_button_toggled
			-- The toggle button has been toggled.
		local
			a_toggle: POINTER
		do
			return_combo_toggle (container_widget, $a_toggle)
			if a_toggle /= default_pointer then
				if {GTK}.gtk_toggle_button_get_active (a_toggle) then
					if not has_focus then
						is_list_shown := True
					end
					if drop_down_actions_internal /= Void then
						drop_down_actions_internal.call (Void)
					end
				else
						-- Make sure that the combo box is fully popped down.
					{GTK2}.gtk_combo_box_popdown (container_widget)
					if not has_focus then
						is_list_shown := False
						if list_hidden_actions_internal /= Void then
							list_hidden_actions_internal.call (Void)
						end
					end
				end
			end
		end

feature {NONE} -- Externals

	frozen return_combo_toggle (a_combo: POINTER; a_toggle_button: TYPED_POINTER [POINTER])
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

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Add pixmap scaling code with gtk+ 2
			--| For now, do nothing.
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_COMBO_BOX note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_COMBO_BOX_IMP
