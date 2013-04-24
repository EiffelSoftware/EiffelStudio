note
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

	make
			-- Create implemetation object.
		do
			create {WIZARD_HELP_ENGINE_IMP} implementation.make
		end

feature -- Status Report

	last_show_successful: BOOLEAN
			-- Was last call to `show' successful?
		do
			Result := implementation.last_show_successful
		ensure
			message_if_failed: not Result implies (attached last_error_message as m and then not m.is_empty)
			bridge_ok: Result = implementation.last_show_successful
		end

	last_error_message: detachable STRING
			-- Last error message, if any
		do
			Result := implementation.last_error_message
		ensure
			bridge_ok: equal (Result, implementation.last_error_message)
		end

feature -- Basic Operations

	show (a_help_context: WIZARD_HELP_CONTEXT)
			-- Show help with context `a_help_context'.
		do
			implementation.show (a_help_context)
		end

feature {NONE} -- Implementation

	implementation: WIZARD_HELP_ENGINE_I;
			-- Platform specific implementation

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
