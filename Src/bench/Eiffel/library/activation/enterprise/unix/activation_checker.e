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
		redefine
			check_license
		end

	SHARED_BENCH_LICENSES
		rename
			check_license as is_check_license
		end

feature

	check_activation is
			-- Check whether product can be started.
			-- Decrement remaining execution count
			-- if not activated.
			-- Set `can_run' to `True' if product can
			-- be started, `False' otherwise.
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
		end
	
feature {NONE} -- Implementation

	check_license is
			-- Check license information and set `can_run', `is_licensed' and `is_evaluating'
			-- to their proper value?
		do
			license.get_license
			is_licensed := license.licensed
			is_evaluating := is_licensed and has_limited_license
			can_run := is_licensed
			if is_evaluating then
				io.error.putstring (expiration_message)
			end
			if not is_licensed then
				lic_die (-1)
			end
		end
	
	report_engine_not_initialized is
			-- Action to be performed when engine is not initialized.
		do
		end

end -- class ACTIVATION_CHECKER
