indexing
	description: "[
		Check whether product is correctly activated,
		Currently true for command-line only version.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ACTIVATION_CHECKER
	
inherit
	ACTIVATION_CHECKER_I
		redefine
			check_license
		end
	
feature -- Basic Operations

	check_activation is
			-- Free version, can always run.
		do
			check_license
		end

	check_activation_while_running (a_next_action: PROCEDURE [ANY, TUPLE]) is
			-- Check whether product can be started.
			-- Decrement remaining execution count
			-- if not activated.
			-- Set `can_run' to `True' if product can
			-- be started, `False' otherwise.
		do
			check_license
			a_next_action.call ([])
		end

	check_license is
			-- Check license information and set `can_run', `is_licensed' and `is_evaluating'
			-- to their proper value?
		do
			is_licensed := True
			can_run := True
			is_evaluating := True
		end

feature {NONE} -- Implementation

	report_engine_not_initialized is
			-- Action to be performed when engine is not initialized.
		do
		end

end -- class ACTIVATION_CHECKER
