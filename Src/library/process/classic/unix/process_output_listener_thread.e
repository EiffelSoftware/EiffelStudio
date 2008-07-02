indexing
	description:
		"[
			Object defining a listener for output data from another process.

			It is used when you redirect output of a process to an agent.
			It listens to process's output pipe, if data arrives,
			it will call the agent specified in `output_handler' in PROCESS.
		 ]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	PROCESS_OUTPUT_LISTENER_THREAD

inherit
	PROCESS_IO_LISTENER_THREAD

create
	make

feature {NONE} -- Initialization

	make (prc_launcher: PROCESS_IMP) is
		require
			thread_capable: {PLATFORM}.is_thread_capable
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
				process_launcher.read_output_stream
				if process_launcher.last_output_bytes = 0 then
					if should_thread_exit then
						done := True
					else
						sleep (l_sleep_time)
					end
				end
			end
		end

indexing
	library:   "EiffelProcess: Manipulation of processes with IO redirection."
	copyright: "Copyright (c) 1984-2008, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
