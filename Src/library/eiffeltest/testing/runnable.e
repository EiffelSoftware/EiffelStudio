indexing
	description:
		"Executable components"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	RUNNABLE

feature -- Status report

	is_enabled: BOOLEAN is
			-- Is component enabled?
	 	deferred
		end
		
	is_ready: BOOLEAN is
	 		-- Is component ready to be executed?
		deferred
		end
	
feature -- Basic operations

	execute is
			-- Execute component.
		require
			enabled: is_enabled
			ready: is_ready
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




end -- class RUNNABLE

