indexing
	description:
		"Action sequences for EV_BUTTON_IMP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_BUTTON_ACTION_SEQUENCES_IMP

inherit
	EV_BUTTON_ACTION_SEQUENCES_I

	EV_ANY_IMP
		undefine
			needs_event_box,
			dispose,
			destroy
		end

feature -- Event handling

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		do
			create Result
			signal_connect (visual_widget, App_implementation.clicked_event_string, agent (App_implementation.gtk_marshal).button_select_intermediary (c_object), Void, False)
		end

--	Gtk_signal_clicked: INTEGER is
--		once
--			Result := C.gtk_signal_name ("clicked")
--		end

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




end

