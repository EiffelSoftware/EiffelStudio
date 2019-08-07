note
	description: "Sensitive check."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DV_SENSITIVE_CHECK

feature -- Access

	checked: BOOLEAN
			-- Is property checked?
		deferred
		end

feature -- Basic operations

	enable_checked
			-- Check property.
		deferred
		end

	disable_checked
			-- Uncheck property.
		deferred
		end

	request_sensitive
			-- Request display sensitive.
		deferred
		end

	request_insensitive
			-- Request display insensitive.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_SENSITIVE_CHECK


