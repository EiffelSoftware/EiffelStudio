note
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

feature -- Event handling

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a select action sequence.
			-- Attach to GTK "clicked" signal.
		local
			l_app_imp: EV_APPLICATION_IMP
		do
			create Result
			l_app_imp := app_implementation
			l_app_imp.gtk_marshal.signal_connect (visual_widget, l_app_imp.clicked_event_string, agent (l_app_imp.gtk_marshal).button_select_intermediary (c_object), Void, False)
		end

feature {NONE}

	c_object: POINTER
		deferred
		end

	visual_widget: POINTER
		deferred
		end

	app_implementation: EV_APPLICATION_IMP
		deferred
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




end

