-- Shared instance of execution environment

class SHARED_EXEC_ENVIRONMENT
	
feature {NONE}

	Execution_environment: EXECUTION_ENVIRONMENT is
		once
			!!Result;
		end;

end
