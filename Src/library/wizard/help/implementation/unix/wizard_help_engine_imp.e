indexing
	description: "Help engine, displays help context, GTK implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."

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
			Result := "No help is available"
		end
			
feature -- Basic Operations

	show (a_help_context: WIZARD_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		do
			(create {EXECUTION_ENVIRONMENT}).launch ("netscape " + a_help_context.url)
		end

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




end -- class WIZARD_HELP_ENGINE_IMP


