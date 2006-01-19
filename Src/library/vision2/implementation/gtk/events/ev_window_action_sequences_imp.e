indexing
	description:
		"Action sequences for EV_WINDOW_IMP."
	status: "Generated!"
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

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

