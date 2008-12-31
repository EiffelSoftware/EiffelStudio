note
	description: "[
		Supports spawning of mulitple processes asynchronously with a synchronous queue.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	SPAWNER

inherit
	THREAD_CONTROL
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	make (a_threshold: like concurrent_threshold)
			-- Initialize spawner using a maximum number threshold of processes to spawn.
		require
			a_threshold_positive: a_threshold > 0
		do
			create internal_running_processes.make (concurrent_threshold)
			create internal_unsuccessful_processes.make (0)
			concurrent_threshold := a_threshold
			reset
		ensure
			concurrent_threshold_set: concurrent_threshold = a_threshold
			not_exit_failurea_process: not exit_failure
			successful: successful
		end

feature -- Access

	running: NATURAL_16
			-- Number of running processes
		do
			mutex.lock
			Result := internal_running_processes.count.to_natural_16
			mutex.unlock
		end

	running_processes: ARRAYED_LIST [PROCESS]
			-- List of processes running at this point in time
			-- Note: Due to thread-saftey a new list is returned for each call.
		do
			mutex.lock
			Result := internal_running_processes.twin
			Result.start
			mutex.unlock
		ensure
			result_attached: Result /= Void
		end

	unsuccessful_processes: ARRAYED_LIST [PROCESS]
			-- List of processes that failed to execute correctly
			-- Note: Due to thread-saftey a new list is returned for each call.
		do
			mutex.lock
			Result := internal_unsuccessful_processes.twin
			Result.start
			mutex.unlock
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	concurrent_threshold: NATURAL_16
			-- Maximum number of concurrent processes

feature -- Status report

	successful: BOOLEAN
			-- Indiciates if the last run process was successful
		do
			mutex.lock
			Result := internal_unsuccessful_processes.is_empty
			mutex.unlock
		end

	is_running: BOOLEAN
			-- Determines if any processes are currently running
		do
			Result := running > 0
		end

feature {NONE} -- Status report

	is_at_threshold: BOOLEAN
			-- Determines if spawer is current running a number of processes that
			-- reaches the threshold `concurrent_threshold'
		note
			thread: safe
		do
			mutex.lock
			Result := running = concurrent_threshold
			mutex.unlock
		end

	exit_failure: BOOLEAN
			-- Indicates if there was a process exit failure

feature -- Basic operations

	reset
			-- Reset spawner internals after a failure
		require
			not_is_running: not is_running
		do
			exit_failure := False
			internal_running_processes.wipe_out
			internal_unsuccessful_processes.wipe_out
		ensure
			not_exit_failure: not exit_failure
			successful: successful
		end

	launch_process (a_process: PROCESS; a_fail_on_error: BOOLEAN)
			-- Launches a process.
			--
			-- `a_process': Process to launch.
			-- `a_fail_on_error': True to causes a failure on a non-successful error result, False otherwise.
		require
			a_process_attached: a_process /= Void
			not_a_process_launched: not a_process.launched
		do
			if not exit_failure then
				start_process (a_process, a_fail_on_error)
				from until not is_at_threshold loop
					yield
					sleep (10)
				end
			end
		end

	wait_for_exit
			-- Waits for all running processes to exit
		do
			from until not is_running loop
				yield
				sleep (10)
			end
		end

feature {NONE} -- Extension

	start_process (a_process: PROCESS; a_fail_on_error: BOOLEAN)
			-- Starts the process `a_process' and returns
			--
			-- `a_process': Process to launch.
			-- `a_fail_on_error': Indicates if a failure exit code should signal a complete failure.
		require
			a_process_attached: a_process /= Void
			not_a_process_launched: not a_process.launched
			not_a_process_is_running: not a_process.is_running
			not_is_at_threshold: not is_at_threshold
			not_exit_failure: not exit_failure
		do
			a_process.set_on_exit_handler (agent remove_process (a_process, a_fail_on_error))
			mutex.lock
			internal_running_processes.extend (a_process)
			mutex.unlock

			a_process.launch

			mutex.lock
			if not a_process.launched then
				remove_process (a_process, a_fail_on_error)
			end
			mutex.unlock
		end

feature {NONE} -- Removal

	remove_process (a_process: PROCESS; a_fail_on_error: BOOLEAN)
			-- Removed the process `a_process' from the list of running processes
			-- Note: If `a_process' returned an error result `successful' is affected.
			--
			-- `a_process': Process to removed from the list.
			-- `a_fail_on_error': Indicates if a failure exit code should signal a complete failure.
		require
			a_process_attached: a_process /= Void
			not_a_process_is_running: not a_process.is_running
		do
			mutex.lock
			internal_running_processes.start
			internal_running_processes.search (a_process)
			if not internal_running_processes.after then
				internal_running_processes.remove
			end
			if not a_process.launched or else a_process.exit_code /= 0 then
				if a_fail_on_error then
					exit_failure := True
				end
				internal_unsuccessful_processes.extend (a_process)
			end
			mutex.unlock
		end

feature {NONE} -- Implementation

	mutex: MUTEX
			-- Global mutext for controlling access to `Current'
		do
			Result := internal_mutex
			if Result = Void then
				create Result.make
				internal_mutex := Result
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Internal implementation cache

	internal_mutex: like mutex
			-- Cached version of `mutex'
			-- Note: Do not use directly!			

	internal_unsuccessful_processes: ARRAYED_LIST [PROCESS]
			-- Cached version of `unsuccessful_processes'
			-- Note: Do not use directly!

	internal_running_processes: ARRAYED_LIST [PROCESS]
			-- Cached version of `running_processes'
			-- Note: Do not use directly!		

invariant
	running_small_enough: running <= concurrent_threshold
	concurrent_threshold_positive: concurrent_threshold > 0
	internal_unsuccessful_processes_attached: internal_unsuccessful_processes /= Void
	internal_running_processes_attached: internal_running_processes /= Void

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
