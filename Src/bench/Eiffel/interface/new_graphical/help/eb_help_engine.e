indexing
	description: "Help engine, displays help context"

class
	EB_HELP_ENGINE

inherit
	EV_HELP_ENGINE

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create implemetation object.
		do
			create {EB_HELP_ENGINE_IMP} implementation.make
		end

feature -- Status Report

	last_show_successful: BOOLEAN is
			-- Was last call to `show' successful?
		do
			Result := implementation.last_show_successful
		ensure
			message_if_failed: not Result implies (last_error_message /= Void and then not last_error_message.is_empty)
			bridge_ok: Result = implementation.last_show_successful
		end
	
	last_error_message: STRING is
			-- Last error message, if any
		do
			Result := implementation.last_error_message
		ensure
			bridge_ok: equal (Result, implementation.last_error_message)
		end
			
feature -- Basic Operations

	show (a_help_context: EB_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		do
			implementation.show (a_help_context)
		end

feature {NONE} -- Implementation

	implementation: EB_HELP_ENGINE_I
			-- Platform specific implementation

end -- class EB_HELP_ENGINE
