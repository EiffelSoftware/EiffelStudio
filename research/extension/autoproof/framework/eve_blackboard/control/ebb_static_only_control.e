note
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_STATIC_ONLY_CONTROL

inherit

	EBB_CONTROL

	SHARED_EIFFEL_PROJECT

create
	make

feature -- Access

	name: STRING = "Static only"
			-- <Precursor>

feature -- Basic operations

	think
			-- <Precursor>
--		local
--			l_input: EBB_TOOL_INPUT
--			l_tool: EBB_TOOL
--			l_configuration: EBB_TOOL_CONFIGURATION
		do
--			if
--				blackboard.executions.running_executions.is_empty and
--				blackboard.executions.waiting_executions.is_empty and
--				not eiffel_project.is_compiling and
--				not blackboard.tools.is_empty
--			then
--				current_class_index := current_class_index + 1
--				if current_class_index > blackboard.data.classes.count then
--					current_class_index := 1
--				end
--				if current_class.is_compiled and then (current_class.is_static_score_stale or current_class.static_score = {EBB_VERIFICATION_SCORE}.not_verified) then
--					create l_input.make
--					l_input.add_class (current_class.compiled_class)
--					l_tool := blackboard.default_tool_of_type ({EBB_TOOL_CATEGORY}.static_verification)
--					l_configuration := l_tool.default_configuration
--					create next_tool_execution.make (l_tool, l_configuration, l_input)
--				end

--			end
		end

	create_new_tool_executions
			-- <Precursor>
		do
			if next_tool_execution /= Void then
				blackboard.executions.queue_tool_execution (next_tool_execution)
				next_tool_execution := Void
			end
		end

feature {NONE} -- Implementation

	current_class_index: INTEGER
			-- Index of current class being verified.

	current_class: EBB_CLASS_DATA
			-- Current class being verified.
		do
			Result := blackboard.data.classes.i_th (current_class_index)
		end

	next_tool_execution: EBB_TOOL_EXECUTION
			-- Next tool execution (Void if no execution next step).

end
