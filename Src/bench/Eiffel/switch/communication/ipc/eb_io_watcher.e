indexing
	description	: "Mechanism to call an action when a file/pipe is changed."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_IO_WATCHER

inherit
	ANY
		redefine
			default_create
		end

create
	default_create,
	make_with_action

feature {NONE} -- Initialization

	default_create is
			-- Create a default IO-listener. No action is associated, and 
			-- therefore nothing will happen when the file/pipe is changed.
		do
			create implementation
		end

	make_with_action (an_action: like action) is
			-- Create an IO-listener with `an_action' as callback feature.
		require
			an_agent_not_void: an_action /= Void
		do
			default_create
			set_action (an_action)
		end

feature -- Access

	action: PROCEDURE [ANY, TUPLE] is
			-- Callback feature called with the file/pipe is changed.
		do
			Result := implementation.action
		end

feature -- Element change

	set_action (an_action: like action) is
			-- Set `an_action' as callback feature.
		require
			an_agent_not_void: an_action /= Void
		do
			implementation.set_action (an_action)
		ensure
			agent_set: action = an_action
		end

	remove_action is
			-- Remove the current action
		do
			implementation.remove_action
		ensure
			no_action: action = Void
		end

feature {NONE} -- Implementation

	implementation: EB_IO_WATCHER_IMP
			-- Platform dependent implementation.

end -- EB_IO_WATCHER


