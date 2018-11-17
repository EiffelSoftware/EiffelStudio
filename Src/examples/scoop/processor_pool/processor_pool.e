note
	description: "[
		A pool of active processors that provides the following core functionality:
			1. Setup and start a given number of active processors.
			2. Register a new task for execution.
			3. Fetch a registered task and unregister it.
			4. Handle a request to stop active processors as soon as all registered tasks have been executed.
	]"

class PROCESSOR_POOL

create
	make

feature {NONE} -- Creation

	make (n: NATURAL_16)
			-- Create a pool of `n` processors.
		require
			n >= 1
		do
				-- Allocate storage for tasks.
			create tasks.make (10)
				-- Record the number of active processors.
			processor_count := n
				-- Start processors.
			across
				{NATURAL_16} 1 |..| n as i
			loop
					-- Processor number is used for demonstration only.
				separate create {separate PROCESSOR}.make (Current, i.item.as_natural_16) as p do
					p.run
				end
			end
		end

feature -- Status report

	processor_count: NATURAL_16
			-- Total number of processors used to process tasks.

	has_task: BOOLEAN
			-- Is there a task to execute?
		do
			Result := not tasks.is_empty
		ensure
			definition: Result = not tasks.is_empty
		end

feature {NONE} -- Access

	tasks: ARRAYED_QUEUE [detachable separate PROCEDURE]
			-- Tasks to be executed.
			-- `Void` item indicates that no more tasks are available and active processors can stop.

feature -- Access

	task: detachable separate PROCEDURE
			-- A task to be executed first.
			-- `Void` indicates that no more tasks are available and an active processor can stop.
		require
			has_task
		do
			Result := tasks.item
		end

feature -- Modification

	add_task (t: separate PROCEDURE)
			-- Add a task `t` for execution.
		do
			tasks.put (t)
		ensure
			has_task
		end

	remove_task
			-- Remove a task to be executed first.
		require
			has_task
		do
			tasks.remove
		end

	stop
			-- Tell that no more tasks are going to be added.
		do
			across
				{NATURAL_16} 1 |..| processor_count as i
			loop
				tasks.put (Void)
			end
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
