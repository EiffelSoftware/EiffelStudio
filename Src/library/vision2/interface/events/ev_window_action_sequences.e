indexing
	description:
		"Action sequences for EV_WINDOW."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_WINDOW_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_WINDOW_ACTION_SEQUENCES_I

feature -- Event handling


	move_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Actions to be performed when window moves.
		do
			Result := implementation.move_actions
		ensure
			not_void: Result /= Void
		end


	show_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when window is shown.
		do
			Result := implementation.show_actions
		ensure
			not_void: Result /= Void
		end
		
	close_request_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed whan a request to close window
			-- has been received.
		do
			Result := implementation.close_request_actions
		ensure
			not_void: Result /= Void
		end

end
