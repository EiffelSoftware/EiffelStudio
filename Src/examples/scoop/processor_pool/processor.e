note
	description: "[
		A processor to execute registered tasks.

		The main loop has the following steps:
			1. Retrieve a task.
			2. Exit from the loop, if the retrieved task is `Void`, indicating that no more tasks are to be executed.
			3. Execute the task otherwise and repeat the loop.
	]"

class PROCESSOR

create {PROCESSOR_POOL}
	make

feature {NONE} -- Creation

	make (p: separate PROCESSOR_POOL; i: NATURAL_16)
			-- Create a processor number `i` associated with the pool `p`.
		do
			pool := p
			id := i
		end

feature {NONE} -- Access

	pool: separate PROCESSOR_POOL
			-- Associated processor pool.
			-- Used to retrieve tasks for execution.

	id: NATURAL_16
			-- A unique identifier of the processor in the pool.
			-- Used for illustrative purposes only.

feature {PROCESSOR_POOL} -- Execution

	run
			-- Execute tasks from `pool`.
		do
			print ("Starting processor #" + id.out + "%N")
			from
			until
				not attached retrieved_task (pool) as task
			loop
				print ("Executing a task on processor #" + id.out + "%N")
				separate task as t do
					t.call
				end
			end
			print ("Exiting processor #" + id.out + "%N")
		end

feature {NONE} -- Execution

	retrieved_task (p: like pool): detachable separate PROCEDURE
		require
			p.has_task
		do
			Result := p.task
			p.remove_task
		end

note
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2018, Eiffel Software"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
