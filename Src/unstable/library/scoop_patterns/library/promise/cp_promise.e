note
	description: "Handle to an asynchronous operation. This class defines the interface for the task submitter."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_PROMISE

feature -- Access

--	last_exception: detachable EXCEPTION
--			-- The last exception in the asynchronous call, if any.

	last_exception_trace: detachable READABLE_STRING_32
			-- The exception trace of the last exception.
		deferred
		ensure
			trace_implies_exceptional: attached Result implies is_exceptional
		end

	progress: DOUBLE
			-- The current progress of the asynchronous operation.
			-- The result is a value between 0.0 and 1.0.
			-- Note: Progress indication has to be supported by the asynchronous operation.
		deferred
		ensure
			valid:0.0 <= progress and progress <= 1.0
		end

feature -- Status report

	is_terminated: BOOLEAN
			-- Has the asynchronous operation terminated?
		deferred
		end


	is_successfully_terminated: BOOLEAN
			-- Has the asynchronous operation terminated without an exception?
		do
			Result := is_terminated and then not is_exceptional
		end


	is_exceptional: BOOLEAN
			-- Has there been an exception in the asynchronous call?
		deferred
		ensure
			exception_implies_terminated: Result implies is_terminated
		end

	is_cancelled: BOOLEAN
			-- Has there been a cancellation request?
		deferred
		end

feature -- Basic operations

	cancel
			-- Request a cancellation.
			-- Note: Cacellation has to be supported by the asynchronous operation.
		deferred
		end

end
