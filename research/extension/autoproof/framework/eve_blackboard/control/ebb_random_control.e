note
	description: "Blackboard controller selecting input classes and tools at random."
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_RANDOM_CONTROL

inherit

	EBB_CONTROL

	SHARED_EIFFEL_PROJECT

create
	make

feature -- Access

	name: STRING = "Random"
			-- <Precursor>

feature -- Basic operations

	think
			-- <Precursor>
		do
		end

	create_new_tool_executions
			-- <Precursor>
		local
			l_classes: LIST [EBB_CLASS_DATA]
			l_class: EBB_CLASS_DATA
			l_input: EBB_TOOL_INPUT
			l_tool: EBB_TOOL
			l_configuration: EBB_TOOL_CONFIGURATION
			l_execution: EBB_TOOL_EXECUTION
		do
				-- Only launch new tool when:
				--  - no other tool is running
				--  - no other tool is waiting
				--  - no compilation is running
				--  - there is a tool
			if
				blackboard.executions.running_executions.is_empty and
				blackboard.executions.waiting_executions.is_empty and
				not eiffel_project.is_compiling and
				not blackboard.tools.is_empty and
				not blackboard.data.classes.is_empty
			then

				from
					l_classes := blackboard.data.classes
				until
					l_class /= Void and l_class.is_compiled
				loop
					random.forth
					l_class := l_classes.i_th ((random.item \\ l_classes.count) + 1)
				end

					-- Create input set
				create l_input.make
				l_input.add_class (l_class.compiled_class)

					-- Select tool and configuration.
				random.forth
				l_tool := blackboard.tools.i_th ((random.item \\ blackboard.tools.count) + 1)
				l_configuration := l_tool.default_configuration

					-- Add tool execution to waiting list
				create l_execution.make (l_tool, l_configuration, l_input)
				blackboard.executions.queue_tool_execution (l_execution)
			end
		end

	random: RANDOM
			-- Random number generator.
		local
			l_time: TIME
		once
			create l_time.make_now
			create Result.set_seed (l_time.compact_time)
		end

end
