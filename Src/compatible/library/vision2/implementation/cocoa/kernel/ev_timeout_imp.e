note
	description: "Eiffel Vision timeout. Cocoa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TIMEOUT_IMP

inherit
	EV_TIMEOUT_I
		redefine
			interface,
			on_timeout
		end

	EV_ANY_IMP
		redefine
			interface,
			destroy
		end

create
	make

feature -- Initialization

	make (an_interface: like interface)
			-- Call base make only.
		do
			base_make (an_interface)
		end

	initialize
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

feature -- Access

	interval: INTEGER
			-- Time between calls to `timeout_actions' in milliseconds.
			-- Zero when disabled.

	set_interval (an_interval: INTEGER)
			-- Assign `an_interval' in milliseconds to `interval'.
			-- Zero disables.
		do
			interval := an_interval
		end

feature {EV_INTERMEDIARY_ROUTINES, EV_ANY_I} -- Implementation

	on_timeout
			-- Call the timeout actions.
		do
				-- Prevent nested calls by flagging intermediary to not call should a call be in progress.
			actions_called := True
			Precursor
			actions_called := False
		end

	actions_called: BOOLEAN
		-- Are the timeout actions in the process of being called.

	interface: EV_TIMEOUT
		-- Interface object.

feature {EV_ANY_I} -- Implementation

	destroy
			-- Render `Current' unusable.
		do
			set_interval (0)
			Precursor {EV_ANY_IMP}
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_TIMEOUT_IMP

