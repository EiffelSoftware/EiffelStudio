indexing
	description:
		"Action sequences for EV_WIDGET_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WIDGET_ACTION_SEQUENCES_IMP

inherit
	EV_WIDGET_ACTION_SEQUENCES_I

EV_ANY_IMP undefine dispose, destroy end

feature -- Event handling

	create_pointer_motion_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Create a pointer_motion action sequence.
			-- Attach to GTK "motion-notify-event" signal.
		do
			create Result
			--connect_signal_to_actions (Gtk_signal_motion_notify_event, Result, default_translate)
			connect_signal_to_actions ("motion-notify-event", Result, default_translate)
		end

--	Gtk_signal_motion_notify_event: INTEGER is
--		once
--			Result := C.gtk_signal_name ("motion-notify-event")
--		end

	create_pointer_button_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Create a pointer_button_press action sequence.
		do
			create Result
		end

	create_pointer_double_press_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Create a pointer_double_press action sequence.
		do
			create Result
		end

	create_pointer_button_release_actions: EV_POINTER_BUTTON_ACTION_SEQUENCE is
			-- Create a pointer_button_release action sequence.
			-- Attach to GTK "button-release-event" signal.
		do
			create Result
			--connect_signal_to_actions (Gtk_signal_button_release_event, Result, default_translate)
			connect_signal_to_actions ("button-release-event", Result, default_translate)
		end

--	Gtk_signal_button_release_event: INTEGER is
--		once
--			Result := C.gtk_signal_name ("button-release-event")
--		end

	create_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a pointer_enter action sequence.
			-- Attach to GTK "enter-notify-event" signal.
		do
			create Result
			--connect_signal_to_actions (Gtk_signal_enter_notify_event, Result, default_translate)
			connect_signal_to_actions ("enter-notify-event", Result, default_translate)
		end

--	Gtk_signal_enter_notify_event: INTEGER is
--		once
--			Result := C.gtk_signal_name ("enter-notify-event")
--		end

	create_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a pointer_leave action sequence.
			-- Attach to GTK "leave-notify-event" signal.
		do
			create Result
			--connect_signal_to_actions (Gtk_signal_leave_notify_event, Result, default_translate)
			connect_signal_to_actions ("leave-notify-event", Result, default_translate)
		end

--	Gtk_signal_leave_notify_event: INTEGER is
--		once
--			Result := C.gtk_signal_name ("leave-notify-event")
--		end

	create_key_press_actions: EV_KEY_ACTION_SEQUENCE is
			-- Create a key_press action sequence.
		do
			create Result
		end

	create_key_press_string_actions: EV_KEY_STRING_ACTION_SEQUENCE is
			-- Create a key_press_string action sequence.
		do
			create Result
		end

	create_key_release_actions: EV_KEY_ACTION_SEQUENCE is
			-- Create a key_release action sequence.
		do
			create Result
		end

	create_focus_in_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- Create a focus_in action sequence.
			-- Attach to GTK "focus-in-event" signal.
		do
			create Result
			--connect_signal_to_actions (Gtk_signal_focus_in_event, Result, default_translate)
			connect_signal_to_actions ("focus-in-event", Result, default_translate)
		end

--	Gtk_signal_focus_in_event: INTEGER is
--		once
--			Result := C.gtk_signal_name ("focus-in-event")
--		end

	create_focus_out_actions: EV_FOCUS_ACTION_SEQUENCE is
			-- Create a focus_out action sequence.
			-- Attach to GTK "focus-out-event" signal.
		do
			create Result
			--connect_signal_to_actions (Gtk_signal_focus_out_event, Result, default_translate)
			connect_signal_to_actions ("focus-out-event", Result, default_translate)
		end

--	Gtk_signal_focus_out_event: INTEGER is
--		once
--			Result := C.gtk_signal_name ("focus-out-event")
--		end

	create_resize_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Create a resize action sequence.
		do
			create Result
		end

end


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

