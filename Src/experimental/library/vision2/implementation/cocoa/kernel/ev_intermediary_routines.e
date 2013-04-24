note
	description: "Intermediary routines between ... and eiffel."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


class
	EV_INTERMEDIARY_ROUTINES

feature {EV_ANY_IMP} -- Timeout intermediary agent routine

	on_timeout_intermediary (a_object_id: INTEGER)
			-- Timeout has occurred.
		do
		end

feature {EV_ANY_IMP} -- Notebook intermediary agent routines

	on_notebook_page_switch_intermediary (a_c_object: POINTER; a_page: NATURAL_32)
			-- Notebook page is switched
		do
		end

feature {EV_ANY_IMP} -- Drawing Area intermediary agent routines

	on_drawing_area_event_intermediary (a_c_object: POINTER; a_event_number: INTEGER)
			-- Drawing area focus lost or gained
		do
		end

	create_expose_actions_intermediary (a_c_object: POINTER; a_x, a_y, a_width, a_height: INTEGER)
			-- Area needs to be redrawn
		do
		end

feature {EV_ANY_IMP} -- Gauge intermediary agent routines

	on_gauge_value_changed_intermediary (a_c_object: POINTER)
			-- Gauge value changed
		do
		end

feature {EV_ANY_IMP} -- Key Event intermediary agent routines

	on_key_event_intermediary (a_object_id: INTEGER; a_key: EV_KEY; a_key_string: STRING_32; a_key_press: BOOLEAN)
			-- Key event
		do
		end

feature {EV_ANY_IMP} -- Widget intermediary agent routines

	on_size_allocate_intermediate (a_object_id, a_x, a_y, a_width, a_height: INTEGER)
			-- Size allocate happened on widget.
		do
		end

	window_focus_intermediary (a_object_id: INTEGER; a_focused: BOOLEAN)
			-- Focus handling intermediary.
		do
		end

	on_set_focus_event_intermediary (a_object_id: INTEGER; a_widget_ptr: POINTER)
			-- Set Focus handling intermediary.
		do
		end

feature {EV_ANY_IMP} -- Text component intermediary agent routines

	text_component_change_intermediary (a_c_object: POINTER)
			-- Changed
		do
		end

	text_field_return_intermediary (a_c_object: POINTER)
			-- Return
		do
		end

feature {EV_ANY_IMP} -- Button intermediary agent routines	

	button_select_intermediary (a_c_object: POINTER)
			-- Selected
		do
		end

	button_press_switch_intermediary (a_c_object: POINTER; a_type: INTEGER;	a_x, a_y, a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER)
			--  Call to switch between type of button press event
		do
		end

feature {EV_ANY_IMP} -- Window intermediary agent routines

	on_window_close_request (a_c_object: POINTER)
			-- Close requested
		do
		end

	on_widget_show (a_c_object: POINTER)
			-- Widget has been shown
		do
		end

feature {EV_ANY_IMP} -- Menu intermediary agent routines

	menu_item_activate_intermediary (a_c_object: POINTER)
			-- Item activated
		do
		end

feature {EV_ANY_IMP} -- Pointer intermediary agent routines	

	pointer_enter_leave_action_intermediary (a_c_object: POINTER; a_enter_leave: BOOLEAN)
			-- Pointer entered
		do
		end

feature {EV_ANY_IMP} -- Dialog intermediary agent routines			

	color_dialog_on_ok_intermediary (a_c_object: POINTER)
			-- Color dialog ok
		do
		end

	color_dialog_on_cancel_intermediary (a_c_object: POINTER)
			-- Color dialog cancel
		do
		end

	directory_dialog_on_ok_intermediary (a_c_object: POINTER)
			-- Directory dialog ok
		do
		end

	directory_dialog_on_cancel_intermediary (a_c_object: POINTER)
			-- Directory dialog cancel
		do
		end

	file_dialog_on_ok_intermediary (a_c_object: POINTER)
			-- File dialog ok
		do
		end

	file_dialog_on_cancel_intermediary (a_c_object: POINTER)
			-- File dialog cancel
		do
		end

	font_dialog_on_ok_intermediary (a_c_object: POINTER)
			-- Font dialog ok
		do
		end

	font_dialog_on_cancel_intermediary (a_c_object: POINTER)
			-- Font dialog cancel
		do
		end

feature {EV_ANY_IMP} -- Accelerator intermediary agent routines

	accelerator_actions_internal_intermediary (a_c_object: POINTER)
			-- Intermediary agent for accelerator show action
		do
		end

note
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

