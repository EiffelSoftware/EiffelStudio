indexing
	description	: "Objects that process help requests according to a given help context."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords	: "help"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EV_HELP_ENGINE

feature -- Basic Operations

	show (a_help_context: EV_HELP_CONTEXT) is
			-- Show help with context `a_help_context'.
		require
			a_help_context_not_void: a_help_context /= Void
		deferred
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




end -- class EV_HELP_ENGINE

