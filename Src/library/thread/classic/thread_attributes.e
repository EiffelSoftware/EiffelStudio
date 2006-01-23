indexing
	description:
		"Class defining thread attributes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	THREAD_ATTRIBUTES

create
	make

feature {NONE} -- Initialization

	make is
			-- Set default values to the thread attributes.
		do
			priority := default_priority
			scheduling_policy := default_policy
			detached := True
		end

feature -- Attribute change

	set_priority (prio: INTEGER) is
			-- Set thread priority to `prio'.
		require
			valid_priority:	(prio >= min_priority) and (prio <= max_priority)
		do
			priority := prio
		end

	set_policy (policy: INTEGER) is
			-- Set scheduling policy to `policy'.  Possible values are:
			-- default_policy, other, fifo and round_robin.
		require
			valid_policy: (policy >= 0) and (policy <= 3)
		do
			scheduling_policy := policy
		end

	set_detached (bool: BOOLEAN) is
			-- Set the detached state of the thread attribute to `bool'. If
			-- `bool' is True (default), the thread will be created detached
			-- on the C level. You can always `join' a thread, even if it was
			-- created detached. This only affects the C join().
		do
			detached := bool
		end

feature -- Access

	priority: INTEGER

	scheduling_policy: INTEGER

	detached: BOOLEAN

feature -- Implementation for scheduling_policy

	default_policy: INTEGER is 0

	other: INTEGER is 1

	fifo: INTEGER is 2

	round_robin: INTEGER is 3

feature -- Externals

	default_priority: INTEGER is
			-- Get default thread priority for the current architecture.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_default_priority"
		end

	min_priority: INTEGER is
			-- Get minimum thread priority for the current architecture.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_min_priority"
		end

	max_priority: INTEGER is
			-- Get maximum thread priority for the current architecture.
		external
			"C | %"eif_threads.h%""
		alias
			"eif_thr_max_priority"
		end

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




end -- class THREAD_ATTRIBUTES

