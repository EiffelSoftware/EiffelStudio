indexing
	description: "Window displaying a console application output%
					%Used together with class PROCESS_LAUNCHER"

deferred class
	WIZARD_OUTPUT_WINDOW

feature -- Basic Operations

	add_title (a_text: STRING) is
			-- Add `a_text' to output using title format.
		require
			non_void_text: a_text /= Void
		deferred
		end

	add_message (a_text: STRING) is
			-- Add `a_text' to output using standard format.
		require
			non_void_message: a_text /= Void
		deferred
		end

	add_warning (a_text: STRING) is		
			-- Add `a_text' to output using warning format.
		require
			non_void_text: a_text /= Void
		deferred
		end

	add_error (a_text: STRING) is		
			-- Add `a_text' to output using error format.
		require
			non_void_text: a_text /= Void
		deferred
		end

	clear is
			-- Clear output.
		deferred
		end

end -- class WIZARD_OUTPUT_WINDOW
