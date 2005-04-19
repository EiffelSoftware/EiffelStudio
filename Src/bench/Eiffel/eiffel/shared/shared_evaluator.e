-- Shared instances of types evaluators

class SHARED_EVALUATOR
	
feature {NONE}

	Result_evaluator: RESULT_EVALUATOR is
			-- Evaluator of Result types
		once
			create Result
		ensure
			result_evaluator_not_void: Result /= Void
		end

	Arg_evaluator: ARG_EVALUATOR is
			-- Evaluator of argument types
		once
			create Result
		ensure
			arg_evaluator_not_void: Result /= Void
		end

	Local_evaluator: LOCAL_EVALUATOR is
			-- Evaluator  of argument types
		once
			create Result
		ensure
			local_evaluator_not_void: Result /= Void
		end
		
end
