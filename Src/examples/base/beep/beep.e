class
	BEEP

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			io.put_string ("Making sound...")
			error_beep
			if is_successful then
				io.put_string ("Passed.")
			else
				io.put_string ("Failed.")
			end
			io.put_new_line
		end

feature {NONE} -- Sound

	is_successful: BOOLEAN
			-- Is last call attempt to make sound successful?

	warning_beep
			-- Attempt to make a warning beep.
			-- Make status available in `is_successful'.
		do
			is_successful := c_beep (c_warning_beep_kind)
		end

	error_beep
			-- Attempt to make an error beep.
			-- Make status available in `is_successful'.
		do
			is_successful := c_beep (c_error_beep_kind)
		end

feature {NONE} -- Sound: interfacing to C code

	c_warning_beep_kind: INTEGER
			-- Beep kind for a warning.
		external "[
				C inline use "my_beep.h"
			]"
			alias "return warning_beep_kind;"
		end

	c_error_beep_kind: INTEGER
			-- Beep kind for an error.
		external "[
				C inline use "my_beep.h"
			]"
			alias "return error_beep_kind;"
		end

	c_beep (kind: INTEGER): BOOLEAN
			-- Attempt to make a beep of a given kind `kind'.
			-- Return `True' on success and `False' otherwise.
		require
			kind = c_error_beep_kind or kind = c_warning_beep_kind
		external "[
				C inline use "my_beep.h"
			]"
			alias "return my_beep ($kind);"
		end

end
