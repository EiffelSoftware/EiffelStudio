indexing
	description: "[
		Objects representing testing progress of an evaluator. Since result retreival is done in a
		separate thread, mutexes are used to controll access.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

frozen class
	EIFFEL_TEST_EVALUATOR_STATUS

create
	make

feature {NONE} -- Initialization

	make (a_execution_assigner: like execution_assigner)
			-- Initialize `Current'.
			--
			-- `a_execution_assigner': Assigner for retrieving tests to be executed.
		do
			execution_assigner := a_execution_assigner
			max_attempts := 2
			create status_queue.make
			create queue_mutex.make
		ensure
			not_connected: not is_connected
			not_finished: not is_finished
			execution_status_set: execution_assigner = a_execution_assigner
		end

feature -- Access

	max_attempts: NATURAL
			-- Number of times a test will be relaunched after crashing the evaluator

feature {NONE} -- Access

	execution_assigner: !EIFFEL_TEST_EXECUTION_ASSIGNER
			-- Assigner for retrieving tests to be executed

	status_queue: !DS_LINKED_LIST [like fetch_progress]
			-- Queue containing evaluator progress

	queue_mutex: !MUTEX
			-- Mutex for controlling access to `status_queue'

feature -- Status report

	is_listening: BOOLEAN
			-- Is result receiver waiting for connection?
		do
			Result := status = listening_status_code
		end

	is_connected: BOOLEAN
			-- Is result receiver currently connected to evaluator?
		do
			Result := status = connected_status_code
		end

	is_disconnected: BOOLEAN
			-- Has evaluator closed connection to result receiver?
		do
			Result := status = disconnected_status_code
		end

	is_finished: BOOLEAN
			-- Have all outcomes been received and is there no new test to be executed?

feature {NONE} -- Status report

	is_termination_forced: BOOLEAN
			-- Is next evaluator termination forced?

	status: NATURAL
			-- Current status

	is_expecting_outcome: BOOLEAN
			-- Is `status_queue' expecting an outcome?
		do
			Result := not status_queue.is_empty and then status_queue.first.outcome = Void
		end

feature -- Status setting

	set_max_attempts (a_max_attempts: like max_attempts)
			-- Set total number of times `Current' will launch a test if test crashed evaluator.
		require
			a_max_attempts_positive: a_max_attempts > 0
		do
			max_attempts := a_max_attempts
		end

feature {EIFFEL_TEST_RESULT_RECEIVER} -- Status setting

	set_listening
			-- Set `is_listening' to True if not finished.
		do
			queue_mutex.lock
			status := listening_status_code
			if not is_finished then
				if not is_expecting_outcome then
					is_finished := execution_assigner.has_next
				end
				is_termination_forced := False
			end
			queue_mutex.unlock
		end

	set_disconnected
			-- Set `is_disconnected' to True if not fininshed.
		local
			l_first: like fetch_progress
		do
			queue_mutex.lock
			status := disconnected_status_code
			if not is_finished then
				if is_expecting_outcome then
					l_first := status_queue.first
					if is_termination_forced then
						if execution_assigner.is_aborted (l_first.index) then
							status_queue.remove_first
							assign_next
						else
							-- In this case the evaluator was already testing the next test, so the termination occurred
							--     to late so we will simply relaunch it. In this case we do nothing and simply continue
						end
					else
						if l_first.attempts >= max_attempts then
							l_first.outcome := create {EQA_TEST_OUTCOME}.make_without_response (create {DATE_TIME}.make_now, False)
							assign_next
						else
							l_first.attempts := l_first.attempts + 1
						end
					end
				end
			end
			queue_mutex.unlock
		end

feature {EIFFEL_TEST_EXECUTOR_I} -- Status setting

	set_forced_termination
			-- Set `is_termination_forced' to True.
		do
			is_termination_forced := True
		end

feature {EIFFEL_TEST_RESULT_RECEIVER} -- Status setting

	next: NATURAL
			-- Index of next test to be executed
		do
			queue_mutex.lock
			status := connected_status_code
			if not is_expecting_outcome then
				assign_next
			end
			if not is_finished then
				Result := status_queue.first.index
			end
			queue_mutex.unlock
		end

	put_outcome (a_outcome: !EQA_TEST_OUTCOME)
			-- Add `a_outcome' to `status_queue'.
		do
			queue_mutex.lock
			if is_expecting_outcome then
					-- We assume the provider of this outcome object no longer accesses it,
					-- otherwise it would be safer to create a copy of if.
				status_queue.first.outcome := a_outcome
				assign_next
			end
			queue_mutex.unlock
		end

feature {NONE} -- Status setting

	assign_next
			-- Retrieve next index from `execution_assigner' and add it to `status_queue'. If not new index
			-- available, set `is_finished' to True.
		require
			not_expecting_outcome: not is_expecting_outcome
		local
			l_next: NATURAL
		do
			l_next := execution_assigner.next_test
			if l_next = 0 then
				is_finished := True
			else
				status_queue.put_first ([l_next, Void, {NATURAL} 1])
			end
		ensure
			finished_or_expecting_outcome: is_finished or is_expecting_outcome
		end

feature {EIFFEL_TEST_EXECUTOR_I} -- Basic operations

	fetch_progress: !TUPLE [index: like next; outcome: ?EQA_TEST_OUTCOME; attempts: NATURAL]
			-- Retrieve current status
			--
			-- Note: `fetch_progress' might return information about tests which have been aborted.
		local
			l_zero: NATURAL
		do
			queue_mutex.lock
			if not status_queue.is_empty then
					-- Note: twin is important here to avoid accesses from different threads
				Result := status_queue.last.twin
				if Result.outcome /= Void then
					status_queue.remove_last
				end
			else
				l_zero := 0
				Result := [l_zero, Void, l_zero]
			end
			queue_mutex.unlock
		end

feature {NONE} -- Constants

	listening_status_code: NATURAL = 1
	connected_status_code: NATURAL = 2
	disconnected_status_code: NATURAL = 3

end
