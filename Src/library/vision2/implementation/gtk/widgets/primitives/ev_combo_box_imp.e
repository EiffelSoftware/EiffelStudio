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
			pointer_over_widget,
			create_focus_in_actions,
			create_focus_out_actions
		redefine
			initialize,
			make,
			interface,
			set_foreground_color,
			foreground_color_pointer,
			set_text,
			has_focus,
			destroy,
			on_key_event,
			set_focus,
			default_key_processing_blocked,
			on_focus_changed
		end

	EV_LIST_ITEM_LIST_IMP
		undefine
			set_default_colors,
			visual_widget,
			set_composite_widget_pointer_style
		redefine
			select_callback,
			remove_i_th,
			gtk_reorder_child,
			initialize,
			make,
			selected,
			add_to_container,
			interface,
			set_foreground_color,
			foreground_color_pointer,
			has_focus,
			destroy,
			on_item_clicked,
			on_key_event,
			set_focus,
			default_key_processing_blocked,
			on_focus_changed
		end

	EV_KEY_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a combo-box.
		local
			
		do
			base_make (an_interface)

			-- create of the gtk object.
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_vbox_new (False, 0))
			container_widget := feature {EV_GTK_EXTERNALS}.gtk_combo_new
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (container_widget)
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (c_object, container_widget, False, False, 0)

			-- Pointer to the text we see.
			entry_widget := feature {EV_GTK_EXTERNALS}.gtk_combo_struct_entry (container_widget)

			-- Pointer to the list of items.
			list_widget := feature {EV_GTK_EXTERNALS}.gtk_combo_struct_list (container_widget)
			feature {EV_GTK_EXTERNALS}.gtk_combo_set_use_arrows (container_widget, 0)
			feature {EV_GTK_EXTERNALS}.gtk_combo_set_case_sensitive (container_widget, 1)
	
			create timer.make_with_interval (0)
			timer.actions.extend (agent launch_select_actions)
			timer_imp ?= timer.implementation
			activate_id := feature {EV_GTK_EXTERNALS}.gtk_combo_struct_activate_id (container_widget)
			feature {EV_GTK_EXTERNALS}.signal_handler_block (entry_widget, activate_id)
			
			on_key_pressed_intermediary_agent := agent (App_implementation.gtk_marshal).on_list_item_list_key_pressed_intermediary (c_object, ?, ?, ?)
			on_item_clicked_intermediary_agent := agent (App_implementation.gtk_marshal).on_list_item_list_item_clicked_intermediary (c_object)
		end
		
	initialize is
			-- Connect action sequences to signals.
		do
			initialize_pixmaps
			Precursor {EV_LIST_ITEM_LIST_IMP}

			--| We don't call EV_TEXT_FIELD_IMP Precursor as this only
			--| adds two extra ones to what ev_list_imp Precursor calls
			--| already.
			feature {EV_GTK_EXTERNALS}.gtk_list_set_selection_mode (
				list_widget,
				feature {EV_GTK_EXTERNALS}.gTK_SELECTION_BROWSE_ENUM
			)
			real_signal_connect (entry_widget, "focus-in-event", agent (App_implementation.gtk_marshal).widget_focus_in_intermediary (c_object), Void)
			real_signal_connect (entry_widget, "focus-out-event", agent (App_implementation.gtk_marshal).widget_focus_out_intermediary (c_object), Void)
			real_signal_connect (
					list_widget,
					"button-release-event",
					agent (App_implementation.gtk_marshal).on_combo_box_button_release (c_object),
					Void
			)
		
		end
		
