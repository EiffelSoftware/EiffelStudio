-- Starts the C compilation in W_code or F_code

deferred class EWB_C_CODE

inherit
	EWB_CMD
		redefine
			loop_execute
		end;
	EXECUTION_ENVIRONMENT
		rename
			system as exec_env_system
		end;

feature

	loop_execute is
		do

		end;

	execute is
		do
		end;

end

