indexing
	description: "[
		Check whether product is correctly activated,
		decrement remaining executions counter otherwise.
		When counter reaches 0, product must be activated.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ACTIVATION_CHECKER

inherit
	ACTIVATION_CHECKER_I

feature

	check_activation is
			-- Check whether product can be started.
			-- Decrement remaining execution count
			-- if not activated.
			-- Set `can_run' to `True' if product can
			-- be started, `False' otherwise.
		local
			validator_window: ACTIVATION_KEY_VALIDATOR_WINDOW
			l_app: EV_APPLICATION
		do
			check_license
			if is_evaluating then
				create l_app
				create validator_window.make (agent set_can_run (True), agent l_app.destroy)
				validator_window.show
				l_app.launch
			end
			launch_gc_cycle
		end

	check_activation_while_running (a_next_action: PROCEDURE [ANY, TUPLE]) is
			-- Check whether product can be started.
			-- Decrement remaining execution count
			-- if not activated.
			-- Set `can_run' to `True' if product can
			-- be started, `False' otherwise.
		local
			validator_window: ACTIVATION_KEY_VALIDATOR_WINDOW
		do
			check_license
			if is_evaluating then
				create validator_window.make (agent set_can_run (True), a_next_action)
				validator_window.show
			end
			launch_gc_cycle
		end
	
feature {NONE} -- Implementation

	report_engine_not_initialized is
			-- Action to be performed when engine is not initialized.
		do
		end

end -- class ACTIVATION_CHECKER
