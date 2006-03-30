indexing
	description:
		"Semaphore synchronization object, allows threads to access global %
		%data through critical sections."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SEMAPHORE

create
	make

feature -- Initialization

	make (a_count: INTEGER) is
			-- Create semaphore.
		require
			thread_capable: {PLATFORM}.is_thread_capable
			count_positive:	a_count >= 0
		do
			count := a_count
		ensure
			is_set: is_set
		end

feature -- Access

	is_set: BOOLEAN is
			-- Is mutex initialized?
		do
			Result := count >= 0
		end

feature -- Status setting

	try_wait: BOOLEAN is
			-- Has client been successful in decrementing semaphore
			-- count without waiting?
		require
			valid_semaphore: is_set
		do
			Result := wait_with_timeout (0)
		end

	wait is
			-- Decrement semaphore count, waiting if necessary until
			-- that becomes possible.
		require
			valid_semaphore: is_set
		local
			dummy_boolean: BOOLEAN
		do
			{MONITOR}.enter (Current)
			from
			until
				count > 0
			loop
				dummy_boolean := {MONITOR}.wait (Current)
				check
					dummy_boolean
				end
			end
			count := count - 1
			{MONITOR}.exit (Current)
		rescue
			{MONITOR}.exit (Current)
		end

	post is
			-- Increment semaphore count.
		require
			valid_semaphore: is_set
		do
			{MONITOR}.enter (Current)
			count := count + 1
			{MONITOR}.pulse (Current)
			{MONITOR}.exit (Current)
		rescue
			{MONITOR}.exit (Current)
		end

	destroy is
			-- Destroy semaphore.
		require
			valid_semaphore: is_set
		do
			count := -1
		end

feature {CONDITION_VARIABLE} -- Implementation

	wait_with_timeout (a_timeout: INTEGER): BOOLEAN is
			-- Has client been successful in decrementing semaphore
			-- count with only `a_timeout' ?
		local
		do
			{MONITOR}.enter (Current)
			Result := (count > 0) 
				and then {MONITOR}.wait (Current, a_timeout)
			if Result then
				count := count - 1
			end
			{MONITOR}.exit (Current)
		rescue
			{MONITOR}.exit (Current)
		end

	post_count (nb: INTEGER) is
			-- Increment semaphore count by `nb'.
		require
			nb > 0
		do
			{MONITOR}.enter (Current)
			count := count + nb
			{MONITOR}.pulse (Current)
			{MONITOR}.exit (Current)
		rescue
			{MONITOR}.exit (Current)
		end

feature {NONE} -- Implementation

	count: INTEGER
			-- Semaphore count.

invariant
	is_thread_capable: {PLATFORM}.is_thread_capable

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


end -- class SEMAPHORE

