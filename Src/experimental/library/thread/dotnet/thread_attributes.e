note
	description: "Class defining thread attributes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_ATTRIBUTES

create
	make

feature {NONE} -- Initialization

	make
			-- Set default values to the thread attributes.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		do
			set_priority (default_priority)
			set_stack_size (0)
		ensure
			priority_set: priority = default_priority
			stack_size_set: stack_size = 0
		end

feature -- Attribute change

	set_priority (prio: like priority)
			-- Set thread priority to `prio'.
		require
			valid_priority:	(prio >= min_priority) and (prio <= max_priority)
		do
			priority := prio
		ensure
			priority_set: priority = prio
		end

	set_stack_size (s: like stack_size)
			-- Set `stack_size' to `s'.
		do
			stack_size := s
		ensure
			stack_size_set: stack_size = s
		end

feature -- Access

	priority: INTEGER
			-- Current thread priority

	stack_size: NATURAL_64
			-- Size of the call stack reserved for launching the thread. If `0' the default size for
			-- the current platform.

	default_priority: INTEGER
			-- Get default thread priority for the current architecture.
		do
			Result := {THREAD_PRIORITY}.normal.to_integer
		end

	min_priority: INTEGER
			-- Get minimum thread priority for the current architecture.
		do
			Result := {THREAD_PRIORITY}.lowest.to_integer
		end

	max_priority: INTEGER
			-- Get maximum thread priority for the current architecture.
		do
			Result := {THREAD_PRIORITY}.highest.to_integer
		end

feature -- Obsolete: Not applicable

	set_policy (policy: INTEGER)
			-- Set scheduling policy to `policy'.  Possible values are:
			-- default_policy, other, fifo and round_robin.
		obsolete
			"Removed because calls where not portable."
		require
			valid_policy: (policy >= default_policy) and (policy <= round_robin)
		do
		end

	set_detached (bool: BOOLEAN)
			-- Set the detached state of the thread attribute to `bool'. If
			-- `bool' is True (default), the thread will be created detached
			-- on the C level. You can always `join' a thread, even if it was
			-- created detached. This only affects the C join().
		obsolete
			"Removed because now threads are always started detached."
		do
		end

	scheduling_policy: INTEGER
		obsolete
			"Removed because calls where not portable."
		do
		end

	detached: BOOLEAN
		obsolete
			"Removed because calls where not portable."
		do
		end

	default_policy: INTEGER
		obsolete
			"Removed because calls where not portable."
		do
			Result := 0
		end

	other: INTEGER
		obsolete
			"Removed because calls where not portable."
		do
			Result := 1
		end

	fifo: INTEGER
		obsolete
			"Removed because calls where not portable."
		do
			Result := 2
		end

	round_robin: INTEGER
		obsolete
			"Removed because calls where not portable."
		do
			Result := 3
		end

invariant
	priority_bounded: min_priority <= priority and priority <= max_priority

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

