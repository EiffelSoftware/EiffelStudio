indexing
	description:
		"Action sequences for EV_WINDOW_IMP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WINDOW_ACTION_SEQUENCES_IMP

inherit
	EV_WINDOW_ACTION_SEQUENCES_I
		export
			{EV_INTERMEDIARY_ROUTINES} show_actions_internal
		end

	EV_ANY_IMP

		undefine
			dispose,
			destroy
		end

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
			real_signal_connect (c_object, once "map-event", agent (App_implementation.gtk_marshal).on_widget_show (c_object), Void)
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




end

