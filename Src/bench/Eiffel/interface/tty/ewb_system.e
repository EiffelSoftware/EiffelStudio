indexing

	description: 
		"Abstract notion of system commands with associated commands.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_SYSTEM

inherit
	
	EWB_CMD

feature {NONE}

	associated_cmd: E_OUTPUT_CMD is
			-- Associated system command to be executed
		deferred
		ensure
			non_void_result: Result /= Void
		end;

	execute is
		local
			cmd: like associated_cmd;
			st: STRUCTURED_TEXT
		do
			!! st.make;
			cmd := clone (associated_cmd);
			cmd.set_structured_text (st);
			cmd.execute;
			output_window.put_string (st.image);
			output_window.new_line;
		end;

end -- class EWB_SYSTEM
