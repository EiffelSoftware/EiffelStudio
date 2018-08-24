note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IV_UNIVERSE_VISITOR

feature -- Visitor

	process_function (a_function: IV_FUNCTION)
			-- Process function `a_function'.
		require
			a_function_attached: attached a_function
		deferred
		end

	process_variable (a_variable: IV_VARIABLE)
			-- Process variable `a_variable'.
		require
			a_variable_attached: attached a_variable
		deferred
		end

	process_constant (a_variable: IV_CONSTANT)
			-- Process variable `a_constant'.
		require
			a_variable_attached: attached a_variable
		deferred
		end

	process_axiom (a_axiom: IV_AXIOM)
			-- Process axiom `a_axiom'.
		require
			a_axiom_attached: attached a_axiom
		deferred
		end

	process_procedure (a_procedure: IV_PROCEDURE)
			-- Process procedure `a_procedure'.
		require
			a_procedure_attached: attached a_procedure
		deferred
		end

	process_implementation (a_implementation: IV_IMPLEMENTATION)
			-- Process implementation `a_implementation'.
		require
			a_implementation_attached: attached a_implementation
		deferred
		end

end
