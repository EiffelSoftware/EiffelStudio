indexing
	description:
		"Action sequences for EV_PICK_AND_DROPABLE_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

inherit
	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_I


feature -- Event handling

	create_pick_actions: EV_PND_START_ACTION_SEQUENCE is
			-- Create a pick action sequence.
		do
			create Result
		end

	create_conforming_pick_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a conforming_pick action sequence.
		do
			create Result
		end

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a drop action sequence.
		do
			create Result
		end

end
