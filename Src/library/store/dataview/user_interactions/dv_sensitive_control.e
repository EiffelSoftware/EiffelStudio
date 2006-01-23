indexing
	description: "Objects that enable the user to%
			%perform an action at runtime."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	DV_SENSITIVE_CONTROL

feature -- Basic operations

	enable_sensitive is
			-- Enable control sensitive.
		deferred
		end

	disable_sensitive is
			-- Disable control sensitive.
		deferred
		end

	set_action (action: PROCEDURE [ANY, TUPLE]) is
			-- Set action performed by control.
		deferred
		end

	activate is
			-- Activate control.
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





end -- class DV_SENSITIVE_CONTROL


