note
	description:
		"Action sequences for EV_DRAWING_AREA_IMP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_DRAWING_AREA_ACTION_SEQUENCES_IMP

inherit
	EV_DRAWING_AREA_ACTION_SEQUENCES_I
		export
			{EV_INTERMEDIARY_ROUTINES} expose_actions_internal
		end

feature -- Event handling

	create_expose_actions: EV_GEOMETRY_ACTION_SEQUENCE
			-- Create a expose action sequence.
			-- Attach to GTK "draw" signal.
		local
			l_app_imp: EV_APPLICATION_IMP
		do
			create Result
			l_app_imp := app_implementation
			l_app_imp.gtk_marshal.signal_connect (visual_widget, once "draw", agent (l_app_imp.gtk_marshal).create_draw_actions_intermediary (c_object, ?), l_app_imp.gtk_marshal.draw_translate_agent, True)
		end

feature {NONE} -- Implementation

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
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end

