indexing
	description:
		"Action sequences for EV_DRAWING_AREA_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_DRAWING_AREA_ACTION_SEQUENCES_IMP

inherit
	EV_DRAWING_AREA_ACTION_SEQUENCES_I

EV_ANY_IMP undefine dispose, destroy end

feature -- Event handling

	create_expose_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Create a expose action sequence.
			-- Attach to GTK "expose-event" signal.
		do
			create Result
			--connect_signal_to_actions (Gtk_signal_expose_event, Result, default_translate)
			connect_signal_to_actions ("expose-event", Result, default_translate)
		end

--	Gtk_signal_expose_event: INTEGER is
--		once
--			Result := C.gtk_signal_name ("expose-event")
--		end

end
