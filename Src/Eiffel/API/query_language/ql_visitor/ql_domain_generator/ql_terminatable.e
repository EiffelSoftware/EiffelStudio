indexing
	description: "Utilities to support domain generation termination"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_TERMINATABLE

feature -- Access

	interval_tick_actions: ACTION_SEQUENCE [TUPLE] is
			-- Actions to be performaed after every `interval_counter' items have been processed.
		do
			Result := interval_tick_actions_cell.item
		ensure
			result_attached: Result /= Void
		end

	tick_action_invocation_function: FUNCTION [ANY, TUPLE, BOOLEAN] is
			-- Function to decide whether or not `interval_tick_actions' should be invoked
		do
			Result := tick_action_invocation_function_cell.item
		end

feature -- Status report

	has_interval_tick_actions: BOOLEAN is
			-- Is there any tick actions registered?
		do
			Result := not interval_tick_actions.is_empty
		end

	set_tick_action_invocation_function (a_function: FUNCTION [ANY, TUPLE, BOOLEAN]) is
			-- Set `tick_action_invocation_function' with `a_function'.
		do
			tick_action_invocation_function_cell.put (a_function)
		end

feature -- Basic operations

	check_interval_tick_actions is
			-- Check if `interval_tick_actions' should be called,
			-- and if it should, invoke all actions in `interval_tick_actions'.
		do
			if
				tick_action_invocation_function /= Void and then
				tick_action_invocation_function.item ([]) and then
				has_interval_tick_actions
			then
				interval_tick_actions.call ([])
			end
		end

feature{NONE} -- Implementation

	interval_tick_actions_cell: CELL [ACTION_SEQUENCE [TUPLE]] is
			-- Cell to hold `interval_tick_actions'.
		once
			create Result.put (create{ACTION_SEQUENCE[TUPLE]})
		ensure
			result_attached: Result /= Void
		end

	tick_action_invocation_function_cell: CELL [FUNCTION [ANY, TUPLE, BOOLEAN]] is
			-- Cell to hold `tick_action_invocation_function'
		once
			create Result.put (Void)
		end

invariant
	interval_tick_actions_cell_attached: interval_tick_actions_cell /= Void
	interval_tick_actions_attached: interval_tick_actions /= Void
	tick_action_invocation_function_cell_attached: tick_action_invocation_function_cell /= Void

end
