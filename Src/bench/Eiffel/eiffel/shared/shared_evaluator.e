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

	Creation_evaluator: CREATION_EVALUATOR is
			-- Evaluator for type creation
		once
			create Result
		ensure
			creation_evaluator_not_void: Result /= Void
		end
		
	type_expr_evaluator: TYPE_EXPR_EVALUATOR is
			-- Evaluator for type expression
		once
			create Result
		ensure
			type_expr_evaluator_not_void: Result /= Void
		end
		
end
