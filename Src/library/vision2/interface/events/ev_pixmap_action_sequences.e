indexing
	description:
		"Action sequences for EV_PIXMAP."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_PIXMAP_ACTION_SEQUENCES

inherit
	ANY
		undefine
			default_create
		end

feature {NONE} -- Implementation

	implementation: EV_PIXMAP_ACTION_SEQUENCES_I

feature -- Event handling


	expose_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Actions to be performed when an area needs to be redrawn.
		do
			Result := implementation.expose_actions
		ensure
			not_void: Result /= Void
		end

end