feature -- Status report

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := ((
				(feature {EV_GTK_EXTERNALS}.gtk_object_struct_flags (entry_widget)
				// feature {EV_GTK_EXTERNALS}.gTK_HAS_FOCUS_ENUM) \\ 2) 
			) = 1
		end

	rows: INTEGER is
		 	-- Number of lines.
		do
			Result := feature {EV_GTK_EXTERNALS}.g_list_length (
				feature {EV_GTK_EXTERNALS}.gtk_list_struct_children (list_widget)
			)
		end

	selected: BOOLEAN is
			-- Is at least one item selected?
		do
			Result := feature {EV_GTK_EXTERNALS}.g_list_length (
				feature {EV_GTK_EXTERNALS}.gtk_list_struct_selection (list_widget)
			).to_boolean
		end

feature -- Status setting

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			avoid_callback := True
			Precursor {EV_TEXT_FIELD_IMP} (a_text)
			avoid_callback := False
		end

	set_maximum_text_length (len: INTEGER) is
			-- Set the length of the longest 
		do
			feature {EV_GTK_EXTERNALS}.gtk_entry_set_max_length (entry_widget, len)
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Set foreground color to `a_color'.
		do
			real_set_foreground_color (list_widget, a_color)
		end
		
	set_focus is
			-- 
		do
			feature {EV_GTK_EXTERNALS}.gtk_widget_grab_focus (entry_widget)
		end

feature {EV_LIST_ITEM_IMP} -- Implementation
		
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
			
	on_key_pressed_intermediary_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE [EV_KEY, STRING, BOOLEAN]]
			-- Intermediary key agent that is reused for list items in `add_to_container'.
			
	on_item_clicked_intermediary_agent: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE]
			-- Intermediary key agent that is reused for list items in `add_to_container'.

	default_key_processing_blocked (a_key: EV_KEY): BOOLEAN is
			-- 
		do
			-- We don't want to lose focus on up or down keys.
			if a_key.code = feature {EV_KEY_CONSTANTS}.key_down or else a_key.code = feature {EV_KEY_CONSTANTS}.key_up then
				Result := True
			end
		end

	on_focus_changed (a_has_focus: BOOLEAN) is
			-- Focus for `Current' has changed'.
		do
			if a_has_focus then
				top_level_window_imp.set_focus_widget (Current)
				if focus_in_actions_internal /= Void then
					focus_in_actions_internal.call ((App_implementation.gtk_marshal).empty_tuple)				
				end
			else
				top_level_window_imp.set_focus_widget (Void)
				if focus_out_actions_internal /= Void then
					focus_out_actions_internal.call ((App_implementation.gtk_marshal).empty_tuple)
				end			
			end
		end

	add_to_container (v: like item; v_imp: EV_LIST_ITEM_IMP) is
			-- Add `v' to container.
		local
			a_cs: C_STRING
		do
			create a_cs.make (v_imp.text)
			feature {EV_GTK_EXTERNALS}.gtk_combo_set_item_string (container_widget, v_imp.c_object, a_cs.item)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (list_widget, v_imp.c_object)
			v_imp.set_item_parent_imp (Current)
			real_signal_connect (v_imp.c_object, "button-press-event", on_item_clicked_intermediary_agent, Void)
			real_signal_connect (v_imp.c_object, "key-press-event", on_key_pressed_intermediary_agent, key_event_translate_agent)
			if count = 1 and is_sensitive then
				feature {EV_GTK_EXTERNALS}.gtk_list_item_select (v_imp.c_object)
			end
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
			feature {EV_GTK_EXTERNALS}.gtk_box_reorder_child (container_widget, a_child, an_index - 1)
		end

	foreground_color_pointer: POINTER is
			-- Pointer on the C object representing the foreground color of Current
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_style_struct_fg (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (list_widget))
		end
		
	timer: EV_TIMEOUT; timer_imp: EV_TIMEOUT_IMP
		-- Timer and its associated implementation needed for selection hack.
	
	triggering_item: EV_LIST_ITEM_IMP
		-- Item that has been selected.
	
	activate_id: INTEGER
			-- Activate event handler id

	avoid_callback: BOOLEAN
			-- Flag used to avoid repeated emission of select signal from combo box.

	select_callback (n: INTEGER; an_item: POINTER) is
			-- Redefined to counter repeated select signal of combo box. 
		local
			popwin: POINTER
		do	
			--| FIXME IEK Remove hacks when gtk+ 2.0 is out
			if is_displayed then
				if not avoid_callback then			
				 	triggering_item ?= eif_object_from_c ((App_implementation.gtk_marshal).gtk_value_pointer (an_item))
				 	if not button_pressed then
						popwin := feature {EV_GTK_EXTERNALS}.gtk_combo_struct_popwin (container_widget)
						feature {EV_GTK_EXTERNALS}.gtk_widget_hide (popwin)
						if (((feature {EV_GTK_EXTERNALS}.gtk_object_struct_flags (visual_widget) // feature {EV_GTK_EXTERNALS}.gTK_HAS_GRAB_ENUM) \\ 2)) = 1 then
							feature {EV_GTK_EXTERNALS}.gtk_grab_remove (popwin)
							feature {EV_GTK_EXTERNALS}.gdk_pointer_ungrab (0)
						end
					end
					avoid_callback := True
					timer_imp.set_interval_kamikaze (1)
				else
					avoid_callback := False
				end
			end
		end
		
	button_pressed: BOOLEAN

	on_item_clicked is
			-- The user has clicked on an item.
		do
			Precursor {EV_LIST_ITEM_LIST_IMP}
			button_pressed := True
		end
		
	on_key_event (a_key: EV_KEY; a_key_string: STRING; a_key_press: BOOLEAN) is
		local
		--	success: BOOLEAN
		do
			if 
				a_key /= Void and then Key_down = a_key.code
			then
					feature {EV_GTK_EXTERNALS}.signal_handler_unblock (entry_widget, activate_id)
				--	success := feature {EV_GTK_EXTERNALS}.gtk_widget_activate (entry_widget)
					feature {EV_GTK_EXTERNALS}.signal_handler_block (entry_widget, activate_id)
			end
			Precursor {EV_TEXT_FIELD_IMP} (a_key, a_key_string, a_key_press)
		end
	
	launch_select_actions is
			-- 
		local
			a_triggering_item: EV_LIST_ITEM_IMP
		do
			timer.actions.wipe_out
			a_triggering_item := triggering_item
			if a_triggering_item /= Void then
				call_select_actions (a_triggering_item)
			end
			triggering_item := Void
			timer.actions.extend (agent launch_select_actions)
		end

	destroy is
			-- Destroy Current
		do
			timer.destroy
			timer := Void
			triggering_item := Void
			Precursor {EV_TEXT_FIELD_IMP}
		end
		
feature {EV_INTERMEDIARY_ROUTINES} -- Implementation
		
	on_button_released is
		do
			button_pressed := False
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

