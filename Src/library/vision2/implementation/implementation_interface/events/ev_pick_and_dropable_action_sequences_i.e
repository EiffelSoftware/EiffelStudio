indexing
	description:
		"Action sequences for EV_PICK_AND_DROPABLE_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_I


feature -- Event handling

	pick_actions: EV_PND_START_ACTION_SEQUENCE is
			-- Actions to be performed when `pebble' is picked up.
		do
			if pick_actions_internal = Void then
				pick_actions_internal :=
					 create_pick_actions
			end
			Result := pick_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_pick_actions: EV_PND_START_ACTION_SEQUENCE is
			-- Create a pick action sequence.
		deferred
		end

	pick_actions_internal: EV_PND_START_ACTION_SEQUENCE
			-- Implementation of once per object `pick_actions'.


feature -- Event handling

	conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble that fits here is picked.
		do
			if conforming_pick_actions_internal = Void then
				conforming_pick_actions_internal :=
					 create_conforming_pick_actions
			end
			Result := conforming_pick_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a conforming_pick action sequence.
		deferred
		end

	conforming_pick_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `conforming_pick_actions'.


feature -- Event handling

	drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Actions to be performed when a pebble is dropped here.
		do
			if drop_actions_internal = Void then
				drop_actions_internal :=
					 create_drop_actions
			end
			Result := drop_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a drop action sequence.
		deferred
		end

	drop_actions_internal: EV_PND_ACTION_SEQUENCE
			-- Implementation of once per object `drop_actions'.

end
