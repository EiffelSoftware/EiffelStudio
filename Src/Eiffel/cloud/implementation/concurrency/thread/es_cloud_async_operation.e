note
	description: "Asynchronous cloud operation."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_ASYNC_OPERATION

inherit
	EV_SHARED_APPLICATION

feature {NONE} -- Initialization

	make (a_service: ES_CLOUD_S; cfg: ES_CLOUD_CONFIG)
		require
			a_service /= Void
		do
			service := a_service
			config := cfg
			create mutex.make
		end

feature -- Access: Current

	service: ES_CLOUD_S

feature {NONE} -- Access: thread synchro

	mutex: MUTEX

	completed: BOOLEAN

feature {NONE} -- Access: worker thread

	config: ES_CLOUD_CONFIG

feature -- Execution

	execute
		local
			wt: WORKER_THREAD
		do
			completed := False
			create wt.make (agent 
				do
					execute_operation
					mutex.lock
					completed := True
					mutex.unlock
				end)
			reset_operation
			ev_application.add_idle_action_kamikaze (agent check_for_completion)
			wt.launch
		end

feature {NONE} -- Execution

	execute_operation
		deferred
		end

	reset_operation
		deferred
		end

	on_operation_completion
		deferred
		end

feature {NONE} -- Access

	check_for_completion_timeout: detachable EV_TIMEOUT

	check_for_completion
		local
			t: EV_TIMEOUT
		do
			debug ("es_cloud")
				print (generator + " : Check for completion ..%N")
			end
			create t
			check_for_completion_timeout := t
			t.actions.extend (agent process_check_for_completion (t))
			t.set_interval (500) -- interval in milliseconds
			process_check_for_completion (t)
		end

	process_check_for_completion (t: EV_TIMEOUT)
		local
			b: BOOLEAN
		do
			debug ("es_cloud")
				print (generator + " : Check for completion AGENT ..%N")
			end
			mutex.lock
			b := completed
			mutex.unlock
			if b then
				t.destroy
				on_completion
			else
					-- continue timeout
			end
		end

	on_completion
		do
			debug ("es_cloud")
				print (generator + ".on_completion ..%N")
			end
			if attached check_for_completion_timeout as t then
				check_for_completion_timeout := Void
			end
			on_operation_completion
		end

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
