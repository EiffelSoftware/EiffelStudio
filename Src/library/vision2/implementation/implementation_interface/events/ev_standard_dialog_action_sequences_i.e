indexing
	description:
		"Action sequences for EV_STANDARD_DIALOG_I."
	status: "Generated!"
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_STANDARD_DIALOG_ACTION_SEQUENCES_I


feature -- Event handling

	ok_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when user clicks OK.
		do
			if ok_actions_internal = Void then
				ok_actions_internal :=
					 create_ok_actions
			end
			Result := ok_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_ok_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a ok action sequence.
		deferred
		end

	ok_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `ok_actions'.


feature -- Event handling

	cancel_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Actions to be performed when user cancels.
		do
			if cancel_actions_internal = Void then
				cancel_actions_internal :=
					 create_cancel_actions
			end
			Result := cancel_actions_internal
		ensure
			not_void: Result /= Void
		end

feature {EV_ANY_I} -- Implementation

	create_cancel_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Create a cancel action sequence.
		deferred
		end

	cancel_actions_internal: EV_NOTIFY_ACTION_SEQUENCE
			-- Implementation of once per object `cancel_actions'.

end
