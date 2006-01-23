indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			create thread_imp.make (create {THREAD_START}.make (Current, $call_execute))
			thread_imp.start
			add_children (Current)
		end

	launch_with_attributes (attr: THREAD_ATTRIBUTES) is
			-- Initialize a new thread running `execute', using attributes.
		local
			l_priority: THREAD_PRIORITY
		do

			create thread_imp.make (create {THREAD_START}.make (Current, $call_execute))

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

	thread_imp: SYSTEM_THREAD;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class THREAD

