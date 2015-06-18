note
	description: "Summary description for {CP_AGENT_TASK_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CP_AGENT_TASK_TESTS

inherit
	EQA_TEST_SET
		redefine
			on_prepare,
			on_clean
		end

feature

	test_do_nothing
		local
			task: CP_AGENT_TASK
			promise: CP_PROMISE_PROXY
		do
			create task.make_safe (agent {SUPPORT}.do_nothing)
			assert ("has_promise", not attached task.promise)

			promise := executor.put_and_get_promise (task)

			assert ("different_promise", task.promise = promise.subject)

			promise.await_termination

			assert ("has_exception", not promise.is_exceptional)
			assert ("not_terminated", promise.is_terminated)

			assert ("executor_count_wrong", executor.worker_count = {CP_GLOBAL_PROCESSORS}.worker_count)
		end

	test_failing
		local
			task: CP_AGENT_TASK
			promise: CP_PROMISE_PROXY
		do
			create task.make_safe (agent {SUPPORT}.failing_agent)
			assert ("has_promise", not attached task.promise)

			promise := executor.put_and_get_promise (task)

			assert ("different_promise", task.promise = promise.subject)

			promise.await_termination

			assert ("no_exception", promise.is_exceptional)
			assert ("trace_not_available", attached promise.last_exception_trace)

			assert ("executor_count_wrong", executor.worker_count = {CP_GLOBAL_PROCESSORS}.worker_count)
		end

	test_fibonacci
		local
			task: CP_AGENT_COMPUTATION [INTEGER_64]
			future_executor: CP_FUTURE_EXECUTOR_PROXY [INTEGER_64, CP_NO_IMPORTER [INTEGER_64]]
			promise: CP_RESULT_PROMISE_PROXY [INTEGER_64, CP_NO_IMPORTER [INTEGER_64]]

			res: INTEGER_64
		do
			create future_executor.make (executor.subject)
			create task.make_safe (agent {SUPPORT}.fibonacci (50))
			assert ("has_promise", not attached task.promise)

			promise := future_executor.put_and_get_result_promise (task)

			assert ("different_promise", task.promise = promise.subject)

			res := promise.item

			assert ("result_wrong", res = 12586269025)

			assert ("has_exception", not promise.is_exceptional)
			assert ("not_terminated", promise.is_terminated)
			assert ("executor_count_wrong", executor.worker_count = {CP_GLOBAL_PROCESSORS}.worker_count)
		end

feature {NONE}  -- Implementation

	on_prepare
			-- <Precursor>
		local
			sep_executor: separate CP_TASK_WORKER_POOL
		do
			create sep_executor.make (100, 4)
			create executor.make (sep_executor)
		end

	on_clean
			-- <Precursor>
		do
			executor.stop
		end

	executor: CP_EXECUTOR_PROXY
			-- A global worker pool.

end
