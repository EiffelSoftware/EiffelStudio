indexing
	description: "Intermediary routines between gtk and eiffel."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	EV_INTERMEDIARY_ROUTINES

inherit
	EV_GTK_DEPENDENT_INTERMEDIARY_ROUTINES

feature -- Timeout intermediary agent routine

	on_timeout_intermediary (a_object_id: INTEGER) is
			-- Timeout has occurred.
		local
			a_timeout_imp: EV_TIMEOUT_IMP
		do
			a_timeout_imp ?= eif_id_object (a_object_id)
			if a_timeout_imp /= Void and then not a_timeout_imp.is_destroyed and then not a_timeout_imp.is_timeout_executing and then a_timeout_imp.interval > 0 then
					-- Timeout may possibly have been gc'ed.
				a_timeout_imp.app_implementation.do_once_on_idle (a_timeout_imp.on_timeout_agent)
					-- We call timeout action on idle as not giving back gtk control from a timeout
					-- can cause memory corrupt if events are processed during the timeout call.
			end
		end

feature {EV_ANY_IMP} -- Notebook intermediary agent routines

	on_notebook_page_switch_intermediary (a_c_object: POINTER; a_page: NATURAL_32) is
			-- Notebook page is switched
		local
			a_notebook_imp: EV_NOTEBOOK_IMP
		do
			a_notebook_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_notebook_imp.page_switch (a_page.to_integer_32)
		end

feature -- Expose actions intermediary agent routines

	create_expose_actions_intermediary (a_c_object: POINTER; a_x, a_y, a_width, a_height: INTEGER) is
			-- Area needs to be redrawn
		local
			l_drawing_area_imp: EV_DRAWING_AREA_IMP
			l_pixmap_imp: EV_PIXMAP_IMP
		do
			l_drawing_area_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			if l_drawing_area_imp /= Void then
				l_drawing_area_imp.call_expose_actions (a_x, a_y, a_width, a_height)
			else
				l_pixmap_imp ?= c_get_eif_reference_from_object_id (a_c_object)
				if l_pixmap_imp /= Void then
					l_pixmap_imp.call_expose_actions (a_x, a_y, a_width, a_height)
				end
			end
		end

feature {EV_ANY_IMP} -- Gauge intermediary agent routines

	on_gauge_value_changed_intermediary (a_c_object: POINTER) is
			-- Gauge value changed
		local
			a_gauge_imp: EV_GAUGE_IMP
		do
			a_gauge_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_gauge_imp.value_changed_handler
		end

feature -- Widget intermediary agent routines

	on_size_allocate_intermediate (a_object_id, a_x, a_y, a_width, a_height: INTEGER) is
			-- Size allocate happened on widget.
		local
			a_widget: EV_WIDGET_IMP
		do
			a_widget ?= eif_id_object (a_object_id)
			if a_widget /= Void and then not a_widget.is_destroyed and then a_widget.is_displayed then
				a_widget.on_size_allocate (a_x, a_y, a_width, a_height)
			end
		end

	on_set_focus_event_intermediary (a_object_id: INTEGER; a_widget_ptr: POINTER) is
			-- Set Focus handling intermediary.
		local
			a_window: EV_WINDOW_IMP
		do
			a_window ?= eif_id_object (a_object_id)
			if a_window /= Void and then not a_window.is_destroyed then
				a_window.on_set_focus_event (a_widget_ptr)
			end
		end

feature {EV_ANY_IMP} -- Text component intermediary agent routines

	text_component_change_intermediary (a_c_object: POINTER) is
			-- Changed
		local
			a_text_component_imp: EV_TEXT_COMPONENT_IMP
		do
			a_text_component_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_text_component_imp.on_change_actions
		end

	text_field_return_intermediary (a_c_object: POINTER) is
			-- Return
		local
			a_text_field_imp: EV_TEXT_FIELD_IMP
		do
			a_text_field_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_text_field_imp.return_actions_internal.call (Void)
		end

feature -- Button intermediary agent routines	

	button_select_intermediary (a_c_object: POINTER) is
			-- Selected
		local
			a_button_imp: EV_BUTTON_IMP
			a_rad_imp: EV_RADIO_BUTTON_IMP
		do
			a_button_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_rad_imp ?= a_button_imp
			if a_rad_imp /= Void and then not a_rad_imp.is_selected then
				-- Do nothing as we shouldn't call the select actions of a radio button if it isn't selected
			elseif a_button_imp.select_actions_internal /= Void and then a_button_imp.parent_imp /= Void then
				a_button_imp.select_actions_internal.call (Void)
			end
		end

feature {EV_ANY_IMP} -- Menu intermediary agent routines

	menu_item_activate_intermediary (a_c_object: POINTER) is
			-- Item activated
		local
			a_menu_item_imp: EV_MENU_ITEM_IMP
		do
			a_menu_item_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			if a_menu_item_imp.parent_imp /= Void then
				a_menu_item_imp.on_activate
			end
		end

feature {EV_ANY_IMP} -- Dialog intermediary agent routines			

	color_dialog_on_ok_intermediary (a_c_object: POINTER) is
			-- Color dialog ok
		local
			a_color_dialog_imp: EV_COLOR_DIALOG_IMP
		do
			a_color_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_color_dialog_imp.on_ok
		end

	color_dialog_on_cancel_intermediary (a_c_object: POINTER) is
			-- Color dialog cancel
		local
			a_color_dialog_imp: EV_COLOR_DIALOG_IMP
		do
			a_color_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_color_dialog_imp.on_cancel
		end

	directory_dialog_on_ok_intermediary (a_c_object: POINTER) is
			-- Directory dialog ok
		local
			a_directory_dialog_imp: EV_DIRECTORY_DIALOG_IMP
		do
			a_directory_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_directory_dialog_imp.on_ok
		end

	directory_dialog_on_cancel_intermediary (a_c_object: POINTER) is
			-- Directory dialog cancel
		local
			a_directory_dialog_imp: EV_DIRECTORY_DIALOG_IMP
		do
			a_directory_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_directory_dialog_imp.on_cancel
		end

	file_dialog_on_ok_intermediary (a_c_object: POINTER) is
			-- File dialog ok
		local
			a_file_dialog_imp: EV_FILE_DIALOG_IMP
		do
			a_file_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_file_dialog_imp.on_ok
		end

	file_dialog_on_cancel_intermediary (a_c_object: POINTER) is
			-- File dialog cancel
		local
			a_file_dialog_imp: EV_FILE_DIALOG_IMP
		do
			a_file_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_file_dialog_imp.on_cancel
		end

	font_dialog_on_ok_intermediary (a_c_object: POINTER) is
			-- Font dialog ok
		local
			a_font_dialog_imp: EV_FONT_DIALOG_IMP
		do
			a_font_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_font_dialog_imp.on_ok
		end

	font_dialog_on_cancel_intermediary (a_c_object: POINTER) is
			-- Font dialog cancel
		local
			a_font_dialog_imp: EV_FONT_DIALOG_IMP
		do
			a_font_dialog_imp ?= c_get_eif_reference_from_object_id (a_c_object)
			a_font_dialog_imp.on_cancel
		end

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




end -- class EV_INTERMEDIARY_ROUTINES

