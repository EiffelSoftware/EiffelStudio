indexing
	description: "Abstract notion of system commands with associated commands.";
	date: "$Date$";
	revision: "$Revision$"

deferred class EWB_SYSTEM

inherit
	EWB_CMD

feature {NONE}

	associated_cmd: E_OUTPUT_CMD is
			-- Associated system command to be executed
		deferred
		ensure
			non_void_result: Result /= Void
		end

	execute is
		local
			cmd: like associated_cmd
		do
			cmd := associated_cmd
			cmd.execute
			output_window.put_string (cmd.structured_text.image)
			output_window.new_line
		end

end -- class EWB_SYSTEM
