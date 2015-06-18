note
	description: "Utility functions to perform operations on a {separate CP_PROMISE} object."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_PROMISE_UTILS

feature -- Access

	promise_last_exception_trace (a_promise: separate CP_PROMISE): detachable separate READABLE_STRING_32
			-- Last exception trace in `a_promise'.
		do
			Result := a_promise.last_exception_trace
		ensure
			correct: Result = a_promise.last_exception_trace
		end

	promise_imported_last_exception_trace (a_promise: separate CP_PROMISE): detachable READABLE_STRING_32
			-- Imported exception trace in `a_promise'.
		do
			if attached promise_last_exception_trace (a_promise) as l_trace then
				create {STRING_32} Result.make_from_separate (l_trace)
			end
		ensure
			correct: Result ~ a_promise.last_exception_trace
		end

	promise_progress (a_promise: separate CP_PROMISE): DOUBLE
			-- Progress in `a_promise'.
		do
			Result := a_promise.progress
		end

	promise_change_event (a_promise: separate CP_SHARED_PROMISE): separate CP_EVENT [detachable TUPLE]
			-- Change event in `a_promise'.
		do
			Result := a_promise.change_event
		end

feature -- Status report

	is_promise_terminated (a_promise: separate CP_PROMISE): BOOLEAN
			-- Is `a_promise' terminated?
		do
			Result := a_promise.is_terminated
		end

	is_promise_cancelled (a_promise: separate CP_PROMISE): BOOLEAN
			-- Is `a_promise' cancelled?
		do
			Result := a_promise.is_cancelled
		end

	is_promise_exceptional (a_promise: separate CP_PROMISE): BOOLEAN
			-- Is `a_promise' exceptional?
		do
			Result := a_promise.is_exceptional
		end

feature -- Basic operations

	promise_cancel (a_promise: separate CP_PROMISE)
			-- Cancel `a_promise'.
		do
			a_promise.cancel
		end

	promise_terminate (a_promise: separate CP_SHARED_PROMISE)
			-- Terminate `a_promise'.
		do
			a_promise.terminate
		end

	promise_set_exception_and_terminate (a_promise: separate CP_SHARED_PROMISE; a_exception: separate EXCEPTION)
			-- Set `a_exception' in `a_promise'.
		do
			a_promise.set_exception_and_terminate (a_exception)
		end

	promise_set_progress (a_promise: separate CP_SHARED_PROMISE; a_progress: DOUBLE)
			-- Set `a_progress' in `a_promise'.
		require
			valid: 0.0 <= a_progress and a_progress <= 1.0
		do
			a_promise.set_progress (a_progress)
		end

	promise_await_termination (a_promise: separate CP_PROMISE)
			-- Wait until `a_promise' has terminated
		require
			a_promise.is_terminated
		do
		end

feature -- Factory functions

	new_promise: CP_SHARED_PROMISE
			-- Create a new promise on the local processor.
		do
			create Result.make
		end

end
