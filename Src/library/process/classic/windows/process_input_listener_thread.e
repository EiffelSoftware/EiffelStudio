indexing
	description: "[
					Object defining a listener for sending data into launched process.
					It is used when you redirect input to stream.
		 		]"

	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_INPUT_LISTENER_THREAD

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
			done: BOOLEAN
			l_sleep_time: INTEGER_64
		do
			from
				done := False
				l_sleep_time := sleep_time.to_integer_64 * 1000000
			until
				done
			loop
				process_launcher.write_input_stream
				if should_exit_signal then
					done := True
				elseif process_launcher.last_input_bytes = 0 then
					sleep (l_sleep_time)
				end
			end
		end

end
