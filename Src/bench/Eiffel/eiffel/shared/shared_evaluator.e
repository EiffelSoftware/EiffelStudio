-- Shared instances of types evaluators

class SHARED_EVALUATOR
	
feature {NONE}

	Result_evaluator: RESULT_EVALUATOR is
			-- Evaluator of Result types
		once
			create Result;
		end;

	Arg_evaluator: ARG_EVALUATOR is
			-- Evaluator of argument types
		once
			create Result;
		end;

	Local_evaluator: LOCAL_EVALUATOR is
			-- Evaluator  of argument types
		once
			create Result;
		end;

	Creation_evaluator: CREATION_EVALUATOR is
			-- Evaluator for type creation
		once
			create Result
		end
end
