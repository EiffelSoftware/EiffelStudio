indexing
	description:
		"[
			Object defining a listener for error data from another process.

			It is used when you redirect error of a process to an agent.
			It listens to process's error pipe, if data arrives,
			it will call the agent specified in `error_handler' in PROCESS.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_ERROR_LISTENER_THREAD

inherit
	PROCESS_IO_LISTENER_THREAD

create
	make

feature {NONE} -- Initialization

	make (prc_launcher: PROCESS_IMP) is
		require
			process_launcher_not_null: prc_launcher /= Void
		do
			process_launcher := prc_launcher
			should_exit_signal:= False
			sleep_time := initial_sleep_time
			create mutex.make
		ensure
			process_launched_set: prc_launcher = prc_launcher
			should_exit_signal_set_to_false: not should_exit_signal
			sleep_time_set: sleep_time = initial_sleep_time
		end

feature -- Run	

	execute is
		local
			done: BOOLEAN
			l_sleep_time: INTEGER_64
		do
			from
				done := False
				l_sleep_time := sleep_time.to_integer_64 * 1000000
			until
				done
			loop
				process_launcher.read_error_stream
				if process_launcher.last_error_bytes = 0 then
					if should_thread_exit then
						done := True
					else
						sleep (l_sleep_time)
					end
				end
			end
		end
end
