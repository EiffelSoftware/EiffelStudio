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

feature -- Expose actions intermediary agent routines

	create_expose_actions_intermediary (a_c_object: POINTER; a_x, a_y, a_width, a_height: INTEGER)
			-- Area needs to be redrawn
		do
			if attached c_get_eif_reference_from_object_id (a_c_object) as l_imp then
				if attached {EV_DRAWING_AREA_IMP} l_imp as l_drawing_area_imp then
					l_drawing_area_imp.call_expose_actions (a_x, a_y, a_width, a_height)
				elseif attached {EV_PIXMAP_IMP} l_imp as l_pixmap_imp then
					l_pixmap_imp.call_expose_actions (a_x, a_y, a_width, a_height)
				end
			end
		end

feature {EV_ANY_IMP} -- Gauge intermediary agent routines

	on_gauge_value_changed_intermediary (a_c_object: POINTER)
			-- Gauge value changed
		do
			check attached {EV_GAUGE_IMP} c_get_eif_reference_from_object_id (a_c_object) as l_gauge_imp then
				l_gauge_imp.value_changed_handler
			end
		end

feature -- Widget intermediary agent routines

	on_size_allocate_intermediate (a_object_id, a_x, a_y, a_width, a_height: INTEGER)
			-- Size allocate happened on widget.
		do
			if
				attached {EV_WIDGET_IMP} eif_id_object (a_object_id) as a_widget and then
			 	not a_widget.is_destroyed
			then
				a_widget.on_size_allocate (a_x, a_y, a_width, a_height)
			end
		end

	on_set_focus_event_intermediary (a_object_id: INTEGER; a_widget_ptr: POINTER)
			-- Set Focus handling intermediary.
		do
			if
				attached {EV_WINDOW_IMP} eif_id_object (a_object_id) as a_window and then
				not a_window.is_destroyed
			then
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

	color_dialog_on_ok_intermediary (a_c_object: POINTER)
			-- Color dialog ok
		local
			a_color_dialog_imp: detachable EV_COLOR_DIALOG_IMP
		do
			a_color_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check a_color_dialog_imp /= Void then end
			a_color_dialog_imp.on_ok
		end

	color_dialog_on_cancel_intermediary (a_c_object: POINTER)
			-- Color dialog cancel
		local
			a_color_dialog_imp: detachable EV_COLOR_DIALOG_IMP
		do
			a_color_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check a_color_dialog_imp /= Void then end
			a_color_dialog_imp.on_cancel
		end

	directory_dialog_on_ok_intermediary (a_c_object: POINTER)
			-- Directory dialog ok
		local
			a_directory_dialog_imp: detachable EV_DIRECTORY_DIALOG_IMP
		do
			a_directory_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check a_directory_dialog_imp /= Void then end
			a_directory_dialog_imp.on_ok
		end

	directory_dialog_on_cancel_intermediary (a_c_object: POINTER)
			-- Directory dialog cancel
		local
			a_directory_dialog_imp: detachable EV_DIRECTORY_DIALOG_IMP
		do
			a_directory_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check a_directory_dialog_imp /= Void then end
			a_directory_dialog_imp.on_cancel
		end

	file_dialog_on_ok_intermediary (a_c_object: POINTER)
			-- File dialog ok
		local
			a_file_dialog_imp: detachable EV_FILE_DIALOG_IMP
		do
			a_file_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check a_file_dialog_imp /= Void then end
			a_file_dialog_imp.on_ok
		end

	file_dialog_on_cancel_intermediary (a_c_object: POINTER)
			-- File dialog cancel
		local
			a_file_dialog_imp: detachable EV_FILE_DIALOG_IMP
		do
			a_file_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check a_file_dialog_imp /= Void then end
			a_file_dialog_imp.on_cancel
		end

	font_dialog_on_ok_intermediary (a_c_object: POINTER)
			-- Font dialog ok
		local
			a_font_dialog_imp: detachable EV_FONT_DIALOG_IMP
		do
			a_font_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check a_font_dialog_imp /= Void then end
			a_font_dialog_imp.on_ok
		end

	font_dialog_on_cancel_intermediary (a_c_object: POINTER)
			-- Font dialog cancel
		local
			a_font_dialog_imp: detachable EV_FONT_DIALOG_IMP
		do
			a_font_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			check a_font_dialog_imp /= Void then end
			a_font_dialog_imp.on_cancel
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
