indexing
	description:
		"Action sequences for EV_BUTTON_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_BUTTON_ACTION_SEQUENCES_I


feature -- Event handling

	select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when button is pressed then released.
		do
			if select_actions_internal = Void then
				select_actions_internal :=
					 create_select_actions
			end
			Result := select_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a select action sequence.
		deferred
		end

	select_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `select_actions'.

end
