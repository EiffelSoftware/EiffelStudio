note
	description: "Eiffel Vision timeout. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TIMEOUT_IMP

inherit
	EV_TIMEOUT_I
		export
			{EV_INTERMEDIARY_ROUTINES}
				is_destroyed
		redefine
			interface
		end

	IDENTIFIED
		undefine
			is_equal,
			copy
		redefine
			dispose
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Call base make only.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			timeout_agent_internal := agent (App_implementation.gtk_marshal).on_timeout_intermediary (object_id)
			set_is_initialized (True)
		end

feature -- Access

	interval: INTEGER
			-- Time between calls to `timeout_actions' in milliseconds.
			-- Zero when disabled.

	set_interval (an_interval: INTEGER)
			-- Assign `an_interval' in milliseconds to `interval'.
			-- Zero disables.
		do
			interval := an_interval
			if timeout_connection_id > 0 then
				{GTK}.g_source_remove (timeout_connection_id)
				timeout_connection_id := 0
			end

			if an_interval > 0 and then timeout_agent_internal /= Void then
				timeout_connection_id :=
					{EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_timeout_connect (
						an_interval.max (10), timeout_agent_internal
					)
			end
		end

feature {EV_ANY, EV_ANY_I, EV_INTERMEDIARY_ROUTINES} -- Implementation

	interface: detachable EV_TIMEOUT note option: stable attribute end
		-- Interface object.

	app_implementation: EV_APPLICATION_IMP
			-- App implementation object
		local
			l_result: detachable EV_APPLICATION_IMP
		once
			l_result ?= (create {EV_ENVIRONMENT}).implementation.application_i
			check l_result /= Void then end
			Result := l_result
		end

feature {NONE} -- Implementation

	timeout_connection_id: NATURAL_32
		-- GTK handle on timeout connection.

	timeout_agent_internal: detachable PROCEDURE note option: stable attribute end
		-- Reusable agent used for connecting timeout to gtk implementation.

feature {EV_ANY_I} -- Implementation

	destroy
			-- Render `Current' unusable.
		do
			set_interval (0)
			set_is_destroyed (True)
		end

feature {NONE} -- Implementation

	dispose
			-- Clean up
		do
			if timeout_connection_id > 0 then
				{GTK}.g_source_remove (timeout_connection_id)
			end
			Precursor
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




end -- class EV_TIMEOUT_IMP











