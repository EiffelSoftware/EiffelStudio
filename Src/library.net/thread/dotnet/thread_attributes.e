indexing
	description:
		"Class defining thread attributes."
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
			-- Not implemented under dotnet
		do
			scheduling_policy := policy
		end

	set_detached (bool: BOOLEAN) is
			-- Set the detached state of the thread attribute to `bool'. If
			-- `bool' is True (default), the thread will be created detached
			-- on the C level. You can always `join' a thread, even if it was
			-- created detached. This only affects the C join().
			--| under dotnet ~ Thread.isBackground
		do
			detached := bool
		end

feature -- Access

	priority: INTEGER

	scheduling_policy: INTEGER

	detached: BOOLEAN

feature -- Implementation for scheduling_policy

	default_policy: INTEGER is 0

--	other: INTEGER is 1
--
--	fifo: INTEGER is 2
--
--	round_robin: INTEGER is 3

feature -- Externals

	default_priority: INTEGER is
			-- Get default thread priority for the current architecture.
		do
			Result := {THREAD_PRIORITY}.normal.to_integer
		end

	min_priority: INTEGER is
			-- Get minimum thread priority for the current architecture.
		do
			Result := {THREAD_PRIORITY}.lowest.to_integer
		end

	max_priority: INTEGER is
			-- Get maximum thread priority for the current architecture.
		do
			Result := {THREAD_PRIORITY}.highest.to_integer
		end

end -- class THREAD_ATTRIBUTES

--|----------------------------------------------------------------
--| EiffelThread: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

