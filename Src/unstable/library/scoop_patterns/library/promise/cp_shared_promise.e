note
	description: "Promise implementation that can be shared between two processors."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	CP_SHARED_PROMISE

inherit

	CP_PROMISE

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			is_terminated := False
			is_exceptional := False
			is_cancelled := False
			create change_event.make
		ensure
			not_terminated: not is_terminated
			not_exceptional: not is_exceptional
			not_cancelled: not is_cancelled
			no_trace: last_exception_trace = Void
		end

feature -- Access

	last_exception_trace: detachable READABLE_STRING_32
			-- <Precursor>

	progress: DOUBLE
			-- <Precursor>

	change_event: CP_EVENT [detachable TUPLE]
			-- Event source for change notifications.
			-- A subscribed agent should not take any arguments.

feature -- Status report

	is_terminated: BOOLEAN
			-- <Precursor>

	is_exceptional: BOOLEAN
			-- <Precursor>

	is_cancelled: BOOLEAN
			-- <Precursor>

feature -- Basic operations

	cancel
			-- <Precursor>
		do
			is_cancelled := True
		ensure then
			cancelled: is_cancelled
		end

	terminate
			-- Declare the asynchronous operation as terminated.
		do
			is_terminated := True
			change_event.publish (Void)
		ensure
			terminated: is_terminated
		end

	set_progress (a_progress: like progress)
			-- Set `progress' to `a_progress'.
		require
			valid: 0.0 <= a_progress and a_progress <= 1.0
		do
			progress := a_progress
			change_event.publish (Void)
		ensure
			progress_set: progress = a_progress
		end

	set_exception_and_terminate (a_exception: separate EXCEPTION)
			-- Declare the asynchronous operation as exceptional and set the exception trace.
		do
			fixme ("TODO: Properly import an exception.")

			is_exceptional := True
			terminate

			if attached a_exception.trace as l_trace then
				create {STRING_32} last_exception_trace.make_from_separate (l_trace)
			end
		ensure
			exceptional: is_exceptional
			trace_set: attached a_exception.trace implies attached last_exception_trace
		end

invariant
	exception_implies_terminated: is_exceptional implies is_terminated
	trace_implies_exceptional: attached last_exception_trace implies is_exceptional
end
