indexing
	description:
		"Action sequences for EV_APPLICATION."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_APPLICATION_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_APPLICATION_ACTION_SEQUENCES_I

feature -- Event handling


	post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed just after application `launch'.
		do
			Result := implementation.post_launch_actions
		ensure
			not_void: Result /= Void
		end


	idle_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when the application is otherwise idle.
		do
			Result := implementation.idle_actions
		ensure
			not_void: Result /= Void
		end


	pick_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when any "pick" occurs.
		do
			Result := implementation.pick_actions
		ensure
			not_void: Result /= Void
		end


	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when any "drop" occurs.
		do
			Result := implementation.drop_actions
		ensure
			not_void: Result /= Void
		end

end
