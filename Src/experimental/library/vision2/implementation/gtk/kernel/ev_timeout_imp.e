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

	old_make (an_interface: like interface)
			-- Call base make only.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			if internal_id = 0 then
				internal_id := eif_current_object_id
			end
			timeout_agent_internal := agent (App_implementation.gtk_marshal).on_timeout_intermediary (internal_id)
			on_timeout_agent := agent on_timeout
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
				{EV_GTK_EXTERNALS}.gtk_timeout_remove (timeout_connection_id)
				timeout_connection_id := 0
			end

			if an_interval > 0 then
				timeout_connection_id :=
					{EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_timeout_connect (
						an_interval.max (20), timeout_agent_internal
					)
			end
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_ANY_I} -- Implementation

	interface: detachable EV_TIMEOUT note option: stable attribute end
		-- Interface object.

	app_implementation: EV_APPLICATION_IMP
			-- App implementation object
		local
			l_result: detachable EV_APPLICATION_IMP
		once
			l_result ?= (create {EV_ENVIRONMENT}).implementation.application_i
			check l_result /= Void end
			Result := l_result
		end

	on_timeout_agent: PROCEDURE [EV_TIMEOUT_IMP, TUPLE]
		-- Reusable timeout for adding to idle actions.

feature {NONE} -- Implementation

	timeout_object: POINTER

	timeout_connection_id: INTEGER
		-- GTK handle on timeout connection.

	timeout_agent_internal: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE]
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
				{EV_GTK_EXTERNALS}.gtk_timeout_remove (timeout_connection_id)
			end
			Precursor
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




end -- class EV_TIMEOUT_IMP











