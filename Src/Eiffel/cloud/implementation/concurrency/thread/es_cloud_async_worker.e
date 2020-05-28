note
	description: "Summary description for {ES_CLOUD_ASYNC_WORKER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ASYNC_WORKER

create
	make

feature {NONE} -- Initialization	

	make
		do
			create jobs.make (10)
			create completed_jobs.make (10)
			create mutex.make
			create semaphore.make (10)
			create thread.make (mutex, Current)
			thread.launch
		end

feature -- Access

	pending_job_count: NATURAL_32

feature -- Protected Access

	exit_requested: BOOLEAN

	jobs: ARRAYED_STACK [ES_CLOUD_ASYNC_JOB]

	completed_jobs: ARRAYED_STACK [ES_CLOUD_ASYNC_JOB]

feature -- Element change

	add_job (a_job: ES_CLOUD_ASYNC_JOB)
		do
			pending_job_count := pending_job_count + 1
			debug ("es_cloud_async")
				print (">> New ASYNC job {"+ a_job.generator +"}%N")
			end
			mutex.lock
			a_job.pre_execute
			jobs.force (a_job)
			mutex.unlock
			if thread.terminated then
				check should_not_occur: False end
				thread.launch
			end
			semaphore.post
			check_for_completion
		end

	request_exit
		do
			mutex.lock
			exit_requested := True
			mutex.unlock
		end

feature {ES_CLOUD_ASYNC_WORKER_THREAD} -- Synchronized access	

	next_job: detachable ES_CLOUD_ASYNC_JOB
		local
			l_jobs: like jobs
		do
				-- `mutex` should be locked
			l_jobs := jobs
			if not l_jobs.is_empty then
				Result := jobs.item
				if Result /= Void then
					jobs.remove
				end
			end
		end

	complete_job (a_job: ES_CLOUD_ASYNC_JOB)
		do
			-- `mutex` should be locked
			debug ("es_cloud_async")
				print (">> New ASYNC completed job {"+ a_job.generator +"}%N")
			end
			completed_jobs.force (a_job)
		end

feature -- Synchronization

	thread: ES_CLOUD_ASYNC_WORKER_THREAD

	mutex: MUTEX
	semaphore: SEMAPHORE

feature -- Check for completion

	timeout: detachable EV_TIMEOUT

	check_for_completion
		local
			t: EV_TIMEOUT
		do
			debug ("es_cloud_async")
				print (">> START checking for completion ..%N")
			end
			t := timeout
			if t = Void then
				create t
				timeout := t
				t.actions.extend (agent process_check_for_completion)
				t.set_interval (100)
			elseif t.interval = 0 then
				t.set_interval (100)
			end
			process_check_for_completion
		end

	process_check_for_completion
		local
			l_jobs: like completed_jobs
			l_job: like next_job
		do
			mutex.lock
			l_jobs := completed_jobs
--			debug ("es_cloud_async")
--				print (generator + " : CHECK completed jobs = "+ l_jobs.count.out +" / "+ pending_job_count.out +" ..%N")
--			end
			if l_jobs.is_empty then
					-- No new completed job
			else
				l_job := l_jobs.item
				if l_job /= Void then
					l_jobs.remove
				end
				pending_job_count := pending_job_count - 1
			end
			mutex.unlock
			if pending_job_count = 0 then
				stop_checking_for_completion
			end
			if l_job /= Void then
				debug ("es_cloud_async")
					print (">> job {"+ l_job.generator +"} completed ..%N")
				end
				l_job.post_execute
			end
		end

	stop_checking_for_completion
		require
			pending_job_count = 0
		local
			t: like timeout
		do
			t := timeout
			if t /= Void then
				t.set_interval (0)
			end
			debug ("es_cloud_async")
				print (">> STOP checking for completion ..%N")
			end
		end

invariant
note
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
