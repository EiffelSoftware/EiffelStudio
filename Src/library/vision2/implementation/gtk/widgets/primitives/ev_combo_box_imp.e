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
			visual_widget,
			set_text,
			has_focus,
			destroy,
			on_key_event,
			set_focus
		end

	EV_LIST_ITEM_LIST_IMP
		undefine
			set_default_colors,
			visual_widget
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
			visual_widget,
			has_focus,
			destroy,
			on_item_clicked,
			on_key_event,
			set_focus
		end

	EV_KEY_CONSTANTS

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a combo-box.
		do
			base_make (an_interface)

			-- create of the gtk object.
			set_c_object (C.gtk_event_box_new)
			container_widget := C.gtk_combo_new
			C.gtk_widget_show (container_widget)
			C.gtk_container_add (c_object, container_widget)

			-- Pointer to the text we see.
			entry_widget := C.gtk_combo_struct_entry (container_widget)

			-- Pointer to the list of items.
			list_widget := C.gtk_combo_struct_list (container_widget)
			C.gtk_combo_set_use_arrows (container_widget, 0)
			C.gtk_combo_set_case_sensitive (container_widget, 1)

			real_signal_connect (
					entry_widget,
					"key_press_event",
					agent on_key_event,
					key_event_translate_agent
				)
			real_signal_connect (
					entry_widget,
					"key_release_event",
					agent on_key_event,
					key_event_translate_agent)
			
			create timer.make_with_interval (0)
			timer.actions.extend (agent launch_select_actions)
			activate_id := C.gtk_combo_struct_activate_id (container_widget)
			C.gtk_signal_handler_block (entry_widget, activate_id)
		end

	initialize is
			-- Connect action sequences to signals.
		do
			initialize_pixmaps
			{EV_LIST_ITEM_LIST_IMP} Precursor

			--| We don't call EV_TEXT_FIELD_IMP Precursor as this only
			--| adds two extra ones to what ev_list_imp Precursor calls
			--| already.
			C.gtk_list_set_selection_mode (
				list_widget,
				C.GTK_SELECTION_SINGLE_ENUM
			)
			real_signal_connect (entry_widget, "focus-in-event", agent attain_focus, Default_translate)
			real_signal_connect (entry_widget, "focus-out-event", agent lose_focus, Default_translate)
			real_signal_connect (
					list_widget,
					"button-release-event",
					agent on_button_released,
					Default_translate
			)
			on_item_clicked_agent := agent on_item_clicked
			on_key_pressed_agent := agent on_key_pressed
		end
		
	on_item_clicked_agent, on_key_pressed_agent: PROCEDURE [EV_COMBO_BOX_IMP, TUPLE]
		
feature -- Status report

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			--| Shift to put bit in least significant place then take mod 2.
			Result := ((
				(C.gtk_object_struct_flags (entry_widget)
				// C.GTK_HAS_FOCUS_ENUM) \\ 2) 
			) = 1
		end

	rows: INTEGER is
		 	-- Number of lines.
		do
			Result := C.g_list_length (
				C.gtk_list_struct_children (list_widget)
			)
		end

	selected: BOOLEAN is
			-- Is at least one item selected?
		do
			Result := C.g_list_length (
				C.gtk_list_struct_selection (list_widget)
			).to_boolean
		end

feature -- Status setting

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			avoid_callback := True
			Precursor {EV_TEXT_FIELD_IMP} (a_text)
		end

	set_maximum_text_length (len: INTEGER) is
			-- Set the length of the longest 
		do
			C.gtk_entry_set_max_length (entry_widget, len)
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Set foreground color to `a_color'.
		do
			real_set_foreground_color (list_widget, a_color)
		end
		
	set_focus is
			-- 
		do
			C.gtk_widget_grab_focus (entry_widget)
		end

feature {NONE} -- Implementation

	attain_focus is
			-- The list has just grabbed the focus.
		do
			top_level_window_imp.set_focus_widget (Current)
			if focus_in_actions_internal /= Void then
				focus_in_actions_internal.call (empty_tuple)				
			end
		end

	lose_focus is
			-- The list has just lost the focus.
		do
				-- This routine is called when an item loses the focus too.
				-- The follwing test prevent call to `focus_out_actions' when
				-- the user has only changed the selected item.
			top_level_window_imp.set_focus_widget (Void)
			if focus_out_actions_internal /= Void then
				focus_out_actions_internal.call (empty_tuple)
			end
		end

	add_to_container (v: like item) is
			-- Add `v' to container.
		local
			imp: EV_LIST_ITEM_IMP
			a_gs: GEL_STRING
		do
			imp ?= v.implementation
			create a_gs.make (imp.text)
			C.gtk_combo_set_item_string (container_widget, imp.c_object, a_gs.item)
			C.gtk_container_add (list_widget, imp.c_object)
			imp.set_item_parent_imp (Current)
			real_signal_connect (imp.c_object, "button-press-event", on_item_clicked_agent, Default_translate)
			real_signal_connect (imp.c_object, "key-press-event", on_key_pressed_agent, key_event_translate_agent)
			if count = 1 and is_sensitive then
				imp.enable_select
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
			C.gtk_box_reorder_child (container_widget, a_child, an_index - 1)
		end

	foreground_color_pointer: POINTER is
			-- Pointer on the C object representing the foreground color of Current
		do
			Result := C.gtk_style_struct_fg (C.gtk_widget_struct_style (list_widget))
		end
		
	timer: EV_TIMEOUT
	
	triggering_item: EV_LIST_ITEM_IMP
	
	container_widget: POINTER
			-- Gtk combo struct
	
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
				 	triggering_item ?= eif_object_from_c (gtk_marshal.gtk_value_pointer (an_item))
					timer.set_interval (1)
				 	if not button_pressed then
						popwin := C.gtk_combo_struct_popwin (container_widget)
						C.gtk_widget_hide (popwin)
						if (((C.gtk_object_struct_flags (visual_widget) // C.GTK_HAS_GRAB_ENUM) \\ 2)) = 1 then
							C.gtk_grab_remove (popwin)
							C.gdk_pointer_ungrab (0)
						end
					end
					avoid_callback := True
				else
					avoid_callback := False
				end
			end
		end

	visual_widget: POINTER is
		do
			Result := c_object
		end

	on_button_released is
		do
			button_pressed := False
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
					C.gtk_signal_handler_unblock (entry_widget, activate_id)
				--	success := C.gtk_widget_activate (entry_widget)
					C.gtk_signal_handler_block (entry_widget, activate_id)
			end
			Precursor (a_key, a_key_string, a_key_press)
		end
	
	launch_select_actions is
			-- 
		do
			timer.set_interval (0)
			if triggering_item /= Void then
				call_select_actions (triggering_item)
				triggering_item := Void
			end
		end
	
	destroy is
			-- Destroy Current
		do
			timer.destroy
			timer := Void
			triggering_item := Void
			Precursor
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

