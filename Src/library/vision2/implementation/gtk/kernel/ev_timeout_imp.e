indexing
	description: "Eiffel Vision timeout. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TIMEOUT_IMP

inherit
	EV_TIMEOUT_I
		redefine
			interface,
			on_timeout
		end

	EV_ANY_IMP
		redefine
			interface,
			destroy,
			dispose
		end

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Call base make only.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_label_new (NULL))
		end

	initialize is
			-- Initialize `Current'.
		do
			timeout_agent_internal := agent (App_implementation.gtk_marshal).on_timeout_intermediary (object_id)
			set_is_initialized (True)
		end

feature -- Access

	interval: INTEGER
			-- Time between calls to `timeout_actions' in milliseconds.
			-- Zero when disabled.

	set_interval (an_interval: INTEGER) is
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
					App_implementation.gtk_marshal.c_ev_gtk_callback_marshal_timeout_connect (
						an_interval, timeout_agent_internal
					)
			end
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_ANY_I} -- Implementation

	on_timeout is
			-- Call the timeout actions.
		do
				-- Prevent nested calls by flagging intermediary to not call should a call be in progress.
			actions_called := True
			Precursor
			actions_called := False
		end

	actions_called: BOOLEAN
		-- Are the timeout actions in the process of being called.

	interface: EV_TIMEOUT
		-- Interface object.

feature {NONE} -- Implementation

	timeout_connection_id: INTEGER
		-- GTK handle on timeout connection.

	timeout_agent_internal: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE]
		-- Reusable agent used for connecting timeout to gtk implementation.

feature {EV_ANY_I} -- Implementation

	destroy is
			-- Render `Current' unusable.
		do
			set_interval (0)
			Precursor {EV_ANY_IMP}
		end

feature {NONE} -- Implementation

	dispose is
			-- Clean up
		do
			if timeout_connection_id > 0 then
				{EV_GTK_EXTERNALS}.gtk_timeout_remove (timeout_connection_id)
			end
			Precursor {EV_ANY_IMP}
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




end -- class EV_TIMEOUT_IMP

