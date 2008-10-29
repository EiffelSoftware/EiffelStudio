indexing
	description: "Thread to check if interpreter process has not reponsed for a certain amount of time"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	AUT_TIME_OUT_CHECKER_THREAD

inherit
	THREAD
		rename
			sleep as thread_sleep
		export{ANY}
			terminated
		end

	DT_SHARED_SYSTEM_CLOCK

	EXECUTION_ENVIRONMENT
		rename
			launch as launch_process
		end

create
	make

feature{NONE} -- Initialization

	make (a_proxy: like proxy; a_time_out: like time_out; a_mutex: like mutex) is
			-- Initialize Current with `a_proxy'.
		require
			a_proxy_attached: a_proxy /= Void
			a_time_out_positive: a_time_out > 0
		do
			proxy := a_proxy
			time_out := a_time_out
			mutex := a_mutex
		end

feature -- Status report

	should_exit: BOOLEAN
			-- Should Current thread exit?

feature -- Access

	time_out: INTEGER
			-- Time out in second

	mutex: MUTEX

feature -- Basic operations

	execute is
			-- Routine executed by new thread.
		local
			l_proxy: like proxy
			l_last_request_count: NATURAL_64
			l_start_time: DT_DATE_TIME
			l_time_left: DT_DATE_TIME_DURATION
			l_time_out_duration: DT_DATE_TIME_DURATION
			l_sleep_time: like default_sleep_time
			l_should_terminate_interp: BOOLEAN
		do
			l_proxy := proxy
			l_sleep_time := default_sleep_time

			from
				create l_time_out_duration.make (0, 0, 0, 0, 0, time_out)
				l_last_request_count := l_proxy.request_count
			until
				should_exit
			loop
					-- Sleep for a while first to allow interpreter to
					-- have some time to execute some requests.
				sleep (l_sleep_time)
				if l_proxy.is_running then
					if l_start_time = Void then
						l_start_time := system_clock.date_time_now
					end

					if l_last_request_count /= l_proxy.request_count then
							-- If new request already started, new count down will start,
							-- otherwise, the old count down continues.
						l_start_time := system_clock.date_time_now
						l_last_request_count := l_proxy.request_count
					else
						l_time_left := l_time_out_duration - system_clock.date_time_now.duration (l_start_time)
						l_time_left.set_time_canonical

							-- We run out of time, terminiate the interpreter process right away.
						l_should_terminate_interp := l_time_left.second_count < 0
					end

						-- Terminate interpreter process.
						-- Fixme: We assume the process is terminated after, while in some rare cases,
						-- the termination can fail.
					if l_should_terminate_interp then
						mutex.lock
						l_proxy.terminate_process
						mutex.unlock
						l_start_time := system_clock.date_time_now
					end
				else
					l_start_time := Void
				end
			end
		end

feature -- Setting

	set_should_exit (b: BOOLEAN) is
			-- Set `should_exit' with `b'.
		do
			should_exit := b
		ensure
			should_exit_set: should_exit = b
		end

feature{NONE} -- Implementation

	proxy: AUT_INTERPRETER_PROXY
			-- Proxy used to generate test cases.

feature{NONE} -- Constants

	default_sleep_time: INTEGER_64 is 10000
			-- Sleep time in nanosecond.

invariant
	proxy_attached: proxy /= Void
	interpreter_process_attached: proxy.process /= Void
	time_out_positive: time_out > 0

end
