indexing
	description: "Wizard help engine, displays help context"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	WIZARD_HELP_ENGINE

inherit
	EV_HELP_ENGINE

create
	make

feature {NONE} -- Initialization

	make is
			-- Create implemetation object.
		do
			create {WIZARD_HELP_ENGINE_IMP} implementation.make
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

	show (a_help_context: WIZARD_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		do
			implementation.show (a_help_context)
		end

feature {NONE} -- Implementation

	implementation: WIZARD_HELP_ENGINE_I;
			-- Platform specific implementation

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




end -- class WIZARD_HELP_ENGINE

