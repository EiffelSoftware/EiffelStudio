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
			-- Are there no more test left to execute?
		do
			Result := status = finished_status_code
		end

feature {NONE} -- Status report

	is_termination_forced: BOOLEAN
			-- Is next evaluator termination forced?

	status: NATURAL
			-- Current status

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
			if not is_finished then
				status := listening_status_code
				is_termination_forced := False
			end
			queue_mutex.unlock
		end

	set_disconnected
			-- Set `is_disconnected' to True if not fininshed.
		do
			queue_mutex.lock
			if not is_finished then
				status := disconnected_status_code
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

	fetch_next (a_outcome: ?EQA_TEST_OUTCOME): NATURAL
			-- Index of next test to be executed
			--
			-- `a_outcome': Outcome of current test
		local
			l_first: like fetch_progress
			l_needs_outcome, l_new: BOOLEAN
			l_attempt: NATURAL
		do
			queue_mutex.lock
			status := connected_status_code
			if not status_queue.is_empty then
				l_first := status_queue.first
				l_needs_outcome := l_first.outcome = Void
			end
			check
				valid_argument: (a_outcome /= Void) implies (l_needs_outcome)
			end
			l_new := True
			if l_needs_outcome then
				if a_outcome /= Void then
					l_first.outcome := a_outcome
				else
					Result := l_first.index
					if is_termination_forced then
						if execution_assigner.is_aborted (l_first.index) then
							status_queue.remove_first
						else
								-- In this case the evaluator was already testing the next test, so we will simply relaunch
								-- it.
							l_new := False
						end
					else
						if l_first.attempts >= max_attempts then
							l_first.outcome := create {EQA_TEST_OUTCOME}.make_without_response (create {DATE_TIME}.make_now, False)
						else
							l_first.attempts := l_first.attempts + 1
							l_new := False
						end
					end
				end
			end
			if l_new then
				check
					valid_queue_state: status_queue.is_empty or else l_first.outcome /= Void
				end
				Result := execution_assigner.next_test
				if Result = 0 then
					status := finished_status_code
				else
					l_attempt := 1
					status_queue.put_first ([Result, Void, l_attempt])
				end
			end
			queue_mutex.unlock
		end

feature {EIFFEL_TEST_EXECUTOR_I} -- Basic operations

	fetch_progress: !TUPLE [index: like fetch_next; outcome: ?EQA_TEST_OUTCOME; attempts: NATURAL]
			-- Retrieve current status
			--
			-- Note: `fetch_progress' might return information about tests which have been aborted.
		local
			l_zero: NATURAL
		do
			queue_mutex.lock
			if not status_queue.is_empty then
				Result := status_queue.last
				if Result.outcome /= Void then
					status_queue.remove_last
				else
					Result := Result.twin
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
	finished_status_code: NATURAL = 4

end
