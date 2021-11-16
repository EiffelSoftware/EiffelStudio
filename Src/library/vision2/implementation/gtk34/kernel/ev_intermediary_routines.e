note
	description: "Intermediary routines between gtk and eiffel."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	EV_INTERMEDIARY_ROUTINES

inherit
	EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES

	EV_ANY_HANDLER

feature -- Timeout intermediary agent routine

	on_timeout_intermediary (a_object_id: INTEGER)
			-- Timeout has occurred.
		do
			if attached {EV_TIMEOUT_IMP} eif_id_object (a_object_id) as l_timeout_imp then
				l_timeout_imp.on_timeout
			end
		end

feature {EV_ANY_IMP} -- Notebook agent routines

	on_notebook_page_switch_event (a_c_object: POINTER; arguments: POINTER)
			-- Notebook page is switched
		local
			gtkarg2: POINTER
		do
			if attached {EV_NOTEBOOK_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_notebook_imp then
				gtkarg2 := {GTK2}.gtk_args_array_i_th (arguments, 1)
				l_notebook_imp.page_switch ({GTK2}.gtk_value_uint (gtkarg2).to_integer_32)
			end
		end

feature -- map,unmap event

	on_widget_mapped_signal_intermediary (a_c_object: POINTER)
			-- Set mapped handling intermediary.
		do
			if attached {EV_WIDGET_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_widget_imp then
				l_widget_imp.on_widget_mapped
			end
		end

	on_widget_unmapped_signal_intermediary (a_c_object: POINTER)
			-- Set unmapped handling intermediary.
		do
			if attached {EV_WIDGET_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_widget_imp then
				l_widget_imp.on_widget_unmapped
			end
		end

feature -- Draw and configure signal

	draw_actions_event (a_c_object: POINTER; arguments: POINTER): BOOLEAN
			-- "draw" signal has been emitted.
			-- Result:
			-- 		False: execute remaining processing (including default)
			--		True: stop all processing
		do
			if attached {EV_ANY_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_any_imp then
				Result := l_any_imp.process_draw_event ({GTK2}.gtk_value_pointer (arguments))
			end
		end

	configure_event (a_c_object: POINTER; arguments: POINTER): BOOLEAN
			-- "configure-event" signal has been emitted.
			-- Result:
			-- 		False: execute remaining processing (including default)
			--		True: stop all processing
		local
			l_gdk_configure: POINTER
		do
			if attached {EV_ANY_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_any_imp then
				l_gdk_configure := {GTK2}.gtk_value_pointer (arguments)
				Result := l_any_imp.process_configure_event ({GTK}.gdk_event_configure_struct_x (l_gdk_configure), {GTK}.gdk_event_configure_struct_y (l_gdk_configure), {GTK}.gdk_event_configure_struct_width (l_gdk_configure), {GTK}.gdk_event_configure_struct_height (l_gdk_configure))
			end
		end

feature {EV_ANY_IMP} -- Scrolling event

	scroll_event (a_c_object: POINTER; arguments: POINTER): BOOLEAN
			-- "leave-notify-event" signal has been emitted.
		do
			if attached {EV_ANY_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_any_imp then
				Result := l_any_imp.process_scroll_event ({GTK2}.gtk_value_pointer (arguments))
			end
		end

feature {EV_ANY_IMP} -- Gauge intermediary agent routines

	on_gauge_value_changed_intermediary (a_c_object: POINTER)
			-- Gauge value changed
		do
			if attached {EV_GAUGE_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_gauge_imp then
				l_gauge_imp.value_changed_handler
			else
				check is_gauge_imp: False end
			end
		end

feature -- Widget agent routines

	on_size_allocate_event (a_object_id: INTEGER; arguments:POINTER)
			-- Size allocate happened on widget.
			-- Result:
			-- 		False: execute remaining processing (including default)
			--		True: stop all processing
		local
			gtk_alloc: POINTER
		do
			if
				attached {EV_WIDGET_IMP} eif_id_object (a_object_id) as a_widget and then
				not a_widget.is_destroyed
			then
				gtk_alloc := {GTK2}.gtk_value_pointer (arguments)
				a_widget.on_size_allocate ({GTK}.gtk_allocation_struct_x (gtk_alloc), {GTK}.gtk_allocation_struct_y (gtk_alloc), {GTK}.gtk_allocation_struct_width (gtk_alloc), {GTK}.gtk_allocation_struct_height (gtk_alloc))
			end
		end

feature -- Widget set_focus routines

	on_set_focus_event (a_object_id: INTEGER; arguments: POINTER)
			-- Set Focus handling intermediary.
		do
			if
				attached {EV_WINDOW_IMP} eif_id_object (a_object_id) as a_window and then
				not a_window.is_destroyed
			then
				a_window.on_set_focus_event ({GTK2}.gtk_value_pointer (arguments))
			end
		end

feature {EV_ANY_IMP} -- Text component agent routines

	text_component_change_intermediary (a_c_object: POINTER)
			-- Changed
		do
			check attached {EV_TEXT_COMPONENT_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_text_component_imp then
				l_text_component_imp.on_change_actions
			end
		end

	text_field_return_intermediary (a_c_object: POINTER)
			-- Return
		do
			check attached {EV_TEXT_FIELD_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_text_field_imp then
				if attached l_text_field_imp.return_actions_internal as l_text_field_return_actions then
					l_text_field_return_actions.call (Void)
				end
			end
		end

feature -- Button agent routines	

	button_select_intermediary (a_c_object: POINTER)
			-- Selected
		local
			l_any_imp: detachable EV_ANY_IMP
		do
			l_any_imp := c_get_eif_reference_from_object_id (a_c_object)
			if
				attached {EV_RADIO_BUTTON_IMP} l_any_imp as l_rad_imp and then
				not l_rad_imp.is_selected
			then
				-- Do nothing as we shouldn't call the select actions of a radio button if it isn't selected
			elseif
				attached {EV_BUTTON_IMP} l_any_imp as l_button_imp and then
				attached l_button_imp.select_actions_internal as l_button_imp_select_actions and then
				l_button_imp.parent_imp /= Void
			then
				l_button_imp_select_actions.call (Void)
			end
		end

feature {EV_ANY_IMP} -- Menu agent routines

	menu_item_activate_intermediary (a_c_object: POINTER)
			-- Item activated
		do
			if
				attached {EV_MENU_ITEM_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_menu_item_imp and then
				l_menu_item_imp.allow_on_activate
			then
					-- Add event to idle actions so that menu may closed
					-- This also prevents crashes with dbus handled menus if events are processed during activate.
				l_menu_item_imp.app_implementation.do_once_on_idle (agent l_menu_item_imp.on_activate)
			end
		end

feature {EV_ANY_IMP} -- Dialog agent routines

	gtk_dialog_response_event (a_c_object: POINTER; arguments: POINTER): POINTER
			-- Dialog "response" signal intermediary.
		do
			check attached {EV_STANDARD_DIALOG_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_sd then
				l_sd.on_response ({GTK2}.gtk_value_int (arguments))
			end
		end

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


end -- class EV_INTERMEDIARY_ROUTINES
