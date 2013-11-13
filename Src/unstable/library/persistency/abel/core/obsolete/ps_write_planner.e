note
	description: "This class breaks cycles in an object graph and generates a totally ordered list of operations to be performed by the database backend."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_WRITE_PLANNER

inherit

	PS_ABEL_EXPORT

create
	make

feature {PS_ABEL_EXPORT} -- Access

	object_graph: PS_OBJECT_GRAPH_ROOT
			-- The root of an object graph to generate a plan for.

	operation_plan: LINKED_LIST [PS_OBJECT_GRAPH_PART]
			-- The plan for all write operations.
		require
			generated: is_plan_generated
		attribute
		end

feature {PS_ABEL_EXPORT} -- Status report

	is_plan_generated: BOOLEAN
			-- Has an operation plan for `object_graph' been generated?

feature {PS_ABEL_EXPORT} -- Basic operations

	generate_plan
			-- Generate an `operation_plan' for `object_graph'.
		require
			has_graph: not object_graph.dependencies.is_empty
		do
			break_cycles
			topological_sort
			remove_noops
			is_plan_generated := True
		ensure
			generated: is_plan_generated
		end

	set_object_graph (an_object_graph: PS_OBJECT_GRAPH_ROOT)
			-- Set `object_graph' to `an_object_graph'.
		do
			object_graph := an_object_graph
			operation_plan.wipe_out
			is_plan_generated := False
		ensure
			not_generated: not is_plan_generated
		end

feature {NONE} -- Implementation

	break_cycles
			-- Search and break all cycles.
		local
			cursor: PS_OBJECT_GRAPH_CURSOR
		do
			from
				cursor := object_graph.new_cursor
					-- Let the cursor and the object graph parts itself resolve dependency cycles
				cursor.set_handler (agent {PS_OBJECT_GRAPH_PART}.break_dependency)
			until
				cursor.after
			loop
					-- Prepare for the next step
				cursor.item.set_visited (False)
				cursor.forth
			end
		end

	topological_sort
			-- Do a topological sort on the object graph.
		do
			visit (object_graph)
		end

	visit (node: PS_OBJECT_GRAPH_PART)
			-- Visit a node in depth-first search and then add the node to the operation plan.
		do
			if not node.is_visited then
				node.set_visited (True)
				across
					node.dependencies as cursor
				loop
					visit (cursor.item)
				end
				operation_plan.extend (node)
			end
		end

	remove_noops
			-- Remove all `No_operation' items from the list.
		do
			from
				operation_plan.start
			until
				operation_plan.after
			loop
				if operation_plan.item.write_operation = operation_plan.item.write_operation.No_operation then
					operation_plan.remove
				else
					operation_plan.forth
				end
			end
		end

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			create object_graph.make
			create operation_plan.make
		ensure
			not_generated: not is_plan_generated
		end

end
