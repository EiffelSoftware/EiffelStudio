indexing
	description:
		"Action sequences for EV_APPLICATION_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_APPLICATION_ACTION_SEQUENCES_IMP

inherit
	EV_APPLICATION_ACTION_SEQUENCES_I


feature -- Event handling

	create_post_launch_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a post_launch action sequence.
		do
			create Result
		end

	create_idle_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a idle action sequence.
		do
			create Result
		end

	create_pick_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a pick action sequence.
		do
			create Result
		end

	create_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Create a drop action sequence.
		do
			create Result
		end

end
