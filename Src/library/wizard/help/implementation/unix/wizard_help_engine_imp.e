indexing
	description: "Help engine, displays help context, GTK implementation"

class
	WIZARD_HELP_ENGINE_IMP

inherit
	WIZARD_HELP_ENGINE_I

create
	make
	
feature {NONE} -- Initialization

	make is
		do
		end

feature -- Status Report

	last_show_successful: BOOLEAN is
			-- Was last call to `show' successful?
		do
		end
	
	last_error_message: STRING is
			-- Last error message, if any
		do
		end
			
feature -- Basic Operations

	show (a_help_context: EB_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		do
			(create {EXECUTION_ENVIRONMENT}.make).launch ("netscape " + a_help_context.url)
		end

end -- class WIZARD_HELP_ENGINE_IMP