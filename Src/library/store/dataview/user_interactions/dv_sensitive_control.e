note
	description: "Objects that enable the user to%
			%perform an action at runtime."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: 2015-12-17 14:34:17 +0100 (Thu, 17 Dec 2015) $"
	revision: "$Revision: 98279 $"

deferred class
	DV_SENSITIVE_CONTROL

feature -- Basic operations

	enable_sensitive
			-- Enable control sensitive.
		deferred
		end

	disable_sensitive
			-- Disable control sensitive.
		deferred
		end

	set_action (action: PROCEDURE)
			-- Set action performed by control.
		deferred
		end

	activate
			-- Activate control.
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





end -- class DV_SENSITIVE_CONTROL


