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
			feature {MONITOR}.enter (Current)
			from
			until
				count > 0
			loop
				dummy_boolean := feature {MONITOR}.wait (Current)
				check
					dummy_boolean
				end
			end
			count := count - 1
			feature {MONITOR}.exit (Current)
		rescue
			feature {MONITOR}.exit (Current)
		end

	wait_with_timeout (a_timeout: INTEGER): BOOLEAN is
			-- Has client been successful in decrementing semaphore
			-- count with only `a_timeout' ?
		local
		do
			feature {MONITOR}.enter (Current)
			Result := (count > 0) 
				and then feature {MONITOR}.wait (Current, a_timeout)
			if Result then
				count := count - 1
			end
			feature {MONITOR}.exit (Current)
		rescue
			feature {MONITOR}.exit (Current)
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
			feature {MONITOR}.enter (Current)
			count := count + 1
			feature {MONITOR}.pulse (Current)
			feature {MONITOR}.exit (Current)
		rescue
			feature {MONITOR}.exit (Current)
		end

	post_count (nb: INTEGER) is
			-- Increment semaphore count by `nb'.
		require
			nb > 0
		do
			feature {MONITOR}.enter (Current)
			count := count + nb
			feature {MONITOR}.pulse (Current)
			feature {MONITOR}.exit (Current)
		rescue
			feature {MONITOR}.exit (Current)
		end

feature -- Access

	is_set: BOOLEAN is
			-- Is mutex initialized?
		do
			Result := True
		end

end -- class SEMAPHORE
