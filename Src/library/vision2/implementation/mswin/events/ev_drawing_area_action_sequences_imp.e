indexing
	description:
		"Action sequences for EV_DRAWING_AREA_IMP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_DRAWING_AREA_ACTION_SEQUENCES_IMP

inherit
	EV_DRAWING_AREA_ACTION_SEQUENCES_I

feature -- Event handling

	create_expose_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Create a expose action sequence.
		do
			create Result
		end

end
