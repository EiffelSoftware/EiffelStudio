indexing
	description: "Help engine, displays help context, implementation interface"

deferred class
	WIZARD_HELP_ENGINE_I

feature -- Status Report

	last_show_successful: BOOLEAN is
			-- Was last call to `show' successful?
		deferred
		ensure
			message_if_failed: not Result implies (last_error_message /= Void and then not last_error_message.is_empty)
		end
	
	last_error_message: STRING is
			-- Last error message, if any
		deferred
		end
			
feature -- Basic Operations

	show (a_help_context: WIZARD_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		deferred
		end

end -- class WIZARD_HELP_ENGINE