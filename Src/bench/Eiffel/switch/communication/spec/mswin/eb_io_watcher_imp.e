indexing
	description	: "Mechanism to call an action when a file/pipe is changed.%N%
				  %Windows Implementation."
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

class
	EB_IO_WATCHER_IMP

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
			win_ioh_make_client ($call_back, Current, delay) 
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

	interface: EB_IO_WATCHER
			-- Platform independent interface.

	call_back is
			-- Called back by the implementation when the
			-- file/pipe is changed.
		do
			-- We just call the action if any.
			if action /= Void then
				action.call(no_arg)
			end
		end

	no_arg: TUPLE is
			-- Empty tuple to speed up `call_back'.
		once
			create Result.make
		end

feature {NONE} -- Externals

	win_ioh_make_client (callback_feature: POINTER; obj: like Current; delay: INTEGER) is
			-- Make the io handler function
		external
			"C"
		end

end -- EB_IO_WATCHER_IMP


