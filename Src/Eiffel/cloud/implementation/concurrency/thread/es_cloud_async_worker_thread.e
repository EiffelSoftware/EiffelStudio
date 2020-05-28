note
	description: "Summary description for {ES_CLOUD_ASYNC_WORKER_THREAD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ASYNC_WORKER_THREAD

inherit
	THREAD
		rename
			make as make_thread
		end

create
	make

feature {NONE} -- Initialization

	make (a_mutex: MUTEX; a_worker: ES_CLOUD_ASYNC_WORKER)
		do
			mutex := a_worker.mutex
			semaphore := a_worker.semaphore
			worker := a_worker
			make_thread
		end

feature -- Access

	mutex: MUTEX

	semaphore: SEMAPHORE

	worker: ES_CLOUD_ASYNC_WORKER

feature -- Execution

	execute
		local
			l_exit_requested: BOOLEAN
			l_job: detachable ES_CLOUD_ASYNC_JOB
		do
			debug ("es_cloud_async")
				print (">> Cloud async worker: started.%N")
			end
			from until l_exit_requested loop
				semaphore.wait
				mutex.lock
				l_exit_requested := worker.exit_requested
				l_job := worker.next_job
				mutex.unlock
				if l_job /= Void then
					l_job.execute
					mutex.lock
					worker.complete_job (l_job)
					mutex.unlock
				else
--					sleep (10_000_000) -- 10 ms
				end
			end
			debug ("es_cloud_async")
				print (">> Cloud async worker: finished.%N")
			end
		end

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
