indexing

	description: 
		"Abstract notion of system commands with associated commands.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_SYSTEM

inherit
	
	EWB_CMD

feature {NONE}

	associated_cmd: E_CMD is
			-- Associated system command to be executed
		deferred
		ensure
			non_void_result: Result /= Void
		end;

	execute is
		local
			cmd: like associated_cmd
		do
			cmd := clone (associated_cmd);
			cmd.set_output_window (output_window);
			cmd.execute
		end;

end -- class EWB_SYSTEM
