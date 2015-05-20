note
	description: "A queue structure containing TASK objects."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	TASK_QUEUE

inherit
	ARRAYED_QUEUE [separate TASK]

create
	make

feature -- Status report

	is_stopped: BOOLEAN
			-- Are there no more task to be executed in the future?
		do
			Result := is_stop_signalled and active_task_count = 0
		end


	next_task_number: INTEGER
			-- The task number of the next job.
		require
			not_empty: not is_empty
		do
			separate
				item as l_item
			do
				Result := l_item.task_number
			end
		rescue
			print ("Error: In rescue.%N")
		end

feature -- Element change

	increment_task_count
			-- Add one to the total number of tasks.
		do
			active_task_count := active_task_count + 1
		end

	decrement_task_count
			-- Decrement the total number of tasks.
		do
			active_task_count := active_task_count - 1
		end

feature -- Basic operations

	stop
			-- Signal that no more fresh tasks will be inserted.
		do
			is_stop_signalled := True
		end

feature {NONE} -- Implementation


	active_task_count: INTEGER
			-- The total amount of unfinished tasks in the queue.

	is_stop_signalled: BOOLEAN

end
