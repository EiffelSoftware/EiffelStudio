indexing
	description:
		"Action sequences for EV_BUTTON_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_BUTTON_ACTION_SEQUENCES_IMP

inherit
	EV_BUTTON_ACTION_SEQUENCES_I

EV_ANY_IMP undefine dispose, destroy end

feature -- Event handling

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		do
			create Result
			--real_connect_signal_to_actions (button_widget, Gtk_signal_clicked, Result, Void)
			real_connect_signal_to_actions (button_widget, "clicked", Result, Void)
		end
	
	button_widget: POINTER is deferred end

--	Gtk_signal_clicked: INTEGER is
--		once
--			Result := C.gtk_signal_name ("clicked")
--		end

end
