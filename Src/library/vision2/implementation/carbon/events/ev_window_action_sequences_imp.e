indexing
	description:
		"Action sequences for EV_WINDOW_IMP."

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
		do
			create Result
		end

	create_hide_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a hide action sequence.
		do
			create Result
		end

indexing
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"

end

