indexing
	description:
		"Screen log facilities for test results"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class SCREEN_LOG inherit

	LOG_FACILITY
		redefine
			output_device
		end

create

	make, make_with_stdout, make_with_stderr

feature {NONE} -- Initialization

	make_with_stderr is
			-- Create log to standard error.
		do
			set_stderr
		ensure
			stderr_set: is_stderr
		end

	make, make_with_stdout is
			-- Create log to standard output.
		do
			set_stdout
		ensure
			stdout_set: is_stdout
		end

feature -- Status report

	is_stderr: BOOLEAN is
			-- Output on standard error?
		do
			Result := output_device = Io.error
		end

	is_stdout: BOOLEAN is
			-- Output on standard output?
		do
			Result := output_device = Io.output
		end

feature -- Status setting

	set_stderr is
			-- Set output to standard error.
		do
			output_device := Io.error
		ensure
			output_to_stderr: output_device = Io.error
		end

	set_stdout is
			-- Set output to standard output.
		do
			output_device := Io.output
		ensure
			output_to_stdout: output_device = Io.output
		end

feature {NONE} -- Implementation

	output_device: PLAIN_TEXT_FILE
			-- Output device for log

invariant

	well_defined_state: is_stdout xor is_stderr

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SCREEN_LOG

