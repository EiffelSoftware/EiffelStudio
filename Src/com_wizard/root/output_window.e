indexing
	description: "Window displaying a console application output%
					%Used together with class PROCESS_LAUNCHER"

deferred class
	OUTPUT_WINDOW

feature -- Basic Operations

	new_line is
			-- Begin a new line.
		deferred
		end
		
	add_text (a_text: STRING) is
			-- Add `a_text' to output.
		require
			non_void_text: a_text /= Void
		deferred
		end
	
	clear is
			-- Clear output.
		deferred
		end

end -- class OUTPUT_WINDOW