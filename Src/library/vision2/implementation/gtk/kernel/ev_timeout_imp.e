indexing
	description: "Eiffel Vision timeout. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TIMEOUT_IMP

inherit
	EV_TIMEOUT_I
		redefine
			interface
		end
		
	EV_ANY_IMP
		redefine
			interface,
			destroy
		end

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Call base make only.
		do
			base_make (an_interface)
			set_c_object (C.gtk_label_new (NULL))
		end

	initialize is 
		do 
			is_initialized := True
			timeout_agent_internal := agent (App_implementation.gtk_marshal).on_timeout_intermediary (c_object)
		end

feature -- Access

	interval: INTEGER 
			-- Time between calls to `timeout_actions' in milliseconds.
			-- Zero when disabled.

	set_interval (an_interval: INTEGER) is
			-- Assign `an_interval' in milliseconds to `interval'.
			-- Zero disables.
		do
			if timeout_connection_id > 0 then
				C.gtk_timeout_remove (timeout_connection_id)
				timeout_connection_id := 0
			end

			if an_interval > 0 then
				timeout_connection_id :=
					App_implementation.gtk_marshal.c_ev_gtk_callback_marshal_timeout_connect (
						an_interval, timeout_agent_internal
					)
			end
			interval := an_interval
		end

feature {EV_ANY_IMP, EV_INTERMEDIARY_ROUTINES, EV_APPLICATION_IMP} -- Implementation

	set_interval_kamikaze (an_interval: INTEGER) is
			-- Assign `an_interval' in milliseconds to `interval'.
			-- The timeout will only be executed once.
		require
			valid_interval: an_interval >= 0
		do
			if timeout_kamikaze_agent_internal = Void then
				timeout_kamikaze_agent_internal := agent (App_implementation.gtk_marshal).on_timeout_kamikaze_intermediary (c_object)
			end
			App_implementation.gtk_marshal.c_ev_gtk_callback_marshal_delayed_agent_call (
				an_interval, timeout_kamikaze_agent_internal
			)		
		end
		
	timeout_kamikaze_agent_internal: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE]
		-- Kamikaze agent used to call timeout actions only once.

feature {EV_INTERMEDIARY_ROUTINES, EV_ANY_I} -- Implementation

	call_timeout_actions is
			-- Call the timeout actions.
			-- FIXME This should be done in the implementation interface to avoid repeated timeouts.
		do
			if not actions_called then
				actions_called := True
				on_timeout
				actions_called := False
			end	
		end
		
	actions_called: BOOLEAN
		-- Are the timeout actions in the process of being called.

	interface: EV_TIMEOUT
	
feature {NONE} -- Implementation

	timeout_connection_id: INTEGER
		-- GTK handle on timeout connection.

	timeout_agent_internal: PROCEDURE [EV_GTK_CALLBACK_MARSHAL, TUPLE]

feature {EV_ANY_I} -- Implementation

	destroy is 
			-- Render `Current' unusable.
		do 
			set_interval (0)
			Precursor {EV_ANY_IMP}
		end

end -- class EV_TIMEOUT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

