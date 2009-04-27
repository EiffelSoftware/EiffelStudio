indexing
	description:
		"Action sequences for EV_BUTTON_IMP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "Generated!"
	revision: "Generated!"

deferred class
	 EV_BUTTON_ACTION_SEQUENCES_IMP

inherit
	EV_BUTTON_ACTION_SEQUENCES_I

	EV_ANY_IMP
		undefine
			dispose,
			destroy
		end

feature -- Event handling

	create_select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Create a select action sequence.
		do
			create Result
		end


indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end

