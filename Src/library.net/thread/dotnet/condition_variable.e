indexing
	description: "Class describing a condition variable."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONDITION_VARIABLE

creation
	make

feature -- Initialization

	make is
			-- Create and initialize condition variable.
		do
			cv_waiters_count := 0
			cv_was_broadcast := False
			create cv_sema.make (0)
			create cv_waiters_lock
			create cv_waiters_done.make (False)
			is_set := True
		end

feature -- Access

	is_set: BOOLEAN
			-- Is Current initialized ?

feature -- Status setting

	signal is
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

	broadcast is
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

	wait (a_mutex: MUTEX) is
			-- Block calling thread on current condition variable.
		require
			valid_pointer: is_set
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

	wait_with_timeout (a_mutex: MUTEX; a_timeout: INTEGER): BOOLEAN is
			-- Block calling thread on current condition variable.
			--| Return `True' is we got the condition variable on time
			--| Otherwise return `False'
		require
			is_set: is_set
			a_mutex_not_void: a_mutex /= Void
		local
			l_set_signal_succeed: BOOLEAN
			l_wait_with_timeout_succeed: BOOLEAN
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
			
--			if l_wait_with_timeout_succeed and then cv_waiters_lock.try_lock then 
--				--| If we got the sema before the timeout
--				--| and then we got the lock right away, we got the
--				--| `condition_var' on time
--				Result := True
--			else
--				--| Otherwise we passed the timeout and we continue as usual
--				--| since we already got the `cv_sema'
--				Result := False
--			end
			
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

feature {NONE} -- Implementation

	cv_waiters_count: INTEGER
	cv_sema: SEMAPHORE
	cv_was_broadcast: BOOLEAN
	cv_waiters_done: AUTO_RESET_EVENT
	cv_waiters_lock: MUTEX

end -- class CONDITION_VARIABLE
