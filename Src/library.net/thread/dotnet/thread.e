indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	THREAD

inherit
	THREAD_CONTROL
		redefine
			thread_imp, internal_thread_id
		end

feature -- Initialization

	execute is
		deferred
		end

	launch is
		do
			create thread_imp.make (create {SYSTEM_THREAD_START}.make (Current, $call_execute))
			thread_imp.start
			add_children (Current)
		end

	launch_with_attributes (attr: THREAD_ATTRIBUTES) is
			-- Initialize a new thread running `execute', using attributes.
		local
			l_priority: INTEGER
--			l_policy: INTEGER
			l_detached: INTEGER
		do
			l_priority 	:= attr.priority
--			l_policy 	:= attr.scheduling_policy
			l_detached 	:= attr.detached

			create thread_imp.make (create {SYSTEM_THREAD_START}.make (Current, $call_execute))

			--| Set attributes
			thread_imp.set_priority (feature {SYSTEM_THREAD_PRIORITY}.from_integer (l_priority))
			thread_imp.set_is_background (l_detached)

			thread_imp.start
			add_children (Current)
		end
		
	thread_id: INTEGER is
		do
			Result := internal_thread_id
		end

feature -- Implementation

	frozen call_execute is
		do
			internal_thread_id := current_thread_id
			execute
--			remove_children_creation (Current)
		end

	internal_thread_id: INTEGER

	thread_imp: SYSTEM_THREAD

end -- class THREAD
