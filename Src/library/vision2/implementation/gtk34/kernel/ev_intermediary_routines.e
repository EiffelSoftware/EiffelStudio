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
		local
			a_timeout_imp: detachable EV_TIMEOUT_IMP
		do
			a_timeout_imp ?= eif_id_object (a_object_id)
			if a_timeout_imp /= Void then
				a_timeout_imp.on_timeout
			end
		end

feature {EV_ANY_IMP} -- Button intermediary agent routines

	on_button_event (a_application_imp: EV_APPLICATION_IMP; a_gdk_event: POINTER)
		do
			a_application_imp.process_button_event (a_gdk_event, True)
		end

feature {EV_ANY_IMP} -- Notebook intermediary agent routines

	on_notebook_page_switch_intermediary (a_c_object: POINTER; a_page: NATURAL_32)
			-- Notebook page is switched
		local
			a_notebook_imp: detachable EV_NOTEBOOK_IMP
		do
			a_notebook_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check a_notebook_imp /= Void then end
			a_notebook_imp.page_switch (a_page.to_integer_32)
		end

feature -- Draw signal intermediary.

	draw_actions_intermediary (a_c_object: POINTER; a_cairo_context: POINTER)
			-- "draw" signal has been emitted.
		do
			if attached {EV_ANY_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_any_imp then
				l_any_imp.process_draw_event (a_cairo_context)
			end
		end

	configure_event_intermediary (a_c_object: POINTER; a_x, a_y, a_width, a_height: INTEGER)
			-- "configure-event" signal has been emitted.
		do
			if attached {EV_ANY_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_any_imp then
				l_any_imp.process_configure_event (a_x, a_y, a_width, a_height)
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

feature -- Widget intermediary agent routines

	on_size_allocate_intermediate (a_object_id, a_x, a_y, a_width, a_height: INTEGER)
			-- Size allocate happened on widget.
		local
			a_widget: detachable EV_WIDGET_IMP
		do
			a_widget ?= eif_id_object (a_object_id)
			if a_widget /= Void and then not a_widget.is_destroyed then
				a_widget.on_size_allocate (a_x, a_y, a_width, a_height)
			end
		end

	on_set_focus_event_intermediary (a_object_id: INTEGER; a_widget_ptr: POINTER)
			-- Set Focus handling intermediary.
		local
			a_window: detachable EV_WINDOW_IMP
		do
			a_window ?= eif_id_object (a_object_id)
			if a_window /= Void and then not a_window.is_destroyed then
				a_window.on_set_focus_event (a_widget_ptr)
			end
		end

feature {EV_ANY_IMP} -- Text component intermediary agent routines

	text_component_change_intermediary (a_c_object: POINTER)
			-- Changed
		local
			a_text_component_imp: detachable EV_TEXT_COMPONENT_IMP
		do
			a_text_component_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check a_text_component_imp /= Void then end
			a_text_component_imp.on_change_actions
		end

	text_field_return_intermediary (a_c_object: POINTER)
			-- Return
		local
			l_text_field_imp: detachable EV_TEXT_FIELD_IMP
		do
			l_text_field_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check l_text_field_imp /= Void then end

			if attached l_text_field_imp.return_actions_internal as l_text_field_return_actions then
				l_text_field_return_actions.call (Void)
			end
		end

feature -- Button intermediary agent routines	

	button_select_intermediary (a_c_object: POINTER)
			-- Selected
		local
			l_button_imp: detachable EV_BUTTON_IMP
			l_rad_imp: detachable EV_RADIO_BUTTON_IMP
		do
			l_button_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			l_rad_imp ?= l_button_imp
			if l_rad_imp /= Void and then not l_rad_imp.is_selected then
				-- Do nothing as we shouldn't call the select actions of a radio button if it isn't selected
			elseif
				l_button_imp /= Void and then
				attached l_button_imp.select_actions_internal as l_button_imp_select_actions and then
				l_button_imp.parent_imp /= Void
			then
				l_button_imp_select_actions.call (Void)
			end
		end

feature {EV_ANY_IMP} -- Menu intermediary agent routines

	menu_item_activate_intermediary (a_c_object: POINTER)
			-- Item activated
		local
			a_menu_item_imp: detachable EV_MENU_ITEM_IMP
		do
			a_menu_item_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			if a_menu_item_imp /= Void and then a_menu_item_imp.allow_on_activate then
					-- Add event to idle actions so that menu may closed
					-- This also prevents crashes with dbus handled menus if events are processed during activate.
				a_menu_item_imp.app_implementation.do_once_on_idle (agent a_menu_item_imp.on_activate)
			end
		end

feature {EV_ANY_IMP} -- Dialog intermediary agent routines

	gtk_dialog_response_intermediary (a_c_object: POINTER; a_response_id: INTEGER)
			-- Dialog "response" signal intermediary.
		local
			l_sd: EV_STANDARD_DIALOG_IMP
		do
			l_sd ?= c_get_eif_reference_from_object_id (a_c_object)
			check l_sd /= Void then end
			l_sd.on_response (a_response_id)
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
