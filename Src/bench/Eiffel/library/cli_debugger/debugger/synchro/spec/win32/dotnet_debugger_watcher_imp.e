indexing
	description: "Implementation on Windows for synchronisation"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	DOTNET_DEBUGGER_WATCHER_IMP

inherit
	ANY
		redefine
			default_create
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		undefine
			default_create
		end

create
	default_create

feature {NONE} -- Initialization

	default_create is
		local
			delay: INTEGER
		do
				-- Retrieve delay.
			delay := Configure_resources.get_pos_integer (r_Windows_timer_delay, 10)

				-- Adjust timer range.
			if delay < 5 then
				delay := 5
			elseif delay > 200 then	
				delay := 200
			end
				
				-- Setup the callback mechanism.
			init_timer (agent call_back, delay) 
		end

feature -- Access

	action: PROCEDURE [ANY, TUPLE]
			-- Callback feature called with the file/pipe is changed.

feature -- Element change

	set_action (an_action: like action) is
			-- Set `an_action' as callback feature.
		require
			an_agent_not_void: an_action /= Void
		do
			action := an_action
		ensure
			agent_set: action = an_action
		end

	remove_action is
			-- Remove the current action
		do
			action := Void
		ensure
			no_action: action = Void
		end

feature {NONE} -- Implementation

	call_back is
			-- Called back by the implementation when the
			-- file/pipe is changed.
		do
			-- We just call the action if any.
			if action /= Void then
				action.call(Void)
			end
		end

feature {NONE} -- Timer related

	init_timer (a_callback: like action; a_delay: INTEGER) is
		do
			if dbg_timer = Void then
				create dbg_timer.make_with_interval (a_delay) -- milliseconds
				dbg_timer.actions.extend (a_callback)
			end
		end

	dbg_timer: EV_TIMEOUT

end -- class DOTNET_DEBUGGER_WATCHER
