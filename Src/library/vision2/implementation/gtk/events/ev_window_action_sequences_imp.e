indexing
	description:
		"Action sequences for EV_WINDOW_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WINDOW_ACTION_SEQUENCES_IMP

inherit
	EV_WINDOW_ACTION_SEQUENCES_I

EV_ANY_IMP undefine dispose, destroy end

feature -- Event handling

	create_close_request_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a close request action sequence.
		do
			create Result
		end

	create_move_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Create a move action sequence.
		do
			create Result
		end

	create_show_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a show action sequence.
			-- Attach to GTK "map-event" signal.
		do
			create Result
			--connect_signal_to_actions (Gtk_signal_map_event, Result, default_translate)
			connect_signal_to_actions ("map-event", Result, default_translate)
		end

--	Gtk_signal_map_event: INTEGER is
--		once
--			Result := C.gtk_signal_name ("map-event")
--		end

end
