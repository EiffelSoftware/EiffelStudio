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

feature -- Event handling

	create_close_request_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a close_request action sequence.
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

end
