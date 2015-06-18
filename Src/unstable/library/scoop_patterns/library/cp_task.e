note
	description: "Operations that can be copied across processor boundaries."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CP_TASK

inherit

	CP_STARTABLE

	CP_IMPORTABLE

	CP_PROMISE_UTILS

feature {CP_DYNAMIC_TYPE_IMPORTER}-- Initialization

	make_from_separate (other: separate like Current)
			-- Initialize `Current' from `other'.
		deferred
		ensure then
			same_token: promise = other.promise
		end

feature -- Access

	promise: detachable separate CP_SHARED_PROMISE
			-- A promise object to update the status of the current task.
		deferred
		end

feature -- Element change

	set_promise (a_promise: like promise)
			-- Set `promise' to `a_promise'.
		deferred
		ensure
			promise_set: promise = a_promise
		end

feature -- Basic operations

	frozen start
			-- Start the current task.
		local
			l_retried: BOOLEAN
			l_exception_manager: EXCEPTION_MANAGER
		do
			if not l_retried then
				run
				if attached promise as l_promise then
					promise_terminate (l_promise)
				end
			end
		rescue
			l_retried := True
			create l_exception_manager

			if
				attached l_exception_manager.last_exception as l_exception
				and	attached promise as l_promise
			then
				promise_set_exception_and_terminate (l_promise, l_exception)
			end

			retry
		end

	run
			-- Run the current task.
		deferred
		end

end
