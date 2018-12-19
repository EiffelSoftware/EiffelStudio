note
	descrption: "[
		An example demonstrating how multiple tasks can be executed by a fixed set of SCOOP processors.

		There are 3 major steps:
			1. Setup a pool of processors that will execute tasks.
			2. Create tasks to execute and register them for execution in the pool.
			3. Tell to the pool that no more tasks are going to be executed so that it can free resources when done.
	]"
	keywords: example, scoop, "passive region", "processor pool"

class EXAMPLE

create
	make

feature {NONE} -- Creation

	make
		local
			pool: separate PROCESSOR_POOL
			task: separate TASK
			task_number: NATURAL_32
		do
				-- Create a pool of 10 processors.
			create pool.make (10)
				-- Create 100 tasks.
			from
					-- Task number and task duration are used solely for demonstrative purposes.
				task_number := 1
			until
				task_number >= 100
			loop
					-- Create a task of a given duration in a passive region.
					-- The task can be executed only by some active processor.
				create <NONE> task.make (pool, task_duration, task_number)
				task_number := task_number + 1
			end
				-- Tell the pool that no more tasks are going to be added.
			separate pool as p do
				p.stop
			end
		end

feature {NONE} -- Simulation of task execution

	task_duration: NATURAL_64
			-- A randomized execution time of a task.
		do
			Result := (random.item // ({INTEGER_32}.max_value // 5_000)).as_natural_64
			random.forth
		end

	random: RANDOM
			-- A random generator.
		once
			create Result.make
		end

note
	author: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
