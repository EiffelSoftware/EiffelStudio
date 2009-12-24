note
	description: "[
		Condition variables allow threads to synchronize based on the content of a shared data, whereas
		mutexes only synchronize access to the data. In other words, a condition variable is a
		synchronization object that enables threads to wait until a particular condition occurs.

		When a thread executes a `wait' call on a condition variable, it must hold an associated `mutex'
		(used for checking that condition). Then, it is immediately suspended and put into the waiting
		queue. The thread is suspended and is waiting for the condition to occur.

		Eventually, when the condition has occurred, a thread will `signal' it. Two possible scenarios:
		- if there are threads waiting, then one of the waiting thread will resume its execution and
		  will get the `mutex' in a locked state.
		- if there are no threads waiting, nothing is done

		For the simple usage of a condition variable, it is very similar to using a semaphore.

		In addition you have `broadcast' that will resume all waiting threads at once, and
		`wait_with_timeout' that will wait only a certain amount of time before abandonning the wait.

		The `signal' and `broadcast' routines can be called by a thread whether or not it currently owns
		the mutex that threads calling `wait' or `wait_with_timeout' have associated with the condition
		variable during their waits. If, however, predictable scheduling behavior is required, then that
		mutex should be locked by the thread prior to calling `signal' or `broadcast'.

		Assuming `shared_data' an INTEGER initially set to zero, then a typical usage of condition variable
		to wait until `shared_data' becomes one, could be written as followed in thread A:

			mutex.lock
			from
			until
				shared_data = 1
			loop
				condition_variable.wait
			end
			mutex.unlock

		and in thread B:

			mutex.lock
			shared_data := 1
			condition_variable.signal
			mutex.unlock

		Thread A will be blocked until thread B signal that now `shared_data' is 1.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONDITION_VARIABLE

create
	make

feature -- Initialization

	make
			-- Create and initialize condition variable.
		require
			thread_capable: {PLATFORM}.is_thread_capable
		do
			cv_waiters_count := 0
			cv_was_broadcast := False
			create cv_sema.make (0)
			create cv_waiters_lock.make
			create cv_waiters_done.make (False)
			is_set := True
		end

feature -- Access

	is_set: BOOLEAN
			-- Is condition variable initialized ?

feature -- Status setting

	signal
			-- Unblock one thread blocked on the current condition variable.
		require
			is_set: is_set
		do
			--| If there aren't any waiters, then this
			--| is a no-op.

			if cv_waiters_count > 0 then
				cv_sema.post
			end
		end

	broadcast
			-- Unblock all threads blocked on the current condition variable.
		require
			is_set: is_set
		local
			l_wait_succeed: BOOLEAN
		do
			if cv_waiters_count > 0 then
				-- We are broadcasting even if there is just one waiter

				--| Record that we are broadcasting.
				--| This helps optimize cond_wait().
				cv_was_broadcast := True

				--| Wake up all the waiters.
				cv_sema.post_count (cv_waiters_count)

				--| Wait for all the awakened threads to
				--| acquire the counting semaphore.
				l_wait_succeed := cv_waiters_done.wait_one
				check
					l_wait_succeed
				end
				cv_was_broadcast := False
			end
		end

	wait (a_mutex: MUTEX)
			-- Block calling thread on current condition variable.
		require
			is_set: is_set
			a_mutex_not_void: a_mutex /= Void
		local
			l_set_signal_succeed: BOOLEAN
		do
			--| It's ok to increment the number
			--| of waiters since <a_mutex>
			--| must be locked by the caller.
			cv_waiters_count := cv_waiters_count + 1

			--| Keep the lock held just long enough to
			--| increment the count of waiters by one.
			--| We can't keep it held across the call
			--| to SEMAPHORE.wait() since that will
			--| deadlock other calls to `cond_signal'
			--| and `cond_broadcast'.

			-- Release Mutex
			a_mutex.unlock

			--| Wait to be awakened by a `cond_signal' or
			--| `cond_broadcast'.
			cv_sema.wait

			--| Reacquire lock to avoid race conditions
			cv_waiters_lock.lock

			--| We're no longer waiting...
			cv_waiters_count := cv_waiters_count - 1

			--| If we're the last waiter thread
			--| during this particular broadcast then
			--| let all the other threads proceed.
			if cv_was_broadcast and then cv_waiters_count = 0 then
				l_set_signal_succeed := cv_waiters_done.set
				check
					l_set_signal_succeed
				end
			end
			cv_waiters_lock.unlock

			--| Always regain the external mutex since that's
			--| the guarantee that we give to our callers.
			a_mutex.lock
		end

	wait_with_timeout (a_mutex: MUTEX; a_timeout: INTEGER): BOOLEAN
			-- Block calling thread on current condition variable for at most `a_timeout' milliseconds.
			--| Return `True' is we got the condition variable on time
			--| Otherwise return `False'
		require
			is_set: is_set
			a_mutex_not_void: a_mutex /= Void
			timeout_positive: a_timeout >= 0
		local
			l_set_signal_succeed: BOOLEAN
		do
			--| It's ok to increment the number
			--| of waiters since <a_mutex>
			--| must be locked by the caller.
			cv_waiters_count := cv_waiters_count + 1

			--| Keep the lock held just long enough to
			--| increment the count of waiters by one.
			--| We can't keep it held across the call
			--| to SEMAPHORE.wait() since that will
			--| deadlock other calls to `cond_signal'
			--| and `cond_broadcast'.

			-- Release Mutex
			a_mutex.unlock

			--| Wait to be awakened by a `cond_signal' or `cond_broadcast'.
			--| but until `a_timeout'
			Result := cv_sema.wait_with_timeout (a_timeout)

			--| Reacquire lock to avoid race conditions
			cv_waiters_lock.lock

			--| We're no longer waiting...
			cv_waiters_count := cv_waiters_count - 1

			--| If we're the last waiter thread
			--| during this particular broadcast then
			--| let all the other threads proceed.
			if cv_was_broadcast and then cv_waiters_count = 0 then
				l_set_signal_succeed := cv_waiters_done.set
				check
					l_set_signal_succeed
				end
			end
			cv_waiters_lock.unlock

			--| Always regain the external mutex since that's
			--| the guarantee that we give to our callers.
			a_mutex.lock
		end

	destroy
			-- Destroy condition variable
		require
			is_set: is_set
		do
			cv_sema.destroy
			cv_waiters_done.close
			cv_waiters_lock.destroy
		end

feature {NONE} -- Implementation

	cv_waiters_count: INTEGER
	cv_sema: SEMAPHORE
	cv_was_broadcast: BOOLEAN
	cv_waiters_done: AUTO_RESET_EVENT
	cv_waiters_lock: MUTEX;

invariant
	is_thread_capable: {PLATFORM}.is_thread_capable

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"


end -- class CONDITION_VARIABLE

