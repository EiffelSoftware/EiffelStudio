indexing
	description:
		"Action sequences for EV_PICK_AND_DROPABLE."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_PICK_AND_DROPABLE_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create,
			copy
		end

feature {NONE} -- Implementation

	implementation: EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_I

feature -- Event handling


	pick_actions: EV_PND_START_ACTION_SEQUENCE is
			-- Actions to be performed when `pebble' is picked up.
		do
			Result := implementation.pick_actions
		ensure
			not_void: Result /= Void
		end


	conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble that fits here is picked.
		do
			Result := implementation.conforming_pick_actions
		ensure
			not_void: Result /= Void
		end


	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble is dropped here.
		do
			Result := implementation.drop_actions
		ensure
			not_void: Result /= Void
		end

end
