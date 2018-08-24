note
	description: "Summary description for {EBB_EXECUTIONS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_EXECUTIONS

inherit

	EBB_SHARED_BLACKBOARD

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize executions lists.
		do
			create waiting_executions.make
			create running_executions.make
			create finished_executions.make

		end

feature -- Access

	waiting_executions: LINKED_LIST [EBB_TOOL_EXECUTION]
			-- Tool executions waiting to be started.

	running_executions: LINKED_LIST [EBB_TOOL_EXECUTION]
			-- Tool executions running at the moment.

	finished_executions: LINKED_LIST [EBB_TOOL_EXECUTION]
			-- Tool executions that finished.

	max_parallel_executions: INTEGER = 1
			-- Maximum number of parallel tool executions.

feature -- Basic operations

	check_running_tool_executions
			-- Check running tools and move them to finished list if necessary.
		local
			l_execution: EBB_TOOL_EXECUTION
		do
			from
				running_executions.start
			until
				running_executions.after
			loop
				l_execution := running_executions.item
				if not l_execution.is_running and not l_execution.is_finished then
					l_execution.set_finished
				end
				if l_execution.is_finished then
					finished_executions.put_front (l_execution)
					running_executions.remove
					blackboard.tool_execution_changed_event.publish ([])
				else
					running_executions.forth
				end
			end
		end

	start_waiting_tool_executions
			-- Start waiting tool executions if the limit is not yet reached.
		do
			if running_executions.count < max_parallel_executions and not waiting_executions.is_empty then
				start_tool_execution (waiting_executions.first)
			end
		end

	queue_tool_execution (a_execution: EBB_TOOL_EXECUTION)
			-- Queue `a_execution' and add it to the waiting list.
		do
			waiting_executions.extend (a_execution)
			blackboard.tool_execution_changed_event.publish ([])
		ensure
			waiting: waiting_executions.has (a_execution)
		end

	start_tool_execution (a_execution: EBB_TOOL_EXECUTION)
			-- Start `a_execution' and move it to the running list.
		require
			not_at_limit: running_executions.count < max_parallel_executions
		do
			if waiting_executions.has (a_execution) then
				waiting_executions.prune_all (a_execution)
			end

			a_execution.start

			running_executions.extend (a_execution)
			blackboard.tool_execution_changed_event.publish ([])
		ensure
			not_waiting: not waiting_executions.has (a_execution)
			executing: running_executions.has (a_execution)
		end

	handle_changed_class (a_class: CLASS_I)
			-- Handle fact that `a_class' changed.
		local
			l_execution: EBB_TOOL_EXECUTION
			l_input: EBB_TOOL_INPUT
			l_class_overlap: BOOLEAN
		do
			across running_executions as l_cursor loop
				l_execution := l_cursor.item
				if l_execution.is_running then
					l_input := l_execution.input
					l_class_overlap := across l_input.features as l_features some l_features.item.written_class.name.is_equal (a_class.name) end
					if l_class_overlap then
						l_execution.cancel
					end
				end
			end
		end

invariant
	max_number_of_running_executions: running_executions.count <= max_parallel_executions
	consistent_waiting: across waiting_executions as c all not c.item.is_running and not c.item.is_finished end
	consistent_running: across running_executions as c all c.item.is_running xor c.item.is_finished end
	consistent_finished: across finished_executions as c all not c.item.is_running and c.item.is_finished end

end
