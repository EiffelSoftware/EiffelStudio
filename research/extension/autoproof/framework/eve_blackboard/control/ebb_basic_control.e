note
	description: "A basic control for the blackboard."
	date: "$Date$"
	revision: "$Revision$"

class
	EBB_BASIC_CONTROL

inherit

	EBB_CONTROL

	SHARED_EIFFEL_PROJECT
		export {NONE} all end

--	SHARED_DEBUGGER_MANAGER
--		export {NONE} all end

	EBB_SHARED_HELPER
		export {NONE} all end

create
	make

feature -- Access

	name: STRING = "Basic"
			-- <Precursor>

feature -- Basic operations

	think
			-- <Precursor>
		local
			l_input: EBB_TOOL_INPUT
			l_tool: EBB_TOOL
			l_configuration: EBB_TOOL_CONFIGURATION
		do
			if
				next_tool_execution = Void and
				blackboard.executions.running_executions.is_empty and
				blackboard.executions.waiting_executions.is_empty and
				not eiffel_project.is_compiling and
				not blackboard.tools.is_empty --and
--				not debugger_manager.application_is_executing
			then
					-- Try to run the proof tools
				current_class_index := current_class_index + 1
				if current_class_index > blackboard.data.classes.count then
					current_class_index := 1
				end

				if current_class.is_compiled then
					create l_input.make
					l_input.add_class (current_class.compiled_class)

					l_tool := blackboard.default_tool_of_type ({EBB_TOOL_CATEGORY}.static_verification)
					if needs_tool_execution (l_tool, current_class) then
						l_configuration := l_tool.default_configuration
						create next_tool_execution.make (l_tool, l_configuration, l_input)
					end

					l_tool := blackboard.default_tool_of_type ({EBB_TOOL_CATEGORY}.dynamic_verification)
					if next_tool_execution = Void and then needs_tool_execution (l_tool, current_class) then
						l_configuration := l_tool.default_configuration
						create next_tool_execution.make (l_tool, l_configuration, l_input)
					end
				end
			end
		end

	needs_tool_execution (a_tool: EBB_TOOL; a_class: EBB_CLASS_DATA): BOOLEAN
		local
			l_features: LIST [EBB_FEATURE_DATA]
			l_results: LIST [TUPLE [verification_result: EBB_VERIFICATION_RESULT; is_stale: BOOLEAN]]
			l_tool_run, l_tool_stale: BOOLEAN
		do
			from
				l_features := a_class.children
				l_features.start
			until
				l_features.after or Result
			loop
				if is_feature_data_verified (l_features.item) then
					from
						l_tool_run := False
						l_tool_stale := False
						l_results := l_features.item.tool_results_list
						l_results.start
					until
						l_results.after or l_tool_run
					loop
						if l_results.item.verification_result.tool = a_tool then
							l_tool_run := True
							l_tool_stale := l_results.item.is_stale
						end
						l_results.forth
					end
					if not l_tool_run or else l_tool_stale then
						Result := True
					end
				end
				l_features.forth
			end
		end

	create_new_tool_executions
			-- <Precursor>
		local
			l_class: EBB_CLASS_DATA
			l_input: EBB_TOOL_INPUT
			l_tool: EBB_TOOL
			l_configuration: EBB_TOOL_CONFIGURATION
			l_execution: EBB_TOOL_EXECUTION
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
