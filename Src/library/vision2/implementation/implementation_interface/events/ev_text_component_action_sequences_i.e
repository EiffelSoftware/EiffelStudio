indexing
	description:
		"Action sequences for EV_TEXT_COMPONENT_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TEXT_COMPONENT_ACTION_SEQUENCES_I


feature -- Event handling

	change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when `text' changes.
		do
			if change_actions_internal = Void then
				change_actions_internal :=
					 create_change_actions
			end
			Result := change_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_change_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a change action sequence.
		deferred
		end

	change_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `change_actions'.

end
