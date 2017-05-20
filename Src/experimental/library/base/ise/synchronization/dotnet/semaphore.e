note
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

feature {NONE} -- Initialization

	make (a_count: INTEGER)
			-- Create semaphore with an initial count of `a_count'
			-- allow `a_count' threads to go into a critical section.
		require
			count_positive:	a_count >= 0
		do
			create semaphore.make (a_count, {INTEGER}.max_value)
			is_set := True
		ensure
			is_set: is_set
		end

feature -- Access

	is_set: BOOLEAN
			-- Is mutex initialized?

feature -- Status setting

	try_wait: BOOLEAN
			-- Has client been successful in decrementing semaphore
			-- count without waiting?
		require
			valid_semaphore: is_set
		do
			Result := semaphore.wait_one (0, False)
		end

	wait
			-- Decrement semaphore count, waiting if necessary until
			-- that becomes possible.
		require
			valid_semaphore: is_set
		do
			semaphore.wait_one.do_nothing
		end

	post
			-- Increment semaphore count.
		require
			valid_semaphore: is_set
		do
			semaphore.release.do_nothing
		end

	destroy
			-- Destroy semaphore.
		require
			valid_semaphore: is_set
		do
			semaphore.close
			is_set := False
		ensure
			not_set: not is_set
		end

feature -- Obsolete

	trywait: BOOLEAN
			-- Has client been successful in decrementing semaphore
			-- count without waiting?
		obsolete
			"Use try_wait instead. [2017-05-31]"
		require
			valid_semaphore: is_set
		do
			Result := try_wait
		end

feature {CONDITION_VARIABLE} -- Implementation

	wait_with_timeout (a_timeout: INTEGER): BOOLEAN
			-- Has client been successful in decrementing semaphore
			-- count with only `a_timeout' ?
		do
			Result := semaphore.wait_one (a_timeout, False)
		end

	post_count (nb: INTEGER)
			-- Increment semaphore count by `nb'.
		require
			nb > 0
		do
			semaphore.release (nb).do_nothing
		end

feature {NONE} -- Implementation

	semaphore: SYSTEM_DLL_SEMAPHORE;
			-- .NET reference to the mutex.

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
