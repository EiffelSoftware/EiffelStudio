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
			check
				has_application: (create {EV_ENVIRONMENT}).application /= Void
				application_started: not (create {EV_ENVIRONMENT}).application.is_destroyed
			end
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
		local
			l_warning: EV_WARNING_DIALOG
			l_app: EV_APPLICATION
			l_screen: EV_SCREEN
			l_accelerator: EV_ACCELERATOR
		do
			create l_app			
			create l_warning.make_with_text (Not_initialized_error_message)
			create l_screen
			l_warning.set_position ((l_screen.width - l_warning.width) // 2,
				(l_screen.height - l_warning.height) // 3)
			
			l_warning.set_buttons_and_actions (<<"Quit">>, <<agent die>>)
			create l_accelerator
			l_accelerator.set_key (create {EV_KEY}.make_with_code (feature {EV_KEY_CONSTANTS}.Key_enter))
			l_accelerator.actions.extend (agent die)
			l_warning.accelerators.extend (l_accelerator)
			l_warning.button ("Quit").set_focus
			l_warning.show
			l_app.launch
		end

	die is
			-- Kill current application.
		local
			l_exception: EXCEPTIONS
		do
			create l_exception
			l_exception.die (-1)
		end
		
end -- class ACTIVATION_CHECKER
