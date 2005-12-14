indexing
	description:
		"[
			Object defining a listener for error data from another process.

			It is used when you redirect error of a process to an agent.
			It listens to process's error pipe, if data arrives,
			it will call the agent specified in error_handler in PROCESS.
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
			create mutex
		ensure
			process_launched_set: prc_launcher = prc_launcher
			should_exit_signal_set_to_false: not should_exit_signal
			sleep_time_set: sleep_time = initial_sleep_time
		end

feature -- Run	

	execute is
		local
			str: STRING
			done: BOOLEAN
		do
			from
				create str.make (process_launcher.buffer_size)
				done := False
			until
				done
			loop
				process_launcher.read_error_stream
				str := process_launcher.last_error
				if str /= Void and then not str.is_empty then
					process_launcher.error_handler.call ([str])
				end
				if str = Void then
					done := True
				end
			end
		end
end
