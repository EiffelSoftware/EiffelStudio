indexing
	description:
		"Action sequences for EV_TEXT_FIELD_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_TEXT_FIELD_ACTION_SEQUENCES_I


feature -- Event handling

	return_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when return key is pressed.
		do
			if return_actions_internal = Void then
				return_actions_internal :=
					 create_return_actions
			end
			Result := return_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_return_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a return action sequence.
		deferred
		end

	return_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `return_actions'.

end
