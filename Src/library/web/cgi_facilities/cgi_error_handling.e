indexing
	description: "Error Handling"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	CGI_ERROR_HANDLING
	
inherit
	CGI_IN_AND_OUT

	EXCEPTIONS
		export
			{NONE} all
		end

feature -- Status setting

	set_message is
			-- Display error message.
		do
			debug_level := Dl_message
		end

	set_no_debug is
			-- Do nothing.
		do
			debug_level := Dl_no
		end

feature {NONE} -- Implementation

	debug_level: INTEGER
			-- Debug level.

	Dl_message: INTEGER is 1
			-- Display error message.

	Dl_no: INTEGER is 0;
			-- Do nothing.

	error_happened: BOOLEAN
			-- Did an error occur?

	error_message: STRING
			-- Message describing the error.

feature -- Basic Operations

	handle_exception is
			-- General exception hanlding.
		do
			inspect
				debug_level
			when Dl_no then
					-- Do nothing
			when Dl_message then
					-- Display an error message
				set_error ("Internal error")
				raise_error
			else
					-- Do nothing
			end
		end

	raise_error is
			-- Display error message `msg' and exit.
		do
			response_header.generate_text_header
			response_header.send_to_browser
			output.put_string(error_message)
			die(0)
		end

	set_error (msg: STRING) is
			-- Set error message.
		require
			msg_exists: msg /= Void
		do
			if not error_happened then
				error_message := msg;
				error_happened := True
			end
		end

end -- class CGI_ERROR_HANDLING
