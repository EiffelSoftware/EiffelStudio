note
	description: "Object that represents information of current process"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PROCESS_INFO

inherit
	EXECUTION_ENVIRONMENT
		rename
			arguments as environment_arguments
		end

feature -- Access

	process_id: INTEGER
			-- Process ID of current process
		deferred
		ensure
			instance_free: class
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
