indexing
	description:
		"Action sequences for EV_DRAWING_AREA."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_DRAWING_AREA_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create, copy
		end

feature {NONE} -- Implementation

	implementation: EV_DRAWING_AREA_ACTION_SEQUENCES_I

feature -- Event handling


	expose_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Actions to be performed when an area needs to be redrawn.
		do
			Result := implementation.expose_actions
		ensure
			not_void: Result /= Void
		end

end
