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
			thread_imp
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
			l_priority: SYSTEM_THREAD_PRIORITY
		do

			create thread_imp.make (create {SYSTEM_THREAD_START}.make (Current, $call_execute))

			--| Set attributes
			thread_imp.set_priority (l_priority.from_integer (attr.priority))
			thread_imp.set_is_background (attr.detached)

			thread_imp.start
			add_children (Current)
		end
		
	thread_id: INTEGER

feature -- Implementation

	frozen call_execute is
		do
			thread_id := current_thread_id
			execute
--			remove_children_creation (Current)
		end

	thread_imp: SYSTEM_THREAD

end -- class THREAD
