indexing
	description: "in relation with debugger synchronisation, action associated"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_DEBUGGER_WATCHER

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

	implementation: DOTNET_DEBUGGER_WATCHER_IMP
			-- Platform dependent implementation.

end -- class DOTNET_DEBUGGER_WATCHER
