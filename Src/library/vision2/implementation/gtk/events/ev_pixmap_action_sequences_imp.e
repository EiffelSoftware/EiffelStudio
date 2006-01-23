indexing
	description:
		"Action sequences for EV_PIXMAP_IMP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_PIXMAP_ACTION_SEQUENCES_IMP

inherit
	EV_PIXMAP_ACTION_SEQUENCES_I

EV_ANY_IMP undefine dispose, destroy end

feature -- Event handling

	create_expose_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Create a expose action sequence.
			-- Attach to GTK "expose-event" signal.
		do
			create Result
			real_signal_connect (visual_widget, once "expose-event", agent (App_implementation.gtk_marshal).create_expose_actions_intermediary (c_object, ?, ?, ?, ?), Void)
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

