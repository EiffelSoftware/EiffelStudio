indexing
	description:
		"Semaphore synchronization object, allows threads to access global %
		%data through critical sections."
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
			count_positive:	a_count >= 0
		do
			count := a_count
		end

	count: INTEGER
			-- Semaphore count

	wait is
			-- Decrement semaphore count, waiting if necessary until 
			-- that becomes possible.
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

	try_wait: BOOLEAN is
			-- Has client been successful in decrementing semaphore
			-- count without waiting?
		do
			Result := wait_with_timeout (0)
		end

	post is
			-- Increment semaphore count.
		do
			{MONITOR}.enter (Current)
			count := count + 1
			{MONITOR}.pulse (Current)
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

feature -- Access

	is_set: BOOLEAN is
			-- Is mutex initialized?
		do
			Result := True
		end

end -- class SEMAPHORE

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

