indexing
	description:
		"Action sequences for EV_DRAWING_AREA_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_DRAWING_AREA_ACTION_SEQUENCES_I


feature -- Event handling

	expose_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Actions to be performed when an area needs to be redrawn.
		do
			if expose_actions_internal = Void then
				expose_actions_internal :=
					 create_expose_actions
			end
			Result := expose_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_expose_actions: EV_GEOMETRY_ACTION_SEQUENCE is
			-- Create a expose action sequence.
		deferred
		end

	expose_actions_internal: EV_GEOMETRY_ACTION_SEQUENCE
			-- Implementation of once per object `expose_actions'.

end
